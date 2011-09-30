From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] add lame win32 credential-helper
Date: Fri, 30 Sep 2011 16:42:15 +0200
Message-ID: <CABPQNSY7ieW+0XjQWir6-Zk86j1THWW2VVLgvfrqe3XOEudemQ@mail.gmail.com>
References: <1316118324-6164-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: jaysoffian@gmail.com, peff@peff.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 16:43:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9eIo-0003jh-3H
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 16:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab1I3Om5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 10:42:57 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:49694 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab1I3Om4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 10:42:56 -0400
Received: by yib18 with SMTP id 18so1555148yib.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bD0XCeFKVWwy1IHaKWRrWaPiEmDWr0653swNmT542wA=;
        b=bc3hAFKNwpS25JzIA6eMm4oVNt6lJpNr2Kl/FxMl/eMcvfGT/uWZcItHp71ymdk6pr
         tZXyCB92uTu2zA/HD7BMAJCh60hQGGLS5iE8vp1ke6x7lq5yCshsHpxXXSCpP4qW7hJm
         S92tXu1g6x/C6aYd/BxuBGukyB+AR2F5caNnU=
Received: by 10.68.4.132 with SMTP id k4mr58490868pbk.78.1317393775078; Fri,
 30 Sep 2011 07:42:55 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Fri, 30 Sep 2011 07:42:15 -0700 (PDT)
In-Reply-To: <1316118324-6164-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182484>

On Thu, Sep 15, 2011 at 10:25 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> I got curious what a credential-helper that uses Windows'
> Credential Manager would look like; this is the result.
>
> Some parts of the code is heavily inspired by Jay Soffian's
> OSX-keychain work.
>
> Not that it's useful yet, since the core-git code for the
> credential-helper support doesn't compile on Windows. So
> it's not fully tested, I've only read the interface
> documentation and experimented with it from the command
> line.
>

...aaand with the following patch applied on top, it pass the
credential-helper test that peff wrote:

---8<---
Subject: [PATCH] fix helper to pass test

---
 .../credential-wincred/git-credential-wincred.c    |   87 +++++++++++---------
 1 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/contrib/credential-wincred/git-credential-wincred.c
b/contrib/credential-wincred/git-credential-wincred.c
index 072c002..278dd80 100644
--- a/contrib/credential-wincred/git-credential-wincred.c
+++ b/contrib/credential-wincred/git-credential-wincred.c
@@ -84,31 +84,35 @@ static void emit_user_pass(WCHAR *username, WCHAR *password)
 		wprintf(L"password=%s\n", password);
 }

-static int find_credentials(WCHAR *target, WCHAR *username)
+static WCHAR *get_target(WCHAR *unique, WCHAR *username)
 {
+	static WCHAR target_buf[4096];
+	_snwprintf(target_buf, sizeof(target_buf), L"gitcred:%s:%s",
+	    unique, username);
+	return target_buf;
+}
+
+static int find_credentials(WCHAR *unique, WCHAR *username)
+{
+	int i;
 	WCHAR user_buf[256], pass_buf[256];
 	DWORD user_buf_size = sizeof(user_buf) - 1,
 	      pass_buf_size = sizeof(pass_buf) - 1;
 	CREDENTIALW **creds, *cred = NULL;
 	DWORD num_creds;

-	if (!CredEnumerateW(target, 0, &num_creds, &creds))
+	if (!CredEnumerateW(get_target(unique, username ? username : L"*"),
+	    0, &num_creds, &creds))
 		return -1;

-	if (!username) {
-		/* no username was specified, just pick the first one */
-		cred = creds[0];
-	} else {
-		/* search for the first credential that matches username */
-		int i;
-		for (i = 0; i < num_creds; ++i)
-			if (!wcscmp(username, creds[i]->UserName)) {
-				cred = creds[i];
-				break;
-			}
-		if (!cred)
-			return -1;
-	}
+	/* search for the first credential that matches username */
+	for (i = 0; i < num_creds; ++i)
+		if (!username || !wcscmp(username, creds[i]->UserName)) {
+			cred = creds[i];
+			break;
+		}
+	if (!cred)
+		return -1;

 	if (!CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
 	    cred->CredentialBlobSize, user_buf, &user_buf_size, NULL, NULL,
@@ -126,9 +130,9 @@ static int find_credentials(WCHAR *target, WCHAR *username)
 }

 /* also saves the credentials if the user tells it to */
-static int ask_credentials(WCHAR *target, WCHAR *comment, WCHAR *username)
+static int ask_credentials(WCHAR *unique, WCHAR *comment, WCHAR *username)
 {
-	BOOL save = FALSE;
+	BOOL save = unique != NULL;
 	LPVOID auth_buf = NULL;
 	ULONG auth_buf_size = 0;
 	WCHAR user_buf[256], pass_buf[256];
@@ -140,7 +144,7 @@ static int ask_credentials(WCHAR *target, WCHAR
*comment, WCHAR *username)
 	ULONG package = 0;
 	CREDUI_INFOW info = {
 		sizeof(info), NULL,
-		comment ? comment : target, L"Enter password", NULL
+		comment ? comment : unique, L"Enter password", NULL
 	};

 	if (username)
@@ -148,7 +152,7 @@ static int ask_credentials(WCHAR *target, WCHAR
*comment, WCHAR *username)
 		    in_buf, &in_buf_size);
 	err = CredUIPromptForWindowsCredentialsW(&info, 0, &package,
 	    in_buf, in_buf_size, &auth_buf, &auth_buf_size,
-	    &save, CREDUIWIN_GENERIC | CREDUIWIN_CHECKBOX);
+	    &save, CREDUIWIN_GENERIC | (unique ? CREDUIWIN_CHECKBOX : 0));
 	if (err == ERROR_CANCELLED)
 		return 0;
 	if (err != ERROR_SUCCESS)
@@ -169,7 +173,7 @@ static int ask_credentials(WCHAR *target, WCHAR
*comment, WCHAR *username)
 		CREDENTIALW cred;
 		cred.Flags = 0;
 		cred.Type = CRED_TYPE_GENERIC;
-		cred.TargetName = target;
+		cred.TargetName = get_target(unique, user_buf);
 		cred.Comment = comment;
 		cred.CredentialBlobSize = auth_buf_size;
 		cred.CredentialBlob = auth_buf;
@@ -184,17 +188,21 @@ static int ask_credentials(WCHAR *target, WCHAR
*comment, WCHAR *username)
 	return 0;
 }

-static void delete_credentials(WCHAR *target, WCHAR *username)
+static void delete_credentials(WCHAR *unique, WCHAR *username)
 {
-	WCHAR temp[4096];
+	int i;
+	CREDENTIALW **creds;
+	DWORD num_creds;

-	wcscpy(temp, target);
-	if (username) {
-		wcscat(temp, L"|");
-		wcscat(temp, username);
-	}
-	if (!CredDeleteW(target, CRED_TYPE_GENERIC, 0))
-		die("failed to delete credentials");
+	if (!CredEnumerateW(get_target(unique, username ? username : L"*"),
+	    0, &num_creds, &creds))
+		return;
+
+	for (i = 0; i < num_creds; ++i)
+		if (!CredDeleteW(get_target(unique, creds[i]->UserName),
+		    CRED_TYPE_GENERIC, 0))
+			die("failed to delete credentials");
+	CredFree(creds);
 }

 int main(int argc, char *argv[])
@@ -232,9 +240,6 @@ int main(int argc, char *argv[])
 			die("Unrecognized argument `%s'; try --help", arg);
 	}

-	if (!unique)
-		die("Must specify --unique=TOKEN; try --help");
-
 	/* load DLLs */
 	advapi = LoadLibrary("advapi32.dll");
 	credui = LoadLibrary("credui.dll");
@@ -256,16 +261,18 @@ int main(int argc, char *argv[])
 	CredDeleteW = (CredDeleteWT)GetProcAddress(advapi, "CredDeleteW");
 	if (!CredWriteW || !CredUnPackAuthenticationBufferW ||
 	    !CredUIPromptForWindowsCredentialsW || !CredEnumerateW ||
-	    !CredPackAuthenticationBufferW || !CredFree || !CredDeleteW)
+	    !CredFree || !CredPackAuthenticationBufferW || !CredDeleteW)
 		die("failed to load functions");

-	if (reject) {
-		delete_credentials(unique, username);
-		return 0;
-	}
+	if (unique) {
+		if (reject) {
+			delete_credentials(unique, username);
+			return 0;
+		}

-	if (!find_credentials(unique, username))
-		return 0;
+		if (!find_credentials(unique, username))
+			return 0;
+	}

 	if (!ask_credentials(unique, description, username))
 		return 0;
-- 
1.7.7.rc0.257.g9fefc
---8<---
