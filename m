From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] credential-osxkeychain: load Security framework dynamically
Date: Wed, 14 Sep 2011 18:55:26 -0400
Message-ID: <1316040926-89429-1-git-send-email-jaysoffian@gmail.com>
References: <1316023117-84755-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 00:55:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3yMl-0000vK-Sn
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 00:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020Ab1INWze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 18:55:34 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34956 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab1INWzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 18:55:33 -0400
Received: by qyk30 with SMTP id 30so4497565qyk.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 15:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0AFsLfRko00UbqVDpD5XPnZS2H/BFcRUSCDyz4NGunY=;
        b=AO6ONRd7fTarTtOtdmNKYvm0061NVv1MBmP6WeA7RwTiMNXEpMqXO4m8IRsFk7QnOO
         pNcVVqQILff6NaObp5rwcbzbVrrq78jQdOCv8O159E7PjTUjf57zPVGUb9mkfXBABrWC
         g6s3ECYNosbz8iYO/ZvVGWEgyT28v1q6vmKLU=
Received: by 10.229.101.14 with SMTP id a14mr332064qco.164.1316040932396;
        Wed, 14 Sep 2011 15:55:32 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id t16sm5790119qaa.25.2011.09.14.15.55.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 15:55:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc1.1.g011e1
In-Reply-To: <1316023117-84755-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181406>

Use dlopen() / dysym() instead of dynmically linking to the
Security framework. A followup commit will refactor things such
that git-credential-osxkeychain can be hardlinked to git.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
> Hmm, maybe it can be if I dlopen the security framework instead of linking
> against it.

Something like this. I'm going to pause here for feedback. Is the (not yet
existant) followup commit referenced above allowing git-credential-osxkeychain
to be a hard link to git a worthwhile endeavor? Or would a better approach be
to make git-credential-osxkeychain.c not use any git code?

 contrib/credential-osxkeychain/Makefile            |   12 +++-
 .../credential-osxkeychain/generate_security.py    |   73 ++++++++++++++++++++
 2 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100755 contrib/credential-osxkeychain/generate_security.py

diff --git a/contrib/credential-osxkeychain/Makefile b/contrib/credential-osxkeychain/Makefile
index dc6bbbc3f9..001d695cb8 100644
--- a/contrib/credential-osxkeychain/Makefile
+++ b/contrib/credential-osxkeychain/Makefile
@@ -25,11 +25,17 @@ ifndef V
 endif
 endif
 
-git-credential-osxkeychain: git-credential-osxkeychain.o $(GIT_LIBS)
-	$(QUIET_LINK)$(CC) -o $@ $< $(LIBS) -Wl,-framework -Wl,Security
+git-credential-osxkeychain: git-credential-osxkeychain.o security.o $(GIT_LIBS)
+	$(QUIET_LINK)$(CC) -o $@ $< security.o $(LIBS)
 
 git-credential-osxkeychain.o: git-credential-osxkeychain.c
 	$(QUIET_CC)$(CC) -c $(CFLAGS) $<
 
+security.o: security.c
+	$(QUIET_CC)$(CC) -c $(CFLAGS) $<
+
+security.c: generate_security.py
+	python generate_security.py
+
 clean:
-	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
+	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o security.?
diff --git a/contrib/credential-osxkeychain/generate_security.py b/contrib/credential-osxkeychain/generate_security.py
new file mode 100755
index 0000000000..db94672e95
--- /dev/null
+++ b/contrib/credential-osxkeychain/generate_security.py
@@ -0,0 +1,73 @@
+#!/usr/bin/python
+
+import re
+
+func_decls = """
+OSStatus SecKeychainAddInternetPassword(SecKeychainRef keychain, UInt32 serverNameLength, const char *serverName, UInt32 securityDomainLength, const char *securityDomain, UInt32 accountNameLength, const char *accountName, UInt32 pathLength, const char *path, UInt16 port, SecProtocolType protocol, SecAuthenticationType authenticationType, UInt32 passwordLength, const void *passwordData, SecKeychainItemRef *itemRef);
+OSStatus SecKeychainFindInternetPassword(CFTypeRef keychainOrArray, UInt32 serverNameLength, const char *serverName, UInt32 securityDomainLength, const char *securityDomain, UInt32 accountNameLength, const char *accountName, UInt32 pathLength, const char *path, UInt16 port, SecProtocolType protocol, SecAuthenticationType authenticationType, UInt32 *passwordLength, void **passwordData, SecKeychainItemRef *itemRef);
+OSStatus SecKeychainItemCopyContent(SecKeychainItemRef itemRef, SecItemClass *itemClass, SecKeychainAttributeList *attrList, UInt32 *length, void **outData);
+OSStatus SecKeychainItemDelete(SecKeychainItemRef itemRef);
+OSStatus SecKeychainItemFreeContent(SecKeychainAttributeList *attrList, void *data);
+OSStatus SecKeychainItemModifyContent(SecKeychainItemRef itemRef, const SecKeychainAttributeList *attrList, UInt32 length, const void *data);
+"""
+
+header = r"""
+#include <dlfcn.h>
+#include <Security/Security.h>
+#include "cache.h"
+
+const char *security_framework =
+	"/System/Library/Frameworks/Security.framework/Security";
+
+void *load_security()
+{
+	static void *security;
+	if (!security) {
+		if (!(security = dlopen(security_framework, RTLD_LAZY)))
+			die(_("dlopen(\"%s\") failed: %s"),
+			    security_framework, dlerror());
+	}
+	return security;
+}
+"""
+
+func_tmpl = """
+%(func_decl)s
+{
+	%(func_rv)s (*func)(%(arg_types)s) =
+		dlsym(load_security(), "%(func_name)s");
+	if (!func)
+		die(_("dlsym(%(func_name)s) failed: %%s"), dlerror());
+	return func(%(arg_names)s);
+}
+"""
+
+def generate_func(decl):
+	func_rv, func_name, func_args = re.search(
+		r'^(.*?)\s+([^(]+)\((.*)\);$', decl).groups()
+	func_args = [s.strip() for s in func_args.split(',')]
+	arg_types = []
+	arg_names = []
+	for arg in func_args:
+		arg_type, arg_name = re.search(r'^(.*?)([a-zA-Z]+)$', arg).groups()
+		arg_types.append(arg_type.strip())
+		arg_names.append(arg_name.strip())
+	return func_tmpl % dict(
+		func_decl=decl.rstrip(';'),
+		func_name=func_name,
+		func_rv=func_rv,
+		arg_types=', '.join(arg_types),
+		arg_names=', '.join(arg_names),
+	)
+
+def main():
+	f = open('security.c', 'w')
+	f.write(header)
+	for decl in func_decls.splitlines():
+		decl = decl.strip()
+		if decl:
+			f.write(generate_func(decl))
+	f.close()
+
+if __name__ == '__main__':
+	main()
-- 
1.7.7.rc1.1.g011e1
