From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 21:33:02 +0200
Message-ID: <20090828193302.GB9233@blimp.localdomain>
References: <4A97193A.8090502@facebook.com> <20090828060538.GA22416@coredump.intra.peff.net> <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com> <20090828150212.GA6013@coredump.intra.peff.net> <alpine.LFD.2.00.0908281307510.6044@xanadu.home> <20090828190319.GA9233@blimp.localdomain> <20090828191521.GA12292@coredump.intra.peff.net> <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:33:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh7CO-0001OZ-JL
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbZH1TdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 15:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbZH1TdP
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:33:15 -0400
Received: from mout1.freenet.de ([195.4.92.91]:54034 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbZH1TdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:33:14 -0400
Received: from [195.4.92.10] (helo=0.mx.freenet.de)
	by mout1.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1Mh7C6-0002r2-3m; Fri, 28 Aug 2009 21:33:06 +0200
Received: from x54ff.x.pppool.de ([89.59.84.255]:33656 helo=tigra.home)
	by 0.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #94)
	id 1Mh7C5-0006oU-Nk; Fri, 28 Aug 2009 21:33:06 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 9C4D3277D8;
	Fri, 28 Aug 2009 21:33:02 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 6D0BB36D28; Fri, 28 Aug 2009 21:33:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127342>

=46rom fe67532bdf095dc9ebc0c7dd67be384e807a197c Mon Sep 17 00:00:00 200=
1
=46rom: Alex Riesen <raa.lkml@gmail.com>
Date: Fri, 28 Aug 2009 20:59:59 +0200
Subject: [PATCH] Add date formatting functions with current time explic=
itely formatted

It should allow safe testing of this part of the code.
---
Alex Riesen, Fri, Aug 28, 2009 21:20:50 +0200:
> On Fri, Aug 28, 2009 at 21:15, Jeff King<peff@peff.net> wrote:
> > On Fri, Aug 28, 2009 at 09:03:19PM +0200, Alex Riesen wrote:
> >
> >> +unsigned long approxidate(const char *date)
> >> +{
> >> + =A0 =A0 struct timeval tv;
> >> + =A0 =A0 gettimeofday(&tv, NULL);
> >> + =A0 =A0 return approxidate_relative(date, &tv);
> >> +}
> >
> > This now always calls gettimeofday, whereas the original approxidat=
e
> > only did if parse_date failed.
>=20
> Oh, bugger...
>=20

Rather like this, I mean :)

 cache.h |    2 +
 date.c  |  150 ++++++++++++++++++++++++++++++++++++-------------------=
-------
 2 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/cache.h b/cache.h
index dd7f71e..3fb0166 100644
--- a/cache.h
+++ b/cache.h
@@ -731,9 +731,11 @@ enum date_mode {
 };
=20
 const char *show_date(unsigned long time, int timezone, enum date_mode=
 mode);
+const char *show_date_relative(unsigned long time, int tz, const struc=
t timeval *now);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
+unsigned long approxidate_relative(const char *date, const struct time=
val *now);
 enum date_mode parse_date_format(const char *format);
=20
 #define IDENT_WARN_ON_NO_NAME  1
diff --git a/date.c b/date.c
index 409a17d..171e68f 100644
--- a/date.c
+++ b/date.c
@@ -84,6 +84,67 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
=20
+const char *show_date_relative(unsigned long time, int tz, const struc=
t timeval *now)
+{
+	static char timebuf[100 /* TODO: can be optimized */];
+	unsigned long diff;
+	if (now->tv_sec < time)
+		return "in the future";
+	diff =3D now->tv_sec - time;
+	if (diff < 90) {
+		snprintf(timebuf, sizeof(timebuf), "%lu seconds ago", diff);
+		return timebuf;
+	}
+	/* Turn it into minutes */
+	diff =3D (diff + 30) / 60;
+	if (diff < 90) {
+		snprintf(timebuf, sizeof(timebuf), "%lu minutes ago", diff);
+		return timebuf;
+	}
+	/* Turn it into hours */
+	diff =3D (diff + 30) / 60;
+	if (diff < 36) {
+		snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
+		return timebuf;
+	}
+	/* We deal with number of days from here on */
+	diff =3D (diff + 12) / 24;
+	if (diff < 14) {
+		snprintf(timebuf, sizeof(timebuf), "%lu days ago", diff);
+		return timebuf;
+	}
+	/* Say weeks for the past 10 weeks or so */
+	if (diff < 70) {
+		snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7);
+		return timebuf;
+	}
+	/* Say months for the past 12 months or so */
+	if (diff < 360) {
+		snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 3=
0);
+		return timebuf;
+	}
+	/* Give years and months for 5 years or so */
+	if (diff < 1825) {
+		unsigned long years =3D (diff + 183) / 365;
+		unsigned long months =3D (diff % 365 + 15) / 30;
+		int n;
+		n =3D snprintf(timebuf, sizeof(timebuf), "%lu year%s",
+			     years, (years > 1 ? "s" : ""));
+		if (months)
+			snprintf(timebuf + n, sizeof(timebuf) - n,
+				 ", %lu month%s ago",
+				 months, (months > 1 ? "s" : ""));
+		else
+			snprintf(timebuf + n, sizeof(timebuf) - n,
+				 " ago");
+		return timebuf;
+	}
+	/* Otherwise, just years. Centuries is probably overkill. */
+	snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 36=
5);
+	return timebuf;
+
+}
+
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
@@ -95,63 +156,9 @@ const char *show_date(unsigned long time, int tz, e=
num date_mode mode)
 	}
=20
 	if (mode =3D=3D DATE_RELATIVE) {
-		unsigned long diff;
 		struct timeval now;
 		gettimeofday(&now, NULL);
-		if (now.tv_sec < time)
-			return "in the future";
-		diff =3D now.tv_sec - time;
-		if (diff < 90) {
-			snprintf(timebuf, sizeof(timebuf), "%lu seconds ago", diff);
-			return timebuf;
-		}
-		/* Turn it into minutes */
-		diff =3D (diff + 30) / 60;
-		if (diff < 90) {
-			snprintf(timebuf, sizeof(timebuf), "%lu minutes ago", diff);
-			return timebuf;
-		}
-		/* Turn it into hours */
-		diff =3D (diff + 30) / 60;
-		if (diff < 36) {
-			snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
-			return timebuf;
-		}
-		/* We deal with number of days from here on */
-		diff =3D (diff + 12) / 24;
-		if (diff < 14) {
-			snprintf(timebuf, sizeof(timebuf), "%lu days ago", diff);
-			return timebuf;
-		}
-		/* Say weeks for the past 10 weeks or so */
-		if (diff < 70) {
-			snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7)=
;
-			return timebuf;
-		}
-		/* Say months for the past 12 months or so */
-		if (diff < 360) {
-			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / =
30);
-			return timebuf;
-		}
-		/* Give years and months for 5 years or so */
-		if (diff < 1825) {
-			unsigned long years =3D (diff + 183) / 365;
-			unsigned long months =3D (diff % 365 + 15) / 30;
-			int n;
-			n =3D snprintf(timebuf, sizeof(timebuf), "%lu year%s",
-					years, (years > 1 ? "s" : ""));
-			if (months)
-				snprintf(timebuf + n, sizeof(timebuf) - n,
-					", %lu month%s ago",
-					months, (months > 1 ? "s" : ""));
-			else
-				snprintf(timebuf + n, sizeof(timebuf) - n,
-					" ago");
-			return timebuf;
-		}
-		/* Otherwise, just years. Centuries is probably overkill. */
-		snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 3=
65);
-		return timebuf;
+		return show_date_relative(time, tz, &now);
 	}
=20
 	if (mode =3D=3D DATE_LOCAL)
@@ -866,19 +873,13 @@ static const char *approxidate_digit(const char *=
date, struct tm *tm, int *num)
 	return end;
 }
=20
-unsigned long approxidate(const char *date)
+static unsigned long approximation(const char *date, const struct time=
val *tv)
 {
 	int number =3D 0;
 	struct tm tm, now;
-	struct timeval tv;
 	time_t time_sec;
-	char buffer[50];
=20
-	if (parse_date(date, buffer, sizeof(buffer)) > 0)
-		return strtoul(buffer, NULL, 10);
-
-	gettimeofday(&tv, NULL);
-	time_sec =3D tv.tv_sec;
+	time_sec =3D tv->tv_sec;
 	localtime_r(&time_sec, &tm);
 	now =3D tm;
 	for (;;) {
@@ -899,3 +900,26 @@ unsigned long approxidate(const char *date)
 		tm.tm_year--;
 	return mktime(&tm);
 }
+
+unsigned long approxidate_relative(const char *date, const struct time=
val *tv)
+{
+	char buffer[50];
+
+	if (parse_date(date, buffer, sizeof(buffer)) > 0)
+		return strtoul(buffer, NULL, 10);
+
+	return approximation(date, tv);
+}
+
+unsigned long approxidate(const char *date)
+{
+	struct timeval tv;
+	char buffer[50];
+
+	if (parse_date(date, buffer, sizeof(buffer)) > 0)
+		return strtoul(buffer, NULL, 10);
+
+	gettimeofday(&tv, NULL);
+	return approximation(date, &tv);
+}
+
--=20
1.6.4.1.261.gf9874
