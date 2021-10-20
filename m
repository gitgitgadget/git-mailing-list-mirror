Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F41C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541AD61371
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJTUh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:37:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:43042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhJTUh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 16:37:56 -0400
Received: (qmail 10531 invoked by uid 109); 20 Oct 2021 20:35:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Oct 2021 20:35:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29272 invoked by uid 111); 20 Oct 2021 20:35:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Oct 2021 16:35:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Oct 2021 16:35:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Message-ID: <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 08:39:51PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This series is based off an off-hand comment I made about making the
> cmdlist.sh faster, in the meantime much of the same methods are
> already cooking in "next" for the "lint-docs" target.
> 
> See 7/8 for the main performance numbers, along the way I stole some
> patches from Johannes Sixt who'd worked on optimizing the script
> before, which compliment this new method of generating this file by
> piggy-backing more on GNU make for managing a dependency graph for us.

I still think this is a much more complicated and error-prone approach
than just making the script faster. I know we can't rely on perl, but
could we use it optimistically?

The proof-of-concept below on top of your patch 6 does two things:

  - observes that there is no need for get_category_line in the loop; it
    is just sorting and de-duping the bitfields, but since we just OR
    them together, neither of those things matters

  - uses perl to open each individual doc file to get the synopsis. It
    _feels_ like this should be something that sed or awk could do, but
    it is beyond me. However, speculatively trying perl is an easy win,
    and we can fall back to the shell loop.

Here are my timings:

Benchmark #1: sh generate-cmdlist.sh command-list.txt
  Time (mean ± σ):      40.4 ms ±  18.1 ms    [User: 44.9 ms, System: 7.1 ms]
  Range (min … max):    20.3 ms …  65.5 ms    10 runs

Benchmark #2: sh generate-cmdlist.sh.old command-list.txt
  Time (mean ± σ):      1.414 s ±  0.038 s    [User: 1.641 s, System: 0.863 s]
  Range (min … max):    1.344 s …  1.451 s    10 runs

Summary
  'sh generate-cmdlist.sh command-list.txt' ran
   34.96 ± 15.66 times faster than 'sh generate-cmdlist.sh.old command-list.txt'

I hate having fallbacks, because the seldom-used version may bitrot. I'm
tempted to just write that loop in C, but there's a circular dependency
with using any of libgit.a (even though it's really only the git
porcelain that cares about command-list.h, it goes into help.o which
goes into libgit.a. We could break that dependency if we wanted,
though). If we can do it in awk, that may be worthwhile.

But either way, I think this is superior to trying to parallelize the
Makefile:

  - it actually uses less CPU, rather than just trying to improve
    wall-clock time by using more cores

  - there's little chance of having some subtle dependency problem

Parallelizing makes a lot of sense to me when the operation is truly
expensive. But in this case it's literally just opening a file, and the
only reason it's slow is because we spawn a ton of processes to do it.

---
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index a1ab2b1f07..f922eebe23 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -63,11 +63,23 @@ define_category_names () {
 print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"
 
+	# try perl first, as we can do it all in one process
+	command_list "$1" |
+	perl -ne '
+		my ($cmd, @rest) = split;
+		open(my $fh, "<", "Documentation/$cmd.txt");
+		while (<$fh>) {
+			next unless /^$cmd - (.*)/;
+			print "{ \"$cmd\", N_(\"$1\"), 0";
+			print " | CAT_$_" for (@rest);
+			print " },\n";
+		}
+	' ||
 	command_list "$1" |
 	while read cmd rest
 	do
 		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
-		printf " | CAT_%s" $(echo "$rest" | get_category_line)
+		printf " | CAT_%s" $rest
 		echo " },"
 	done
 	echo "};"
