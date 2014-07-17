From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 04/13] Win32: fix environment memory leaks
Date: Thu, 17 Jul 2014 17:37:57 +0200
Message-ID: <1405611486-10176-5-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com Thu Jul 17 17:38:16 2014
Return-path: <msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f59.google.com ([209.85.215.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com>)
	id 1X7nl9-0008VY-Fw
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:15 +0200
Received: by mail-la0-f59.google.com with SMTP id s18sf317914lam.14
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=s7DJGTi1Vr3cfMmoSpoKjF3NEISlNHznZSsfX3sccX8=;
        b=BYWU7kq4I2JtVUDzTzpabVPMhV2bHJiVDAOKNaVmG3Yj/WPzm3OP4RR6m2Vzvw4kTG
         Nu+AdXnYreZMEiImTD64eUdcKYMXExdsM1nlPpSYufZCCo5YKjw4m3kluRgDAFyKSpp9
         aAK4h9wwWbsBnXundFY4bGt61IMx7Xy1hlPZKYNJS2iSH2tZVH9bcT592GTwrj0xtkFP
         Rm0Zo0UIORhFbOPvNsLzgEqyRiXEuKJZiuNQ1NZ+hsOWkow56AqbgyqXR+P7J6Jdvfh3
         xe8E9zVT5P4ytIcP1K9JspFi5vYKlkE1aUsVkiX5Xx/HmG0VsOnZ2OjswmTbcAPYAKC3
         a8Dg==
X-Received: by 10.180.105.67 with SMTP id gk3mr95313wib.5.1405611495211;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.105.33 with SMTP id gj1ls448592wib.33.gmail; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.180.89.100 with SMTP id bn4mr1353091wib.0.1405611494530;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r13si375101wib.0.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 608C31C01A4; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253745>

From: Karsten Blees <blees@dcon.de>

All functions that modify the environment have memory leaks.

Disable gitunsetenv in the Makefile and use env_setenv (via mingw_putenv)
instead (this frees removed environment entries).

Move xstrdup from env_setenv to make_augmented_environ, so that
mingw_putenv no longer copies the environment entries (according to POSIX
[1], "the string [...] shall become part of the environment"). This also
fixes the memory leak in gitsetenv, which expects a POSIX compliant putenv.

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/putenv.html

Note: This patch depends on taking control of char **environ and having
our own mingw_putenv (both introduced in "Win32: Unicode environment
(incoming)").

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c   | 10 ++++++----
 compat/mingw.h   |  1 +
 config.mak.uname |  2 --
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index eadba8a..47e866c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1219,14 +1219,14 @@ static char **env_setenv(char **env, const char *name)
 			for (i = 0; env[i]; i++)
 				;
 			env = xrealloc(env, (i+2)*sizeof(*env));
-			env[i] = xstrdup(name);
+			env[i] = (char*) name;
 			env[i+1] = NULL;
 		}
 	}
 	else {
 		free(env[i]);
 		if (*eq)
-			env[i] = xstrdup(name);
+			env[i] = (char*) name;
 		else
 			for (; env[i]; i++)
 				env[i] = env[i+1];
@@ -1241,8 +1241,10 @@ char **make_augmented_environ(const char *const *vars)
 {
 	char **env = copy_environ();
 
-	while (*vars)
-		env = env_setenv(env, *vars++);
+	while (*vars) {
+		const char *v = *vars++;
+		env = env_setenv(env, strchr(v, '=') ? xstrdup(v) : v);
+	}
 	return env;
 }
 
diff --git a/compat/mingw.h b/compat/mingw.h
index c3889ca..ef94194 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -212,6 +212,7 @@ char *mingw_getenv(const char *name);
 #define getenv mingw_getenv
 int mingw_putenv(const char *namevalue);
 #define putenv mingw_putenv
+#define unsetenv mingw_putenv
 
 int mingw_gethostname(char *host, int namelen);
 #define gethostname mingw_gethostname
diff --git a/config.mak.uname b/config.mak.uname
index 00cf4c6..15ee15e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -327,7 +327,6 @@ ifeq ($(uname_S),Windows)
 	NO_IPV6 = YesPlease
 	NO_UNIX_SOCKETS = YesPlease
 	NO_SETENV = YesPlease
-	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
@@ -480,7 +479,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SYMLINK_HEAD = YesPlease
 	NO_UNIX_SOCKETS = YesPlease
 	NO_SETENV = YesPlease
-	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
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
