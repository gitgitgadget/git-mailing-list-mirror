From: Jeff King <peff@peff.net>
Subject: [PATCHv3 08/13] credential: make relevance of http path configurable
Date: Sat, 10 Dec 2011 05:31:34 -0500
Message-ID: <20111210103133.GH16529@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKDT-0005y2-UV
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab1LJKbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:31:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47018
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab1LJKbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:31:36 -0500
Received: (qmail 14016 invoked by uid 107); 10 Dec 2011 10:38:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:38:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:31:34 -0500
Content-Disposition: inline
In-Reply-To: <20111210102827.GA16460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186740>

When parsing a URL into a credential struct, we carefully
record each part of the URL, including the path on the
remote host, and use the result as part of the credential
context.

This had two practical implications:

  1. Credential helpers which store a credential for later
     access are likely to use the "path" portion as part of
     the storage key. That means that a request to

       https://example.com/foo.git

     would not use the same credential that was stored in an
     earlier request for:

       https://example.com/bar.git

  2. The prompt shown to the user includes all relevant
     context, including the path.

In most cases, however, users will have a single password
per host. The behavior in (1) will be inconvenient, and the
prompt in (2) will be overly long.

This patch introduces a config option to toggle the
relevance of http paths. When turned on, we use the path as
before. When turned off, we drop the path component from the
context: helpers don't see it, and it does not appear in the
prompt.

This is nothing you couldn't do with a clever credential
helper at the start of your stack, like:

  [credential "http://"]
	helper = "!f() { grep -v ^path= ; }; f"
	helper = your_real_helper

But doing this:

  [credential]
	useHttpPath = false

is way easier and more readable. Furthermore, since most
users will want the "off" behavior, that is the new default.
Users who want it "on" can set the variable (either for all
credentials, or just for a subset using
credential.*.useHttpPath).

Signed-off-by: Jeff King <peff@peff.net>
---
 credential.c           |   14 ++++++++++++++
 credential.h           |    3 ++-
 t/t0300-credentials.sh |   29 +++++++++++++++++++++++++++++
 t/t5550-http-fetch.sh  |    2 +-
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/credential.c b/credential.c
index 3c17ea1..a17eafe 100644
--- a/credential.c
+++ b/credential.c
@@ -69,16 +69,30 @@ static int credential_config_callback(const char *var, const char *value,
 		if (!c->username)
 			c->username = xstrdup(value);
 	}
+	else if (!strcmp(key, "usehttppath"))
+		c->use_http_path = git_config_bool(var, value);
 
 	return 0;
 }
 
+static int proto_is_http(const char *s)
+{
+	if (!s)
+		return 0;
+	return !strcmp(s, "https") || !strcmp(s, "http");
+}
+
 static void credential_apply_config(struct credential *c)
 {
 	if (c->configured)
 		return;
 	git_config(credential_config_callback, c);
 	c->configured = 1;
+
+	if (!c->use_http_path && proto_is_http(c->protocol)) {
+		free(c->path);
+		c->path = NULL;
+	}
 }
 
 static void credential_describe(struct credential *c, struct strbuf *out)
diff --git a/credential.h b/credential.h
index e504272..96ea41b 100644
--- a/credential.h
+++ b/credential.h
@@ -6,7 +6,8 @@
 struct credential {
 	struct string_list helpers;
 	unsigned approved:1,
-		 configured:1;
+		 configured:1,
+		 use_http_path:1;
 
 	char *username;
 	char *password;
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 53e94bc..885af8f 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -247,4 +247,33 @@ test_expect_success 'pull username from config' '
 	EOF
 '
 
+test_expect_success 'http paths can be part of context' '
+	check fill "verbatim foo bar" <<-\EOF &&
+	protocol=https
+	host=example.com
+	path=foo.git
+	--
+	username=foo
+	password=bar
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=example.com
+	EOF
+	test_config credential.https://example.com.useHttpPath true &&
+	check fill "verbatim foo bar" <<-\EOF
+	protocol=https
+	host=example.com
+	path=foo.git
+	--
+	username=foo
+	password=bar
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=example.com
+	verbatim: path=foo.git
+	EOF
+'
+
 test_done
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 3262f90..95a133d 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -53,7 +53,7 @@ test_expect_success 'setup askpass helpers' '
 '
 
 expect_askpass() {
-	dest=$HTTPD_DEST/auth/repo.git
+	dest=$HTTPD_DEST
 	{
 		case "$1" in
 		none)
-- 
1.7.8.rc2.40.gaf387
