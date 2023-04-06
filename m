Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69548C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 09:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjDFJgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 05:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjDFJgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 05:36:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B62171C
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 02:36:04 -0700 (PDT)
Received: (qmail 13443 invoked by uid 109); 6 Apr 2023 09:36:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Apr 2023 09:36:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24866 invoked by uid 111); 6 Apr 2023 09:36:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Apr 2023 05:36:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Apr 2023 05:36:02 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] t/lib-httpd: pass PERL_PATH to CGI scripts
Message-ID: <20230406093602.GD2215039@coredump.intra.peff.net>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <20230406032647.GA2092142@coredump.intra.peff.net>
 <ZC6AdylF4TI41vnX@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC6AdylF4TI41vnX@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2023 at 10:19:03AM +0200, Patrick Steinhardt wrote:

> > Does this fix the cases you saw, or are there others?
> 
> You know, let's just go with your patch. With PERL_PATH set it fixes all
> the issues I have observed. At some point in time I saw more issues than
> the one you fix here, but that's because my `config.mak` got lost
> without me noticing. Oops, embarassing.

OK, that is good if there is nothing left to fix. :) Let us know if any
of the others pop up again.

I also built the docs, which seems to use PERL_PATH as appropriate,
though one thing that did trip me up is that:

  make PERL_PATH=/my/actual/perl
  cd Documentation
  make

does not pick up the earlier PERL_PATH. Which is not surprising if you
think about it. It's just that we shove some knobs into
GIT-BUILD-OPTIONS and then pick them out later (but only in shell
scripts, not in the Makefile), which created a false expectation.

> > Subject: [PATCH] t/lib-httpd: pass PERL_PATH to CGI scripts

Reposting verbatim with a Cc and a catchier subject to get the
maintainer's attention.

-- >8 --
Subject: t/lib-httpd: pass PERL_PATH to CGI scripts

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

