From: "Philipp A. Hartmann" <pah@qo.cx>
Subject: [PATCH 2/4] contrib: add generic credential helper
Date: Thu, 23 Aug 2012 18:57:46 +0200
Message-ID: <1345741068-11004-3-git-send-email-pah@qo.cx>
References: <1345741068-11004-1-git-send-email-pah@qo.cx>
Cc: Jeff King <peff@peff.net>, John Szakmeister <john@szakmeister.net>,
	"Philipp A. Hartmann" <pah@qo.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 19:07:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4asV-0005um-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 19:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759100Ab2HWRHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 13:07:16 -0400
Received: from offis4.offis.uni-oldenburg.de ([134.106.51.109]:34518 "EHLO
	offis4.offis.uni-oldenburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755591Ab2HWRHE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 13:07:04 -0400
Received: by offis4.offis.uni-oldenburg.de (Postfix, from userid 1003)
	id 17F95741DA9; Thu, 23 Aug 2012 18:58:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	offis4.offis.uni-oldenburg.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.3.2
X-Spam-DCC: : offis4 1282; Body=3 Fuz1=3 Fuz2=3
X-Spam-score: -1.7 ()
X-Spam-hits: -1.7
Received: from localhost (ritchie.offis.uni-oldenburg.de [134.106.53.254])
	by offis4.offis.uni-oldenburg.de (Postfix) with ESMTP id 57B96741DA7;
	Thu, 23 Aug 2012 18:58:09 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1345741068-11004-1-git-send-email-pah@qo.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204157>

From: "Philipp A. Hartmann" <pah@qo.cx>

This adds a generic implementation for credential helpers.

It provides a header file credential_helper.h containing
a simplified credential API and common helper functions.
The implementation in credential_helper.c already provides
a main() function and chooses the credential operation
from a function table:

  struct credential_operation const credential_helper_ops[] =
  {
      { "get",   my_backend_get   },
      { "store", my_backend_store },
      { "erase", my_backend_erase },
      CREDENTIAL_OP_END
  };

With this, a specific credential helper backend usually only
needs to implement these operation callbacks.

Signed-off-by: Philipp A. Hartmann <pah@qo.cx>
---
 contrib/credential/helper/credential_helper.c |  149 +++++++++++++++++++++++++
 contrib/credential/helper/credential_helper.h |  116 +++++++++++++++++++
 2 files changed, 265 insertions(+)
 create mode 100644 contrib/credential/helper/credential_helper.c
 create mode 100644 contrib/credential/helper/credential_helper.h

diff --git a/contrib/credential/helper/credential_helper.c b/contrib/credential/helper/credential_helper.c
new file mode 100644
index 0000000..e99c2ec
--- /dev/null
+++ b/contrib/credential/helper/credential_helper.c
@@ -0,0 +1,149 @@
+/*
+ * Copyright (C) 2012 Philipp A. Hartmann <pah@qo.cx>
+ *
+ * This file is licensed under the GPL v2, or a later version
+ * at the discretion of Linus.
+ *
+ * This credential struct and API is simplified from git's
+ * credential.{h,c} to be used within credential helper
+ * implementations.
+ */
+
+#include <credential_helper.h>
+
+void credential_init(struct credential *c)
+{
+	memset(c, 0, sizeof(*c));
+}
+
+void credential_clear(struct credential *c)
+{
+	free(c->protocol);
+	free(c->host);
+	free(c->path);
+	free(c->username);
+	free_password(c->password);
+
+	credential_init(c);
+}
+
+int credential_read(struct credential *c)
+{
+	char    buf[1024];
+	ssize_t line_len = 0;
+	char   *key      = buf;
+	char   *value;
+
+	while (fgets(buf, sizeof(buf), stdin))
+	{
+		line_len = strlen(buf);
+
+		if(buf[line_len-1]=='\n')
+			buf[--line_len]='\0';
+
+		if(!line_len)
+			break;
+
+		value = strchr(buf,'=');
+		if(!value) {
+			warning("invalid credential line: %s", key);
+			return -1;
+		}
+		*value++ = '\0';
+
+		if (!strcmp(key, "protocol")) {
+			free(c->protocol);
+			c->protocol = xstrdup(value);
+		} else if (!strcmp(key, "host")) {
+			free(c->host);
+			c->host = xstrdup(value);
+			value = strrchr(c->host,':');
+			if (value) {
+				*value++ = '\0';
+				c->port = atoi(value);
+			}
+		} else if (!strcmp(key, "path")) {
+			free(c->path);
+			c->path = xstrdup(value);
+		} else if (!strcmp(key, "username")) {
+			free(c->username);
+			c->username = xstrdup(value);
+		} else if (!strcmp(key, "password")) {
+			free_password(c->password);
+			c->password = xstrdup(value);
+			while (*value) *value++ = '\0';
+		}
+		/*
+		 * Ignore other lines; we don't know what they mean, but
+		 * this future-proofs us when later versions of git do
+		 * learn new lines, and the helpers are updated to match.
+		 */
+	}
+	return 0;
+}
+
+void credential_write_item(FILE *fp, const char *key, const char *value)
+{
+	if (!value)
+		return;
+	fprintf(fp, "%s=%s\n", key, value);
+}
+
+void credential_write(const struct credential *c)
+{
+	/* only write username/password, if set */
+	credential_write_item(stdout, "username", c->username);
+	credential_write_item(stdout, "password", c->password);
+}
+
+static void usage(const char *name)
+{
+	struct credential_operation const *try_op = credential_helper_ops;
+	const char *basename = strrchr(name,'/');
+
+	basename = (basename) ? basename + 1 : name;
+	fprintf(stderr, "Usage: %s <", basename);
+	while(try_op->name) {
+		fprintf(stderr,"%s",(try_op++)->name);
+		if(try_op->name)
+			fprintf(stderr,"%s","|");
+	}
+	fprintf(stderr,"%s",">\n");
+}
+
+/*
+ * generic main function for credential helpers
+ */
+int main(int argc, char *argv[])
+{
+	int ret = EXIT_SUCCESS;
+
+	struct credential_operation const *try_op = credential_helper_ops;
+	struct credential                  cred   = CREDENTIAL_INIT;
+
+	if (!argv[1]) {
+		usage(argv[0]);
+		goto out;
+	}
+
+	/* lookup operation callback */
+	while(try_op->name && strcmp(argv[1], try_op->name))
+		try_op++;
+
+	/* unsupported operation given -- ignore silently */
+	if(!try_op->name || !try_op->op)
+		goto out;
+
+	ret = credential_read(&cred);
+	if(ret)
+		goto out;
+
+	/* perform credential operation */
+	ret = (*try_op->op)(&cred);
+
+	credential_write(&cred);
+
+out:
+	credential_clear(&cred);
+	return ret;
+}
diff --git a/contrib/credential/helper/credential_helper.h b/contrib/credential/helper/credential_helper.h
new file mode 100644
index 0000000..8266078
--- /dev/null
+++ b/contrib/credential/helper/credential_helper.h
@@ -0,0 +1,116 @@
+/*
+ * Copyright (C) 2012 Philipp A. Hartmann <pah@qo.cx>
+ *
+ * This file is licensed under the GPL v2, or a later version
+ * at the discretion of Linus.
+ *
+ * This credential struct and API is simplified from git's
+ * credential.{h,c} to be used within credential helper
+ * implementations.
+ */
+#ifndef CREDENTIAL_HELPER_H_INCLUDED_
+#define CREDENTIAL_HELPER_H_INCLUDED_
+
+#include <stdio.h>
+#include <string.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <errno.h>
+
+struct credential
+{
+	char          *protocol;
+	char          *host;
+	unsigned short port;
+	char          *path;
+	char          *username;
+	char          *password;
+};
+
+#define CREDENTIAL_INIT \
+  { NULL,NULL,0,NULL,NULL,NULL }
+
+void credential_init(struct credential *c);
+void credential_clear(struct credential *c);
+int  credential_read(struct credential *c);
+void credential_write(const struct credential *c);
+
+typedef int (*credential_op_cb)(struct credential*);
+
+struct credential_operation
+{
+	char             *name;
+	credential_op_cb op;
+};
+
+#define CREDENTIAL_OP_END \
+  { NULL,NULL }
+
+/*
+ * Table with operation callbacks is defined in concrete
+ * credential helper implementation and contains entries
+ * like { "get", function_to_get_credential } terminated
+ * by CREDENTIAL_OP_END.
+ */
+extern struct credential_operation const credential_helper_ops[];
+
+/* ---------------- common helper functions ---------------- */
+
+static inline void free_password(char *password)
+{
+	char *c = password;
+	if (!password)
+		return;
+
+	while (*c) *c++ = '\0';
+	free(password);
+}
+
+static inline void warning(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	fprintf(stderr, "warning: ");
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n" );
+	va_end(ap);
+}
+
+static inline void error(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	fprintf(stderr, "error: ");
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n" );
+	va_end(ap);
+}
+
+static inline void die(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap,fmt);
+	error(fmt, ap);
+	va_end(ap);
+	exit(EXIT_FAILURE);
+}
+
+static inline void die_errno(int err)
+{
+	error("%s", strerror(err));
+	exit(EXIT_FAILURE);
+}
+
+static inline char *xstrdup(const char *str)
+{
+	char *ret = strdup(str);
+	if (!ret)
+		die_errno(errno);
+
+	return ret;
+}
+
+#endif /* CREDENTIAL_HELPER_H_INCLUDED_ */
-- 
1.7.10.4
