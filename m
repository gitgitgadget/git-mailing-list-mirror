From: Chris Webb <chris@arachsys.com>
Subject: [PATCH] format-patch: use current date in mbox 'From COMMIT DATE'
 header line
Date: Thu, 15 Apr 2010 15:41:59 +0100
Message-ID: <9946ffbdf26e7b08b9b00b87d4b575fea774be4c.1271342450.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 16:42:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2QGh-00063b-BB
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 16:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab0DOOmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 10:42:05 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:38087 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0DOOmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 10:42:04 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2QGW-0002Od-TK; Thu, 15 Apr 2010 15:42:01 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144992>

Put the current date in the 'From COMMIT DATE' header line instead of using
the fixed date 'Mon Sep 17 00:00:00 2001'. A DATE_UTC mode for show_date() is
introduced so we can easily generate this line in the correct format.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/blame.c |    1 +
 cache.h         |    3 ++-
 date.c          |    4 +++-
 log-tree.c      |    2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..42fb1bd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2301,6 +2301,7 @@ parse_done:
 		/* "normal" is used as the fallback for "relative" */
 	case DATE_LOCAL:
 	case DATE_NORMAL:
+	case DATE_UTC:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
 	}
diff --git a/cache.h b/cache.h
index 5eb0573..fdb0643 100644
--- a/cache.h
+++ b/cache.h
@@ -769,7 +769,8 @@ enum date_mode {
 	DATE_LOCAL,
 	DATE_ISO8601,
 	DATE_RFC2822,
-	DATE_RAW
+	DATE_RAW,
+	DATE_UTC
 };
 
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
diff --git a/date.c b/date.c
index 002aa3c..88b1b58 100644
--- a/date.c
+++ b/date.c
@@ -166,6 +166,8 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 
 	if (mode == DATE_LOCAL)
 		tz = local_tzoffset(time);
+	else if (mode == DATE_UTC)
+		tz = 0;
 
 	tm = time_to_tm(time, tz);
 	if (!tm)
@@ -192,7 +194,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tm->tm_year + 1900,
-				(mode == DATE_LOCAL) ? 0 : ' ',
+				(mode != DATE_NORMAL) ? 0 : ' ',
 				tz);
 	return timebuf;
 }
diff --git a/log-tree.c b/log-tree.c
index d3ae969..798baf6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -217,7 +217,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		subject = "Subject: ";
 	}
 
-	printf("From %s Mon Sep 17 00:00:00 2001\n", name);
+	printf("From %s %s\n", name, show_date(time(NULL), 0, DATE_UTC));
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
 		printf("Message-Id: <%s>\n", opt->message_id);
-- 
1.7.0.3
