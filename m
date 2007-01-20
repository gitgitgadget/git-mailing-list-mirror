From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] show_date(): fix relative dates
Date: Sat, 20 Jan 2007 22:21:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701202203260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jan 20 22:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Nen-00035M-CZ
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 22:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392AbXATVVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 16:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965394AbXATVVl
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 16:21:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:53707 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965392AbXATVVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 16:21:40 -0500
Received: (qmail invoked by alias); 20 Jan 2007 21:21:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 20 Jan 2007 22:21:38 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37291>


We pass a timestamp (i.e. number of seconds elapsed since Jan 1 1970,
00:00:00 GMT) to the function. So there is no need to "fix" the
timestamp according to the timezone.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Just compile & run this little test program to see what I mean:

	#include "cache.h"

	int main(int argc, char **argv)
	{
		time_t t = time(NULL);
		printf("%s\n", show_rfc2822_date(t, 100));
		printf("%s\n", show_date(t, 100, 0));
		printf("%s\n", show_date(t, 0, 0));
		printf("%s\n", show_date(t, 100, 1));
		printf("%s\n", show_date(t, 0, 1));
		return 0;
	}

	Here, it outputs this:

	Sat, 20 Jan 2007 22:20:42 +0100
	Sat Jan 20 22:20:42 2007 +0100
	Sat Jan 20 21:20:42 2007 +0000
	in the future
	0 seconds ago

	Noticed that "in the future"?

 date.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index 7acb8cb..542c004 100644
--- a/date.c
+++ b/date.c
@@ -62,12 +62,11 @@ const char *show_date(unsigned long time, int tz, int relative)
 
 	if (relative) {
 		unsigned long diff;
-		time_t t = gm_time_t(time, tz);
 		struct timeval now;
 		gettimeofday(&now, NULL);
-		if (now.tv_sec < t)
+		if (now.tv_sec < time)
 			return "in the future";
-		diff = now.tv_sec - t;
+		diff = now.tv_sec - time;
 		if (diff < 90) {
 			snprintf(timebuf, sizeof(timebuf), "%lu seconds ago", diff);
 			return timebuf;
-- 
1.5.0.rc1.g956c1-dirty
