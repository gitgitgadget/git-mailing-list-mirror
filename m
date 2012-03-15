From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] i18n: mark relative dates for translation
Date: Thu, 15 Mar 2012 13:51:02 -0500
Message-ID: <20120315185102.GA4636@burratino>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
 <1331198198-22409-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 19:52:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8FmB-0000S6-Te
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 19:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093Ab2COSvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 14:51:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41197 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965297Ab2COSvo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 14:51:44 -0400
Received: by iagz16 with SMTP id z16so4243876iag.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wmk9Zw5MAEQ6bxG/w01h2Ts0S9dqRF0qvnQWVhjHuV4=;
        b=DdYRzISvk1nMeUHbWqRe3Cldc7HhNfq+uMA/rfGyoSS8bHRP4rE/YNSjsS+Pl5Gqh5
         S2oE6OopdOx8MUV1lBBEl0RU7ZSTUbwuJN1C1yZWVlZOaVqMZPBQ2EtkflZT9XmLTCQw
         u8Z7FETbFdEkeTpB33DETa+/VOu0F9ai+vzPj8re9DRtkzcwJGKH66Xt9aWZ24weIHSx
         lQKhAraiP9du2X8o/8WF0ypg9g5yryS0yydc1mLNLsCfvK2Isrjs35NComuKOp2McYun
         yTkyxA4oQMq6CTvDfPbwv4bHHlSZcvInuKKspHZYpCRIVKx1kEDWu5g6ZExLZmUASSj3
         +Tlg==
Received: by 10.50.10.200 with SMTP id k8mr17727066igb.27.1331837504138;
        Thu, 15 Mar 2012 11:51:44 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vr4sm4470577igb.1.2012.03.15.11.51.43
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Mar 2012 11:51:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331198198-22409-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193221>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> English dates get correct plural/singular form as a side effect.
[...]
> +++ b/date.c
> @@ -93,38 +93,46 @@ const char *show_date_relative(unsigned long time=
, int tz,
[...]
>  	if (diff < 90) {
> -		snprintf(timebuf, timebuf_size, "%lu seconds ago", diff);
> +		snprintf(timebuf, timebuf_size,
> +			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
>  		return timebuf;

This leaves me vaguely nervous --- sure, no language is going to use
an expression for "<n> years" that is more than 200 bytes long, but if
one does, it would get truncated.

Would something like the following (untested) on top make sense?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
My other worry is that

> +	struct strbuf sb =3D STRBUF_INIT;
> +	strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
> +	/* TRANSLATORS: "%s" is "<n> years" */
> +	snprintf(timebuf, timebuf_size,
> +	         Q_("%s, %lu month ago", "%s, %lu months ago", months),
> +	         sb.buf, months);
> +	strbuf_release(&sb);

seems excessively complicated.  How do translations normally deal with
cases like this of strings with multiple numbers in them?

 cache.h     |    5 ++--
 date.c      |   73 +++++++++++++++++++++++++++++++--------------------=
--------
 test-date.c |    7 +++---
 3 files changed, 45 insertions(+), 40 deletions(-)

diff --git i/cache.h w/cache.h
index e5e1aa4e..ca704bdd 100644
--- i/cache.h
+++ w/cache.h
@@ -906,10 +906,9 @@ enum date_mode {
 };
=20
 const char *show_date(unsigned long time, int timezone, enum date_mode=
 mode);
-const char *show_date_relative(unsigned long time, int tz,
+void show_date_relative(unsigned long time, int tz,
 			       const struct timeval *now,
-			       char *timebuf,
-			       size_t timebuf_size);
+			       struct strbuf *timebuf);
 int parse_date(const char *date, char *buf, int bufsize);
 int parse_date_basic(const char *date, unsigned long *timestamp, int *=
offset);
 void datestamp(char *buf, int bufsize);
diff --git i/date.c w/date.c
index 063f3449..dfe906dd 100644
--- i/date.c
+++ w/date.c
@@ -86,54 +86,55 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
=20
-const char *show_date_relative(unsigned long time, int tz,
+void show_date_relative(unsigned long time, int tz,
 			       const struct timeval *now,
-			       char *timebuf,
-			       size_t timebuf_size)
+			       struct strbuf *timebuf)
 {
 	unsigned long diff;
-	if (now->tv_sec < time)
-		return _("in the future");
+	if (now->tv_sec < time) {
+		strbuf_addstr(timebuf, _("in the future"));
+		return;
+	}
 	diff =3D now->tv_sec - time;
 	if (diff < 90) {
-		snprintf(timebuf, timebuf_size,
+		strbuf_addf(timebuf,
 			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
-		return timebuf;
+		return;
 	}
 	/* Turn it into minutes */
 	diff =3D (diff + 30) / 60;
 	if (diff < 90) {
-		snprintf(timebuf, timebuf_size,
+		strbuf_addf(timebuf,
 			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
-		return timebuf;
+		return;
 	}
 	/* Turn it into hours */
 	diff =3D (diff + 30) / 60;
 	if (diff < 36) {
-		snprintf(timebuf, timebuf_size,
+		strbuf_addf(timebuf,
 			 Q_("%lu hour ago", "%lu hours ago", diff), diff);
-		return timebuf;
+		return;
 	}
 	/* We deal with number of days from here on */
 	diff =3D (diff + 12) / 24;
 	if (diff < 14) {
-		snprintf(timebuf, timebuf_size,
+		strbuf_addf(timebuf,
 			 Q_("%lu day ago", "%lu days ago", diff), diff);
-		return timebuf;
+		return;
 	}
 	/* Say weeks for the past 10 weeks or so */
 	if (diff < 70) {
-		snprintf(timebuf, timebuf_size,
+		strbuf_addf(timebuf,
 			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
 			 (diff + 3) / 7);
-		return timebuf;
+		return;
 	}
 	/* Say months for the past 12 months or so */
 	if (diff < 365) {
-		snprintf(timebuf, timebuf_size,
+		strbuf_addf(timebuf,
 			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
 			 (diff + 15) / 30);
-		return timebuf;
+		return;
 	}
 	/* Give years and months for 5 years or so */
 	if (diff < 1825) {
@@ -141,40 +142,42 @@ const char *show_date_relative(unsigned long time=
, int tz,
 		unsigned long years =3D totalmonths / 12;
 		unsigned long months =3D totalmonths % 12;
 		if (months) {
 			struct strbuf sb =3D STRBUF_INIT;
 			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
 			/* TRANSLATORS: "%s" is "<n> years" */
-			snprintf(timebuf, timebuf_size,
+			strbuf_addf(timebuf,
 				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
 				 sb.buf, months);
 			strbuf_release(&sb);
 		} else
-			snprintf(timebuf, timebuf_size,
+			strbuf_addf(timebuf,
 				 Q_("%lu year ago", "%lu years ago", years), years);
-		return timebuf;
+		return;
 	}
 	/* Otherwise, just years. Centuries is probably overkill. */
-	snprintf(timebuf, timebuf_size,
+	strbuf_addf(timebuf,
 		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
 		 (diff + 183) / 365);
-	return timebuf;
 }
=20
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
-	static char timebuf[200];
+	static struct strbuf timebuf =3D STRBUF_INIT;
=20
 	if (mode =3D=3D DATE_RAW) {
-		snprintf(timebuf, sizeof(timebuf), "%lu %+05d", time, tz);
-		return timebuf;
+		strbuf_reset(&timebuf);
+		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
+		return timebuf.buf;
 	}
=20
 	if (mode =3D=3D DATE_RELATIVE) {
 		struct timeval now;
+
+		strbuf_reset(&timebuf);
 		gettimeofday(&now, NULL);
-		return show_date_relative(time, tz, &now,
-					  timebuf, sizeof(timebuf));
+		show_date_relative(time, tz, &now, &timebuf);
+		return timebuf.buf;
 	}
=20
 	if (mode =3D=3D DATE_LOCAL)
@@ -183,23 +186,25 @@ const char *show_date(unsigned long time, int tz,=
 enum date_mode mode)
 	tm =3D time_to_tm(time, tz);
 	if (!tm)
 		return NULL;
+
+	strbuf_reset(&timebuf);
 	if (mode =3D=3D DATE_SHORT)
-		sprintf(timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
+		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
 	else if (mode =3D=3D DATE_ISO8601)
-		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
+		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
 	else if (mode =3D=3D DATE_RFC2822)
-		sprintf(timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
+		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else
-		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
+		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
 				month_names[tm->tm_mon],
 				tm->tm_mday,
@@ -207,7 +212,7 @@ const char *show_date(unsigned long time, int tz, e=
num date_mode mode)
 				tm->tm_year + 1900,
 				(mode =3D=3D DATE_LOCAL) ? 0 : ' ',
 				tz);
-	return timebuf;
+	return timebuf.buf;
 }
=20
 /*
diff --git i/test-date.c w/test-date.c
index 6bcd5b03..10afaabb 100644
--- i/test-date.c
+++ w/test-date.c
@@ -7,13 +7,14 @@ static const char *usage_msg =3D "\n"
=20
 static void show_dates(char **argv, struct timeval *now)
 {
-	char buf[128];
+	struct strbuf buf =3D STRBUF_INIT;
=20
 	for (; *argv; argv++) {
 		time_t t =3D atoi(*argv);
-		show_date_relative(t, 0, now, buf, sizeof(buf));
-		printf("%s -> %s\n", *argv, buf);
+		show_date_relative(t, 0, now, &buf);
+		printf("%s -> %s\n", *argv, buf.buf);
 	}
+	strbuf_release(&buf);
 }
=20
 static void parse_dates(char **argv, struct timeval *now)
