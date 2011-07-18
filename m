From: Jeff King <peff@peff.net>
Subject: [PATCH 09/14] allow the user to configure credential helpers
Date: Mon, 18 Jul 2011 03:51:26 -0400
Message-ID: <20110718075126.GI12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:51:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiic1-0004i9-UM
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab1GRHv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:51:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50629
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab1GRHv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:51:28 -0400
Received: (qmail 19913 invoked by uid 107); 18 Jul 2011 07:51:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:51:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:51:26 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177352>

The functionality for helpers is already there; we just need
to give the users a way to turn it on.

The new functionality is enabled whenever a caller of the
credentials API passes a NULL method list. This will enable
it for all current callers (i.e., the http code).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-credentials.txt |    5 ++-
 config.c                                    |    4 +++
 credential.c                                |   31 +++++++++++++++++++++++---
 credential.h                                |    2 +
 t/t5550-http-fetch.sh                       |   13 +++++++++++
 5 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 880db92..335a007 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -25,8 +25,9 @@ Data Structures
 	The credential functions take a `string_list` of methods for
 	acquiring credentials. Each string specifies an external
 	helper which will be run, in order, to acquire credentials,
-	until both a username and password have been acquired. A NULL or
-	empty methods list indicates that the internal
+	until both a username and password have been acquired. A NULL
+	parameter means to use the default list (as configured by
+	`credential.helper`); an empty list indicates that the internal
 	`credential_getpass` function should be used.
 
 
diff --git a/config.c b/config.c
index 1fc063b..ee643eb 100644
--- a/config.c
+++ b/config.c
@@ -9,6 +9,7 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "credential.h"
 
 #define MAXNAME (256)
 
@@ -791,6 +792,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		return 0;
 	}
 
+	if (!prefixcmp(var, "credential."))
+		return git_default_credential_config(var, value);
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/credential.c b/credential.c
index 3a4104c..744d105 100644
--- a/credential.c
+++ b/credential.c
@@ -4,6 +4,8 @@
 #include "string-list.h"
 #include "run-command.h"
 
+static struct string_list default_methods;
+
 static int credential_config_callback(const char *var, const char *value,
 				      void *data)
 {
@@ -173,15 +175,18 @@ void credential_fill(struct credential *c, const struct string_list *methods)
 {
 	struct strbuf err = STRBUF_INIT;
 
+	if (!methods)
+		methods = &default_methods;
+
 	if (!credential_fill_gently(c, methods))
 		return;
 
 	strbuf_addstr(&err, "unable to get credentials");
 	if (c->description)
 		strbuf_addf(&err, "for '%s'", c->description);
-	if (methods && methods->nr == 1)
+	if (methods->nr == 1)
 		strbuf_addf(&err, "; tried '%s'", methods->items[0].string);
-	else if (methods) {
+	else {
 		int i;
 		strbuf_addstr(&err, "; tried:");
 		for (i = 0; i < methods->nr; i++)
@@ -198,7 +203,10 @@ int credential_fill_gently(struct credential *c,
 	if (c->username && c->password)
 		return 0;
 
-	if (!methods || !methods->nr)
+	if (!methods)
+		methods = &default_methods;
+
+	if (!methods->nr)
 		return credential_getpass(c);
 
 	for (i = 0; i < methods->nr; i++) {
@@ -214,7 +222,10 @@ void credential_reject(struct credential *c, const struct string_list *methods)
 {
 	int i;
 
-	if (methods && c->username) {
+	if (!methods)
+		methods = &default_methods;
+
+	if (c->username) {
 		for (i = 0; i < methods->nr; i++) {
 			/* ignore errors, there's nothing we can do */
 			credential_do(c, methods->items[i].string, "--reject");
@@ -226,3 +237,15 @@ void credential_reject(struct credential *c, const struct string_list *methods)
 	free(c->password);
 	c->password = NULL;
 }
+
+int git_default_credential_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "credential.helper")) {
+		if (!value)
+			return config_error_nonbool(var);
+		string_list_append(&default_methods, xstrdup(value));
+		return 0;
+	}
+
+	return 0;
+}
diff --git a/credential.h b/credential.h
index 30a0156..788ed8e 100644
--- a/credential.h
+++ b/credential.h
@@ -17,4 +17,6 @@ int credential_fill_gently(struct credential *, const struct string_list *method
 void credential_fill(struct credential *, const struct string_list *methods);
 void credential_reject(struct credential *, const struct string_list *methods);
 
+int git_default_credential_config(const char *var, const char *value);
+
 #endif /* CREDENTIAL_H */
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index c78baaf..407e1cb 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -93,6 +93,19 @@ test_expect_success 'http auth can pull user from config' '
 	test_cmp askpass-expect-pass askpass-query
 '
 
+test_expect_success 'http auth respects credential helpers' '
+	cat >credential-helper <<-\EOF &&
+	#!/bin/sh
+	echo username=user@host
+	echo password=user@host
+	EOF
+	chmod +x credential-helper &&
+	git config --global credential.helper "\"$PWD/credential-helper\"" &&
+	>askpass-query &&
+	git clone "$HTTPD_URL/auth/repo.git" clone-auth-helper &&
+	test_cmp askpass-expect-none askpass-query
+'
+
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
-- 
1.7.6.rc1.12.g65e2
