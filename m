Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF3C433FE
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 23:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJPXSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 19:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJPXSi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 19:18:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A2333A25
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 16:18:35 -0700 (PDT)
Received: (qmail 23919 invoked by uid 109); 16 Oct 2022 23:18:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 16 Oct 2022 23:18:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 446 invoked by uid 111); 16 Oct 2022 23:18:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 16 Oct 2022 19:18:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 16 Oct 2022 19:18:34 -0400
From:   Jeff King <peff@peff.net>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Git.pm: add semicolon after catch statement
Message-ID: <Y0yRStZ6gM+H8/Bf@coredump.intra.peff.net>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221016212236.12453-2-michael@mcclimon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221016212236.12453-2-michael@mcclimon.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 16, 2022 at 05:22:36PM -0400, Michael McClimon wrote:

> When attempting to initialize a repository object in an unsafe
> directory, a syntax error is reported (Can't use string as a HASH ref
> while strict refs in use). Fix this runtime error by adding the required
> semicolon after the catch statement.
> 
> Without the semicolon, the result of the following line (i.e., the
> result of Cwd::abs_path) is passed as the third argument to Error.pm's
> catch function. That function expects that its third argument,
> $clauses, is a hash reference, and trying to access a string as a hash
> reference is a fatal error.

Curiously this works as expected for me, both before and after your
patch. I wonder if it depends on perl version. Mine is 5.34.

I've never used Error.pm's try/catch before, so I don't know what's
normal. Regular if/unless doesn't need it, but certainly an earlier
catch uses a semicolon. So it seems like a reasonable fix.

> diff --git a/perl/Git.pm b/perl/Git.pm
> index 080cdc2a..cf15ead6 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -217,7 +217,7 @@ sub repository {
>  			} catch Git::Error::Command with {
>  				# Mimic git-rev-parse --git-dir error message:
>  				throw Error::Simple("fatal: Not a git repository: $dir");
> -			}
> +			};

I'd assume t9700 passes for you, since I don't think we cover this case.
Maybe it's worth squashing this in:

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index e046f7db76..5bd3687f37 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -30,6 +30,12 @@ sub adjust_dirsep {
 # set up
 our $abs_repo_dir = cwd();
 ok(our $r = Git->repository(Directory => "."), "open repository");
+{
+	local $ENV{GIT_TEST_ASSUME_DIFFERENT_OWNER} = 1;
+	my $failed = eval { Git->repository(Directory => ".") };
+	ok(!$failed, "reject unsafe repository");
+	like($@, qr/not a git repository/i, "unsafe error message");
+}
 
 # config
 is($r->config("test.string"), "value", "config scalar: string");
