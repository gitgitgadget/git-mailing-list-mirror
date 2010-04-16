From: Chris Webb <chris@arachsys.com>
Subject: [PATCH v2 1/2] format-patch: use commit date in mbox 'From COMMIT
 DATE' header line
Date: Fri, 16 Apr 2010 17:42:02 +0100
Message-ID: <39d9b1c49e6d8e28eed7fa8d2817dc55834011fb.1271436192.git.chris@arachsys.com>
References: <20100416075251.GA25147@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 18:44:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2oeO-0005aR-0Y
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582Ab0DPQoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 12:44:10 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:44850 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758577Ab0DPQoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:44:08 -0400
Received: from [94.172.195.14] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2oeD-0000nm-U5; Fri, 16 Apr 2010 17:44:06 +0100
Content-Disposition: inline
In-Reply-To: <20100416075251.GA25147@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145080>

Put the commit date in the 'From COMMIT DATE' header line instead of using
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
index d3ae969..90262f9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -217,7 +217,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		subject = "Subject: ";
 	}
 
-	printf("From %s Mon Sep 17 00:00:00 2001\n", name);
+	printf("From %s %s\n", name, show_date(commit->date, 0, DATE_UTC));
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
 		printf("Message-Id: <%s>\n", opt->message_id);
-- 
1.7.0.3
