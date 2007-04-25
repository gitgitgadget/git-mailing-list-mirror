From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add date format --local-zone
Date: Tue, 24 Apr 2007 23:36:22 -0700
Message-ID: <1177482982542-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 08:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgb7M-0007Rr-JQ
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 08:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423230AbXDYGgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 02:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423235AbXDYGgY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 02:36:24 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59243 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423230AbXDYGgX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 02:36:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425063623.TWPS1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Wed, 25 Apr 2007 02:36:23 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rJcN1W00a1kojtg0000000; Wed, 25 Apr 2007 02:36:23 -0400
X-Mailer: git-send-email 1.5.2.rc0.719.gb3626
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45498>

This adds --local-zone option to log family of commands, to
display timestamps in user's local timezone.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I got tired of looking at +0000 timestamps on commits
   imported from CVS at day-job.  Does not seem to break
   existing tests, but I am not sure if this is useful.

 builtin-rev-list.c |    2 +-
 cache.h            |    2 +-
 commit.c           |   12 ++++++------
 commit.h           |    2 +-
 date.c             |   31 +++++++++++++++++++++++++++++++
 log-tree.c         |    4 ++--
 revision.c         |    6 +++++-
 revision.h         |    2 +-
 8 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c0329dc..ebf53f5 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -95,7 +95,7 @@ static void show_commit(struct commit *commit)
 		static char pretty_header[16384];
 		pretty_print_commit(revs.commit_format, commit, ~0,
 				    pretty_header, sizeof(pretty_header),
-				    revs.abbrev, NULL, NULL, revs.relative_date);
+				    revs.abbrev, NULL, NULL, revs.date_mode);
 		printf("%s%c", pretty_header, hdr_termination);
 	}
 	fflush(stdout);
diff --git a/cache.h b/cache.h
index f05b67a..6620591 100644
--- a/cache.h
+++ b/cache.h
@@ -389,7 +389,7 @@ extern void *read_object_with_reference(const unsigned char *sha1,
 					unsigned long *size,
 					unsigned char *sha1_ret);
 
-enum date_mode { DATE_NORMAL = 0, DATE_RELATIVE, DATE_SHORT };
+enum date_mode { DATE_NORMAL = 0, DATE_RELATIVE, DATE_SHORT, DATE_LOCAL };
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 const char *show_rfc2822_date(unsigned long time, int timezone);
 int parse_date(const char *date, char *buf, int bufsize);
diff --git a/commit.c b/commit.c
index 10466c4..f1ba972 100644
--- a/commit.c
+++ b/commit.c
@@ -526,7 +526,7 @@ static int add_rfc2047(char *buf, const char *line, int len,
 }
 
 static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
-			 const char *line, int relative_date,
+			 const char *line, enum date_mode dmode,
 			 const char *encoding)
 {
 	char *date;
@@ -569,7 +569,7 @@ static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 	switch (fmt) {
 	case CMIT_FMT_MEDIUM:
 		ret += sprintf(buf + ret, "Date:   %s\n",
-			       show_date(time, tz, relative_date));
+			       show_date(time, tz, dmode));
 		break;
 	case CMIT_FMT_EMAIL:
 		ret += sprintf(buf + ret, "Date: %s\n",
@@ -577,7 +577,7 @@ static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 		break;
 	case CMIT_FMT_FULLER:
 		ret += sprintf(buf + ret, "%sDate: %s\n", what,
-			       show_date(time, tz, relative_date));
+			       show_date(time, tz, dmode));
 		break;
 	default:
 		/* notin' */
@@ -919,7 +919,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				  char *buf, unsigned long space,
 				  int abbrev, const char *subject,
 				  const char *after_subject,
-				  int relative_date)
+				  enum date_mode dmode)
 {
 	int hdr = 1, body = 0, seen_title = 0;
 	unsigned long offset = 0;
@@ -1023,14 +1023,14 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				offset += add_user_info("Author", fmt,
 							buf + offset,
 							line + 7,
-							relative_date,
+							dmode,
 							encoding);
 			if (!memcmp(line, "committer ", 10) &&
 			    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER))
 				offset += add_user_info("Commit", fmt,
 							buf + offset,
 							line + 10,
-							relative_date,
+							dmode,
 							encoding);
 			continue;
 		}
diff --git a/commit.h b/commit.h
index 59de17e..86e8dca 100644
--- a/commit.h
+++ b/commit.h
@@ -61,7 +61,7 @@ enum cmit_fmt {
 };
 
 extern enum cmit_fmt get_commit_format(const char *arg);
-extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject, const char *after_subject, int relative_date);
+extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject, const char *after_subject, enum date_mode dmode);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/date.c b/date.c
index 0ceccbe..aa6ac33 100644
--- a/date.c
+++ b/date.c
@@ -55,6 +55,34 @@ static struct tm *time_to_tm(unsigned long time, int tz)
 	return gmtime(&t);
 }
 
+/*
+ * What value of "tz" was in effect back then at "time" in the
+ * local timezone?
+ */
+static int local_tzoffset(unsigned long time)
+{
+	time_t t, t_local, t_gm;
+	struct tm tm;
+	int offset, eastwest;
+
+	t = time;
+	localtime_r(&t, &tm);
+	t_local = my_mktime(&tm);
+	gmtime_r(&t, &tm);
+	t_gm = my_mktime(&tm);
+
+	if (t_local < t_gm) {
+		eastwest = -1;
+		offset = t_gm - t_local;
+	} else {
+		eastwest = 1;
+		offset = t_local - t_gm;
+	}
+	offset /= 60; /* in minutes */
+	offset = (offset % 60) + ((offset / 60) * 100);
+	return offset * eastwest;
+}
+
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
@@ -102,6 +130,9 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 		/* Else fall back on absolute format.. */
 	}
 
+	if (mode == DATE_LOCAL)
+		tz = local_tzoffset(time);
+
 	tm = time_to_tm(time, tz);
 	if (!tm)
 		return NULL;
diff --git a/log-tree.c b/log-tree.c
index 300b733..c679324 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -267,7 +267,7 @@ void show_log(struct rev_info *opt, const char *sep)
 		if (opt->reflog_info) {
 			show_reflog_message(opt->reflog_info,
 				    opt->commit_format == CMIT_FMT_ONELINE,
-				    opt->relative_date);
+				    opt->date_mode);
 			if (opt->commit_format == CMIT_FMT_ONELINE) {
 				printf("%s", sep);
 				return;
@@ -280,7 +280,7 @@ void show_log(struct rev_info *opt, const char *sep)
 	 */
 	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header,
 				  sizeof(this_header), abbrev, subject,
-				  extra_headers, opt->relative_date);
+				  extra_headers, opt->date_mode);
 
 	if (opt->add_signoff)
 		len = append_signoff(this_header, sizeof(this_header), len,
diff --git a/revision.c b/revision.c
index 49bd292..2a8e2b8 100644
--- a/revision.c
+++ b/revision.c
@@ -1111,7 +1111,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				continue;
 			}
 			if (!strcmp(arg, "--relative-date")) {
-				revs->relative_date = 1;
+				revs->date_mode = DATE_RELATIVE;
+				continue;
+			}
+			if (!strcmp(arg, "--local-zone")) {
+				revs->date_mode = DATE_LOCAL;
 				continue;
 			}
 
diff --git a/revision.h b/revision.h
index 5b41e2d..8f8720a 100644
--- a/revision.h
+++ b/revision.h
@@ -64,7 +64,7 @@ struct rev_info {
 	/* Format info */
 	unsigned int	shown_one:1,
 			abbrev_commit:1,
-			relative_date:1;
+			date_mode:2;
 
 	const char **ignore_packed; /* pretend objects in these are unpacked */
 	int num_ignore_packed;
-- 
1.5.2.rc0.719.gb3626
