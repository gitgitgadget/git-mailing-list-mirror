From: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] t5550: factor out http auth setup
Date: Mon, 27 Aug 2012 09:24:31 -0400
Message-ID: <20120827132431.GB17375@sigill.intra.peff.net>
References: <20120827132145.GA17265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:24:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zJ5-0001Nx-86
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389Ab2H0NYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:24:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39688 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab2H0NYd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 09:24:33 -0400
Received: (qmail 12778 invoked by uid 107); 27 Aug 2012 13:24:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 09:24:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 09:24:31 -0400
Content-Disposition: inline
In-Reply-To: <20120827132145.GA17265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204335>

The t5550 script sets up a nice askpass helper for
simulating user input and checking what git prompted for.
Let's make it available to other http scripts by migrating
it to lib-httpd.

We can use this immediately in t5540 to make our tests more
robust (previously, we did not check at all that hitting the
password-protected repo actually involved a password).
Unfortunately, we end up failing the test because the
current code erroneously prompts twice (once for
git-remote-http, and then again when the former spawns
git-http-push).

More importantly, though, it will let us easily add
smart-http authentication tests in t5541 and t5551; we
currently do not test smart-http authentication at all.

As part of making it generic, let's always look for and
store auxiliary askpass files at the top-level trash
directory; this makes it compatible with t5540, which runs
some tests from sub-repositories. We can abstract away the
ugliness with a short helper function.

Signed-off-by: Jeff King <peff@peff.net>
---
If we do backport this to v1.7.8-era, note that write_script did not
exist then.

 t/lib-httpd.sh        | 39 +++++++++++++++++++++++++++++++++++++
 t/t5540-http-push.sh  | 17 ++++++++---------
 t/t5550-http-fetch.sh | 53 ++++++++-------------------------------------------
 3 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d773542..02f442b 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -167,3 +167,42 @@ test_http_push_nonff() {
 		test_i18ngrep "Updates were rejected because" output
 	'
 }
+
+setup_askpass_helper() {
+	test_expect_success 'setup askpass helper' '
+		write_script "$TRASH_DIRECTORY/askpass" <<-\EOF &&
+		echo >>"$TRASH_DIRECTORY/askpass-query" "askpass: $*" &&
+		cat "$TRASH_DIRECTORY/askpass-response"
+		EOF
+		GIT_ASKPASS="$TRASH_DIRECTORY/askpass" &&
+		export GIT_ASKPASS &&
+		export TRASH_DIRECTORY
+	'
+}
+
+set_askpass() {
+	>"$TRASH_DIRECTORY/askpass-query" &&
+	echo "$*" >"$TRASH_DIRECTORY/askpass-response"
+}
+
+expect_askpass() {
+	dest=$HTTPD_DEST
+	{
+		case "$1" in
+		none)
+			;;
+		pass)
+			echo "askpass: Password for 'http://$2@$dest': "
+			;;
+		both)
+			echo "askpass: Username for 'http://$dest': "
+			echo "askpass: Password for 'http://$2@$dest': "
+			;;
+		*)
+			false
+			;;
+		esac
+	} >"$TRASH_DIRECTORY/askpass-expect" &&
+	test_cmp "$TRASH_DIRECTORY/askpass-expect" \
+		 "$TRASH_DIRECTORY/askpass-query"
+}
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 1eea647..f141f2d 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -46,15 +46,7 @@ test_expect_success 'create password-protected repository' '
 	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git"
 '
 
-test_expect_success 'setup askpass helper' '
-	cat >askpass <<-\EOF &&
-	#!/bin/sh
-	echo user@host
-	EOF
-	chmod +x askpass &&
-	GIT_ASKPASS="$PWD/askpass" &&
-	export GIT_ASKPASS
-'
+setup_askpass_helper
 
 test_expect_success 'clone remote repository' '
 	cd "$ROOT_PATH" &&
@@ -162,6 +154,7 @@ test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 
 test_expect_success 'push to password-protected repository (user in URL)' '
 	test_commit pw-user &&
+	set_askpass user@host &&
 	git push "$HTTPD_URL_USER/auth/dumb/test_repo.git" HEAD &&
 	git rev-parse --verify HEAD >expect &&
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git" \
@@ -169,9 +162,15 @@ test_expect_success 'push to password-protected repository (user in URL)' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'user was prompted only once for password' '
+	expect_askpass pass user@host
+'
+
 test_expect_failure 'push to password-protected repository (no user in URL)' '
 	test_commit pw-nouser &&
+	set_askpass user@host &&
 	git push "$HTTPD_URL/auth/dumb/test_repo.git" HEAD &&
+	expect_askpass both user@host
 	git rev-parse --verify HEAD >expect &&
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git" \
 		rev-parse --verify HEAD >actual &&
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 5ad2123..16ef041 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -46,62 +46,28 @@ test_expect_success 'create password-protected repository' '
 	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git"
 '
 
-test_expect_success 'setup askpass helpers' '
-	cat >askpass <<-EOF &&
-	#!/bin/sh
-	echo >>"$PWD/askpass-query" "askpass: \$*" &&
-	cat "$PWD/askpass-response"
-	EOF
-	chmod +x askpass &&
-	GIT_ASKPASS="$PWD/askpass" &&
-	export GIT_ASKPASS
-'
-
-expect_askpass() {
-	dest=$HTTPD_DEST
-	{
-		case "$1" in
-		none)
-			;;
-		pass)
-			echo "askpass: Password for 'http://$2@$dest': "
-			;;
-		both)
-			echo "askpass: Username for 'http://$dest': "
-			echo "askpass: Password for 'http://$2@$dest': "
-			;;
-		*)
-			false
-			;;
-		esac
-	} >askpass-expect &&
-	test_cmp askpass-expect askpass-query
-}
+setup_askpass_helper
 
 test_expect_success 'cloning password-protected repository can fail' '
-	>askpass-query &&
-	echo wrong >askpass-response &&
+	set_askpass wrong &&
 	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-fail &&
 	expect_askpass both wrong
 '
 
 test_expect_success 'http auth can use user/pass in URL' '
-	>askpass-query &&
-	echo wrong >askpass-response &&
+	set_askpass wrong &&
 	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
 	expect_askpass none
 '
 
 test_expect_success 'http auth can use just user in URL' '
-	>askpass-query &&
-	echo user@host >askpass-response &&
+	set_askpass user@host &&
 	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-pass &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'http auth can request both user and pass' '
-	>askpass-query &&
-	echo user@host >askpass-response &&
+	set_askpass user@host &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-both &&
 	expect_askpass both user@host
 '
@@ -112,24 +78,21 @@ test_expect_success 'http auth respects credential helper config' '
 		echo username=user@host
 		echo password=user@host
 	}; f" &&
-	>askpass-query &&
-	echo wrong >askpass-response &&
+	set_askpass wrong &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-helper &&
 	expect_askpass none
 '
 
 test_expect_success 'http auth can get username from config' '
 	test_config_global "credential.$HTTPD_URL.username" user@host &&
-	>askpass-query &&
-	echo user@host >askpass-response &&
+	set_askpass user@host &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-user &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'configured username does not override URL' '
 	test_config_global "credential.$HTTPD_URL.username" wrong &&
-	>askpass-query &&
-	echo user@host >askpass-response &&
+	set_askpass user@host &&
 	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-user2 &&
 	expect_askpass pass user@host
 '
-- 
1.7.11.5.10.g3c8125b
