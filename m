From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 2/3] Win32: Unicode file name support (dirent)
Date: Tue, 15 Jul 2014 15:43:16 +0200
Message-ID: <1405431797-20899-3-git-send-email-kasal@ucw.cz>
References: <20140712075035.GA12400@ucw.cz>
 <1405431797-20899-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com Tue Jul 15 15:43:31 2014
Return-path: <msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com>)
	id 1X730y-00077M-30
	for gcvm-msysgit@m.gmane.org; Tue, 15 Jul 2014 15:43:28 +0200
Received: by mail-wg0-f58.google.com with SMTP id l18sf579746wgh.23
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Rt2aGiGSoj7UbchqKrgiK8sjitF9LnQKYlLZkXBedV8=;
        b=hEeE9LnHBmp5r3ny+g3AtIeLLzXiNoVIriLsEteqgqZD4pUVI4GRyjfvIDaaSawnHE
         870ypSV12dFku11SsG3b5LcXTanbWr0P3VnWVeaIgfkes1Brsdn60ay2SPe+W9XadccE
         9UIKkMPx+FjafpbycbtnBO9ctMQNlbsVuqm326Vc3kcE2WMeRlNovYA1nIvLZzvECmO6
         /fnnOnoNR18X6EY+XeUiS1LPRQmpk5/diMrwJ8tl1EFDj33QXM1JdfXO6NVT9OefgW3w
         u4XMQyuzDRuaSmGp+T2zamszIiCuiqHcL1nfy//5J4a1KELDOmM1IIo49kFuKlXohq3X
         ePTA==
X-Received: by 10.152.45.66 with SMTP id k2mr15567lam.13.1405431807795;
        Tue, 15 Jul 2014 06:43:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.23.9 with SMTP id i9ls37784laf.17.gmail; Tue, 15 Jul 2014
 06:43:26 -0700 (PDT)
X-Received: by 10.112.129.170 with SMTP id nx10mr46675lbb.21.1405431806821;
        Tue, 15 Jul 2014 06:43:26 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id iz18si640393wic.3.2014.07.15.06.43.26
        for <msysgit@googlegroups.com>;
        Tue, 15 Jul 2014 06:43:26 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 8ADAE1C0151; Tue, 15 Jul 2014 15:43:26 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405431797-20899-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253558>

From: Karsten Blees <blees@dcon.de>
Date: Sat, 14 Jan 2012 22:01:09 +0100

Changes opendir/readdir to use Windows Unicode APIs and convert between
UTF-8/UTF-16.

Removes parameter checks that are already covered by xutftowcs_path. This
changes detection of ENAMETOOLONG from MAX_PATH - 2 to MAX_PATH (matching
is_dir_empty in mingw.c). If name + "/*" or the resulting absolute path is
too long, FindFirstFile fails and errno is set through err_win_to_posix.

Increases the size of dirent.d_name to accommodate the full
WIN32_FIND_DATA.cFileName converted to UTF-8 (UTF-16 to UTF-8 conversion
may grow by factor three in the worst case).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/win32/dirent.c | 30 ++++++++++--------------------
 compat/win32/dirent.h |  2 +-
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index 82a515c..52420ec 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -6,10 +6,10 @@ struct DIR {
 	int dd_stat;          /* 0-based index */
 };
 
-static inline void finddata2dirent(struct dirent *ent, WIN32_FIND_DATAA *fdata)
+static inline void finddata2dirent(struct dirent *ent, WIN32_FIND_DATAW *fdata)
 {
-	/* copy file name from WIN32_FIND_DATA to dirent */
-	memcpy(ent->d_name, fdata->cFileName, sizeof(ent->d_name));
+	/* convert UTF-16 name to UTF-8 */
+	xwcstoutf(ent->d_name, fdata->cFileName, sizeof(ent->d_name));
 
 	/* Set file type, based on WIN32_FIND_DATA */
 	if (fdata->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
@@ -20,25 +20,15 @@ static inline void finddata2dirent(struct dirent *ent, WIN32_FIND_DATAA *fdata)
 
 DIR *opendir(const char *name)
 {
-	char pattern[MAX_PATH];
-	WIN32_FIND_DATAA fdata;
+	wchar_t pattern[MAX_PATH + 2]; /* + 2 for '/' '*' */
+	WIN32_FIND_DATAW fdata;
 	HANDLE h;
 	int len;
 	DIR *dir;
 
-	/* check that name is not NULL */
-	if (!name) {
-		errno = EINVAL;
+	/* convert name to UTF-16 and check length < MAX_PATH */
+	if ((len = xutftowcs_path(pattern, name)) < 0)
 		return NULL;
-	}
-	/* check that the pattern won't be too long for FindFirstFileA */
-	len = strlen(name);
-	if (len + 2 >= MAX_PATH) {
-		errno = ENAMETOOLONG;
-		return NULL;
-	}
-	/* copy name to temp buffer */
-	memcpy(pattern, name, len + 1);
 
 	/* append optional '/' and wildcard '*' */
 	if (len && !is_dir_sep(pattern[len - 1]))
@@ -47,7 +37,7 @@ DIR *opendir(const char *name)
 	pattern[len] = 0;
 
 	/* open find handle */
-	h = FindFirstFileA(pattern, &fdata);
+	h = FindFirstFileW(pattern, &fdata);
 	if (h == INVALID_HANDLE_VALUE) {
 		DWORD err = GetLastError();
 		errno = (err == ERROR_DIRECTORY) ? ENOTDIR : err_win_to_posix(err);
@@ -72,8 +62,8 @@ struct dirent *readdir(DIR *dir)
 	/* if first entry, dirent has already been set up by opendir */
 	if (dir->dd_stat) {
 		/* get next entry and convert from WIN32_FIND_DATA to dirent */
-		WIN32_FIND_DATAA fdata;
-		if (FindNextFileA(dir->dd_handle, &fdata)) {
+		WIN32_FIND_DATAW fdata;
+		if (FindNextFileW(dir->dd_handle, &fdata)) {
 			finddata2dirent(&dir->dd_dir, &fdata);
 		} else {
 			DWORD lasterr = GetLastError();
diff --git a/compat/win32/dirent.h b/compat/win32/dirent.h
index 8838cd6..058207e 100644
--- a/compat/win32/dirent.h
+++ b/compat/win32/dirent.h
@@ -10,7 +10,7 @@ typedef struct DIR DIR;
 
 struct dirent {
 	unsigned char d_type;      /* file type to prevent lstat after readdir */
-	char d_name[MAX_PATH];     /* file name */
+	char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8 conversion) */
 };
 
 DIR *opendir(const char *dirname);
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
