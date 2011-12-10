From: Jeff King <peff@peff.net>
Subject: [PATCHv3 06/13] credential: apply helper config
Date: Sat, 10 Dec 2011 05:31:24 -0500
Message-ID: <20111210103124.GF16529@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:31:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKDJ-0005uf-K2
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab1LJKb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:31:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47012
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab1LJKb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:31:26 -0500
Received: (qmail 13959 invoked by uid 107); 10 Dec 2011 10:38:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:38:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:31:24 -0500
Content-Disposition: inline
In-Reply-To: <20111210102827.GA16460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186737>

The functionality for credential storage helpers is already
there; we just need to give the users a way to turn it on.
This patch provides a "credential.helper" configuration
variable which allows the user to provide one or more helper
strings.

Rather than simply matching credential.helper, we will also
compare URLs in subsection headings to the current context.
This means you can apply configuration to a subset of
credentials. For example:

  [credential "https://example.com"]
	helper = foo

would match a request for "https://example.com/foo.git", but
not one for "https://kernel.org/foo.git".

This is overkill for the "helper" variable, since users are
unlikely to want different helpers for different sites (and
since helpers run arbitrary code, they could do the matching
themselves anyway).

However, future patches will add new config variables where
this extra feature will be more useful.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential.c           |   61 ++++++++++++++++++++++++++++++++++++++++++++++++
 credential.h           |    5 +++-
 t/t0300-credentials.sh |   42 +++++++++++++++++++++++++++++++++
 t/t5550-http-fetch.sh  |   12 +++++++++
 4 files changed, 119 insertions(+), 1 deletions(-)

diff --git a/credential.c b/credential.c
index c349b9a..96be1c2 100644
--- a/credential.c
+++ b/credential.c
@@ -22,6 +22,61 @@ void credential_clear(struct credential *c)
 	credential_init(c);
 }
 
+int credential_match(const struct credential *want,
+		     const struct credential *have)
+{
+#define CHECK(x) (!want->x || (have->x && !strcmp(want->x, have->x)))
+	return CHECK(protocol) &&
+	       CHECK(host) &&
+	       CHECK(path) &&
+	       CHECK(username);
+#undef CHECK
+}
+
+static int credential_config_callback(const char *var, const char *value,
+				      void *data)
+{
+	struct credential *c = data;
+	const char *key, *dot;
+
+	key = skip_prefix(var, "credential.");
+	if (!key)
+		return 0;
+
+	if (!value)
+		return config_error_nonbool(var);
+
+	dot = strrchr(key, '.');
+	if (dot) {
+		struct credential want = CREDENTIAL_INIT;
+		char *url = xmemdupz(key, dot - key);
+		int matched;
+
+		credential_from_url(&want, url);
+		matched = credential_match(&want, c);
+
+		credential_clear(&want);
+		free(url);
+
+		if (!matched)
+			return 0;
+		key = dot + 1;
+	}
+
+	if (!strcmp(key, "helper"))
+		string_list_append(&c->helpers, value);
+
+	return 0;
+}
+
+static void credential_apply_config(struct credential *c)
+{
+	if (c->configured)
+		return;
+	git_config(credential_config_callback, c);
+	c->configured = 1;
+}
+
 static void credential_describe(struct credential *c, struct strbuf *out)
 {
 	if (!c->protocol)
@@ -195,6 +250,8 @@ void credential_fill(struct credential *c)
 	if (c->username && c->password)
 		return;
 
+	credential_apply_config(c);
+
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
 		if (c->username && c->password)
@@ -215,6 +272,8 @@ void credential_approve(struct credential *c)
 	if (!c->username || !c->password)
 		return;
 
+	credential_apply_config(c);
+
 	for (i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "store");
 	c->approved = 1;
@@ -224,6 +283,8 @@ void credential_reject(struct credential *c)
 {
 	int i;
 
+	credential_apply_config(c);
+
 	for (i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "erase");
 
diff --git a/credential.h b/credential.h
index 8a6d162..e504272 100644
--- a/credential.h
+++ b/credential.h
@@ -5,7 +5,8 @@
 
 struct credential {
 	struct string_list helpers;
-	unsigned approved:1;
+	unsigned approved:1,
+		 configured:1;
 
 	char *username;
 	char *password;
@@ -25,5 +26,7 @@ struct credential {
 
 int credential_read(struct credential *, FILE *);
 void credential_from_url(struct credential *, const char *url);
+int credential_match(const struct credential *have,
+		     const struct credential *want);
 
 #endif /* CREDENTIAL_H */
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 81a455f..42d0f5b 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -192,4 +192,46 @@ test_expect_success 'internal getpass does not ask for known username' '
 	EOF
 '
 
+HELPER="!f() {
+		cat >/dev/null
+		echo username=foo
+		echo password=bar
+	}; f"
+test_expect_success 'respect configured credentials' '
+	test_config credential.helper "$HELPER" &&
+	check fill <<-\EOF
+	--
+	username=foo
+	password=bar
+	--
+	EOF
+'
+
+test_expect_success 'match configured credential' '
+	test_config credential.https://example.com.helper "$HELPER" &&
+	check fill <<-\EOF
+	protocol=https
+	host=example.com
+	path=repo.git
+	--
+	username=foo
+	password=bar
+	--
+	EOF
+'
+
+test_expect_success 'do not match configured credential' '
+	test_config credential.https://foo.helper "$HELPER" &&
+	check fill <<-\EOF
+	protocol=https
+	host=bar
+	--
+	username=askpass-username
+	password=askpass-password
+	--
+	askpass: Username for '\''https://bar'\'':
+	askpass: Password for '\''https://askpass-username@bar'\'':
+	EOF
+'
+
 test_done
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 398a2d2..c59908f 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -101,6 +101,18 @@ test_expect_success 'http auth can request both user and pass' '
 	expect_askpass both user@host
 '
 
+test_expect_success 'http auth respects credential helper config' '
+	test_config_global credential.helper "!f() {
+		cat >/dev/null
+		echo username=user@host
+		echo password=user@host
+	}; f" &&
+	>askpass-query &&
+	echo wrong >askpass-response &&
+	git clone "$HTTPD_URL/auth/repo.git" clone-auth-helper &&
+	expect_askpass none
+'
+
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
-- 
1.7.8.rc2.40.gaf387
