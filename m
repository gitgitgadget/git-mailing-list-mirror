From: "Philipp A. Hartmann" <pah@qo.cx>
Subject: [PATCH 4/4] osxkeychain: port to generic credential helper implementation
Date: Thu, 23 Aug 2012 18:57:48 +0200
Message-ID: <1345741068-11004-5-git-send-email-pah@qo.cx>
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
	id 1T4asV-0005um-33
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 19:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759096Ab2HWRHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 13:07:12 -0400
Received: from offis4.offis.uni-oldenburg.de ([134.106.51.109]:34514 "EHLO
	offis4.offis.uni-oldenburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755128Ab2HWRHE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 13:07:04 -0400
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 13:07:03 EDT
Received: by offis4.offis.uni-oldenburg.de (Postfix, from userid 1003)
	id E0645741D79; Thu, 23 Aug 2012 18:58:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	offis4.offis.uni-oldenburg.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.3.2
X-Spam-DCC: : offis4 1282; Body=1 Fuz1=1 Fuz2=1
X-Spam-score: -1.7 ()
X-Spam-hits: -1.7
Received: from localhost (ritchie.offis.uni-oldenburg.de [134.106.53.254])
	by offis4.offis.uni-oldenburg.de (Postfix) with ESMTP id 9250E741DAD;
	Thu, 23 Aug 2012 18:58:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1345741068-11004-1-git-send-email-pah@qo.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204156>

From: "Philipp A. Hartmann" <pah@qo.cx>

This reduces code duplication in the osxkeychain helper by
basing the implementation on the generic helper implementation.

Alongside, the return codes of the helper are tightened to be
more consistent in corner cases and the memory containing
cleartext passwords is explicitly cleared when possible.

Signed-off-by: Philipp A. Hartmann <pah@qo.cx>
---
 contrib/credential/helper/credential_helper.h      |    9 +
 contrib/credential/osxkeychain/Makefile            |   22 ++-
 .../osxkeychain/git-credential-osxkeychain.c       |  183 ++++++++------------
 3 files changed, 96 insertions(+), 118 deletions(-)

diff --git a/contrib/credential/helper/credential_helper.h b/contrib/credential/helper/credential_helper.h
index 8266078..76b6e50 100644
--- a/contrib/credential/helper/credential_helper.h
+++ b/contrib/credential/helper/credential_helper.h
@@ -113,4 +113,13 @@ static inline char *xstrdup(const char *str)
 	return ret;
 }
 
+static inline char *xstrndup(const char *str, size_t len)
+{
+	char *ret = strndup(str,len);
+	if (!ret)
+		die_errno(errno);
+
+	return ret;
+}
+
 #endif /* CREDENTIAL_HELPER_H_INCLUDED_ */
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 4b3a08a..64ee7c5 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -1,4 +1,5 @@
-all:: git-credential-osxkeychain
+MAIN:=git-credential-osxkeychain
+all:: $(MAIN)
 
 CC = gcc
 RM = rm -f
@@ -7,11 +8,20 @@ CFLAGS = -g -O2 -Wall
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
-git-credential-osxkeychain: git-credential-osxkeychain.o
-	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) -Wl,-framework -Wl,Security
+INCS:=
+LIBS:=-Wl,-framework -Wl,Security
+HELPER:=../helper
+VPATH +=$(HELPER)
 
-git-credential-osxkeychain.o: git-credential-osxkeychain.c
-	$(CC) -c $(CFLAGS) $<
+SRCS:=$(MAIN).c
+SRCS+=credential_helper.c
+OBJS:=$(SRCS:.c=.o)
+
+%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) -I$(HELPER) $(INCS) -o $@ -c $<
+
+$(MAIN): $(OBJS)
+	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
 
 clean:
-	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
+	@$(RM) $(MAIN) $(OBJS)
diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 6beed12..60bd973 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -1,53 +1,40 @@
+
+#include <credential_helper.h>
+
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
 #include <Security/Security.h>
 
 static SecProtocolType protocol;
-static char *host;
-static char *path;
-static char *username;
-static char *password;
-static UInt16 port;
-
-static void die(const char *err, ...)
-{
-	char msg[4096];
-	va_list params;
-	va_start(params, err);
-	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s\n", msg);
-	va_end(params);
-	exit(1);
-}
-
-static void *xstrdup(const char *s1)
-{
-	void *ret = strdup(s1);
-	if (!ret)
-		die("Out of memory");
-	return ret;
-}
 
 #define KEYCHAIN_ITEM(x) (x ? strlen(x) : 0), x
-#define KEYCHAIN_ARGS \
+#define KEYCHAIN_ARGS(c) \
 	NULL, /* default keychain */ \
-	KEYCHAIN_ITEM(host), \
+	KEYCHAIN_ITEM(c->host), \
 	0, NULL, /* account domain */ \
-	KEYCHAIN_ITEM(username), \
-	KEYCHAIN_ITEM(path), \
-	port, \
+	KEYCHAIN_ITEM(c->username), \
+	KEYCHAIN_ITEM(c->path), \
+	(UInt16) c->port, \
 	protocol, \
 	kSecAuthenticationTypeDefault
 
-static void write_item(const char *what, const char *buf, int len)
+static int prepare_internet_password(struct credential *c)
 {
-	printf("%s=", what);
-	fwrite(buf, 1, len, stdout);
-	putchar('\n');
+	if (!c->protocol)
+		return -1;
+	else if (!strcmp(c->protocol, "https"))
+		protocol = kSecProtocolTypeHTTPS;
+	else if (!strcmp(c->protocol, "http"))
+		protocol = kSecProtocolTypeHTTP;
+	else /* we don't yet handle other protocols */
+		return -1;
+
+	return 0;
 }
 
-static void find_username_in_item(SecKeychainItemRef item)
+static void
+find_username_in_item(SecKeychainItemRef item, struct credential *c)
 {
 	SecKeychainAttributeList list;
 	SecKeychainAttribute attr;
@@ -59,27 +46,37 @@ static void find_username_in_item(SecKeychainItemRef item)
 	if (SecKeychainItemCopyContent(item, NULL, &list, NULL, NULL))
 		return;
 
-	write_item("username", attr.data, attr.length);
+	free(c->username);
+	c->username = xstrndup(attr.data, attr.length);
+
 	SecKeychainItemFreeContent(&list, NULL);
 }
 
-static void find_internet_password(void)
+static int find_internet_password(struct credential *c)
 {
 	void *buf;
 	UInt32 len;
 	SecKeychainItemRef item;
 
-	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, &len, &buf, &item))
-		return;
+	/* Silently ignore unsupported protocols */
+	if (prepare_internet_password(c))
+		return EXIT_SUCCESS;
 
-	write_item("password", buf, len);
-	if (!username)
-		find_username_in_item(item);
+	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS(c), &len, &buf, &item))
+		return EXIT_SUCCESS;
+
+	free_password(c->password);
+	c->password = xstrndup(buf, len);
+	memset(buf,len,'\0');
+
+	if (!c->username)
+		find_username_in_item(item, c);
 
 	SecKeychainItemFreeContent(NULL, buf);
+	return EXIT_SUCCESS;
 }
 
-static void delete_internet_password(void)
+static int delete_internet_password(struct credential *c)
 {
 	SecKeychainItemRef item;
 
@@ -88,86 +85,48 @@ static void delete_internet_password(void)
 	 * will give us; if you want to do something more fancy, use the
 	 * Keychain manager.
 	 */
-	if (!protocol || !host)
-		return;
+	if (!c->protocol || !c->host)
+		return EXIT_FAILURE;
 
-	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, 0, NULL, &item))
-		return;
+	/* Silently ignore unsupported protocols */
+	if (prepare_internet_password(c))
+		return EXIT_SUCCESS;
+
+	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS(c), 0, NULL, &item))
+		return EXIT_SUCCESS;
 
-	SecKeychainItemDelete(item);
+	if (!SecKeychainItemDelete(item))
+		return EXIT_SUCCESS;
+
+	return EXIT_FAILURE;
 }
 
-static void add_internet_password(void)
+static int add_internet_password(struct credential *c)
 {
 	/* Only store complete credentials */
-	if (!protocol || !host || !username || !password)
-		return;
+	if (!c->protocol || !c->host || !c->username || !c->password)
+		return EXIT_FAILURE;
+
+	if (prepare_internet_password(c))
+		return EXIT_FAILURE;
 
 	if (SecKeychainAddInternetPassword(
-	      KEYCHAIN_ARGS,
-	      KEYCHAIN_ITEM(password),
+	      KEYCHAIN_ARGS(c),
+	      KEYCHAIN_ITEM(c->password),
 	      NULL))
-		return;
-}
+		return EXIT_FAILURE;
 
-static void read_credential(void)
-{
-	char buf[1024];
-
-	while (fgets(buf, sizeof(buf), stdin)) {
-		char *v;
-
-		if (!strcmp(buf, "\n"))
-			break;
-		buf[strlen(buf)-1] = '\0';
-
-		v = strchr(buf, '=');
-		if (!v)
-			die("bad input: %s", buf);
-		*v++ = '\0';
-
-		if (!strcmp(buf, "protocol")) {
-			if (!strcmp(v, "https"))
-				protocol = kSecProtocolTypeHTTPS;
-			else if (!strcmp(v, "http"))
-				protocol = kSecProtocolTypeHTTP;
-			else /* we don't yet handle other protocols */
-				exit(0);
-		}
-		else if (!strcmp(buf, "host")) {
-			char *colon = strchr(v, ':');
-			if (colon) {
-				*colon++ = '\0';
-				port = atoi(colon);
-			}
-			host = xstrdup(v);
-		}
-		else if (!strcmp(buf, "path"))
-			path = xstrdup(v);
-		else if (!strcmp(buf, "username"))
-			username = xstrdup(v);
-		else if (!strcmp(buf, "password"))
-			password = xstrdup(v);
-	}
+	return EXIT_SUCCESS;
 }
 
-int main(int argc, const char **argv)
+/*
+ * Table with helper operation callbacks, used by generic
+ * credential helper main function.
+ */
+struct credential_operation const credential_helper_ops[] =
 {
-	const char *usage =
-		"Usage: git credential-osxkeychain <get|store|erase>";
-
-	if (!argv[1])
-		die(usage);
-
-	read_credential();
-
-	if (!strcmp(argv[1], "get"))
-		find_internet_password();
-	else if (!strcmp(argv[1], "store"))
-		add_internet_password();
-	else if (!strcmp(argv[1], "erase"))
-		delete_internet_password();
-	/* otherwise, ignore unknown action */
-
-	return 0;
-}
+	{ "get",   find_internet_password   },
+	{ "store", add_internet_password    },
+	{ "erase", delete_internet_password },
+	CREDENTIAL_OP_END
+};
-- 
1.7.10.4
