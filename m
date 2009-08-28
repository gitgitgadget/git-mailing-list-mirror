From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 21:03:19 +0200
Message-ID: <20090828190319.GA9233@blimp.localdomain>
References: <4A97193A.8090502@facebook.com> <20090828060538.GA22416@coredump.intra.peff.net> <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com> <20090828150212.GA6013@coredump.intra.peff.net> <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6k3-00013d-EA
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbZH1TDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbZH1TDd
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:03:33 -0400
Received: from mout3.freenet.de ([195.4.92.93]:43706 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbZH1TDc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:03:32 -0400
Received: from [195.4.92.22] (helo=12.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1Mh6jM-0001i8-2T; Fri, 28 Aug 2009 21:03:24 +0200
Received: from x54ff.x.pppool.de ([89.59.84.255]:34155 helo=tigra.home)
	by 12.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #94)
	id 1Mh6jL-0008U3-JN; Fri, 28 Aug 2009 21:03:24 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 84FE7277D8;
	Fri, 28 Aug 2009 21:03:20 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 0CFF136D28; Fri, 28 Aug 2009 21:03:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127331>

>From b51bc56816490c71cd37f52be73a06cef6b9bf14 Mon Sep 17 00:00:00 2001
From: Alex Riesen <raa.lkml@gmail.com>
Date: Fri, 28 Aug 2009 20:59:59 +0200
Subject: [PATCH] Add date formatting functions with current time explicitely formatted

It should allow safe testing of this part of the code.
---
Nicolas Pitre, Fri, Aug 28, 2009 19:28:34 +0200:
> On Fri, 28 Aug 2009, Jeff King wrote:
> > On Fri, Aug 28, 2009 at 09:58:27AM +0200, Alex Riesen wrote:
> > 
> > > > I couldn't find any tests related to relative date processing, so it
> > > > would be really nice to have some. But I'm not sure of the best way to
> > > > do it without dealing with race conditions. Annoyingly, show_date calls
> > > > gettimeofday at a pretty low level, so there isn't a way of
> > > > instrumenting it short of LD_PRELOAD trickery (which is probably not
> > > > very portable).
> > > 
> > > Maybe better prepare the _test_ so that it uses current time and time
> > > arithmetics then put yet another cludge in operational code? Especially
> > > when we already have a greate number of GIT_ environment variables,
> > > documented nowhere, with effects not immediately obvious:
> > 
> > But that's the point: you can't do that without a race condition. Your
> > test gets a sense of the current time, then runs git, which checks the
> > current time again. How many seconds elapsed between the two checks?
> > 
> > I guess it is good enough for testing large time spans, but I was hoping
> > for a comprehensive time test.
> 
> I agree with your concern.  This is why I created the --index-version 
> switch to pack-objects.
> 

This is what I mean with "supplying current time":

 cache.h |    2 +
 date.c  |  130 ++++++++++++++++++++++++++++++++++----------------------------
 2 files changed, 73 insertions(+), 59 deletions(-)

diff --git a/cache.h b/cache.h
index dd7f71e..3fb0166 100644
--- a/cache.h
+++ b/cache.h
@@ -731,9 +731,11 @@ enum date_mode {
 };
 
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
+const char *show_date_relative(unsigned long time, int tz, const struct timeval *now);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
+unsigned long approxidate_relative(const char *date, const struct timeval *now);
 enum date_mode parse_date_format(const char *format);
 
 #define IDENT_WARN_ON_NO_NAME  1
diff --git a/date.c b/date.c
index 409a17d..08b4b49 100644
--- a/date.c
+++ b/date.c
@@ -84,6 +84,67 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
 
+const char *show_date_relative(unsigned long time, int tz, const struct timeval *now)
+{
+	static char timebuf[100 /* TODO: can be optimized */];
+	unsigned long diff;
+	if (now->tv_sec < time)
+		return "in the future";
+	diff = now->tv_sec - time;
+	if (diff < 90) {
+		snprintf(timebuf, sizeof(timebuf), "%lu seconds ago", diff);
+		return timebuf;
+	}
+	/* Turn it into minutes */
+	diff = (diff + 30) / 60;
+	if (diff < 90) {
+		snprintf(timebuf, sizeof(timebuf), "%lu minutes ago", diff);
+		return timebuf;
+	}
+	/* Turn it into hours */
+	diff = (diff + 30) / 60;
+	if (diff < 36) {
+		snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
+		return timebuf;
+	}
+	/* We deal with number of days from here on */
+	diff = (diff + 12) / 24;
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
+		snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
+		return timebuf;
+	}
+	/* Give years and months for 5 years or so */
+	if (diff < 1825) {
+		unsigned long years = (diff + 183) / 365;
+		unsigned long months = (diff % 365 + 15) / 30;
+		int n;
+		n = snprintf(timebuf, sizeof(timebuf), "%lu year%s",
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
+	snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 365);
+	return timebuf;
+
+}
+
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
@@ -95,63 +156,9 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	}
 
 	if (mode == DATE_RELATIVE) {
-		unsigned long diff;
 		struct timeval now;
 		gettimeofday(&now, NULL);
-		if (now.tv_sec < time)
-			return "in the future";
-		diff = now.tv_sec - time;
-		if (diff < 90) {
-			snprintf(timebuf, sizeof(timebuf), "%lu seconds ago", diff);
-			return timebuf;
-		}
-		/* Turn it into minutes */
-		diff = (diff + 30) / 60;
-		if (diff < 90) {
-			snprintf(timebuf, sizeof(timebuf), "%lu minutes ago", diff);
-			return timebuf;
-		}
-		/* Turn it into hours */
-		diff = (diff + 30) / 60;
-		if (diff < 36) {
-			snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
-			return timebuf;
-		}
-		/* We deal with number of days from here on */
-		diff = (diff + 12) / 24;
-		if (diff < 14) {
-			snprintf(timebuf, sizeof(timebuf), "%lu days ago", diff);
-			return timebuf;
-		}
-		/* Say weeks for the past 10 weeks or so */
-		if (diff < 70) {
-			snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7);
-			return timebuf;
-		}
-		/* Say months for the past 12 months or so */
-		if (diff < 360) {
-			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
-			return timebuf;
-		}
-		/* Give years and months for 5 years or so */
-		if (diff < 1825) {
-			unsigned long years = (diff + 183) / 365;
-			unsigned long months = (diff % 365 + 15) / 30;
-			int n;
-			n = snprintf(timebuf, sizeof(timebuf), "%lu year%s",
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
-		snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 365);
-		return timebuf;
+		return show_date_relative(time, tz, &now);
 	}
 
 	if (mode == DATE_LOCAL)
@@ -866,19 +873,17 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num)
 	return end;
 }
 
-unsigned long approxidate(const char *date)
+unsigned long approxidate_relative(const char *date, const struct timeval *tv)
 {
 	int number = 0;
 	struct tm tm, now;
-	struct timeval tv;
 	time_t time_sec;
 	char buffer[50];
 
 	if (parse_date(date, buffer, sizeof(buffer)) > 0)
 		return strtoul(buffer, NULL, 10);
 
-	gettimeofday(&tv, NULL);
-	time_sec = tv.tv_sec;
+	time_sec = tv->tv_sec;
 	localtime_r(&time_sec, &tm);
 	now = tm;
 	for (;;) {
@@ -899,3 +904,10 @@ unsigned long approxidate(const char *date)
 		tm.tm_year--;
 	return mktime(&tm);
 }
+
+unsigned long approxidate(const char *date)
+{
+	struct timeval tv;
+	gettimeofday(&tv, NULL);
+	return approxidate_relative(date, &tv);
+}
-- 
1.6.4.1.261.gf9874
