From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop unnecessary copying in credential_ask_one
Date: Thu, 2 Jan 2014 02:38:35 -0500
Message-ID: <20140102073835.GA5431@sigill.intra.peff.net>
References: <1388624793-5563-1-git-send-email-rctay89@gmail.com>
 <20140102030330.GA10976@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 08:38:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vycrl-0005YU-N0
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 08:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbaABHii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 02:38:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:53772 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750711AbaABHih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 02:38:37 -0500
Received: (qmail 3974 invoked by uid 102); 2 Jan 2014 07:38:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jan 2014 01:38:37 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jan 2014 02:38:35 -0500
Content-Disposition: inline
In-Reply-To: <20140102030330.GA10976@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239850>

On Wed, Jan 01, 2014 at 10:03:30PM -0500, Jeff King wrote:

> On Thu, Jan 02, 2014 at 09:06:33AM +0800, Tay Ray Chuan wrote:
> 
> > We were leaking memory in there, as after obtaining a string from
> > git_getpass, we returned a copy of it, yet no one else held the original
> > string, apart from credential_ask_one.
> 
> I don't think this change is correct by itself.
> 
> credential_ask_one calls git_prompt. That function in turn calls
> git_terminal_prompt, which returns a pointer to a static buffer (because
> it may be backed by the system getpass() implementation).
> 
> So there is no leak there, and dropping the strdup would be bad (the
> call to ask for the password would overwrite the value we got for the
> username).

By the way, you can see the breakage from your patch pretty easily by
testing the terminal input. Disable any credential helper config you
have, and then run:

  GIT_CURL_VERBOSE=1 \
  git ls-remote https://github.com/peff/ask-for-auth 2>&1 |
  perl -lne '/Authorization: Basic (.*)/ and print $1' |
  openssl base64 -d

enter "myuser" and "mypass" respectively on the terminal. The result is
that we send "mypass:mypass" to the server. And then double-free the
result, which cases glibc to barf.

I wondered why we did not see this breakage in test suite. My assumption
was that it was simply because our test user has the same username and
password. So I fixed that, but to my surprise we still did not detect
the problem. The issue is that your patch does the right thing when
GIT_ASKPASS is in use, and breaks only when the user types into the
terminal. But the test suite, of course, always uses askpass because it
cannot rely on accessing a terminal (we'd have to do some magic with
lib-terminal, I think).

So it doesn't detect the problem in your patch, but I wonder if it is
worth applying the patch below anyway, as it makes the test suite
slightly more robust.

-- >8 --
Subject: use distinct username/password for http auth tests

The httpd server we set up to test git's http client code
knows about a single account, in which both the username and
password are "user@host" (the unusual use of the "@" here is
to verify that we handle the character correctly when URL
escaped).

This means that we may miss a certain class of errors in
which the username and password are mixed up internally by
git. We can make our tests more robust by having distinct
values for the username and password.

In addition to tweaking the server passwd file and the
client URL, we must teach the "askpass" harness to accept
multiple values. As a bonus, this makes the setup of some
tests more obvious; when we are expecting git to ask
only about the password, we can seed the username askpass
response with a bogus value.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh        | 15 ++++++++++++---
 t/lib-httpd/passwd    |  2 +-
 t/t5540-http-push.sh  |  4 ++--
 t/t5541-http-push.sh  |  6 +++---
 t/t5550-http-fetch.sh | 10 +++++-----
 t/t5551-http-fetch.sh |  6 +++---
 6 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index c470784..bfdff2a 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -129,7 +129,7 @@ prepare_httpd() {
 	HTTPD_DEST=127.0.0.1:$LIB_HTTPD_PORT
 	HTTPD_URL=$HTTPD_PROTO://$HTTPD_DEST
 	HTTPD_URL_USER=$HTTPD_PROTO://user%40host@$HTTPD_DEST
-	HTTPD_URL_USER_PASS=$HTTPD_PROTO://user%40host:user%40host@$HTTPD_DEST
+	HTTPD_URL_USER_PASS=$HTTPD_PROTO://user%40host:pass%40host@$HTTPD_DEST
 
 	if test -n "$LIB_HTTPD_DAV" -o -n "$LIB_HTTPD_SVN"
 	then
@@ -217,7 +217,15 @@ setup_askpass_helper() {
 	test_expect_success 'setup askpass helper' '
 		write_script "$TRASH_DIRECTORY/askpass" <<-\EOF &&
 		echo >>"$TRASH_DIRECTORY/askpass-query" "askpass: $*" &&
-		cat "$TRASH_DIRECTORY/askpass-response"
+		case "$*" in
+		*Username*)
+			what=user
+			;;
+		*Password*)
+			what=pass
+			;;
+		esac &&
+		cat "$TRASH_DIRECTORY/askpass-$what"
 		EOF
 		GIT_ASKPASS="$TRASH_DIRECTORY/askpass" &&
 		export GIT_ASKPASS &&
@@ -227,7 +235,8 @@ setup_askpass_helper() {
 
 set_askpass() {
 	>"$TRASH_DIRECTORY/askpass-query" &&
-	echo "$*" >"$TRASH_DIRECTORY/askpass-response"
+	echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
+	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
 }
 
 expect_askpass() {
diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
index f2fbcad..99a34d6 100644
--- a/t/lib-httpd/passwd
+++ b/t/lib-httpd/passwd
@@ -1 +1 @@
-user@host:nKpa8pZUHx/ic
+user@host:xb4E8pqD81KQs
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 01d0d95..5b0198c 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -154,7 +154,7 @@ test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 
 test_expect_success 'push to password-protected repository (user in URL)' '
 	test_commit pw-user &&
-	set_askpass user@host &&
+	set_askpass user@host pass@host &&
 	git push "$HTTPD_URL_USER/auth/dumb/test_repo.git" HEAD &&
 	git rev-parse --verify HEAD >expect &&
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git" \
@@ -168,7 +168,7 @@ test_expect_failure 'user was prompted only once for password' '
 
 test_expect_failure 'push to password-protected repository (no user in URL)' '
 	test_commit pw-nouser &&
-	set_askpass user@host &&
+	set_askpass user@host pass@host &&
 	git push "$HTTPD_URL/auth/dumb/test_repo.git" HEAD &&
 	expect_askpass both user@host
 	git rev-parse --verify HEAD >expect &&
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 470ac54..bfd241e 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -274,7 +274,7 @@ test_expect_success 'push over smart http with auth' '
 	cd "$ROOT_PATH/test_repo_clone" &&
 	echo push-auth-test >expect &&
 	test_commit push-auth-test &&
-	set_askpass user@host &&
+	set_askpass user@host pass@host &&
 	git push "$HTTPD_URL"/auth/smart/test_repo.git &&
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" \
 		log -1 --format=%s >actual &&
@@ -286,7 +286,7 @@ test_expect_success 'push to auth-only-for-push repo' '
 	cd "$ROOT_PATH/test_repo_clone" &&
 	echo push-half-auth >expect &&
 	test_commit push-half-auth &&
-	set_askpass user@host &&
+	set_askpass user@host pass@host &&
 	git push "$HTTPD_URL"/auth-push/smart/test_repo.git &&
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" \
 		log -1 --format=%s >actual &&
@@ -316,7 +316,7 @@ test_expect_success 'push into half-auth-complete requires password' '
 	cd "$ROOT_PATH/half-auth-clone" &&
 	echo two >expect &&
 	test_commit two &&
-	set_askpass user@host &&
+	set_askpass user@host pass@host &&
 	git push "$HTTPD_URL/half-auth-complete/smart/half-auth.git" &&
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/half-auth.git" \
 		log -1 --format=%s >actual &&
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index f7d0f14..8392624 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -62,13 +62,13 @@ test_expect_success 'http auth can use user/pass in URL' '
 '
 
 test_expect_success 'http auth can use just user in URL' '
-	set_askpass user@host &&
+	set_askpass wrong pass@host &&
 	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-pass &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'http auth can request both user and pass' '
-	set_askpass user@host &&
+	set_askpass user@host pass@host &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-both &&
 	expect_askpass both user@host
 '
@@ -77,7 +77,7 @@ test_expect_success 'http auth respects credential helper config' '
 	test_config_global credential.helper "!f() {
 		cat >/dev/null
 		echo username=user@host
-		echo password=user@host
+		echo password=pass@host
 	}; f" &&
 	set_askpass wrong &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-helper &&
@@ -86,14 +86,14 @@ test_expect_success 'http auth respects credential helper config' '
 
 test_expect_success 'http auth can get username from config' '
 	test_config_global "credential.$HTTPD_URL.username" user@host &&
-	set_askpass user@host &&
+	set_askpass wrong pass@host &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-user &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'configured username does not override URL' '
 	test_config_global "credential.$HTTPD_URL.username" wrong &&
-	set_askpass user@host &&
+	set_askpass wrong pass@host &&
 	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-user2 &&
 	expect_askpass pass user@host
 '
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index afb439e..a124efe 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -119,7 +119,7 @@ test_expect_success 'redirects re-root further requests' '
 
 test_expect_success 'clone from password-protected repository' '
 	echo two >expect &&
-	set_askpass user@host &&
+	set_askpass user@host pass@host &&
 	git clone --bare "$HTTPD_URL/auth/smart/repo.git" smart-auth &&
 	expect_askpass both user@host &&
 	git --git-dir=smart-auth log -1 --format=%s >actual &&
@@ -137,7 +137,7 @@ test_expect_success 'clone from auth-only-for-push repository' '
 
 test_expect_success 'clone from auth-only-for-objects repository' '
 	echo two >expect &&
-	set_askpass user@host &&
+	set_askpass user@host pass@host &&
 	git clone --bare "$HTTPD_URL/auth-fetch/smart/repo.git" half-auth &&
 	expect_askpass both user@host &&
 	git --git-dir=half-auth log -1 --format=%s >actual &&
@@ -151,7 +151,7 @@ test_expect_success 'no-op half-auth fetch does not require a password' '
 '
 
 test_expect_success 'redirects send auth to new location' '
-	set_askpass user@host &&
+	set_askpass user@host pass@host &&
 	git -c credential.useHttpPath=true \
 	  clone $HTTPD_URL/smart-redir-auth/repo.git repo-redir-auth &&
 	expect_askpass both user@host auth/smart/repo.git
-- 
1.8.5.2.437.g500496c
