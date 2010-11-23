From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [RFC PATCH 4/6] win32: dirent: handle errors
Date: Tue, 23 Nov 2010 18:30:42 +0100
Message-ID: <1290533444-3404-5-git-send-email-kusmabite@gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 18:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwiO-0003bQ-7b
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab0KWRbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:31:33 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38329 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827Ab0KWRb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:31:27 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so4809402eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lf5rUeeFd1E/4mUQBdhyJC44D90e1+d3TsT708f7qvg=;
        b=eKCUWpAY59ETLyzpWBoQ7BuWnouaC24mgPliVmtalCGiEvp+sjt32FK+4S6uIfPVcE
         owPThfGQCx9XjtFUVZ3vfvsLIQ9mRwi+XF6UPLwvOjW2SPmiXKUO1EEKEG3oIVqEtT2W
         ALa1RAdRkdF4aZrWoD0XK/wgmO3FLNUqLB1LY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JkA6CupdYxGaZK1I+mMZWmgGW5E5GfwABukOnJa54ti8P5H8fuKT5KSBP2RMfHchcw
         THt4NnDkWouThcWwX6HgkC9djKzNwk3mKHxq3inlN4LAJXFG+l1vfppIgflw+sZgKu88
         yDR++vSaChgWNBF0hCC7NBDRmHI0l3eFxZUvY=
Received: by 10.14.126.69 with SMTP id a45mr1734499eei.15.1290533486637;
        Tue, 23 Nov 2010 09:31:26 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v51sm6012931eeh.22.2010.11.23.09.31.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:31:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161986>

Previously all error conditions were ignored. Be nice, and set errno
when we should.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |    2 +-
 compat/msvc.c  |   28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fdbf093..d8fd5d8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1584,7 +1584,7 @@ struct dirent *mingw_readdir(DIR *dir)
 	HANDLE handle;
 	struct mingw_DIR *mdir = (struct mingw_DIR*)dir;
 
-	if (!dir->dd_handle) {
+	if (!dir || !dir->dd_handle) {
 		errno = EBADF; /* No set_errno for mingw */
 		return NULL;
 	}
diff --git a/compat/msvc.c b/compat/msvc.c
index 38f2d92..8417fd3 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -5,8 +5,29 @@
 
 DIR *opendir(const char *name)
 {
-	int len = strlen(p->dd_name);
+	DWORD attrs = GetFileAttributes(name);
+	int len;
 	DIR *p;
+
+	/* check for valid path */
+	if (attrs == INVALID_FILE_ATTRIBUTES) {
+		errno = ENOENT;
+		return NULL;
+	}
+
+	/* check if it's a directory */
+	if (!(attrs & FILE_ATTRIBUTE_DIRECTORY)) {
+		errno = ENOTDIR;
+		return NULL;
+	}
+
+	/* check that the pattern won't be too long for FindFirstFileA */
+	len = strlen(name);
+	if (len + 2 >= MAX_PATH) {
+		errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	p = xmalloc(sizeof(DIR) + len + 2);
 	memset(p, 0, sizeof(DIR) + len + 2);
 	strcpy(p->dd_name, name);
@@ -18,6 +39,11 @@ DIR *opendir(const char *name)
 }
 int closedir(DIR *dir)
 {
+	if (!dir) {
+		errno = EBADF;
+		return -1;
+	}
+
 	if (dir->dd_handle != (long)INVALID_HANDLE_VALUE)
 		FindClose((HANDLE)dir->dd_handle);
 	free(dir);
-- 
1.7.3.2.493.ge4bf7
