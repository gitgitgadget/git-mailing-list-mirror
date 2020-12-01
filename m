Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CF9C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD7B206F9
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgLALYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:24:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:47032 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgLALYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 06:24:10 -0500
Received: (qmail 25905 invoked by uid 109); 1 Dec 2020 11:23:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 11:23:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25345 invoked by uid 111); 1 Dec 2020 11:23:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 06:23:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 06:23:28 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] handling 4GB .idx files
Message-ID: <X8YnsGsUl53OKFno@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
 <1403797985.37893.1606777048311@ox.hosteurope.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1403797985.37893.1606777048311@ox.hosteurope.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 11:57:27PM +0100, Thomas Braun wrote:

> Below is what I came up with. It passes here. I've replaced awk with
> cut from the original draft, and also moved the perl script out of the
> test as I think the quoting is getting way too messy otherwise. And
> I've added --no-dangling to git fsck as otherwise it takes forever to
> output the obvious dangling blobs. The unpack limit is mostly for
> testing the test itself with a smaller amount of blobs. But I still
> think it is worthwile to force everything into a pack.

I think you can get rid of some of the quoting by using perl directly as
the interpreter, rather than a shell script that only invokes it with
-e. See below.

> --- a/t/t1600-index.sh
> +++ b/t/t1600-index.sh

I don't think this should go in t1600; that's about testing the
.git/index file, not a pack .idx. Probably t5302 would be more
appropriate.

> @@ -97,4 +97,34 @@ test_expect_success 'index version config precedence' '
>  	test_index_version 0 true 2 2
>  '
>  
> +{
> +	echo "#!$SHELL_PATH"
> +	cat <<'EOF'
> +	   "$PERL_PATH" -e '
> +		for (0..154_000_000) {
> +			print "blob\n";
> +			print "data <<EOF\n";
> +			print "$_\n";
> +			print "EOF\n";
> +		} '
> +EOF
> +
> +} >dump
> +chmod +x dump

You can simplify this a bit with write_script, as well. And we do prefer
to put this stuff in a test block, so verbosity, etc, is handled
correctly.

I didn't let it run to completion, but something like this seems to
work:

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 6d83aaf8a4..a4c1dc0f0a 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -97,23 +97,16 @@ test_expect_success 'index version config precedence' '
 	test_index_version 0 true 2 2
 '
 
-{
-	echo "#!$SHELL_PATH"
-	cat <<'EOF'
-	   "$PERL_PATH" -e '
-		for (0..154_000_000) {
-			print "blob\n";
-			print "data <<EOF\n";
-			print "$_\n";
-			print "EOF\n";
-		} '
-EOF
-
-} >dump
-chmod +x dump
-
 test_expect_success EXPENSIVE,PERL 'Test 4GB boundary for the index' '
 	test_config fastimport.unpacklimit 0 &&
+	write_script dump "$PERL_PATH" <<-\EOF &&
+	for (0..154_000_000) {
+		print "blob\n";
+		print "data <<EOF\n";
+		print "$_\n";
+		print "EOF\n";
+	}
+	EOF
 	./dump | git fast-import &&
 	blob=$(echo 0 | git hash-object --stdin) &&
 	git cat-file blob $blob >actual &&

> +test_expect_success EXPENSIVE,PERL 'Test 4GB boundary for the index' '

You can drop the PERL prereq. Even without it set, we assume that we can
do basic perl one-liners that would work even in old versions of perl.

I'm not sure if EXPENSIVE is the right ballpark, or if we'd want a
VERY_EXPENSIVE. On my machine, the whole test suite for v2.29.0 takes 64
seconds to run, and setting GIT_TEST_LONG=1 bumps that to 103s. It got a
bit worse since then, as t7900 adds an EXPENSIVE test that takes ~200s
(it's not strictly additive, since we can work in parallel on other
tests for the first bit, but still, yuck).

So we're looking at 2-3x to run the expensive tests now. This new one
would be 20x or more. I'm not sure if anybody would care or not (i.e.,
whether anyone actually runs the whole suite with this flag). I thought
we did for some CI job, but it looks like it's just the one-off in
t5608.

> +	git cat-file blob $final &&
> +	git cat-file blob fffffff &&

This final cat-file may be a problem when tested with SHA-256. You are
relying on the fact that there is exactly one object that matches seven
f's as its prefix. That may be true for SHA-1, but if so it's mostly
luck.  Seven hex digits is only 28 bits, which is ~260M. For 154M
objects, we'd expect an average of 0.57 objects per 7-digit prefix. So I
wouldn't be at all surprised if there are two of them for SHA-256.

I'm also not sure what it's testing that the $final one isn't.

-Peff
