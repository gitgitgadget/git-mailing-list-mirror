Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DFC20986
	for <e@80x24.org>; Thu, 29 Sep 2016 09:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933015AbcI2JBX (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 05:01:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:49805 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932929AbcI2JBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 05:01:12 -0400
Received: (qmail 11903 invoked by uid 109); 29 Sep 2016 09:01:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 09:01:11 +0000
Received: (qmail 32284 invoked by uid 111); 29 Sep 2016 09:01:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 05:01:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 05:01:09 -0400
Date:   Thu, 29 Sep 2016 05:01:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
Message-ID: <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160928233047.14313-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 04:30:45PM -0700, Junio C Hamano wrote:

> The tests for show-origin codepath in "git config" however cannot be
> tweaked with "--local" etc., because they wants to read also from
> $HOME/.gitconfig and make sure what comes from where.  Disable
> reading from the system-wide config with GIT_CONFIG_NOSYSTEM=1 for
> these tests.

I think anytime you would use GIT_CONFIG_NOSYSTEM over --local, it is an
indication that the test is trying to check how multiple sources
interact. And the right thing to do for them is to set GIT_ETC_GITCONFIG
to some known quantity. We just couldn't do that before, so we skipped
it.

IOW, something like the patch below (on top of yours). Note that the
commands that are doing a "--get" and not a "--list" don't actually seem
to need either (because they are getting the values out of the local
file anyway), so we could drop the setting of GIT_ETC_GITCONFIG from
them entirely.

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index b998568..d2476a8 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1234,6 +1234,11 @@ test_expect_success 'set up --show-origin tests' '
 		[user]
 			relative = include
 	EOF
+	cat >"$HOME"/etc-gitconfig <<-\EOF &&
+		[user]
+			system = true
+			override = system
+	EOF
 	cat >"$HOME"/.gitconfig <<-EOF &&
 		[user]
 			global = true
@@ -1252,6 +1257,8 @@ test_expect_success 'set up --show-origin tests' '
 
 test_expect_success '--show-origin with --list' '
 	cat >expect <<-EOF &&
+		file:$HOME/etc-gitconfig	user.system=true
+		file:$HOME/etc-gitconfig	user.override=system
 		file:$HOME/.gitconfig	user.global=true
 		file:$HOME/.gitconfig	user.override=global
 		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
@@ -1262,14 +1269,16 @@ test_expect_success '--show-origin with --list' '
 		file:.git/../include/relative.include	user.relative=include
 		command line:	user.cmdline=true
 	EOF
-	GIT_CONFIG_NOSYSTEM=1 \
+	GIT_ETC_GITCONFIG=$HOME/etc-gitconfig \
 	git -c user.cmdline=true config --list --show-origin >output &&
 	test_cmp expect output
 '
 
 test_expect_success '--show-origin with --list --null' '
 	cat >expect <<-EOF &&
-		file:$HOME/.gitconfigQuser.global
+		file:$HOME/etc-gitconfigQuser.system
+		trueQfile:$HOME/etc-gitconfigQuser.override
+		systemQfile:$HOME/.gitconfigQuser.global
 		trueQfile:$HOME/.gitconfigQuser.override
 		globalQfile:$HOME/.gitconfigQinclude.path
 		$INCLUDE_DIR/absolute.includeQfile:$INCLUDE_DIR/absolute.includeQuser.absolute
@@ -1280,7 +1289,7 @@ test_expect_success '--show-origin with --list --null' '
 		includeQcommand line:Quser.cmdline
 		trueQ
 	EOF
-	GIT_CONFIG_NOSYSTEM=1 \
+	GIT_ETC_GITCONFIG=$HOME/etc-gitconfig \
 	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
 	nul_to_q <output.raw >output &&
 	# The here-doc above adds a newline that the --null output would not
@@ -1304,7 +1313,7 @@ test_expect_success '--show-origin with --get-regexp' '
 		file:$HOME/.gitconfig	user.global true
 		file:.git/config	user.local true
 	EOF
-	GIT_CONFIG_NOSYSTEM=1 \
+	GIT_ETC_GITCONFIG=$HOME/etc-gitconfig \
 	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
 	test_cmp expect output
 '
@@ -1313,7 +1322,7 @@ test_expect_success '--show-origin getting a single key' '
 	cat >expect <<-\EOF &&
 		file:.git/config	local
 	EOF
-	GIT_CONFIG_NOSYSTEM=1 \
+	GIT_ETC_GITCONFIG=$HOME/etc-gitconfig \
 	git config --show-origin user.override >output &&
 	test_cmp expect output
 '
