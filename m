Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBBFC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJQRe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJQRe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:34:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817A8115D
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:34:24 -0700 (PDT)
Received: (qmail 27323 invoked by uid 109); 17 Oct 2022 17:34:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 17:34:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8811 invoked by uid 111); 17 Oct 2022 17:34:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 13:34:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 13:34:22 -0400
From:   Jeff King <peff@peff.net>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Git.pm: add semicolon after catch statement
Message-ID: <Y02SHlW1rNQdfCHI@coredump.intra.peff.net>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221016212236.12453-2-michael@mcclimon.org>
 <Y0yRStZ6gM+H8/Bf@coredump.intra.peff.net>
 <Y0y7UdLf3qd7RgVQ@newk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0y7UdLf3qd7RgVQ@newk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc people who worked on safe-directory stuff; please check out the
included test and final comments]

On Sun, Oct 16, 2022 at 10:17:53PM -0400, Michael McClimon wrote:

> > Curiously this works as expected for me, both before and after your
> > patch. I wonder if it depends on perl version. Mine is 5.34.
> 
> Hm, curious indeed! It reliably fails without my patch and passes with it on
> all the versions I had lying around (5.8, 5.18, 5.24, 5.26, 5.28, 5.30, 5.34,
> and 5.36).

Doh, sorry to mislead you; I hadn't noticed this was in the bare
repository code path until you pointed it out. I get the same outcome as
you and the OP once that is fixed (both in t9700 and in my manual
testing).

> Ha, well Perl is...let's say special. try/catch is not a language construct
> (until 5.34, where it is experimental), and so it's always implemented by
> subroutines. One upshot of this is that try/catch needs a semicolon, because
> it's sugar for try(sub { ... }), and statements need semicolons separating
> them.

Right, I imagined it was something like that. Your fix is definitely the
right thing, then.

> Curiously, t9700 passes for me with this suggestion both with and without my
> patch. You'd only see this bug in bare repositories, though, and the one set
> up in t9700 is not bare. I can see about trying to make it do so, but I'll
> need to do a bit more reading of how even the tests are set up and run first.

Yeah, this test is particularly confusing because unlike most of our
suite, it drives the test harness using a separate perl script. So you
have setup in one file and tests in another.

You'd want something like:

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 4aa5d90d32..53a838a8e8 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -45,6 +45,10 @@ test_expect_success \
      git config --add test.pathmulti bar
      '
 
+test_expect_success 'set up bare repository' '
+        git init --bare bare.git
+'
+
 test_expect_success 'use t9700/test.pl to test Git.pm' '
 	"$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
 	test_must_be_empty stderr
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index e046f7db76..917b09cdf9 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -30,6 +30,12 @@ sub adjust_dirsep {
 # set up
 our $abs_repo_dir = cwd();
 ok(our $r = Git->repository(Directory => "."), "open repository");
+{
+	local $ENV{GIT_TEST_ASSUME_DIFFERENT_OWNER} = 1;
+	my $failed = eval { Git->repository(Directory => "$abs_repo_dir/bare.git") };
+	ok(!$failed, "reject unsafe bare repository");
+	like($@, qr/not a git repository/i, "unsafe error message");
+}
 
 # config
 is($r->config("test.string"), "value", "config scalar: string");

But curiously this still does not pass after your patch, because we seem
to actually open the repository! I think this is because the C code
allows an explicit GIT_DIR to override the safe-directory checks. But in
this case that GIT_DIR is set by Git.pm searching for the directory, not
because the user desires it.

(I know that I used a "Directory" in the example above, but that is only
to avoid extra chdir-ing around in the test script; calling a bare
Git->repository() triggers the same behavior in the right directory).

So your patch is definitely still the right thing to do, but it feels
like a hole in the safe-directory mechanism, at least when called via
Git.pm. +cc folks who worked on that.

-Peff
