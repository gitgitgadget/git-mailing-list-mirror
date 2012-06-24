From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] compat/terminal: support echoing on windows
Date: Sun, 24 Jun 2012 15:35:03 +0200
Message-ID: <1340544903-37016-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCsr5z_BBoELV_apQ@googlegroups.com Sun Jun 24 15:35:41 2012
Return-path: <msysgit+bncCOPdven-DxCsr5z_BBoELV_apQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCsr5z_BBoELV_apQ@googlegroups.com>)
	id 1Simyb-0003Oo-3s
	for gcvm-msysgit@m.gmane.org; Sun, 24 Jun 2012 15:35:41 +0200
Received: by wefh52 with SMTP id h52sf2080417wef.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 24 Jun 2012 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=vj4adgW1tLKLPkOMs4X4EJWa01Atn2b9gYGCnSSKUik=;
        b=cW33+jF4z86nM0103MCWyUCAe0RWAFO9B4MmlRgOr0QV9yagfq+ktTSSfUMt9NjP6Z
         wb2fbYvP3/grjPNKIIaf2PdIPu9F+bvY5wSeYIkiGbcdAzQxkFRkFZHeG6HKArAocCpI
         7l8OzOhLNx8YWsZLlbntZCjx9t1bfLgerY/ZY=
Received: by 10.204.153.196 with SMTP id l4mr355901bkw.17.1340544940802;
        Sun, 24 Jun 2012 06:35:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.8.149 with SMTP id h21ls2895893bkh.3.gmail; Sun, 24 Jun
 2012 06:35:38 -0700 (PDT)
Received: by 10.205.134.138 with SMTP id ic10mr891696bkc.8.1340544938690;
        Sun, 24 Jun 2012 06:35:38 -0700 (PDT)
Received: by 10.205.134.138 with SMTP id ic10mr891695bkc.8.1340544938676;
        Sun, 24 Jun 2012 06:35:38 -0700 (PDT)
Received: from mail-lb0-f175.google.com (mail-lb0-f175.google.com [209.85.217.175])
        by gmr-mx.google.com with ESMTPS id iv15si10594839bkc.0.2012.06.24.06.35.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 06:35:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.217.175 as permitted sender) client-ip=209.85.217.175;
Received: by mail-lb0-f175.google.com with SMTP id l5so5689579lbo.20
        for <msysgit@googlegroups.com>; Sun, 24 Jun 2012 06:35:38 -0700 (PDT)
Received: by 10.152.102.234 with SMTP id fr10mr8746523lab.32.1340544938427;
        Sun, 24 Jun 2012 06:35:38 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id hm7sm64771628lab.12.2012.06.24.06.35.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 06:35:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.27.gdae0dbb
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.217.175 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200528>

Without /dev/tty support, git_terminal_prompt simply ignores the
'echo'-parameter. On Windows we can do better by clevering up our
getpass-implementation a bit so it can conditionally echo.

While we're at it, plug a small memory-leak by returning a pointer
to a static strbuf instead of detaching it. This is the same thing
the /dev/tty-version of git_terminal_prompt does, and the callee
doesn't expect to have to free it's memory.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c    | 15 ---------------
 compat/mingw.h    |  2 --
 compat/terminal.c | 20 ++++++++++++++++++++
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index afc892d..56ab74c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1699,21 +1699,6 @@ int link(const char *oldpath, const char *newpath)
 	return 0;
 }
 
-char *getpass(const char *prompt)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	fputs(prompt, stderr);
-	for (;;) {
-		char c = _getch();
-		if (c == '\r' || c == '\n')
-			break;
-		strbuf_addch(&buf, c);
-	}
-	fputs("\n", stderr);
-	return strbuf_detach(&buf, NULL);
-}
-
 pid_t waitpid(pid_t pid, int *status, int options)
 {
 	HANDLE h = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION,
diff --git a/compat/mingw.h b/compat/mingw.h
index 61a6521..5e64a98 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -55,8 +55,6 @@ struct passwd {
 	char *pw_dir;
 };
 
-extern char *getpass(const char *prompt);
-
 typedef void (__cdecl *sig_handler_t)(int);
 struct sigaction {
 	sig_handler_t sa_handler;
diff --git a/compat/terminal.c b/compat/terminal.c
index 6d16c8f..53c5166 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -71,6 +71,26 @@ char *git_terminal_prompt(const char *prompt, int echo)
 	return buf.buf;
 }
 
+#elif defined(WIN32)
+
+char *git_terminal_prompt(const char *prompt, int echo)
+{
+	static struct strbuf buf = STRBUF_INIT;
+
+	fputs(prompt, stderr);
+	strbuf_reset(&buf);
+	for (;;) {
+		int c = _getch();
+		if (c == '\n' || c == '\r')
+			break;
+		if (echo)
+			putc(c, stderr);
+		strbuf_addch(&buf, c);
+	}
+	putc('\n', stderr);
+	return buf.buf;
+}
+
 #else
 
 char *git_terminal_prompt(const char *prompt, int echo)
-- 
1.7.11.1.27.gdae0dbb

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
