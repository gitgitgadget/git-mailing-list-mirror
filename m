Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4C7C7619A
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 03:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjDFD0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 23:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDFD0t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 23:26:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC43EE
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 20:26:48 -0700 (PDT)
Received: (qmail 11922 invoked by uid 109); 6 Apr 2023 03:26:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Apr 2023 03:26:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21583 invoked by uid 111); 6 Apr 2023 03:26:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Apr 2023 23:26:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Apr 2023 23:26:47 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <20230406032647.GA2092142@coredump.intra.peff.net>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 12:10:10PM +0200, Patrick Steinhardt wrote:

> The majority of Perl scripts we carry in Git have a `#!/usr/bin/perl`
> shebang. This is not a portable location for the Perl interpreter and
> may thus break on some systems that have the interpreter installed in a
> different location. One such example is NixOS, where the only executable
> installed in `/usr/bin` is env(1).
> 
> Convert the shebangs to resolve the location of the Perl interpreter via
> env(1) to make these scripts more portable. While the location of env(1)
> is not guaranteed by any standard either, in practice all distributions
> including NixOS have it available at `/usr/bin/env`. We're also already
> using this idiom in a small set of other scripts, and until now nobody
> complained about them.
> 
> This makes the test suite pass on NixOS.

Can you tell us more about which tests failed?

Skimming over the list of files here, the first few examples:

>  Documentation/build-docdep.perl                    | 2 +-
>  Documentation/cat-texi.perl                        | 2 +-
>  Documentation/cmd-list.perl                        | 3 ++-
>  Documentation/fix-texi.perl                        | 4 +++-
>  Documentation/lint-fsck-msgids.perl                | 2 +-

will not be affected by your patch, because we never use their shebang
lines at all (we say "$PERL_PATH cmd-list.perl" in the Makefile).

I did try removing /usr/bin/perl completely (and thus likewise had no
perl in my path), setting PERL_PATH, and got a few broken tests, which
could be fixed as below.

Does this fix the cases you saw, or are there others?

-- >8 --
Subject: [PATCH] t/lib-httpd: pass PERL_PATH to CGI scripts

As discussed in t/README, tests should aim to use PERL_PATH rather than
straight "perl". We usually do this automatically with a "perl" function
in test-lib.sh, but a few cases need to be handled specially.

One such case is the apply-one-time-perl.sh CGI, which invokes plain
"perl". It should be using $PERL_PATH, but to make that work, we must
also instruct Apache to pass through the variable.

Prior to this patch, doing:

  mv /usr/bin/perl /usr/bin/my-perl
  make PERL_PATH=/usr/bin/my-perl test

would fail t5702, t5703, and t5616. After this it passes. This is a
pretty extreme case, as even if you install perl elsewhere, you'd likely
still have it in your $PATH. A more realistic case is that you don't
want to use the perl in your $PATH (because it's older, broken, etc) and
expect PERL_PATH to consistently override that (since that's what it's
documented to do). Removing it completely is just a convenient way of
completely breaking it for testing purposes.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf            | 2 ++
 t/lib-httpd/apply-one-time-perl.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index f43a25c1f10..9e6892970de 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -101,6 +101,8 @@ PassEnv LC_ALL
 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
 
+SetEnv PERL_PATH ${PERL_PATH}
+
 <LocationMatch /smart/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
diff --git a/t/lib-httpd/apply-one-time-perl.sh b/t/lib-httpd/apply-one-time-perl.sh
index 09a0abdff7c..d7f9fed6aee 100644
--- a/t/lib-httpd/apply-one-time-perl.sh
+++ b/t/lib-httpd/apply-one-time-perl.sh
@@ -13,7 +13,7 @@ then
 	export LC_ALL
 
 	"$GIT_EXEC_PATH/git-http-backend" >out
-	perl -pe "$(cat one-time-perl)" out >out_modified
+	"$PERL_PATH" -pe "$(cat one-time-perl)" out >out_modified
 
 	if cmp -s out out_modified
 	then
-- 
2.40.0.824.g7b678b1f643

