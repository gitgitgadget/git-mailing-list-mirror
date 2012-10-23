From: Peter Krefting <peter@softwolves.pp.se>
Subject: [RFC PATCH 1/2] Use localized date in log output
Date: Tue, 23 Oct 2012 13:25:05 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1210231325010.705@ds9.cixit.se>
References: <alpine.DEB.2.00.1210231323480.602@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 14:25:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQdXt-0002RS-4C
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 14:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784Ab2JWMZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 08:25:07 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:38486 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756299Ab2JWMZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 08:25:06 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q9NCP5BK000722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 23 Oct 2012 14:25:05 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q9NCP5G8000719
	for <git@vger.kernel.org>; Tue, 23 Oct 2012 14:25:05 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.2.00.1210231323480.602@ds9.cixit.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 23 Oct 2012 14:25:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208225>

When outputting a normal log, without having specified which date format
to use, we should output the current user locale's default format. Do this
by initializing LC_TIME properly and using strftime() to format the date.
---
  date.c    |  4 +++-
  gettext.c |  1 +
  strbuf.c  | 10 ++++++++++
  strbuf.h  |  1 +
  4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 57331ed..88f928c 100644
--- a/date.c
+++ b/date.c
@@ -203,7 +203,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
  			weekday_names[tm->tm_wday], tm->tm_mday,
  			month_names[tm->tm_mon], tm->tm_year + 1900,
  			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
-	else
+	else if (mode == DATE_RAW)
  		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
  				weekday_names[tm->tm_wday],
  				month_names[tm->tm_mon],
@@ -212,6 +212,8 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
  				tm->tm_year + 1900,
  				(mode == DATE_LOCAL) ? 0 : ' ',
  				tz);
+	else
+		strbuf_strftime(&timebuf,"%c",tm);
  	return timebuf.buf;
  }

diff --git a/gettext.c b/gettext.c
index 71e9545..a87d144 100644
--- a/gettext.c
+++ b/gettext.c
@@ -126,6 +126,7 @@ void git_setup_gettext(void)
  		podir = GIT_LOCALE_PATH;
  	bindtextdomain("git", podir);
  	setlocale(LC_MESSAGES, "");
+	setlocale(LC_TIME, "");
  	init_gettext_charset("git");
  	textdomain("git");
  }
diff --git a/strbuf.c b/strbuf.c
index 0510f76..d393de9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -228,6 +228,16 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
  	strbuf_setlen(sb, sb->len + len);
  }

+void strbuf_strftime(struct strbuf *sb, const char *fmt, struct tm *tm)
+{
+	int len;
+
+	if (!strbuf_avail(sb))
+		strbuf_grow(sb, 256);
+	len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
+	strbuf_setlen(sb, sb->len + len);
+}
+
  void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
  		   void *context)
  {
diff --git a/strbuf.h b/strbuf.h
index be941ee..9ca1d59 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -99,6 +99,7 @@ __attribute__((format (printf,2,3)))
  extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
  __attribute__((format (printf,2,0)))
  extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
+extern void strbuf_strfime(struct strbuf *sb, const char *fmt, struct tm *tm);

  extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);

-- 
1.8.0
