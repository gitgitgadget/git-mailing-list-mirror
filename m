From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 1/2] add interface for /dev/tty interaction
Date: Mon,  6 Aug 2012 02:45:39 +0800
Message-ID: <1344192340-19415-2-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:46:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy5q3-0003Hp-HR
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 20:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab2HESp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 14:45:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60972 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab2HESp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 14:45:58 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so1357511pbb.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6Yv3aqw8Tcaeplqg15Tpn8B7a3JeL9/eXIR+pXbzEHc=;
        b=cUgCYQ4Bc35QWF2QoJmUy0tj/1GUeycaxGznInt45yYba7mc4GfMHQQU3Img0PgF4S
         69zCP5iqEYjyvtvGEpibMQpZgy3dRbnuZStlkcHG+C951R1nl5QmNifnuX865a9vEVun
         BO4dtpcZRoPC//9Qu27JhaFFdKb+a2BvZfwacaoxD1C4W+iZHxmRV3yLfbBs3wdoVU1t
         g7VXSOOaO14sSl8zizQssIeyRP0+9OXg3HrGHFFumdCt2zamDGJl95HEpb4wcnxnUohF
         7vvhhAYTUhB1A+W4GkIsJvjVphL5suuzurgv1Cifbk4JMR3x4mW2itoe8MQrdJiQhbvF
         yyiw==
Received: by 10.66.76.196 with SMTP id m4mr13092204paw.61.1344192358347;
        Sun, 05 Aug 2012 11:45:58 -0700 (PDT)
Received: from ubu-01-asus.gateway.2wire.net (cm83.beta238.maxonline.com.sg. [116.86.238.83])
        by mx.google.com with ESMTPS id sf2sm4151691pbc.57.2012.08.05.11.45.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 11:45:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1.187.g6dd9156
In-Reply-To: <1344192340-19415-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202914>

Factor out the opening and closing of /dev/tty from
git_terminal_prompt(), so that callers may first test if a controlling
terminal is available before proceeding with prompting proper.

When HAVE_DEV_TTY is not defined, terminal_open() falls back to checking
tty-ness of stdin and stderr, as getpass() uses them both.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 compat/terminal.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
 compat/terminal.h | 10 ++++++++++
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 6d16c8f..c85d5c7 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -24,15 +24,21 @@ static void restore_term_on_signal(int sig)
 	raise(sig);
 }
 
-char *git_terminal_prompt(const char *prompt, int echo)
+term_t terminal_open(void)
+{
+	return fopen("/dev/tty", "w+");
+}
+
+int terminal_close(term_t term)
+{
+	return fclose(term);
+}
+
+char *terminal_prompt(term_t term, const char *prompt, int echo)
 {
 	static struct strbuf buf = STRBUF_INIT;
 	int r;
-	FILE *fh;
-
-	fh = fopen("/dev/tty", "w+");
-	if (!fh)
-		return NULL;
+	FILE *fh = term;
 
 	if (!echo) {
 		struct termios t;
@@ -64,18 +70,48 @@ char *git_terminal_prompt(const char *prompt, int echo)
 	}
 
 	restore_term();
-	fclose(fh);
 
 	if (r == EOF)
 		return NULL;
 	return buf.buf;
 }
 
+char *git_terminal_prompt(const char *prompt, int echo)
+{
+	char *ret;
+	term_t term;
+
+	term = terminal_open();
+	if (!term)
+		return NULL;
+
+	ret = terminal_prompt(term, prompt, echo);
+
+	terminal_close(term);
+
+	return ret;
+}
+
 #else
 
-char *git_terminal_prompt(const char *prompt, int echo)
+term_t terminal_open()
+{
+	return isatty(0) && isatty(2);
+}
+
+int terminal_close(term_t term)
+{
+	return 0;
+}
+
+char *terminal_prompt(term_t term, const char *prompt, int echo)
 {
 	return getpass(prompt);
 }
 
+char *git_terminal_prompt(const char *prompt, int echo)
+{
+	return terminal_prompt(prompt, echo);
+}
+
 #endif
diff --git a/compat/terminal.h b/compat/terminal.h
index 97db7cd..cf2aa10 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -1,6 +1,16 @@
 #ifndef COMPAT_TERMINAL_H
 #define COMPAT_TERMINAL_H
 
+#ifdef HAVE_DEV_TTY
+typedef FILE *term_t;
+#else
+typedef int term_t;
+#endif
+
+term_t terminal_open();
+int terminal_close(term_t term);
+char *terminal_prompt(term_t term, const char *prompt, int echo);
+
 char *git_terminal_prompt(const char *prompt, int echo);
 
 #endif /* COMPAT_TERMINAL_H */
-- 
1.7.12.rc1.187.g6dd9156
