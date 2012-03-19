From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] contrib: add win32 credential-helper
Date: Tue, 20 Mar 2012 00:06:54 +0100
Message-ID: <1332198414-5884-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 00:07:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9lfs-00088i-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 00:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758462Ab2CSXHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 19:07:32 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39905 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059Ab2CSXHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 19:07:30 -0400
Received: by lbbgm6 with SMTP id gm6so3754738lbb.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 16:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=AZir1qb/L2w3Knss1+UgxRWErz4cFJprNgiGaFnL8GM=;
        b=nNd2pNkAO9RRzf6TnzPbYg+WVLcRGiOtGLQYINB9xE0CSHuudpySci2OlZ/ZjSfJg4
         Dcvsf69VL5JjqWMmuoe7Cf6Ws2Ek+sbC1B9f7x3V7vOq1//yyc0FDnzTEj4iQhGwZhJQ
         2TFg0TUT1lai6PWMrGDtf0xlb4VGDr4hl3sPKK/MVvRyTO5qe4X4p4yBsUXspTw3fD0s
         FexQlGS9Nk15m4JXbsdo/ATKZ8O0fkAEOOBQ1LuSdpXoMTGGgO/+9z2YvXrWiIAa8B7O
         krB1i0VnXQ5nHV4rXipmtdjK1O8yu6bLxCnr7inlhxirc2AT+qxwA/IJMd307vDkWa7a
         aCjQ==
Received: by 10.112.36.198 with SMTP id s6mr5345450lbj.20.1332198449014;
        Mon, 19 Mar 2012 16:07:29 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id py12sm7405971lab.4.2012.03.19.16.07.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 16:07:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193474>

This one pretty much sucks. Mem-leaks and a sketchy deletion-filter.

Currently uses "::" as an attribute-separator, but this is not robust
without encoding if the attribute values themselves contains "::".

Since the Windows port of Git expects binary pipes, we need to make
sure the helper-end also sets up binary pipes.

Side-step CRLF-issue in test to make it pass.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Here's a hacky and not-quite-as-cool-as-I'd-hope credential-helper
for Windows. The good news is that it Works For Me(tm), but the bad
news is that it sucks.

The code is provided for discussion only so far.

I'm not really sure how to make it less sucky in some regards, part
of this I blame on lacking documentation of the credential-helper
prococol :P

Here's some things I can't find documented:

 1) Encoding of usernames. I'm assuming this is supposed to be
 UTF-8, because SecKeychainFindInternetPassword which is used by
 the OSX-helper is documented to take accountName as UTF-8.

 2) Encoding of passwords. I'm assuming UTF-8, as mixing encodings
 here would be insane :P

 3) How to match credentials for look-up when not supplying all
 attributes. I've implemented a kind-of dodgy matching; I use a
 string that packs all supplied attributes. This seems to work,
 but I'm a bit worried about what happens when people try to mix
 credentials saved with credential.useHttpPath=true with those
 saved with credential.useHttpPath=false.

 4) How to match credentials for deletion when not supplying
 all attributes. It seems from the test-suite that a credential is
 expected to be deleted even if the username is not given. But what
 happens in such a case when there's two different credentials for
 one domain, with different username? The OSX-helper seems to only
 delete one of them (but I'm not entirely sure which one, due to
 lacking documentation from Apple's side).
 
 The OSX-helper also have a comment saying "Require at least a
 protocol and host for removal, which is what git will give us; if
 you want to do  something more fancy, use the Keychain manager".
 This comment puzzles me a bit; won't git also give us path in case
 of credential.useHttpPath=true?

 5) How overwriting credentials work. If there's a credential where
 all attributes except for the password match, will "store" just
 overwrite it? Should it complain?

I'm guessing that a lot of these questions fall in the "who cares"
category. For instance, git probably never tries to create a
credential it already has stored. But at least saying "This cannot
happen" in the documentation makes it a lot easier to write a
credential-helper.

Thoughts?

 contrib/credential/wincred/Makefile                |    8 +
 .../credential/wincred/git-credential-wincred.c    |  320 ++++++++++++++++++++
 t/lib-credential.sh                                |    4 +
 3 files changed, 332 insertions(+), 0 deletions(-)
 create mode 100644 contrib/credential/wincred/Makefile
 create mode 100644 contrib/credential/wincred/git-credential-wincred.c

diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
new file mode 100644
index 0000000..b4f098f
--- /dev/null
+++ b/contrib/credential/wincred/Makefile
@@ -0,0 +1,8 @@
+all: git-credential-wincred.exe
+
+CC = gcc
+RM = rm -f
+CFLAGS = -O2 -Wall
+
+git-credential-wincred.exe : git-credential-wincred.c
+	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
new file mode 100644
index 0000000..760a3dc
--- /dev/null
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -0,0 +1,320 @@
+/*
+ * A git credential helper that interface with Windows' Credential Manager
+ *
+ */
+#include <windows.h>
+#include <stdio.h>
+#include <io.h>
+#include <fcntl.h>
+
+/* common helpers */
+
+static void die(const char *err, ...)
+{
+	char msg[4096];
+	va_list params;
+	va_start(params, err);
+	vsnprintf(msg, sizeof(msg), err, params);
+	fprintf(stderr, "%s\n", msg);
+	va_end(params);
+	exit(1);
+}
+
+static void *xmalloc(size_t size)
+{
+	void *ret = malloc(size);
+	if (!ret && !size)
+		ret = malloc(1);
+	if (!ret)
+		 die("Out of memory");
+	return ret;
+}
+
+static char *xstrdup(const char *str)
+{
+	char *ret = strdup(str);
+	if (!ret)
+		die("Out of memory");
+	return ret;
+}
+
+/* MinGW doesn't have wincred.h, so we need to define stuff */
+
+typedef struct _CREDENTIAL_ATTRIBUTE {
+	LPWSTR Keyword;
+	DWORD  Flags;
+	DWORD  ValueSize;
+	LPBYTE Value;
+} CREDENTIAL_ATTRIBUTE, *PCREDENTIAL_ATTRIBUTE;
+
+typedef struct _CREDENTIALW {
+	DWORD                 Flags;
+	DWORD                 Type;
+	LPWSTR                TargetName;
+	LPWSTR                Comment;
+	FILETIME              LastWritten;
+	DWORD                 CredentialBlobSize;
+	LPBYTE                CredentialBlob;
+	DWORD                 Persist;
+	DWORD                 AttributeCount;
+	PCREDENTIAL_ATTRIBUTE Attributes;
+	LPWSTR                TargetAlias;
+	LPWSTR                UserName;
+} CREDENTIALW, *PCREDENTIALW;
+
+#define CRED_TYPE_GENERIC 1
+#define CRED_PERSIST_LOCAL_MACHINE 2
+#define CRED_PACK_GENERIC_CREDENTIALS 4
+
+typedef BOOL (WINAPI *CredWriteWT)(PCREDENTIALW, DWORD);
+typedef BOOL (WINAPI *CredUnPackAuthenticationBufferWT)(DWORD, PVOID, DWORD,
+    LPWSTR, DWORD *, LPWSTR, DWORD *, LPWSTR, DWORD *);
+typedef BOOL (WINAPI *CredEnumerateWT)(LPCWSTR, DWORD, DWORD *,
+    PCREDENTIALW **);
+typedef BOOL (WINAPI *CredPackAuthenticationBufferWT)(DWORD, LPWSTR, LPWSTR,
+    PBYTE, DWORD *);
+typedef VOID (WINAPI *CredFreeT)(PVOID);
+typedef BOOL (WINAPI *CredDeleteWT)(LPCWSTR, DWORD, DWORD);
+
+static HMODULE advapi, credui;
+static CredWriteWT CredWriteW;
+static CredUnPackAuthenticationBufferWT CredUnPackAuthenticationBufferW;
+static CredEnumerateWT CredEnumerateW;
+static CredPackAuthenticationBufferWT CredPackAuthenticationBufferW;
+static CredFreeT CredFree;
+static CredDeleteWT CredDeleteW;
+
+static void load_cred_funcs(void)
+{
+	/* load DLLs */
+	advapi = LoadLibrary("advapi32.dll");
+	credui = LoadLibrary("credui.dll");
+	if (!advapi || !credui)
+		die("failed to load DLLs");
+
+	/* get function pointers */
+	CredWriteW = (CredWriteWT)GetProcAddress(advapi, "CredWriteW");
+	CredUnPackAuthenticationBufferW = (CredUnPackAuthenticationBufferWT)
+	    GetProcAddress(credui, "CredUnPackAuthenticationBufferW");
+	CredEnumerateW = (CredEnumerateWT)GetProcAddress(advapi,
+	    "CredEnumerateW");
+	CredPackAuthenticationBufferW = (CredPackAuthenticationBufferWT)
+	    GetProcAddress(credui, "CredPackAuthenticationBufferW");
+	CredFree = (CredFreeT)GetProcAddress(advapi, "CredFree");
+	CredDeleteW = (CredDeleteWT)GetProcAddress(advapi, "CredDeleteW");
+	if (!CredWriteW || !CredUnPackAuthenticationBufferW ||
+	    !CredEnumerateW || !CredPackAuthenticationBufferW || !CredFree ||
+	    !CredDeleteW)
+		die("failed to load functions");
+}
+
+static char target_buf[1024];
+static char *protocol, *host, *path, *username;
+static WCHAR *wusername, *password, *target;
+
+static void write_item(const char *what, WCHAR *wbuf)
+{
+	char *buf;
+	int len = WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, NULL, 0, NULL,
+	    FALSE);
+	buf = xmalloc(len);
+
+	if (!WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, buf, len, NULL, FALSE))
+		die("WideCharToMultiByte failed!");
+
+	printf("%s=", what);
+	fwrite(buf, 1, len - 1, stdout);
+	putchar('\n');
+	free(buf);
+}
+
+static void get_credential(void)
+{
+	WCHAR *user_buf, *pass_buf;
+	DWORD user_buf_size = 0, pass_buf_size = 0;
+	CREDENTIALW **creds, *cred;
+	DWORD num_creds;
+	WCHAR temp[4096];
+
+	wcscpy(temp, target);
+	wcscat(temp, L"*");
+
+	if (!CredEnumerateW(temp, 0, &num_creds, &creds))
+		return;
+
+	if (!wusername) {
+		/* no username was specified, just pick the first one */
+		cred = creds[0];
+	} else {
+		/* search for the first credential that matches username */
+		int i;
+		cred = NULL;
+		for (i = 0; i < num_creds; ++i)
+			if (!wcscmp(wusername, creds[i]->UserName)) {
+				cred = creds[i];
+				break;
+			}
+		if (!cred)
+			return;
+	}
+
+	CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
+	    cred->CredentialBlobSize, NULL, &user_buf_size, NULL, NULL,
+	    NULL, &pass_buf_size);
+
+	user_buf = xmalloc(user_buf_size * sizeof(WCHAR));
+	pass_buf = xmalloc(pass_buf_size * sizeof(WCHAR));
+
+	if (!CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
+	    cred->CredentialBlobSize, user_buf, &user_buf_size, NULL, NULL,
+	    pass_buf, &pass_buf_size))
+		die("CredUnPackAuthenticationBuffer failed");
+
+	CredFree(creds);
+
+	/* zero-terminate (sizes include zero-termination) */
+	user_buf[user_buf_size - 1] = L'\0';
+	pass_buf[pass_buf_size - 1] = L'\0';
+
+	write_item("username", user_buf);
+	write_item("password", pass_buf);
+
+	free(user_buf);
+	free(pass_buf);
+}
+
+static void store_credential(void)
+{
+	CREDENTIALW cred;
+	BYTE *auth_buf;
+	DWORD auth_buf_size = 0;
+
+	if (!wusername || !password)
+		return;
+
+	/* query buffer size */
+	CredPackAuthenticationBufferW(0, wusername, password,
+	    NULL, &auth_buf_size);
+
+	auth_buf = xmalloc(auth_buf_size);
+
+	if (!CredPackAuthenticationBufferW(0, wusername, password,
+	    auth_buf, &auth_buf_size))
+		die("CredPackAuthenticationBuffer failed");
+
+	cred.Flags = 0;
+	cred.Type = CRED_TYPE_GENERIC;
+	cred.TargetName = target;
+	cred.Comment = L"saved by git-credential-wincred";
+	cred.CredentialBlobSize = auth_buf_size;
+	cred.CredentialBlob = auth_buf;
+	cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
+	cred.AttributeCount = 0;
+	cred.Attributes = NULL;
+	cred.TargetAlias = NULL;
+	cred.UserName = wusername;
+	if (!CredWriteW(&cred, 0))
+		die("CredWrite failed");
+}
+
+static void erase_credential(void)
+{
+	WCHAR temp[4096];
+	CREDENTIALW **creds;
+	DWORD num_creds;
+	int i;
+
+	wcscpy(temp, target);
+	wcscat(temp, L"*");
+
+	if (!CredEnumerateW(temp, 0, &num_creds, &creds))
+		return;
+
+	for (i = 0; i < num_creds; ++i)
+		CredDeleteW(creds[i]->TargetName, creds[i]->Type, 0);
+
+	CredFree(creds);
+}
+
+static WCHAR *utf8_to_utf16_dup(const char *str)
+{
+	int wlen = MultiByteToWideChar(CP_UTF8, 0, str, -1, NULL, 0);
+	WCHAR *wstr = xmalloc(sizeof(WCHAR) * wlen);
+	MultiByteToWideChar(CP_UTF8, 0, str, -1, wstr, wlen);
+	return wstr;
+}
+
+static void read_credential(void)
+{
+	char buf[1024];
+
+	while (fgets(buf, sizeof(buf), stdin)) {
+		char *v;
+
+		if (!strcmp(buf, "\n"))
+			break;
+		buf[strlen(buf)-1] = '\0';
+
+		v = strchr(buf, '=');
+		if (!v)
+			die("bad input: %s", buf);
+		*v++ = '\0';
+
+		if (!strcmp(buf, "protocol"))
+			protocol = xstrdup(v);
+		else if (!strcmp(buf, "host"))
+			host = xstrdup(v);
+		else if (!strcmp(buf, "path"))
+			path = xstrdup(v);
+		else if (!strcmp(buf, "username")) {
+			username = xstrdup(v);
+			wusername = utf8_to_utf16_dup(v);
+		} else if (!strcmp(buf, "password"))
+			password = utf8_to_utf16_dup(v);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	const char *usage =
+	    "Usage: git credential-wincred <get|store|erase>\n";
+
+	if (!argv[1])
+		die(usage);
+
+	/* git use binary pipes to avoid CRLF-issues */
+	_setmode(_fileno(stdin), _O_BINARY);
+	_setmode(_fileno(stdout), _O_BINARY);
+
+	read_credential();
+
+	load_cred_funcs();
+
+	/* prepare 'target', the unique key for the credential */
+	if (!protocol || !host)
+		return 0;
+
+	strncpy(target_buf, "git::protocol=", sizeof(target_buf));
+	strncat(target_buf, protocol, sizeof(target_buf));
+	strncat(target_buf, "::host=", sizeof(target_buf));
+	strncat(target_buf, host, sizeof(target_buf));
+	if (username) {
+		strncat(target_buf, "::user=", sizeof(target_buf));
+		strncat(target_buf, username, sizeof(target_buf));
+	}
+	if (path) {
+		strncat(target_buf, "::path=", sizeof(target_buf));
+		strncat(target_buf, host, sizeof(target_buf));
+	}
+
+	target = utf8_to_utf16_dup(target_buf);
+
+	if (!strcmp(argv[1], "get"))
+		get_credential();
+	else if (!strcmp(argv[1], "store"))
+		store_credential();
+	else if (!strcmp(argv[1], "erase"))
+		erase_credential();
+	/* otherwise, ignore unknown action */
+	return 0;
+}
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 4a37cd7..d30ae8a 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -8,6 +8,10 @@ check() {
 	read_chunk >expect-stdout &&
 	read_chunk >expect-stderr &&
 	test-credential "$@" <stdin >stdout 2>stderr &&
+	if test_have_prereq MINGW
+	then
+		dos2unix -q stderr
+	fi &&
 	test_cmp expect-stdout stdout &&
 	test_cmp expect-stderr stderr
 }
-- 
1.7.9
