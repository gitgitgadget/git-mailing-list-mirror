From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH] Windows: avoid static dependency on advapi32.dll
Date: Sun, 24 Jan 2010 18:53:51 +0000
Organization: 
Message-ID: <1264359231-4672-1-git-send-email-michael.lukashov@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 19:55:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ7bw-00005I-PC
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 19:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0AXSyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 13:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035Ab0AXSyw
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 13:54:52 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:37367 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab0AXSyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 13:54:52 -0500
Received: by bwz27 with SMTP id 27so2151935bwz.21
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 10:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YZe+04FM0C9o7mPRpakd2NUUQImBRuwohmi8fue1zUw=;
        b=pvppzzTI3OhyEzh4ZpRNN4rv9IheHw7otv7GByPeFpQBC/8TFZCAC/m2O8BQVzPjTf
         wxr+/BblxRPVqE5tww9axEB0oN6d9XOUTU7zut+dZKlLcc65SlouHDA8FJV7vJ8eFda3
         DDFAy6eiTX0BlAOeDpfe832Hg71/xvj+h8Dnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pinUVHh1+HaN/ATtLt0gbSipuOD7sC4R+mnbG0MsdVM5tEaY18r5nQkT01JSaaREkr
         M552MNcP8l7r8/8tZc6eS0bpfdJLFCf+eY4WkUlcx7oFzz4w2shS0EHP574iIOHWLkJV
         cZ86+O9c5mQjabKk52lBKWYVzrna9obBDg79A=
Received: by 10.204.24.2 with SMTP id t2mr100055bkb.124.1264359290256;
        Sun, 24 Jan 2010 10:54:50 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 15sm1851360bwz.0.2010.01.24.10.54.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 10:54:49 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1599.gaed1a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137908>

This DLL is used to get default user name. By looking
up the only function that we need at runtime, we can
avoid the startup costs of this DLL.

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 compat/mingw.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ab65f77..6ce398c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1176,13 +1176,42 @@ int mingw_getpagesize(void)
 	return si.dwAllocationGranularity;
 }
 
+static HMODULE advapi32_dll = NULL;
+static BOOL (WINAPI *advapi32_get_user_name)(char *, DWORD *);
+
+static void advapi32_cleanup(void)
+{
+	if (advapi32_dll)
+		FreeLibrary(advapi32_dll);
+	advapi32_dll = NULL;
+	advapi32_get_user_name = NULL;
+}
+
 struct passwd *getpwuid(int uid)
 {
 	static char user_name[100];
 	static struct passwd p;
+	static int advapi32_initialized = 0;
 
 	DWORD len = sizeof(user_name);
-	if (!GetUserName(user_name, &len))
+
+	if (!advapi32_initialized)
+	{
+		advapi32_dll = LoadLibrary("advapi32.dll");
+		if (!advapi32_dll)
+			die("cannot load advapi32.dll");
+		advapi32_get_user_name = (BOOL (WINAPI *)(char *, DWORD *))
+			GetProcAddress(advapi32_dll, "GetUserNameA");
+		if (!advapi32_get_user_name) {
+			FreeLibrary(advapi32_dll);
+			advapi32_dll = NULL;
+			die("cannot find GetUserNameA");
+		}
+		atexit(advapi32_cleanup);
+		advapi32_initialized = 1;
+	}
+
+	if (!advapi32_get_user_name(user_name, &len))
 		return NULL;
 	p.pw_name = user_name;
 	p.pw_gecos = "unknown";
-- 
1.6.6.1599.gaed1a
