From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2 6/6] Win32: fix broken pipe detection
Date: Sat,  7 Jun 2014 09:57:25 +0200
Message-ID: <1402127845-4862-7-git-send-email-kasal@ucw.cz>
References: <20140606183935.GA4197@camelia.ucw.cz>
 <1402127845-4862-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com Sat Jun 07 09:57:32 2014
Return-path: <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>)
	id 1WtBVJ-0004YJ-7z
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 09:57:29 +0200
Received: by mail-lb0-f188.google.com with SMTP id q8sf441166lbi.5
        for <gcvm-msysgit@m.gmane.org>; Sat, 07 Jun 2014 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=6qNeE9zX9NUnhyI/pkWX0tycPvro8XZ2Hqu3ueeTqEE=;
        b=HohOpxVrI9NcX8OsYcO8ukGQ2r8FEuc+RZYDH9t9oGj9BbTyQ2Ya2FEr+EgK4HT71D
         dO3KPDYDgyRoGr93ogMZ1mGvKozmoXR0NTA6Bt7v8CkbLA+6R0+fq7uLYvFrUDEfqvI6
         LRtZSsO0WjsQZ3/Xy7SRfXp21Ptr+JAxHks+wrtyQXBYQSxOBiolIdecmGZciEzW9j8T
         G9IeutGjrf7XWSES8tH2meJXG+XjOoNZzHeH1dKlHGtB07vQ/EEEUqII7S+OI8NUB8pm
         D571/FEgw+SC/8YbwPznWhBB9wx9ORpyPvIW7zg0aRKVrOC4tCodzh1wOogOg3mBrmdH
         gHhg==
X-Received: by 10.180.90.72 with SMTP id bu8mr44151wib.5.1402127849050;
        Sat, 07 Jun 2014 00:57:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.89.176 with SMTP id bp16ls212503wib.6.canary; Sat, 07 Jun
 2014 00:57:28 -0700 (PDT)
X-Received: by 10.14.127.6 with SMTP id c6mr2897190eei.0.1402127848037;
        Sat, 07 Jun 2014 00:57:28 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id ck3si803577wib.0.2014.06.07.00.57.27
        for <msysgit@googlegroups.com>;
        Sat, 07 Jun 2014 00:57:28 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id C281F1C00AF; Sat,  7 Jun 2014 09:57:27 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402127845-4862-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251035>

From: Karsten Blees <blees@dcon.de>
Date: Thu, 1 Mar 2012 21:53:54 +0100

As of "Win32: Thread-safe windows console output", git-log no longer
terminates when the pager process dies. This is due to disabling buffering
for the replaced stdout / stderr streams. Git-log will periodically fflush
stdout (see write_or_die.c/mayble_flush_or_die()), but with no buffering,
this is a NOP that always succeeds (so we never detect the EPIPE error).

Exchange the original console handles with our console thread pipe handles
by accessing the internal MSVCRT data structures directly (which are
exposed via __pioinfo for some reason).

Implement this with minimal assumptions about the actual data structure to
make it work with different (hopefully even future) MSVCRT versions.

While messing with internal data structures is ugly, this patch solves the
problem at the source instead of adding more workarounds. We no longer need
the special winansi_isatty override, and the limitations documented in
"Win32: Thread-safe windows console output" are gone (i.e. fdopen(1/2)
returns unbuffered streams now, and isatty() for duped console file
descriptors works as expected).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.h   |   2 -
 compat/winansi.c | 114 ++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 70 insertions(+), 46 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 4b638d8..8dac6f9 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -318,9 +318,7 @@ int mingw_raise(int sig);
  */
 
 void winansi_init(void);
-int winansi_isatty(int fd);
 HANDLE winansi_get_osfhandle(int fd);
-#define isatty winansi_isatty
 
 /*
  * git specific compatibility
diff --git a/compat/winansi.c b/compat/winansi.c
index fcdd6dc..f96d5c2 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -8,11 +8,6 @@
 #include <winreg.h>
 
 /*
- Functions to be wrapped:
-*/
-#undef isatty
-
-/*
  ANSI codes used by git: m, K
 
  This file is git-specific. Therefore, this file does not attempt
@@ -104,6 +99,7 @@ static int is_console(int fd)
 
 	/* initialize attributes */
 	if (!initialized) {
+		console = hcon;
 		attr = plain_attr = sbi.wAttributes;
 		negative = 0;
 		initialized = 1;
@@ -465,29 +461,80 @@ static HANDLE duplicate_handle(HANDLE hnd)
 	return hresult;
 }
 
-static HANDLE redirect_console(FILE *stream, HANDLE *phcon, int new_fd)
-{
-	/* get original console handle */
-	int fd = _fileno(stream);
-	HANDLE hcon = (HANDLE) _get_osfhandle(fd);
-	if (hcon == INVALID_HANDLE_VALUE)
-		die_errno("_get_osfhandle(%i) failed", fd);
 
-	/* save a copy to phcon and console (used by the background thread) */
-	console = *phcon = duplicate_handle(hcon);
+/*
+ * Make MSVCRT's internal file descriptor control structure accessible
+ * so that we can tweak OS handles and flags directly (we need MSVCRT
+ * to treat our pipe handle as if it were a console).
+ *
+ * We assume that the ioinfo structure (exposed by MSVCRT.dll via
+ * __pioinfo) starts with the OS handle and the flags. The exact size
+ * varies between MSVCRT versions, so we try different sizes until
+ * toggling the FDEV bit of _pioinfo(1)->osflags is reflected in
+ * isatty(1).
+ */
+typedef struct {
+	HANDLE osfhnd;
+	char osflags;
+} ioinfo;
+
+extern __declspec(dllimport) ioinfo *__pioinfo[];
 
-	/* duplicate new_fd over fd (closes fd and associated handle (hcon)) */
-	if (_dup2(new_fd, fd))
-		die_errno("_dup2(%i, %i) failed", new_fd, fd);
+static size_t sizeof_ioinfo = 0;
 
-	/* no buffering, or stdout / stderr will be out of sync */
-	setbuf(stream, NULL);
-	return (HANDLE) _get_osfhandle(fd);
+#define IOINFO_L2E 5
+#define IOINFO_ARRAY_ELTS (1 << IOINFO_L2E)
+
+#define FDEV  0x40
+
+static inline ioinfo* _pioinfo(int fd)
+{
+	return (ioinfo*)((char*)__pioinfo[fd >> IOINFO_L2E] +
+			(fd & (IOINFO_ARRAY_ELTS - 1)) * sizeof_ioinfo);
+}
+
+static int init_sizeof_ioinfo()
+{
+	int istty, wastty;
+	/* don't init twice */
+	if (sizeof_ioinfo)
+		return sizeof_ioinfo >= 256;
+
+	sizeof_ioinfo = sizeof(ioinfo);
+	wastty = isatty(1);
+	while (sizeof_ioinfo < 256) {
+		/* toggle FDEV flag, check isatty, then toggle back */
+		_pioinfo(1)->osflags ^= FDEV;
+		istty = isatty(1);
+		_pioinfo(1)->osflags ^= FDEV;
+		/* return if we found the correct size */
+		if (istty != wastty)
+			return 0;
+		sizeof_ioinfo += sizeof(void*);
+	}
+	error("Tweaking file descriptors doesn't work with this MSVCRT.dll");
+	return 1;
+}
+
+static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
+{
+	ioinfo *pioinfo;
+	HANDLE old_handle;
+
+	/* init ioinfo size if we haven't done so */
+	if (init_sizeof_ioinfo())
+		return INVALID_HANDLE_VALUE;
+
+	/* get ioinfo pointer and change the handles */
+	pioinfo = _pioinfo(fd);
+	old_handle = pioinfo->osfhnd;
+	pioinfo->osfhnd = new_handle;
+	return old_handle;
 }
 
 void winansi_init(void)
 {
-	int con1, con2, hwrite_fd;
+	int con1, con2;
 	char name[32];
 
 	/* check if either stdout or stderr is a console output screen buffer */
@@ -516,19 +563,11 @@ void winansi_init(void)
 	if (atexit(winansi_exit))
 		die_errno("atexit(winansi_exit) failed");
 
-	/* create a file descriptor for the write end of the pipe */
-	hwrite_fd = _open_osfhandle((long) duplicate_handle(hwrite), _O_BINARY);
-	if (hwrite_fd == -1)
-		die_errno("_open_osfhandle(%li) failed", (long) hwrite);
-
 	/* redirect stdout / stderr to the pipe */
 	if (con1)
-		hwrite1 = redirect_console(stdout, &hconsole1, hwrite_fd);
+		hconsole1 = swap_osfhnd(1, hwrite1 = duplicate_handle(hwrite));
 	if (con2)
-		hwrite2 = redirect_console(stderr, &hconsole2, hwrite_fd);
-
-	/* close pipe file descriptor (also closes the duped hwrite) */
-	close(hwrite_fd);
+		hconsole2 = swap_osfhnd(2, hwrite2 = duplicate_handle(hwrite));
 }
 
 static int is_same_handle(HANDLE hnd, int fd)
@@ -537,19 +576,6 @@ static int is_same_handle(HANDLE hnd, int fd)
 }
 
 /*
- * Return true if stdout / stderr is a pipe redirecting to the console.
- */
-int winansi_isatty(int fd)
-{
-	if (fd == 1 && is_same_handle(hwrite1, 1))
-		return 1;
-	else if (fd == 2 && is_same_handle(hwrite2, 2))
-		return 1;
-	else
-		return isatty(fd);
-}
-
-/*
  * Returns the real console handle if stdout / stderr is a pipe redirecting
  * to the console. Allows spawn / exec to pass the console to the next process.
  */
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
