From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 02:05:38 -0400
Message-ID: <20090828060538.GA22416@coredump.intra.peff.net>
References: <4A97193A.8090502@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 08:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgubP-00022M-M6
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 08:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbZH1GFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 02:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbZH1GFl
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 02:05:41 -0400
Received: from peff.net ([208.65.91.99]:48178 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbZH1GFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 02:05:40 -0400
Received: (qmail 3839 invoked by uid 107); 28 Aug 2009 06:05:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 28 Aug 2009 02:05:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2009 02:05:38 -0400
Content-Disposition: inline
In-Reply-To: <4A97193A.8090502@facebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127270>

On Thu, Aug 27, 2009 at 04:39:38PM -0700, David Reiss wrote:

> Previously, a commit from 1 year and 7 months ago would display as
> "2 years, 7 months ago".

Wow, embarrassing.

Acked-by: Jeff King <peff@peff.net>

> Here's my test script.  Let me know if you'd rather have it as part
> of the test suite.

I couldn't find any tests related to relative date processing, so it
would be really nice to have some. But I'm not sure of the best way to
do it without dealing with race conditions. Annoyingly, show_date calls
gettimeofday at a pretty low level, so there isn't a way of
instrumenting it short of LD_PRELOAD trickery (which is probably not
very portable).

But maybe a patch like this is worth doing, which would allow us to test
in a repeatable fashion:

---
diff --git a/date.c b/date.c
index e848d96..db2f831 100644
--- a/date.c
+++ b/date.c
@@ -86,6 +86,33 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
 
+static int current_time(struct timeval *now)
+{
+	static struct timeval fake_time;
+	static int use_fake_time = -1;
+
+	if (use_fake_time == -1) {
+		const char *x = getenv("GIT_FAKE_TIME");
+		if (x) {
+			char buf[50];
+			if (parse_date(x, buf, sizeof(buf)) <= 0)
+				die("unable to parse GIT_FAKE_TIME");
+			fake_time.tv_sec = strtoul(buf, NULL, 10);
+			fake_time.tv_usec = 0;
+			use_fake_time = 1;
+		}
+		else
+			use_fake_time = 0;
+	}
+
+	if (use_fake_time == 1) {
+		memcpy(now, &fake_time, sizeof(*now));
+		return 0;
+	}
+
+	return gettimeofday(now, NULL);
+}
+
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
@@ -99,7 +126,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	if (mode == DATE_RELATIVE) {
 		unsigned long diff;
 		struct timeval now;
-		gettimeofday(&now, NULL);
+		current_time(&now);
 		if (now.tv_sec < time)
 			return "in the future";
 		diff = now.tv_sec - time;
@@ -929,7 +956,7 @@ unsigned long approxidate(const char *date)
 	if (parse_date(date, buffer, sizeof(buffer)) > 0)
 		return strtoul(buffer, NULL, 10);
 
-	gettimeofday(&tv, NULL);
+	current_time(&tv);
 	time_sec = tv.tv_sec;
 	localtime_r(&time_sec, &tm);
 	now = tm;
