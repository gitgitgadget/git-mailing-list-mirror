From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 03/13] Win32: Unicode environment (incoming)
Date: Thu, 17 Jul 2014 17:37:56 +0200
Message-ID: <1405611486-10176-4-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com Thu Jul 17 17:38:21 2014
Return-path: <msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com>)
	id 1X7nl9-0008VZ-KX
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:15 +0200
Received: by mail-la0-f63.google.com with SMTP id hr17sf305483lab.18
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=AReafMYA3ZdunAMJV5Qwy5wcVsUc//kwAOCwWZcOGgg=;
        b=lTzTfnOpkHRrGirpHVTyCcqG+fn4YuldNiK7fL4VGGIK8tVl4b5jhIkOloP+DZLCNg
         PTZruPGkwdeTDnvqcjStklivmyz3tEmdQb+i+hfllYSsIwQl0FO+H54mHN+JqDQxMp3k
         WwC7yp9w4r0rA/EFSqIUU7/oy6kbnkLYil2HpCSLz0p3dKG3aLFWqfWtDphXBx5rmjsz
         tzGM72A6yT2JKna9fFFK/F7XJR3p1+6foaG08zZEZALmIAzU042c3TgeFzrh2AtGLzuu
         UC3AYUWkEVdTI3NMPSUCL3BvdmlpiZaBgjHr46/ZfJj4CwUOP6zQr3v0hwtQI8WL8C7U
         Riew==
X-Received: by 10.180.212.111 with SMTP id nj15mr95028wic.17.1405611495310;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.97.98 with SMTP id dz2ls620940wib.41.canary; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.180.218.170 with SMTP id ph10mr2138265wic.1.1405611494513;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id o6si608383wij.1.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 5C9221C01A1; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253755>

From: Karsten Blees <blees@dcon.de>

Convert environment from UTF-16 to UTF-8 on startup.

No changes to getenv() are necessary, as the MSVCRT version is implemented
on top of char **environ.

However, putenv / _wputenv from MSVCRT no longer work, for two reasons:
1. they try to keep environ, _wenviron and the Win32 process environment
in sync, using the default system encoding instead of UTF-8 to convert
between charsets
2. msysgit and MSVCRT use different allocators, memory allocated in git
cannot be freed by the CRT and vice versa

Implement mingw_putenv using the env_setenv helper function from the
environment merge code.

Note that in case of memory allocation failure, putenv now dies with error
message (due to xrealloc) instead of failing with ENOMEM. As git assumes
setenv / putenv to always succeed, this prevents it from continuing with
incorrect settings.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 15 +++++++++++++++
 compat/mingw.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index bd45950..eadba8a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1259,6 +1259,12 @@ char *mingw_getenv(const char *name)
 	return result;
 }
 
+int mingw_putenv(const char *namevalue)
+{
+	environ = env_setenv(environ, namevalue);
+	return 0;
+}
+
 /*
  * Note, this isn't a complete replacement for getaddrinfo. It assumes
  * that service contains a numerical port, or that it is null. It
@@ -2051,6 +2057,11 @@ void mingw_startup()
 	maxlen = wcslen(_wpgmptr);
 	for (i = 1; i < argc; i++)
 		maxlen = max(maxlen, wcslen(wargv[i]));
+	for (i = 0; wenv[i]; i++)
+		maxlen = max(maxlen, wcslen(wenv[i]));
+
+	/* nedmalloc can't free CRT memory, allocate resizable environment list */
+	environ = xcalloc(i + 1, sizeof(char*));
 
 	/* allocate buffer (wchar_t encodes to max 3 UTF-8 bytes) */
 	maxlen = 3 * maxlen + 1;
@@ -2063,6 +2074,10 @@ void mingw_startup()
 		len = xwcstoutf(buffer, wargv[i], maxlen);
 		__argv[i] = xmemdupz(buffer, len);
 	}
+	for (i = 0; wenv[i]; i++) {
+		len = xwcstoutf(buffer, wenv[i], maxlen);
+		environ[i] = xmemdupz(buffer, len);
+	}
 	free(buffer);
 
 	/* initialize critical section for waitpid pinfo_t list */
diff --git a/compat/mingw.h b/compat/mingw.h
index 510530c..c3889ca 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -210,6 +210,8 @@ char *mingw_getcwd(char *pointer, int len);
 
 char *mingw_getenv(const char *name);
 #define getenv mingw_getenv
+int mingw_putenv(const char *namevalue);
+#define putenv mingw_putenv
 
 int mingw_gethostname(char *host, int namelen);
 #define gethostname mingw_gethostname
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
