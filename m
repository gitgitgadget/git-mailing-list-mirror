From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] contrib: add a credential helper for Mac OS X's keychain
Date: Wed, 14 Sep 2011 13:58:37 -0400
Message-ID: <1316023117-84755-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 19:58:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3tjc-0008F0-L5
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 19:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249Ab1INR6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 13:58:51 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58699 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab1INR6u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 13:58:50 -0400
Received: by qyk30 with SMTP id 30so4178924qyk.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=uQ7MG9L44WRzH5F718zeZW363zvRY6TuMr5fDut3ySI=;
        b=rGqCT4LISU5viKfxBDDJz9yKNBpkVn6zyBP79pNbkfepeVuOhUS23Z5jYsxNO0BxUk
         X7rkCEDsVDGrhkPOGEQpydaMFRvvxrIEnuWWw5aNpAwEbcglPX6jdsIW0WMloPSs0qc7
         PmsBezgT/ja/6L3z2lO8u/6kzJwfGkowUzziU=
Received: by 10.229.66.7 with SMTP id l7mr148114qci.18.1316023129917;
        Wed, 14 Sep 2011 10:58:49 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id dv3sm5204606qab.12.2011.09.14.10.58.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 10:58:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc1.1.g011e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181370>

This credential helper adds, searches, and removes entries from
the Mac OS X keychain via OS X's Security Framework.

Tested with 10.6.8.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
And here's a C version. I cargo-culted the Makefile from
contrib/svn-fe/Makefile. Sadly, linking against git bloats the
binary quite a bit which is dissappointing since this helper
won't be installed as a hard-link. Hmm, maybe it can be if I
dlopen the security framework instead of linking against it.

 contrib/credential-osxkeychain/Makefile            |   35 ++++
 .../git-credential-osxkeychain.c                   |  205 ++++++++++++++++++++
 2 files changed, 240 insertions(+), 0 deletions(-)
 create mode 100644 contrib/credential-osxkeychain/Makefile
 create mode 100644 contrib/credential-osxkeychain/git-credential-osxkeychain.c

diff --git a/contrib/credential-osxkeychain/Makefile b/contrib/credential-osxkeychain/Makefile
new file mode 100644
index 0000000000..dc6bbbc3f9
--- /dev/null
+++ b/contrib/credential-osxkeychain/Makefile
@@ -0,0 +1,35 @@
+all:: git-credential-osxkeychain
+
+CC = gcc
+RM = rm -f
+CFLAGS = -O2 -Wall -I../.. -DSHA1_HEADER='<openssl/sha.h>'
+GIT_LIBS = ../../libgit.a ../../xdiff/lib.a
+LIBS = $(GIT_LIBS) -lz -liconv -lcrypto -lssl
+
+QUIET_SUBDIR0 = +$(MAKE) -C # space to separate -C and subdir
+QUIET_SUBDIR1 =
+
+ifneq ($(findstring $(MAKEFLAGS),w),w)
+PRINT_DIR = --no-print-directory
+else # "make -w"
+NO_SUBDIR = :
+endif
+
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifndef V
+	QUIET_CC      = @echo '   ' CC $@;
+	QUIET_LINK    = @echo '   ' LINK $@;
+	QUIET_SUBDIR0 = +@subdir=
+	QUIET_SUBDIR1 = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+	                $(MAKE) $(PRINT_DIR) -C $$subdir
+endif
+endif
+
+git-credential-osxkeychain: git-credential-osxkeychain.o $(GIT_LIBS)
+	$(QUIET_LINK)$(CC) -o $@ $< $(LIBS) -Wl,-framework -Wl,Security
+
+git-credential-osxkeychain.o: git-credential-osxkeychain.c
+	$(QUIET_CC)$(CC) -c $(CFLAGS) $<
+
+clean:
+	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
diff --git a/contrib/credential-osxkeychain/git-credential-osxkeychain.c b/contrib/credential-osxkeychain/git-credential-osxkeychain.c
new file mode 100644
index 0000000000..64bcc636cb
--- /dev/null
+++ b/contrib/credential-osxkeychain/git-credential-osxkeychain.c
@@ -0,0 +1,205 @@
+/* Copyright 2011 Jay Soffian. All rights reserved.
+ * FreeBSD License.
+ *
+ * A git credential helper that interfaces with the Mac OS X keychain
+ * via the Security framework.
+ */
+#include <stdlib.h>
+#include <Security/Security.h>
+#include "cache.h"
+#include "credential.h"
+#include "parse-options.h"
+
+void emit_user_pass(char *username, char *password)
+{
+	if (username)
+		printf("username=%s\n", username);
+	if (password)
+		printf("password=%s\n", password);
+}
+
+char *username_from_keychain_item(SecKeychainItemRef item)
+{
+	OSStatus status;
+	SecKeychainAttributeList list;
+	SecKeychainAttribute attr;
+	list.count = 1;
+	list.attr = &attr;
+	attr.tag = kSecAccountItemAttr;
+	char *username;
+
+	status = SecKeychainItemCopyContent(item, NULL, &list, NULL, NULL);
+	if (status != noErr)
+		return NULL;
+	username = xmalloc(attr.length + 1);
+	strncpy(username, attr.data, attr.length);
+	username[attr.length] = '\0';
+	SecKeychainItemFreeContent(&list, NULL);
+	return username;
+}
+
+int find_internet_password(SecProtocolType protocol,
+			   char *hostname,
+			   char *username)
+{
+	void *password_buf;
+	UInt32 password_len;
+	OSStatus status;
+	char *password;
+	int free_username;
+	SecKeychainItemRef item;
+
+	status = SecKeychainFindInternetPassword(
+			NULL,
+			strlen(hostname), hostname,
+			0, NULL,
+			username ? strlen(username) : 0, username,
+			0, NULL,
+			0,
+			protocol,
+			kSecAuthenticationTypeDefault,
+			&password_len, &password_buf,
+			&item);
+	if (status != noErr)
+		return -1;
+
+	password = xmalloc(password_len + 1);
+	strncpy(password, password_buf, password_len);
+	password[password_len] = '\0';
+	SecKeychainItemFreeContent(NULL, password_buf);
+	if (!username) {
+		username = username_from_keychain_item(item);
+		free_username = 1;
+	}
+	emit_user_pass(username, password);
+	if (free_username)
+		free(username);
+	free(password);
+	return 0;
+}
+
+void delete_internet_password(SecProtocolType protocol,
+			      char *hostname,
+			      char *username)
+{
+	OSStatus status;
+	SecKeychainItemRef item;
+
+	status = SecKeychainFindInternetPassword(
+			NULL,
+			strlen(hostname), hostname,
+			0, NULL,
+			username ? strlen(username) : 0, username,
+			0, NULL,
+			0,
+			protocol,
+			kSecAuthenticationTypeDefault,
+			0, NULL,
+			&item);
+	if (status != noErr)
+		return;
+	SecKeychainItemDelete(item);
+}
+
+void add_internet_password(SecProtocolType protocol,
+			   char *hostname,
+			   char *username,
+			   char *password,
+			   char *comment)
+{
+	struct strbuf label = STRBUF_INIT;
+	OSStatus status;
+	SecKeychainItemRef item;
+	SecKeychainAttributeList list;
+	SecKeychainAttribute attr;
+	list.count = 1;
+	list.attr = &attr;
+	status = SecKeychainAddInternetPassword(
+			NULL,
+			strlen(hostname), hostname,
+			0, NULL,
+			strlen(username), username,
+			0, NULL,
+			0,
+			protocol,
+			kSecAuthenticationTypeDefault,
+			strlen(password), password,
+			&item);
+	if (status != noErr)
+		return;
+
+	/* set the comment */
+	attr.tag = kSecCommentItemAttr;
+	attr.data = comment;
+	attr.length = strlen(comment);
+	SecKeychainItemModifyContent(item, &list, 0, NULL);
+
+	/* override the label */
+	strbuf_addf(&label, "%s (%s)", hostname, username);
+	attr.tag = kSecLabelItemAttr;
+	attr.data = label.buf;
+	attr.length = label.len;
+	SecKeychainItemModifyContent(item, &list, 0, NULL);
+}
+
+int main(int argc, const char **argv)
+{
+	const char * const usage[] = {
+		"git credential-osxkeychain [options]",
+		NULL
+	};
+	struct credential c = { NULL };
+	int reject = 0;
+	SecProtocolType protocol;
+	char *hostname;
+	struct option options[] = {
+		OPT_BOOLEAN(0, "reject", &reject,
+			    "reject a stored credential"),
+		OPT_STRING(0, "username", &c.username, "name",
+			   "an existing username"),
+		OPT_STRING(0, "description", &c.description, "desc",
+			   "human-readable description of the credential"),
+		OPT_STRING(0, "unique", &c.unique, "token",
+			   "a unique context for the credential [REQUIRED]"),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (argc)
+		usage_with_options(usage, options);
+
+	if (!c.unique)
+		die(_("--unique option required"));
+	hostname = strchr(c.unique, ':');
+	if (!hostname)
+		die(_("Invalid token: '%s'"), c.unique);
+	*hostname++ = '\0';
+
+	/* "GitHub for Mac" compatibility */
+	if (!strcmp(hostname, "github.com"))
+		hostname = "github.com/mac";
+
+	if (!strcmp(c.unique, "https")) {
+		protocol = kSecProtocolTypeHTTPS;
+	} else if (!strcmp(c.unique, "http")) {
+		protocol = kSecProtocolTypeHTTP;
+	}
+	else
+		die(_("Unsupported protocol: '%s'"), c.unique);
+
+	/* if this is a rejection delete the existing creds */
+	if (reject) {
+		delete_internet_password(protocol, hostname, c.username);
+		return 0;
+	}
+
+	/* otherwise look for a matching keychain item */
+	if (!find_internet_password(protocol, hostname, c.username))
+		return 0;
+
+	/* no keychain item found, prompt the user and store the result */
+	credential_getpass(&c);
+	add_internet_password(protocol, hostname, c.username, c.password,
+			      c.description ? c.description : "default");
+	emit_user_pass(c.username, c.password);
+	return 0;
+}
-- 
1.7.7.rc1.1.g011e1
