From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] wt-status: add helpers for printing wt-status lines
Date: Fri, 25 Feb 2011 23:09:41 -0600
Message-ID: <20110226050941.GC27887@elie>
References: <20110226050723.GA27864@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 06:09:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtCPi-0007b6-TJ
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 06:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab1BZFJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 00:09:50 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53634 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1BZFJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 00:09:49 -0500
Received: by vws12 with SMTP id 12so1957246vws.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 21:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Cjywl8CKh+/E5E3mJM642+Vnqi9aaLuUFJCHNpCN15E=;
        b=eTLf+7Hd6jK6B00CkczUySgymE9sloLp23mdRDaL0vWrASpmQXKuwU0XtsfUVmsMt8
         QJ5MPtwD49JrQDXQecjQY0oj2KWNz/hYzE/vhmkFVFK9fJm3cA+GXgXHXGvF4L1Ddcm2
         OHk7PJuB5Y7pYjwJctTF5RK/ej77hdcXBSKnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pQtv63wTm6D3NYP3H/gEWZMrCAH33LTw9JZrTeieqb2gVsqhjM01EvsvH9ADYYmCQr
         tkv3mxeiuDXKF6CmK0YqDDMhOfRXb8NWF34ea/rZ9Rylo8CiyQ3unMrqjXGvJXCO88pr
         YB7IXxurX2rlZQKfSgK9sMUFXBS0iHr8zX1HA=
Received: by 10.52.178.67 with SMTP id cw3mr2099331vdc.305.1298696988385;
        Fri, 25 Feb 2011 21:09:48 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id u6sm1006770vby.17.2011.02.25.21.09.46
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 21:09:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110226050723.GA27864@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167957>

Introduce status_printf{,_ln,_more} wrapper functions around
color_vfprintf() which take care of adding "#" to the beginning of
status lines automatically.  The semantics:

 - status_printf() is just like color_fprintf() but it adds a "# "
   at the beginning of each line of output;

 - status_printf_ln() is a convenience function that additionally
   adds "\n" at the end;

 - status_printf_more() is a variant of status_printf() used to
   continue lines that have already started.  It suppresses the "#" at
   the beginning of the first line.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 color.c     |    9 +++++++
 color.h     |    3 ++
 wt-status.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h |    7 +++++
 4 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/color.c b/color.c
index 6a5a54e..417cf8f 100644
--- a/color.c
+++ b/color.c
@@ -175,6 +175,15 @@ int git_color_default_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb)
+{
+	if (*color)
+		fprintf(fp, "%s", color);
+	fprintf(fp, "%s", sb->buf);
+	if (*color)
+		fprintf(fp, "%s", GIT_COLOR_RESET);
+}
+
 static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 		va_list args, const char *trail)
 {
diff --git a/color.h b/color.h
index 170ff40..c0528cf 100644
--- a/color.h
+++ b/color.h
@@ -1,6 +1,8 @@
 #ifndef COLOR_H
 #define COLOR_H
 
+struct strbuf;
+
 /*  2 + (2 * num_attrs) + 8 + 1 + 8 + 'm' + NUL */
 /* "\033[1;2;4;5;7;38;5;2xx;48;5;2xxm\0" */
 /*
@@ -64,6 +66,7 @@ __attribute__((format (printf, 3, 4)))
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
+void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
 
 int color_is_nil(const char *color);
 
diff --git a/wt-status.c b/wt-status.c
index 123582b..1abd7c3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -32,6 +32,80 @@ static const char *color(int slot, struct wt_status *s)
 	return c;
 }
 
+static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
+		const char *fmt, va_list ap, const char *trail)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf linebuf = STRBUF_INIT;
+	const char *line, *eol;
+
+	strbuf_vaddf(&sb, fmt, ap);
+	if (!sb.len) {
+		strbuf_addch(&sb, '#');
+		if (!trail)
+			strbuf_addch(&sb, ' ');
+		color_print_strbuf(s->fp, color, &sb);
+		if (trail)
+			fprintf(s->fp, "%s", trail);
+		strbuf_release(&sb);
+		return;
+	}
+	for (line = sb.buf; *line; line = eol + 1) {
+		eol = strchr(line, '\n');
+
+		strbuf_reset(&linebuf);
+		if (at_bol) {
+			strbuf_addch(&linebuf, '#');
+			if (*line != '\n' && *line != '\t')
+				strbuf_addch(&linebuf, ' ');
+		}
+		if (eol)
+			strbuf_add(&linebuf, line, eol - line);
+		else
+			strbuf_addstr(&linebuf, line);
+		color_print_strbuf(s->fp, color, &linebuf);
+		if (eol)
+			fprintf(s->fp, "\n");
+		else
+			break;
+		at_bol = 1;
+	}
+	if (trail)
+		fprintf(s->fp, "%s", trail);
+	strbuf_release(&linebuf);
+	strbuf_release(&sb);
+}
+
+void status_printf_ln(struct wt_status *s, const char *color,
+			const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	status_vprintf(s, 1, color, fmt, ap, "\n");
+	va_end(ap);
+}
+
+void status_printf(struct wt_status *s, const char *color,
+			const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	status_vprintf(s, 1, color, fmt, ap, NULL);
+	va_end(ap);
+}
+
+void status_printf_more(struct wt_status *s, const char *color,
+			const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	status_vprintf(s, 0, color, fmt, ap, NULL);
+	va_end(ap);
+}
+
 void wt_status_prepare(struct wt_status *s)
 {
 	unsigned char sha1[20];
diff --git a/wt-status.h b/wt-status.h
index 20b17cf..204a519 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -68,4 +68,11 @@ void wt_status_collect(struct wt_status *s);
 void wt_shortstatus_print(struct wt_status *s, int null_termination, int show_branch);
 void wt_porcelain_print(struct wt_status *s, int null_termination);
 
+void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...)
+	__attribute__((format(printf, 3, 4)));
+void status_printf(struct wt_status *s, const char *color, const char *fmt, ...)
+	__attribute__((format(printf, 3, 4)));
+void status_printf_more(struct wt_status *s, const char *color, const char *fmt, ...)
+	__attribute__((format(printf, 3, 4)));
+
 #endif /* STATUS_H */
-- 
1.7.4.1
