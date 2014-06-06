From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 2/5] Detect console streams more reliably on Windows
Date: Fri,  6 Jun 2014 15:42:50 +0200
Message-ID: <1402062173-9602-3-git-send-email-kasal@ucw.cz>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com Fri Jun 06 15:43:25 2014
Return-path: <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>)
	id 1WsuQO-0000et-Ui
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 15:43:16 +0200
Received: by mail-lb0-f192.google.com with SMTP id p9sf324471lbv.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=V1I8r5R07xkpXZ/blbSwSIbIgbuHPqG5E7M9ZAMxN2M=;
        b=day9wGjZwmn9mP9JAhhutDpFVVlMBXC7ZpwCBHFxBLZORUyaGlgeVj2B9Y7IbrqlPu
         LzSdK9vqPVeeTwjb5dXBADWcaSLFrqkjri+PQ+dBqc1iXRK+VGjSwe1qd5fxY/rH4k7P
         xGR53N1QEwrpxlpHma4KuEIgTP56RP9i5bBymENedWqi6Or2KllDXJ4VhPrScpkdOt0+
         c6h73pUTTu8mWB5/RZA03/6upQeO3aN/jHCAMP+zJ6HaMkyq8BbNTVtPJNVDfOyCmrj2
         BAB1415z30GL6br+7dKQaBlRLrZc+AjvTtszQVMsdMj6uxfD1fR+tSxGElPjMp55jGGP
         ln6A==
X-Received: by 10.152.2.131 with SMTP id 3mr15620lau.18.1402062196789;
        Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.10.4 with SMTP id e4ls123503lab.84.gmail; Fri, 06 Jun 2014
 06:43:15 -0700 (PDT)
X-Received: by 10.152.6.97 with SMTP id z1mr1417088laz.0.1402062195790;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id s1si1302905wiw.3.2014.06.06.06.43.15
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 96B841C00A5; Fri,  6 Jun 2014 15:43:15 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250907>

From: Karsten Blees <blees@dcon.de>

GetStdHandle(STD_OUTPUT_HANDLE) doesn't work for stderr if stdout is
redirected. Use _get_osfhandle of the FILE* instead.

_isatty() is true for all character devices (including parallel and serial
ports). Check return value of GetConsoleScreenBufferInfo instead to
reliably detect console handles (also don't initialize internal state from
an uninitialized CONSOLE_SCREEN_BUFFER_INFO structure if the function
fails).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/winansi.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index abe0fea..c4be401 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -25,27 +25,39 @@ static HANDLE console;
 static WORD plain_attr;
 static WORD attr;
 static int negative;
+static FILE *last_stream = NULL;
 
-static void init(void)
+static int is_console(FILE *stream)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
+	HANDLE hcon;
 
 	static int initialized = 0;
-	if (initialized)
-		return;
 
-	console = GetStdHandle(STD_OUTPUT_HANDLE);
-	if (console == INVALID_HANDLE_VALUE)
-		console = NULL;
+	/* use cached value if stream hasn't changed */
+	if (stream == last_stream)
+		return console != NULL;
 
-	if (!console)
-		return;
+	last_stream = stream;
+	console = NULL;
 
-	GetConsoleScreenBufferInfo(console, &sbi);
-	attr = plain_attr = sbi.wAttributes;
-	negative = 0;
+	/* get OS handle of the stream */
+	hcon = (HANDLE) _get_osfhandle(_fileno(stream));
+	if (hcon == INVALID_HANDLE_VALUE)
+		return 0;
+
+	/* check if its a handle to a console output screen buffer */
+	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
+		return 0;
+
+	if (!initialized) {
+		attr = plain_attr = sbi.wAttributes;
+		negative = 0;
+		initialized = 1;
+	}
 
-	initialized = 1;
+	console = hcon;
+	return 1;
 }
 
 static int write_console(const char *str, size_t len)
@@ -292,12 +304,7 @@ int winansi_fputs(const char *str, FILE *stream)
 {
 	int rv;
 
-	if (!isatty(fileno(stream)))
-		return fputs(str, stream);
-
-	init();
-
-	if (!console)
+	if (!is_console(stream))
 		return fputs(str, stream);
 
 	rv = ansi_emulate(str, stream);
@@ -315,12 +322,7 @@ int winansi_vfprintf(FILE *stream, const char *format, va_list list)
 	char *buf = small_buf;
 	va_list cp;
 
-	if (!isatty(fileno(stream)))
-		goto abort;
-
-	init();
-
-	if (!console)
+	if (!is_console(stream))
 		goto abort;
 
 	va_copy(cp, list);
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
