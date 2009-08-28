From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 15:15:21 -0400
Message-ID: <20090828191521.GA12292@coredump.intra.peff.net>
References: <4A97193A.8090502@facebook.com>
 <20090828060538.GA22416@coredump.intra.peff.net>
 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
 <20090828190319.GA9233@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:15:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6vM-0004mE-Pf
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbZH1TPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbZH1TPX
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:15:23 -0400
Received: from peff.net ([208.65.91.99]:53010 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbZH1TPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:15:21 -0400
Received: (qmail 7331 invoked by uid 107); 28 Aug 2009 19:15:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 28 Aug 2009 15:15:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2009 15:15:21 -0400
Content-Disposition: inline
In-Reply-To: <20090828190319.GA9233@blimp.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127335>

On Fri, Aug 28, 2009 at 09:03:19PM +0200, Alex Riesen wrote:

> +unsigned long approxidate(const char *date)
> +{
> +	struct timeval tv;
> +	gettimeofday(&tv, NULL);
> +	return approxidate_relative(date, &tv);
> +}

This now always calls gettimeofday, whereas the original approxidate
only did if parse_date failed.

I think you could also make this patch much smaller by just wrapping the
whole function and using a '0' sentinel for "you need to fill in the
time." Like:

---
diff --git a/date.c b/date.c
index 409a17d..b084d19 100644
--- a/date.c
+++ b/date.c
@@ -86,6 +86,14 @@ static int local_tzoffset(unsigned long time)
 
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
+	struct timeval now;
+	now.tv_sec = 0;
+	show_date_at_time(time, tz, mode, &now);
+}
+
+const char *show_date_at_time(unsigned long time, int tz, enum date_mode mode,
+		struct timeval now)
+{
 	struct tm *tm;
 	static char timebuf[200];
 
@@ -96,8 +104,8 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 
 	if (mode == DATE_RELATIVE) {
 		unsigned long diff;
-		struct timeval now;
-		gettimeofday(&now, NULL);
+		if (!now.tv_sec)
+			gettimeofday(&now, NULL);
 		if (now.tv_sec < time)
 			return "in the future";
 		diff = now.tv_sec - time;

On the other hand, refactoring the relative date code into its own
function is probably a good thing in the long run.

-Peff
