From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 10/13] Win32: use low-level memory allocation during initialization
Date: Thu, 17 Jul 2014 17:38:03 +0200
Message-ID: <1405611486-10176-11-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com Thu Jul 17 17:38:21 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f190.google.com ([74.125.82.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nlA-0008Vf-1E
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:16 +0200
Received: by mail-we0-f190.google.com with SMTP id w61sf326626wes.27
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=9EWoF7Nu6PptGBk36QwCss/MD77qSyfQeo5DeF5/5VI=;
        b=qruvf/dbjRdZJmCaL0eBWDfyma3TTMxkdGxpnYOZF377b9ywgT7tkkiTEKMHJqSAnM
         WXnc/e2jD1Yz8hMUGeM4nMU8lYafgD3k5g8WbzshOk/E7zHydmhCNBeQsoD9UcOGjBee
         sFTjzLaSx8APggQpEDAwJjhmFnPyQhiVcunVf9QlSNoGkY7F3SBBp8EkmqTk6fThD2DO
         R/jDPKW+NOBWuqnXdS/pFmmK+G3TaSO/zWfPo41iLFF/RkJoNnaa4whE0ks9xhpBxI1K
         ewSnXFHr3GSWajwIfFA300+33y3WfVhcPOxpxTDQ95hqLCE51X95GiLbPZ3yYSiRiRJ6
         a2EQ==
X-Received: by 10.152.37.8 with SMTP id u8mr10415laj.24.1405611495754;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.121.41 with SMTP id lh9ls217360lab.41.gmail; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.152.26.41 with SMTP id i9mr386243lag.8.1405611494705;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id cj4si1078833wid.0.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 8510B1C01AD; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253752>

From: Karsten Blees <blees@dcon.de>

As of d41489a6 "Add more large blob test cases", git's high-level memory
allocation functions (xmalloc, xmemdupz etc.) access the environment to
simulate limited memory in tests (see 'getenv("GIT_ALLOC_LIMIT")' in
memory_limit_check()). These functions should not be used before the
environment is fully initialized (particularly not to initialize the
environment itself).

The current solution ('environ = NULL; ALLOC_GROW(environ...)') only works
because MSVCRT's getenv() reinitializes environ when it is NULL (i.e. it
leaves us with two sets of unusabe (non-UTF-8) and unfreeable (CRT-
allocated) environments).

Add our own set of malloc-or-die functions to be used in startup code.

Also check the result of __wgetmainargs, which may fail if there's not
enough memory for wide-char arguments and environment.

This patch is in preparation of the sorted environment feature, which
completely replaces MSVCRT's getenv() implementation.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e63fd6a..757a6b1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2032,9 +2032,23 @@ static NORETURN void die_startup()
 	exit(128);
 }
 
+static void *malloc_startup(size_t size)
+{
+	void *result = malloc(size);
+	if (!result)
+		die_startup();
+	return result;
+}
+
+static char *wcstoutfdup_startup(char *buffer, const wchar_t *wcs, size_t len)
+{
+	len = xwcstoutf(buffer, wcs, len) + 1;
+	return memcpy(malloc_startup(len), buffer, len);
+}
+
 void mingw_startup()
 {
-	int i, len, maxlen, argc;
+	int i, maxlen, argc;
 	char *buffer;
 	wchar_t **wenv, **wargv;
 	_startupinfo si;
@@ -2051,26 +2065,25 @@ void mingw_startup()
 	for (i = 0; wenv[i]; i++)
 		maxlen = max(maxlen, wcslen(wenv[i]));
 
-	/* nedmalloc can't free CRT memory, allocate resizable environment list */
-	environ = NULL;
+	/*
+	 * nedmalloc can't free CRT memory, allocate resizable environment
+	 * list. Note that xmalloc / xmemdupz etc. call getenv, so we cannot
+	 * use it while initializing the environment itself.
+	 */
 	environ_size = i + 1;
-	ALLOC_GROW(environ, environ_size * sizeof(char*), environ_alloc);
+	environ_alloc = alloc_nr(environ_size * sizeof(char*));
+	environ = malloc_startup(environ_alloc);
 
 	/* allocate buffer (wchar_t encodes to max 3 UTF-8 bytes) */
 	maxlen = 3 * maxlen + 1;
-	buffer = xmalloc(maxlen);
+	buffer = malloc_startup(maxlen);
 
 	/* convert command line arguments and environment to UTF-8 */
-	len = xwcstoutf(buffer, _wpgmptr, maxlen);
-	__argv[0] = xmemdupz(buffer, len);
-	for (i = 1; i < argc; i++) {
-		len = xwcstoutf(buffer, wargv[i], maxlen);
-		__argv[i] = xmemdupz(buffer, len);
-	}
-	for (i = 0; wenv[i]; i++) {
-		len = xwcstoutf(buffer, wenv[i], maxlen);
-		environ[i] = xmemdupz(buffer, len);
-	}
+	__argv[0] = wcstoutfdup_startup(buffer, _wpgmptr, maxlen);
+	for (i = 1; i < argc; i++)
+		__argv[i] = wcstoutfdup_startup(buffer, wargv[i], maxlen);
+	for (i = 0; wenv[i]; i++)
+		environ[i] = wcstoutfdup_startup(buffer, wenv[i], maxlen);
 	environ[i] = NULL;
 	free(buffer);
 
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
