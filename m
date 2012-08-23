From: "Philipp A. Hartmann" <pah@qo.cx>
Subject: [PATCH 1/4] contrib: add credential helper for GnomeKeyring
Date: Thu, 23 Aug 2012 18:57:45 +0200
Message-ID: <1345741068-11004-2-git-send-email-pah@qo.cx>
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
	id 1T4asT-0005um-L3
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 19:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758982Ab2HWRHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 13:07:09 -0400
Received: from offis4.offis.uni-oldenburg.de ([134.106.51.109]:34517 "EHLO
	offis4.offis.uni-oldenburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757565Ab2HWRHE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 13:07:04 -0400
Received: by offis4.offis.uni-oldenburg.de (Postfix, from userid 1003)
	id 5002E741DB0; Thu, 23 Aug 2012 18:58:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	offis4.offis.uni-oldenburg.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.3.2
X-Spam-DCC: : offis4 1282; Body=3 Fuz1=3 Fuz2=3
X-Spam-score: -1.7 ()
X-Spam-hits: -1.7
Received: from localhost (ritchie.offis.uni-oldenburg.de [134.106.53.254])
	by offis4.offis.uni-oldenburg.de (Postfix) with ESMTP id 790D7741CF2;
	Thu, 23 Aug 2012 18:58:08 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1345741068-11004-1-git-send-email-pah@qo.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204158>

From: "Philipp A. Hartmann" <pah@qo.cx>

With this installed in your $PATH, you can store
git-over-http passwords in your keyring by doing:

git config credential.helper gnome-keyring

The code is based in large part on the work of John Szakmeister
who wrote the helper originally for the initial, unpublished
version of the credential helper protocol.

This version will pass t0303 if you do:

  GIT_TEST_CREDENTIAL_HELPER=gnome-keyring \
  ./t0303-credential-external.sh

Signed-off-by: Philipp A. Hartmann <pah@qo.cx>
---
 contrib/credential/gnome-keyring/.gitignore        |    1 +
 contrib/credential/gnome-keyring/Makefile          |   24 ++
 .../gnome-keyring/git-credential-gnome-keyring.c   |  445 ++++++++++++++++++++
 3 files changed, 470 insertions(+)
 create mode 100644 contrib/credential/gnome-keyring/.gitignore
 create mode 100644 contrib/credential/gnome-keyring/Makefile
 create mode 100644 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c

diff --git a/contrib/credential/gnome-keyring/.gitignore b/contrib/credential/gnome-keyring/.gitignore
new file mode 100644
index 0000000..88d8fcd
--- /dev/null
+++ b/contrib/credential/gnome-keyring/.gitignore
@@ -0,0 +1 @@
+git-credential-gnome-keyring
diff --git a/contrib/credential/gnome-keyring/Makefile b/contrib/credential/gnome-keyring/Makefile
new file mode 100644
index 0000000..e6561d8
--- /dev/null
+++ b/contrib/credential/gnome-keyring/Makefile
@@ -0,0 +1,24 @@
+MAIN:=git-credential-gnome-keyring
+all:: $(MAIN)
+
+CC = gcc
+RM = rm -f
+CFLAGS = -g -O2 -Wall
+
+-include ../../../config.mak.autogen
+-include ../../../config.mak
+
+INCS:=$(shell pkg-config --cflags gnome-keyring-1)
+LIBS:=$(shell pkg-config --libs gnome-keyring-1)
+
+SRCS:=$(MAIN).c
+OBJS:=$(SRCS:.c=.o)
+
+%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(INCS) -o $@ -c $<
+
+$(MAIN): $(OBJS)
+	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
+
+clean:
+	@$(RM) $(MAIN) $(OBJS)
diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
new file mode 100644
index 0000000..41f61c5
--- /dev/null
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -0,0 +1,445 @@
+/*
+ * Copyright (C) 2011 John Szakmeister <john@szakmeister.net>
+ *               2012 Philipp A. Hartmann <pah@qo.cx>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * Credits:
+ * - GNOME Keyring API handling originally written by John Szakmeister
+ * - ported to credential helper API by Philipp A. Hartmann
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <gnome-keyring.h>
+
+/*
+ * This credential struct and API is simplified from git's credential.{h,c}
+ */
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
+struct credential_operation const credential_helper_ops[];
+
+/* ---------------- common helper functions ----------------- */
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
+/* ----------------- GNOME Keyring functions ----------------- */
+
+/* create a special keyring option string, if path is given */
+static char* keyring_object(struct credential *c)
+{
+	char* object = NULL;
+
+	if (!c->path)
+		return object;
+
+	object = (char*) malloc(strlen(c->host)+strlen(c->path)+8);
+	if(!object)
+		die_errno(errno);
+
+	if(c->port)
+		sprintf(object,"%s:%hd/%s",c->host,c->port,c->path);
+	else
+		sprintf(object,"%s/%s",c->host,c->path);
+
+	return object;
+}
+
+int keyring_get(struct credential *c)
+{
+	char* object = NULL;
+	GList *entries;
+	GnomeKeyringNetworkPasswordData *password_data;
+	GnomeKeyringResult result;
+
+	if (!c->protocol || !(c->host || c->path))
+		return EXIT_FAILURE;
+
+	object = keyring_object(c);
+
+	result = gnome_keyring_find_network_password_sync(
+				c->username,
+				NULL /* domain */,
+				c->host,
+				object,
+				c->protocol,
+				NULL /* authtype */,
+				c->port,
+				&entries);
+
+	free(object);
+
+	if (result == GNOME_KEYRING_RESULT_NO_MATCH)
+		return EXIT_SUCCESS;
+
+	if (result == GNOME_KEYRING_RESULT_CANCELLED)
+		return EXIT_SUCCESS;
+
+	if (result != GNOME_KEYRING_RESULT_OK) {
+		error("%s",gnome_keyring_result_to_message(result));
+		return EXIT_FAILURE;
+	}
+
+	/* pick the first one from the list */
+	password_data = (GnomeKeyringNetworkPasswordData *) entries->data;
+
+	free_password(c->password);
+	c->password = xstrdup(password_data->password);
+
+	if (!c->username)
+		c->username = xstrdup(password_data->user);
+
+	gnome_keyring_network_password_list_free(entries);
+
+	return EXIT_SUCCESS;
+}
+
+
+int keyring_store(struct credential *c)
+{
+	guint32 item_id;
+	char  *object = NULL;
+
+	/*
+	 * Sanity check that what we are storing is actually sensible.
+	 * In particular, we can't make a URL without a protocol field.
+	 * Without either a host or pathname (depending on the scheme),
+	 * we have no primary key. And without a username and password,
+	 * we are not actually storing a credential.
+	 */
+	if (!c->protocol || !(c->host || c->path) ||
+	    !c->username || !c->password)
+		return EXIT_FAILURE;
+
+	object = keyring_object(c);
+
+	gnome_keyring_set_network_password_sync(
+				GNOME_KEYRING_DEFAULT,
+				c->username,
+				NULL /* domain */,
+				c->host,
+				object,
+				c->protocol,
+				NULL /* authtype */,
+				c->port,
+				c->password,
+				&item_id);
+
+	free(object);
+	return EXIT_SUCCESS;
+}
+
+int keyring_erase(struct credential *c)
+{
+	char  *object = NULL;
+	GList *entries;
+	GnomeKeyringNetworkPasswordData *password_data;
+	GnomeKeyringResult result;
+
+	/*
+	 * Sanity check that we actually have something to match
+	 * against. The input we get is a restrictive pattern,
+	 * so technically a blank credential means "erase everything".
+	 * But it is too easy to accidentally send this, since it is equivalent
+	 * to empty input. So explicitly disallow it, and require that the
+	 * pattern have some actual content to match.
+	 */
+	if (!c->protocol && !c->host && !c->path && !c->username)
+		return EXIT_FAILURE;
+
+	object = keyring_object(c);
+
+	result = gnome_keyring_find_network_password_sync(
+				c->username,
+				NULL /* domain */,
+				c->host,
+				object,
+				c->protocol,
+				NULL /* authtype */,
+				c->port,
+				&entries);
+
+	free(object);
+
+	if (result == GNOME_KEYRING_RESULT_NO_MATCH)
+		return EXIT_SUCCESS;
+
+	if (result == GNOME_KEYRING_RESULT_CANCELLED)
+		return EXIT_SUCCESS;
+
+	if (result != GNOME_KEYRING_RESULT_OK)
+	{
+		error("%s",gnome_keyring_result_to_message(result));
+		return EXIT_FAILURE;
+	}
+
+	/* pick the first one from the list (delete all matches?) */
+	password_data = (GnomeKeyringNetworkPasswordData *) entries->data;
+
+	result = gnome_keyring_item_delete_sync(
+		password_data->keyring, password_data->item_id);
+
+	gnome_keyring_network_password_list_free(entries);
+
+	if (result != GNOME_KEYRING_RESULT_OK)
+	{
+		error("%s",gnome_keyring_result_to_message(result));
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
+
+/*
+ * Table with helper operation callbacks, used by generic
+ * credential helper main function.
+ */
+struct credential_operation const credential_helper_ops[] =
+{
+	{ "get",   keyring_get   },
+	{ "store", keyring_store },
+	{ "erase", keyring_erase },
+	CREDENTIAL_OP_END
+};
+
+/* ------------------ credential functions ------------------ */
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
-- 
1.7.10.4
