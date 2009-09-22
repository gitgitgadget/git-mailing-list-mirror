From: Michael Wookey <michaelwookey@gmail.com>
Subject: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Tue, 22 Sep 2009 14:10:18 +1000
Message-ID: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 06:10:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpwiD-0004QR-AH
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 06:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbZIVEKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 00:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbZIVEKf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 00:10:35 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:4803 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZIVEKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 00:10:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so4717804and.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2009 21:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=HZEwdGE/rApmJemq7n3q6gtHU3shJd+rGO1u7SQPQIc=;
        b=UJQpKalVlPF05FNk5LF4kEvIwZ2PTtF1YNpL8DvfozA9ES8I8ocSHC9DrLAj62YIA9
         GLHVyKCe0mnZFlpu4RSrMezlu8/m/8Py40vf9touf0lxuTytyjb5dUUy3FtLg4j1pz3q
         kX3AebRxd7PXCPSFbuI0ZferEGjZ53Kh24V8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=JMmTmGZT/ylA+3TTbTv8zAXx+J/zVdG3p/GMSX4rg/C64xTqExZ+kJXxoDiqK2C0Wv
         1i0eVYP9UeNKS2wTGnteeibA4nhLSVvixmwM92KXRE/9sHC8TQNkmO4uw4AkUQ/PP5e1
         +sl91F7KI5SQyyT/HSJewag53bZ4hvwXmebts=
Received: by 10.101.190.9 with SMTP id s9mr466388anp.198.1253592638083; Mon, 
	21 Sep 2009 21:10:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128919>

MSVC builds define UNICODE which results in the "WIDE" variation of
Win32 API's being used.

Explicitly use the ANSI variation of the API's for compatibility with
msysgit.

Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
---
 compat/mingw.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6b5b5b2..39be42f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -135,7 +135,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	fd = open(filename, oflags, mode);

 	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
-		DWORD attrs = GetFileAttributes(filename);
+		DWORD attrs = GetFileAttributesA(filename);
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
 			errno = EISDIR;
 	}
@@ -607,7 +607,7 @@ static char *lookup_prog(const char *dir, const
char *cmd, int isexe, int exe_on
 		return xstrdup(path);
 	path[strlen(path)-4] = '\0';
 	if ((!exe_only || isexe) && access(path, F_OK) == 0)
-		if (!(GetFileAttributes(path) & FILE_ATTRIBUTE_DIRECTORY))
+		if (!(GetFileAttributesA(path) & FILE_ATTRIBUTE_DIRECTORY))
 			return xstrdup(path);
 	return NULL;
 }
@@ -641,14 +641,14 @@ static int env_compare(const void *a, const void *b)
 static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
 			   int prepend_cmd)
 {
-	STARTUPINFO si;
+	STARTUPINFOA si;
 	PROCESS_INFORMATION pi;
 	struct strbuf envblk, args;
 	unsigned flags;
 	BOOL ret;

 	/* Determine whether or not we are associated to a console */
-	HANDLE cons = CreateFile("CONOUT$", GENERIC_WRITE,
+	HANDLE cons = CreateFileA("CONOUT$", GENERIC_WRITE,
 			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
 			FILE_ATTRIBUTE_NORMAL, NULL);
 	if (cons == INVALID_HANDLE_VALUE) {
@@ -717,7 +717,7 @@ static pid_t mingw_spawnve(const char *cmd, const
char **argv, char **env,
 	}

 	memset(&pi, 0, sizeof(pi));
-	ret = CreateProcess(cmd, args.buf, NULL, NULL, TRUE, flags,
+	ret = CreateProcessA(cmd, args.buf, NULL, NULL, TRUE, flags,
 		env ? envblk.buf : NULL, NULL, &si, &pi);

 	if (env)
@@ -965,23 +965,23 @@ int mingw_rename(const char *pold, const char *pnew)
 	if (errno != EEXIST)
 		return -1;
 repeat:
-	if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
+	if (MoveFileExA(pold, pnew, MOVEFILE_REPLACE_EXISTING))
 		return 0;
 	/* TODO: translate more errors */
 	gle = GetLastError();
 	if (gle == ERROR_ACCESS_DENIED &&
-	    (attrs = GetFileAttributes(pnew)) != INVALID_FILE_ATTRIBUTES) {
+	    (attrs = GetFileAttributesA(pnew)) != INVALID_FILE_ATTRIBUTES) {
 		if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
 			errno = EISDIR;
 			return -1;
 		}
 		if ((attrs & FILE_ATTRIBUTE_READONLY) &&
-		    SetFileAttributes(pnew, attrs & ~FILE_ATTRIBUTE_READONLY)) {
-			if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
+		    SetFileAttributesA(pnew, attrs & ~FILE_ATTRIBUTE_READONLY)) {
+			if (MoveFileExA(pold, pnew, MOVEFILE_REPLACE_EXISTING))
 				return 0;
 			gle = GetLastError();
 			/* revert file attributes on failure */
-			SetFileAttributes(pnew, attrs);
+			SetFileAttributesA(pnew, attrs);
 		}
 	}
 	if (tries < ARRAY_SIZE(delay) && gle == ERROR_ACCESS_DENIED) {
@@ -1006,7 +1006,7 @@ struct passwd *getpwuid(int uid)
 	static struct passwd p;

 	DWORD len = sizeof(user_name);
-	if (!GetUserName(user_name, &len))
+	if (!GetUserNameA(user_name, &len))
 		return NULL;
 	p.pw_name = user_name;
 	p.pw_gecos = "unknown";
@@ -1151,7 +1151,7 @@ void mingw_open_html(const char *unixpath)
 {
 	const char *htmlpath = make_backslash_path(unixpath);
 	printf("Launching default browser to display HTML ...\n");
-	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
+	ShellExecuteA(NULL, "open", htmlpath, NULL, "\\", 0);
 }

 int link(const char *oldpath, const char *newpath)
@@ -1160,7 +1160,7 @@ int link(const char *oldpath, const char *newpath)
 	static T create_hard_link = NULL;
 	if (!create_hard_link) {
 		create_hard_link = (T) GetProcAddress(
-			GetModuleHandle("kernel32.dll"), "CreateHardLinkA");
+			GetModuleHandleA("kernel32.dll"), "CreateHardLinkA");
 		if (!create_hard_link)
 			create_hard_link = (T)-1;
 	}
-- 
1.6.5.rc1.44.ga1675
