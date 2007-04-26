From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Add --date={local,relative,default}
Date: Wed, 25 Apr 2007 21:56:17 -0700
Message-ID: <11775633782185-git-send-email-junkio@cox.net>
References: <alpine.LFD.0.98.0704250800030.9964@woody.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 06:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgw1n-0005gF-SJ
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 06:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbXDZE4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 00:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbXDZE4U
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 00:56:20 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57316 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbXDZE4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 00:56:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070426045619.RTXX1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Apr 2007 00:56:19 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rgwJ1W00a1kojtg0000000; Thu, 26 Apr 2007 00:56:18 -0400
X-Mailer: git-send-email 1.5.2.rc0.719.gb3626
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45609>

This adds --date={local,relative,default} option to log family of commands,
to allow displaying timestamps in user's local timezone, relative time, or
the default format.

Existing --relative-date option is a synonym of --date=relative; we could
probably deprecate it in the long run.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  >>   I think it's useful (read: I've occasionally wanted it), but I think we 
  >>   should make the date option syntax be more extensible.
  >> 
  >>   Ie, it would be better, I think, to use a
  >> 
  >> 	  --date=local
  >> 	  --date=relative
  >> 	  --date=UTC
  >> 	  ...
  >> 
  >>   kind of syntax, than have each date flag be different ("--relative-date" 

  And I obviously agree.

 Documentation/git-rev-list.txt |   14 +++++++++++++-
 builtin-rev-list.c             |    2 +-
 cache.h                        |    2 +-
 commit.c                       |   12 ++++++------
 commit.h                       |    2 +-
 date.c                         |   35 +++++++++++++++++++++++++++++++++--
 log-tree.c                     |    4 ++--
 revision.c                     |   13 ++++++++++++-
 revision.h                     |    4 ++--
 9 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 77e068b..1b12b4f 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -25,6 +25,7 @@ SYNOPSIS
 	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
+	     [ \--date={local|relative|default} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
@@ -90,9 +91,20 @@ include::pretty-formats.txt[]
 
 --relative-date::
 
-	Show dates relative to the current time, e.g. "2 hours ago".
+	Synonym for `--date=relative`.
+
+--date={relative,local,default}::
+
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty".
++
+`--date=relative` shows dates relative to the current time,
+e.g. "2 hours ago".
++
+`--date=local` shows timestamps in user's local timezone.
++
+`--date=default` shows timestamps in the original timezone
+(either committer's or author's).
 
 --header::
 
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
index 38a0cbd..8e76152 100644
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
index 0ceccbe..a9b59a2 100644
--- a/date.c
+++ b/date.c
@@ -55,6 +55,32 @@ static struct tm *time_to_tm(unsigned long time, int tz)
 	return gmtime(&t);
 }
 
+/*
+ * What value of "tz" was in effect back then at "time" in the
+ * local timezone?
+ */
+static int local_tzoffset(unsigned long time)
+{
+	time_t t, t_local;
+	struct tm tm;
+	int offset, eastwest;
+
+	t = time;
+	localtime_r(&t, &tm);
+	t_local = my_mktime(&tm);
+
+	if (t_local < t) {
+		eastwest = -1;
+		offset = t - t_local;
+	} else {
+		eastwest = 1;
+		offset = t_local - t;
+	}
+	offset /= 60; /* in minutes */
+	offset = (offset % 60) + ((offset / 60) * 100);
+	return offset * eastwest;
+}
+
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
@@ -102,6 +128,9 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 		/* Else fall back on absolute format.. */
 	}
 
+	if (mode == DATE_LOCAL)
+		tz = local_tzoffset(time);
+
 	tm = time_to_tm(time, tz);
 	if (!tm)
 		return NULL;
@@ -109,12 +138,14 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 		sprintf(timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
 	else
-		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d %+05d",
+		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
 				month_names[tm->tm_mon],
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
-				tm->tm_year + 1900, tz);
+				tm->tm_year + 1900,
+				(mode == DATE_LOCAL) ? 0 : ' ',
+				tz);
 	return timebuf;
 }
 
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
index 49bd292..e60a26c 100644
--- a/revision.c
+++ b/revision.c
@@ -1111,7 +1111,18 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				continue;
 			}
 			if (!strcmp(arg, "--relative-date")) {
-				revs->relative_date = 1;
+				revs->date_mode = DATE_RELATIVE;
+				continue;
+			}
+			if (!strncmp(arg, "--date=", 7)) {
+				if (!strcmp(arg + 7, "relative"))
+					revs->date_mode = DATE_RELATIVE;
+				else if (!strcmp(arg + 7, "local"))
+					revs->date_mode = DATE_LOCAL;
+				else if (!strcmp(arg + 7, "default"))
+					revs->date_mode = DATE_NORMAL;
+				else
+					die("unknown date format %s", arg);
 				continue;
 			}
 
diff --git a/revision.h b/revision.h
index 5b41e2d..cdf94ad 100644
--- a/revision.h
+++ b/revision.h
@@ -63,8 +63,8 @@ struct rev_info {
 
 	/* Format info */
 	unsigned int	shown_one:1,
-			abbrev_commit:1,
-			relative_date:1;
+			abbrev_commit:1;
+	enum date_mode date_mode;
 
 	const char **ignore_packed; /* pretend objects in these are unpacked */
 	int num_ignore_packed;
-- 
1.5.2.rc0.719.gb3626
