From: eletuchy@gmail.com
Subject: [PATCH 2/2] --date=relative falls back to "short" format for commits older than a year
Date: Fri, 20 Feb 2009 13:23:54 -0800
Message-ID: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
Cc: git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Fri Feb 20 22:30:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lacx0-00011t-EO
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 22:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZBTV27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 16:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbZBTV26
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 16:28:58 -0500
Received: from outmail002.ash1.tfbnw.net ([69.63.184.102]:50118 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753250AbZBTV26 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 16:28:58 -0500
Received: from [10.18.255.176] ([10.18.255.176:48330] helo=facebook.com)
	by mta004.ash1.facebook.com (envelope-from <eletuchy@facebook.com>)
	(ecelerity 2.2.2.37 r(28805/28844)) with ESMTP
	id F8/BE-17105-B6F1F994; Fri, 20 Feb 2009 13:23:56 -0800
Received: by dev051.snc1.facebook.com (Postfix, from userid 1200)
	id 8C50B11C211; Fri, 20 Feb 2009 13:23:54 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.14.g07c3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110893>

From: Eugene Letuchy <eugene@facebook.com>

In the context of sizing the git blame time column, it doesn't make a
lot of sense to see "12 months ago" next to an exact timestamp +
timezone for something 13 months ago. This commit makes commits older
than 12 months display the date only, not the time.

Signed-off-by: Eugene Letuchy <eugene@facebook.com>
---
 builtin-blame.c |    5 ++---
 date.c          |    4 +++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index aa5c66c..48cedfd 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2286,9 +2286,8 @@ parse_done:
 		blame_date_width = sizeof("2006-10-19");
 		break;
 	case DATE_RELATIVE:
-		/* unfortunately "normal" is the fallback for "relative" */
-		/* blame_date_width = sizeof("14 minutes ago"); */
-		/* break; */
+		blame_date_width = sizeof("14 minutes ago");
+		break;
 	case DATE_LOCAL:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
diff --git a/date.c b/date.c
index 950b88f..edb2078 100644
--- a/date.c
+++ b/date.c
@@ -128,7 +128,9 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
 			return timebuf;
 		}
-		/* Else fall back on absolute format.. */
+
+		/* Else fall back to the short format */
+		mode = DATE_SHORT;
 	}
 
 	if (mode == DATE_LOCAL)
-- 
1.6.2.rc1.14.g07c3.dirty
