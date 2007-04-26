From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Fine-tune relative-date output.
Date: Wed, 25 Apr 2007 22:23:00 -0700
Message-ID: <11775649803059-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 07:23:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgwRk-0006RO-2u
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 07:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbXDZFXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 01:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbXDZFXD
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 01:23:03 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34760 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932768AbXDZFXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 01:23:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070426052259.SFKW1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Thu, 26 Apr 2007 01:22:59 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rhP01W00g1kojtg0000000; Thu, 26 Apr 2007 01:23:00 -0400
X-Mailer: git-send-email 1.5.2.rc0.719.gb3626
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45610>

I've always found relative-date less useful than it could be, as
it switched to coarser unit a bit too quickly, so this attempts
to fine tune it to my liking.

For example, earlier we said "3 weeks ago" if it is between 18
days and 24 days; now we do not say "weeks" if it is less than a
month old.

                        Earlier         Updated

   X minutes ago        < 90 minutes    < 3 hours
   X hours ago          < 36 hours      < 3 days
   X days ago           < 2 weeks       < 1 month
   X weeks ago          < 10 weeks      < 10 weeks
   X months ago         < 1 year        < 2 1/2 years

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I will not strongly insist doing this, but the current
   setting is so annoying that I seldom use --relative-date,
   except when I look at reflog entries that are no older than a
   day.

   We probably could have --relative-date=90,36,14,70,360 (or
   .git/config equivalent) to further fine tune this, but I
   personally did not feel it is worth it.

 date.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/date.c b/date.c
index a9b59a2..d2ea995 100644
--- a/date.c
+++ b/date.c
@@ -99,19 +99,19 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 		}
 		/* Turn it into minutes */
 		diff = (diff + 30) / 60;
-		if (diff < 90) {
+		if (diff < 180) {
 			snprintf(timebuf, sizeof(timebuf), "%lu minutes ago", diff);
 			return timebuf;
 		}
 		/* Turn it into hours */
 		diff = (diff + 30) / 60;
-		if (diff < 36) {
+		if (diff < 72) {
 			snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
 			return timebuf;
 		}
 		/* We deal with number of days from here on */
 		diff = (diff + 12) / 24;
-		if (diff < 14) {
+		if (diff < 35) {
 			snprintf(timebuf, sizeof(timebuf), "%lu days ago", diff);
 			return timebuf;
 		}
@@ -120,8 +120,8 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 			snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7);
 			return timebuf;
 		}
-		/* Say months for the past 12 months or so */
-		if (diff < 360) {
+		/* Say months for the past 30 months or so */
+		if (diff < 900) {
 			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
 			return timebuf;
 		}
-- 
1.5.2.rc0.719.gb3626
