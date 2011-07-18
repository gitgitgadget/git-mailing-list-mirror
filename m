From: Jeff King <peff@peff.net>
Subject: [PATCH 08/14] look for credentials in config before prompting
Date: Mon, 18 Jul 2011 03:51:08 -0400
Message-ID: <20110718075108.GH12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:51:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiibn-0004bH-Pt
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab1GRHvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:51:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50627
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab1GRHvK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:51:10 -0400
Received: (qmail 19885 invoked by uid 107); 18 Jul 2011 07:51:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:51:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:51:08 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177351>

When an http request receives a 401, we ask the user for
both a username and password. While it's generally not a
good idea for us to store the password in plaintext, having
to input the username each time is annoying, and can be
easily solved with a config variable.

This patch teaches the credential subsystem to look up items
in the git config file before prompting. Items are indexed
by the "unique" token passed to the credential system.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential.c           |   38 ++++++++++++++++++++++++++++++++++++++
 credential.h           |    1 +
 t/t0300-credentials.sh |   10 ++++++++++
 t/t5550-http-fetch.sh  |    8 ++++++++
 4 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/credential.c b/credential.c
index c403289..3a4104c 100644
--- a/credential.c
+++ b/credential.c
@@ -4,6 +4,43 @@
 #include "string-list.h"
 #include "run-command.h"
 
+static int credential_config_callback(const char *var, const char *value,
+				      void *data)
+{
+	struct credential *c = data;
+
+	if (!value)
+		return 0;
+
+	var = skip_prefix(var, "credential.");
+	if (!var)
+		return 0;
+
+	var = skip_prefix(var, c->unique);
+	if (!var)
+		return 0;
+
+	if (*var != '.')
+		return 0;
+	var++;
+
+	if (!strcmp(var, "username")) {
+		if (!c->username)
+			c->username = xstrdup(value);
+	}
+	else if (!strcmp(var, "password")) {
+		free(c->password);
+		c->password = xstrdup(value);
+	}
+	return 0;
+}
+
+void credential_from_config(struct credential *c)
+{
+	if (c->unique)
+		git_config(credential_config_callback, c);
+}
+
 static char *credential_ask_one(const char *what, const char *desc)
 {
 	struct strbuf prompt = STRBUF_INIT;
@@ -26,6 +63,7 @@ static char *credential_ask_one(const char *what, const char *desc)
 
 int credential_getpass(struct credential *c)
 {
+	credential_from_config(c);
 
 	if (!c->username)
 		c->username = credential_ask_one("Username", c->description);
diff --git a/credential.h b/credential.h
index 383b720..30a0156 100644
--- a/credential.h
+++ b/credential.h
@@ -11,6 +11,7 @@ struct credential {
 struct string_list;
 
 int credential_getpass(struct credential *);
+void credential_from_config(struct credential *);
 
 int credential_fill_gently(struct credential *, const struct string_list *methods);
 void credential_fill(struct credential *, const struct string_list *methods);
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 447e983..68d838c 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -172,4 +172,14 @@ test_expect_success 'internal getpass does not ask for known username' '
 	EOF
 '
 
+test_expect_success 'internal getpass can pull from config' '
+	git config credential.foo.username configured-username
+	check --unique=foo <<-\EOF
+	username=configured-username
+	password=askpass-result
+	--
+	askpass: Password:
+	EOF
+'
+
 test_done
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index af3bc6b..c78baaf 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -85,6 +85,14 @@ test_expect_success 'http auth can request both user and pass' '
 	test_cmp askpass-expect-both askpass-query
 '
 
+test_expect_success 'http auth can pull user from config' '
+	>askpass-query &&
+	echo user@host >askpass-response &&
+	git config --global credential.$HTTPD_PROTO:$HTTPD_DEST.username user@host &&
+	git clone "$HTTPD_URL/auth/repo.git" clone-auth-config &&
+	test_cmp askpass-expect-pass askpass-query
+'
+
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
-- 
1.7.6.rc1.12.g65e2
