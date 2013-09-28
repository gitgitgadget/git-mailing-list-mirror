From: Jeff King <peff@peff.net>
Subject: [PATCH 9/9] remote-curl: rewrite base url from info/refs redirects
Date: Sat, 28 Sep 2013 04:35:35 -0400
Message-ID: <20130928083535.GD2782@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:35:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPq06-0005OQ-V5
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964Ab3I1Ifi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:35:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:35181 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754960Ab3I1Ifh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:35:37 -0400
Received: (qmail 8926 invoked by uid 102); 28 Sep 2013 08:35:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:35:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:35:35 -0400
Content-Disposition: inline
In-Reply-To: <20130928082956.GA22610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235498>

For efficiency and security reasons, an earlier commit in
this series taught http_get_* to re-write the base url based
on redirections we saw while making a specific request.

This commit wires that option into the info/refs request,
meaning that a redirect from

    http://example.com/foo.git/info/refs

to

    https://example.com/bar.git/info/refs

will behave as if "https://example.com/bar.git" had been
provided to git in the first place.

The tests bear some explanation. We introduce two new
hierearchies into the httpd test config:

  1. Requests to /smart-redir-limited will work only for the
     initial info/refs request, but not any subsequent
     requests. As a result, we can confirm whether the
     client is re-rooting its requests after the initial
     contact, since otherwise it will fail (it will ask for
     "repo.git/git-upload-pack", which is not redirected).

  2. Requests to smart-redir-auth will redirect, and require
     auth after the redirection. Since we are using the
     redirected base for further requests, we also update
     the credential struct, in order not to mislead the user
     (or credential helpers) about which credential is
     needed. We can therefore check the GIT_ASKPASS prompts
     to make sure we are prompting for the new location.
     Because we have neither multiple servers nor https
     support in our test setup, we can only redirect between
     paths, meaning we need to turn on
     credential.useHttpPath to see the difference.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c           |  4 ++++
 t/lib-httpd.sh          |  3 ++-
 t/lib-httpd/apache.conf |  2 ++
 t/t5551-http-fetch.sh   | 11 +++++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 5add2cb..c9b891a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -207,6 +207,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	struct strbuf type = STRBUF_INIT;
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf refs_url = STRBUF_INIT;
+	struct strbuf effective_url = STRBUF_INIT;
 	struct discovery *last = last_discovery;
 	int http_ret, maybe_smart = 0;
 	struct http_get_options options;
@@ -228,6 +229,8 @@ static struct discovery* discover_refs(const char *service, int for_push)
 
 	memset(&options, 0, sizeof(options));
 	options.content_type = &type;
+	options.effective_url = &effective_url;
+	options.base_url = &url;
 	options.no_cache = 1;
 	options.keep_error = 1;
 
@@ -287,6 +290,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	strbuf_release(&refs_url);
 	strbuf_release(&exp);
 	strbuf_release(&type);
+	strbuf_release(&effective_url);
 	strbuf_release(&buffer);
 	last_discovery = last;
 	return last;
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 54dbbfe..ad8f1ef 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -204,7 +204,8 @@ expect_askpass() {
 }
 
 expect_askpass() {
-	dest=$HTTPD_DEST
+	dest=$HTTPD_DEST${3+/$3}
+
 	{
 		case "$1" in
 		none)
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 397c480..3a03e82 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -110,6 +110,8 @@ RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
 RewriteEngine on
 RewriteRule ^/smart-redir-perm/(.*)$ /smart/$1 [R=301]
 RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
+RewriteRule ^/smart-redir-auth/(.*)$ /auth/smart/$1 [R=301]
+RewriteRule ^/smart-redir-limited/(.*)/info/refs$ /smart/$1/info/refs [R=301]
 
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 8196af1..fb16833 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -113,6 +113,10 @@ test_expect_success 'follow redirects (302)' '
 	git clone $HTTPD_URL/smart-redir-temp/repo.git --quiet repo-t
 '
 
+test_expect_success 'redirects re-root further requests' '
+	git clone $HTTPD_URL/smart-redir-limited/repo.git repo-redir-limited
+'
+
 test_expect_success 'clone from password-protected repository' '
 	echo two >expect &&
 	set_askpass user@host &&
@@ -146,6 +150,13 @@ test_expect_success 'no-op half-auth fetch does not require a password' '
 	expect_askpass none
 '
 
+test_expect_success 'redirects send auth to new location' '
+	set_askpass user@host &&
+	git -c credential.useHttpPath=true \
+	  clone $HTTPD_URL/smart-redir-auth/repo.git repo-redir-auth &&
+	expect_askpass both user@host auth/smart/repo.git
+'
+
 test_expect_success 'disable dumb http on server' '
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
 		config http.getanyfile false
-- 
1.8.4.rc3.19.g9da5bf6
