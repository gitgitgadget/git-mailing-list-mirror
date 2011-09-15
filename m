From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] add lame win32 credential-helper
Date: Thu, 15 Sep 2011 22:25:24 +0200
Message-ID: <1316118324-6164-1-git-send-email-kusmabite@gmail.com>
Cc: jaysoffian@gmail.com, peff@peff.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 22:25:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4IV7-0002bs-FX
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 22:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934757Ab1IOUZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 16:25:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33903 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934640Ab1IOUZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 16:25:31 -0400
Received: by eya28 with SMTP id 28so588843eya.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/qKo3iRB/dxXV/QqXIZ5GIgYAINYqnGlatSZY62x1iE=;
        b=Tx5G0T7QyTZ1EcyDNprheCWcjR9vHZLXVc805UEopz8rrJ0krTh/jAq0bo4vDYHnVP
         dt/zmc4ObDAFSpOT1XxZVE1C4KbMnuTNbCnCROv+AXDm1xHQz3ge6Hz91lrn+Lamsf2c
         BDhHL0+B44HOojzvlQLBVV9CAoBSKOrVE9vi0=
Received: by 10.223.62.134 with SMTP id x6mr1032064fah.39.1316118330226;
        Thu, 15 Sep 2011 13:25:30 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no. [84.215.188.225])
        by mx.google.com with ESMTPS id f10sm3550223fac.14.2011.09.15.13.25.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 13:25:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.355.g842ba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181490>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I got curious what a credential-helper that uses Windows'
Credential Manager would look like; this is the result.

Some parts of the code is heavily inspired by Jay Soffian's
OSX-keychain work.

Not that it's useful yet, since the core-git code for the
credential-helper support doesn't compile on Windows. So
it's not fully tested, I've only read the interface
documentation and experimented with it from the command
line.

 contrib/credential-wincred/Makefile                |    8 +
 .../credential-wincred/git-credential-wincred.c    |  271 ++++++++++++++++++++
 2 files changed, 279 insertions(+), 0 deletions(-)
 create mode 100644 contrib/credential-wincred/Makefile
 create mode 100644 contrib/credential-wincred/git-credential-wincred.c

diff --git a/contrib/credential-wincred/Makefile b/contrib/credential-wincred/Makefile
new file mode 100644
index 0000000..b4f098f
--- /dev/null
+++ b/contrib/credential-wincred/Makefile
@@ -0,0 +1,8 @@
+all: git-credential-wincred.exe
+
+CC = gcc
+RM = rm -f
+CFLAGS = -O2 -Wall
+
+git-credential-wincred.exe : git-credential-wincred.c
+	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
diff --git a/contrib/credential-wincred/git-credential-wincred.c b/contrib/credential-wincred/git-credential-wincred.c
new file mode 100644
index 0000000..5c0e2d3
--- /dev/null
+++ b/contrib/credential-wincred/git-credential-wincred.c
@@ -0,0 +1,271 @@
+#include <windows.h>
+#include <stdio.h>
+
+/* MinGW doesn't have wincred.h, let's extract the stuff we need instead */
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
+typedef struct _CREDUI_INFOW {
+	DWORD   cbSize;
+	HWND    hwndParent;
+	LPWSTR  pszMessageText;
+	LPWSTR  pszCaptionText;
+	HBITMAP hbmBanner;
+} CREDUI_INFOW, *PCREDUI_INFOW;
+
+#define CRED_TYPE_GENERIC 1
+#define CRED_PERSIST_LOCAL_MACHINE 2
+#define CREDUIWIN_GENERIC 1
+#define CREDUIWIN_CHECKBOX 2
+#define CREDUIWIN_IN_CRED_ONLY 32
+#define CRED_PACK_GENERIC_CREDENTIALS 4
+
+
+typedef BOOL (WINAPI *CredWriteWT)(PCREDENTIALW, DWORD);
+typedef BOOL (WINAPI *CredUnPackAuthenticationBufferWT)(DWORD, PVOID, DWORD,
+    LPWSTR, DWORD *, LPWSTR, DWORD *, LPWSTR, DWORD *);
+typedef DWORD (WINAPI *CredUIPromptForWindowsCredentialsWT)(PCREDUI_INFOW,
+    DWORD, ULONG *, LPCVOID, ULONG, LPVOID *, ULONG *, BOOL *, DWORD);
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
+static CredUIPromptForWindowsCredentialsWT CredUIPromptForWindowsCredentialsW;
+static CredEnumerateWT CredEnumerateW;
+static CredPackAuthenticationBufferWT CredPackAuthenticationBufferW;
+static CredFreeT CredFree;
+static CredDeleteWT CredDeleteW;
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
+static void emit_user_pass(WCHAR *username, WCHAR *password)
+{
+	if (username)
+		wprintf(L"username=%s\n", username);
+	if (password)
+		wprintf(L"password=%s\n", password);
+}
+
+static int find_credentials(WCHAR *target, WCHAR *username)
+{
+	WCHAR user_buf[256], pass_buf[256];
+	DWORD user_buf_size = sizeof(user_buf) - 1,
+	      pass_buf_size = sizeof(pass_buf) - 1;
+	CREDENTIALW **creds, *cred = NULL;
+	DWORD num_creds;
+
+	if (!CredEnumerateW(target, 0, &num_creds, &creds))
+		return -1;
+
+	if (!username) {
+		/* no username was specified, just pick the first one */
+		cred = creds[0];
+	} else {
+		/* search for the first credential that matches username */
+		int i;
+		for (i = 0; i < num_creds; ++i)
+			if (!wcscmp(username, creds[i]->UserName)) {
+				cred = creds[i];
+				break;
+			}
+		if (!cred)
+			return -1;
+	}
+
+	if (!CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
+	    cred->CredentialBlobSize, user_buf, &user_buf_size, NULL, NULL,
+	    pass_buf, &pass_buf_size))
+		return -1;
+
+	CredFree(creds);
+
+	/* zero terminate */
+	user_buf[user_buf_size] = L'\0';
+	pass_buf[pass_buf_size] = L'\0';
+
+	emit_user_pass(user_buf, pass_buf);
+	return 0;
+}
+
+/* also saves the credentials if the user tells it to */
+static int ask_credentials(WCHAR *target, WCHAR *comment, WCHAR *username)
+{
+	BOOL save = FALSE;
+	LPVOID auth_buf = NULL;
+	ULONG auth_buf_size = 0;
+	WCHAR user_buf[256], pass_buf[256];
+	DWORD user_buf_size = sizeof(user_buf) - 1,
+	      pass_buf_size = sizeof(pass_buf) - 1;
+	BYTE in_buf[1024];
+	DWORD in_buf_size = sizeof(in_buf);
+	DWORD err;
+	ULONG package = 0;
+	CREDUI_INFOW info = {
+		sizeof(info), NULL,
+		comment ? comment : target, L"Enter password", NULL
+	};
+
+	if (username)
+		CredPackAuthenticationBufferW(0, username, L"",
+		    in_buf, &in_buf_size);
+	err = CredUIPromptForWindowsCredentialsW(&info, 0, &package,
+	    in_buf, in_buf_size, &auth_buf, &auth_buf_size,
+	    &save, CREDUIWIN_GENERIC | CREDUIWIN_CHECKBOX);
+	if (err == ERROR_CANCELLED)
+		return 0;
+	if (err != ERROR_SUCCESS)
+		return -1;
+
+	if (!CredUnPackAuthenticationBufferW(0, auth_buf, auth_buf_size,
+	    user_buf, &user_buf_size, NULL, NULL,
+	    pass_buf, &pass_buf_size))
+		return -1;
+
+	/* zero terminate */
+	user_buf[user_buf_size] = L'\0';
+	pass_buf[pass_buf_size] = L'\0';
+
+	emit_user_pass(user_buf, pass_buf);
+
+	if (save) {
+		CREDENTIALW cred;
+		cred.Flags = 0;
+		cred.Type = CRED_TYPE_GENERIC;
+		cred.TargetName = target;
+		cred.Comment = comment;
+		cred.CredentialBlobSize = auth_buf_size;
+		cred.CredentialBlob = auth_buf;
+		cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
+		cred.AttributeCount = 0;
+		cred.Attributes = NULL;
+		cred.TargetAlias = NULL;
+		cred.UserName = user_buf;
+		if (!CredWriteW(&cred, 0))
+			fprintf(stderr, "failed to write credentials\n");
+	}
+	return 0;
+}
+
+static void delete_credentials(WCHAR *target, WCHAR *username)
+{
+	WCHAR temp[4096];
+
+	wcscpy(temp, target);
+	if (username) {
+		wcscat(temp, L"|");
+		wcscat(temp, username);
+	}
+	if (!CredDeleteW(target, CRED_TYPE_GENERIC, 0))
+		die("failed to delete credentials");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *usage =
+	    "Usage: git credential-osxkeychain --unique=TOKEN [options]\n"
+	    "Options:\n"
+	    "    --description=DESCRIPTION\n"
+	    "    --username=USERNAME\n"
+	    "    --reject";
+	WCHAR desc_buf[4096], *description = NULL,
+	      user_buf[256], *username = NULL,
+	      unique_buf[1024], *unique = NULL;
+	int i, reject = 0;
+
+	for (i = 1; i < argc; ++i) {
+		const char *arg = argv[i];
+		if (!strncmp(arg, "--description=", 14)) {
+			MultiByteToWideChar(CP_UTF8, 0, arg + 14, -1,
+			    desc_buf, sizeof(desc_buf));
+			description = desc_buf;
+		} else if (!strncmp(arg, "--username=", 11)) {
+			MultiByteToWideChar(CP_UTF8, 0, arg + 11, -1,
+			    user_buf, sizeof(user_buf));
+			username = user_buf;
+		} else if (!strncmp(arg, "--unique=", 9)) {
+			MultiByteToWideChar(CP_UTF8, 0, arg + 9, -1,
+			    unique_buf, sizeof(unique_buf));
+			unique = unique_buf;
+		} else if (!strcmp(arg, "--reject")) {
+			reject = 1;
+		} else if (!strcmp(arg, "--help")) {
+			die(usage);
+		} else
+			die("Unrecognized argument `%s'; try --help", arg);
+	}
+
+	if (!unique)
+		die("Must specify --unique=TOKEN; try --help");
+
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
+	CredUIPromptForWindowsCredentialsW =
+	    (CredUIPromptForWindowsCredentialsWT)GetProcAddress(credui,
+	    "CredUIPromptForWindowsCredentialsW");
+	CredEnumerateW = (CredEnumerateWT)GetProcAddress(advapi,
+	    "CredEnumerateW");
+	CredPackAuthenticationBufferW = (CredPackAuthenticationBufferWT)
+	    GetProcAddress(credui, "CredPackAuthenticationBufferW");
+	CredFree = (CredFreeT)GetProcAddress(advapi, "CredFree");
+	CredDeleteW = (CredDeleteWT)GetProcAddress(advapi, "CredDeleteW");
+	if (!CredWriteW || !CredUnPackAuthenticationBufferW ||
+	    !CredUIPromptForWindowsCredentialsW || !CredEnumerateW ||
+	    !CredPackAuthenticationBufferW || !CredFree || !CredDeleteW)
+		die("failed to load functions");
+
+	if (reject) {
+		delete_credentials(unique, username);
+		return 0;
+	}
+
+	if (!find_credentials(unique, username))
+		return 0;
+
+	if (!ask_credentials(unique, description, username))
+		return 0;
+
+	return -1;
+}
-- 
1.7.6.355.g842ba.dirty
