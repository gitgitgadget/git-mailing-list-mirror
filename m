From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Sat, 13 Feb 2016 13:04:13 -0500
Message-ID: <20160213180412.GA9516@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <1455373456-64691-4-git-send-email-larsxschneider@gmail.com>
 <20160213174449.GH30144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 13 19:05:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUeZK-00019p-Fm
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 19:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbcBMSEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 13:04:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:41582 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750961AbcBMSEP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 13:04:15 -0500
Received: (qmail 11135 invoked by uid 102); 13 Feb 2016 18:04:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 13:04:15 -0500
Received: (qmail 27158 invoked by uid 107); 13 Feb 2016 18:04:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 13:04:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 13:04:13 -0500
Content-Disposition: inline
In-Reply-To: <20160213174449.GH30144@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286122>

On Sat, Feb 13, 2016 at 12:44:49PM -0500, Jeff King wrote:

> > +test_expect_success '--show-origin' '
> [...]
> I see you split this up more, but there's still quite a bit going on in
> this one block. IMHO, it would be more customary in our tests to put the
> setup into one test_expect_success block, then each of these
> expect-run-cmp blocks into their own test_expect_success.

Here's a squashable patch that shows what I mean.

---
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 112f7c8..c7496aa 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1207,26 +1207,34 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
 '
 
-test_expect_success '--show-origin' '
-	>.git/config &&
-	>"$HOME"/.gitconfig &&
+test_expect_success 'set up --show-origin tests' '
 	INCLUDE_DIR="$HOME/include" &&
 	mkdir -p "$INCLUDE_DIR" &&
-	cat >"$INCLUDE_DIR"/absolute.include <<-EOF &&
+	cat >"$INCLUDE_DIR"/absolute.include <<-\EOF &&
 		[user]
 			absolute = include
 	EOF
-	cat >"$INCLUDE_DIR"/relative.include <<-EOF &&
+	cat >"$INCLUDE_DIR"/relative.include <<-\EOF &&
 		[user]
 			relative = include
 	EOF
-	test_config_global user.global "true" &&
-	test_config_global user.override "global" &&
-	test_config_global include.path "$INCLUDE_DIR"/absolute.include &&
-	test_config include.path ../include/relative.include &&
-	test_config user.local "true" &&
-	test_config user.override "local" &&
+	cat >"$HOME"/.gitconfig <<-EOF &&
+		[user]
+			global = true
+			override = global
+		[include]
+			path = "$INCLUDE_DIR/absolute.include"
+	EOF
+	cat >.git/config <<-\EOF
+		[include]
+			path = ../include/relative.include
+		[user]
+			local = true
+			override = local
+	EOF
+'
 
+test_expect_success '--show-origin with --list' '
 	cat >expect <<-EOF &&
 		file:$HOME/.gitconfig	user.global=true
 		file:$HOME/.gitconfig	user.override=global
@@ -1239,8 +1247,10 @@ test_expect_success '--show-origin' '
 		cmdline:	user.cmdline=true
 	EOF
 	git -c user.cmdline=true config --list --show-origin >output &&
-	test_cmp expect output &&
+	test_cmp expect output
+'
 
+test_expect_success '--show-origin with --list --null' '
 	cat >expect <<-EOF &&
 		file:$HOME/.gitconfigQuser.global
 		trueQfile:$HOME/.gitconfigQuser.override
@@ -1253,25 +1263,32 @@ test_expect_success '--show-origin' '
 		localQcmdline:Quser.cmdline
 		trueQ
 	EOF
-	git -c user.cmdline=true config --null --list --show-origin | nul_to_q >output &&
+	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
+	nul_to_q <output.raw >output &&
 	echo >>output &&
-	test_cmp expect output &&
+	test_cmp expect output
+'
 
+test_expect_success '--show-origin with single file' '
 	cat >expect <<-\EOF &&
 		file:.git/config	include.path=../include/relative.include
 		file:.git/config	user.local=true
 		file:.git/config	user.override=local
 	EOF
 	git config --local --list --show-origin >output &&
-	test_cmp expect output &&
+	test_cmp expect output
+'
 
+test_expect_success '--show-origin with --get-regexp' '
 	cat >expect <<-EOF &&
 		file:$HOME/.gitconfig	user.global true
 		file:.git/config	user.local true
 	EOF
 	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
-	test_cmp expect output &&
+	test_cmp expect output
+'
 
+test_expect_success '--show-origin getting a single key' '
 	cat >expect <<-\EOF &&
 		file:.git/config	local
 	EOF
@@ -1279,11 +1296,13 @@ test_expect_success '--show-origin' '
 	test_cmp expect output
 '
 
-CUSTOM_CONFIG_FILE="file\twith\ttabs.conf" &&
-cat >"$CUSTOM_CONFIG_FILE" <<-\EOF &&
-	[user]
-		custom = true
-EOF
+test_expect_success 'set up custom config file' '
+	CUSTOM_CONFIG_FILE="file\twith\ttabs.conf" &&
+	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
+		[user]
+			custom = true
+	EOF
+'
 
 test_expect_success '--show-origin escape special file name characters' '
 	cat >expect <<-\EOF &&
@@ -1302,8 +1321,6 @@ test_expect_success '--show-origin stdin' '
 '
 
 test_expect_success '--show-origin stdin with file include' '
-	INCLUDE_DIR="$HOME/include" &&
-	mkdir -p "$INCLUDE_DIR" &&
 	cat >"$INCLUDE_DIR"/stdin.include <<-EOF &&
 		[user]
 			stdin = include
