From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add --pretty=changelog
Date: Tue, 27 Feb 2007 16:21:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
To: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 16:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM48z-0004bW-HD
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbXB0PVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbXB0PVa
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:21:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:43858 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932129AbXB0PV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:21:29 -0500
Received: (qmail invoked by alias); 27 Feb 2007 15:21:28 -0000
X-Provags-ID: V01U2FsdGVkX18uvBFlt1guEONHpf3GKqyZtFQxj1QNrOQUoJW8Mk
	uboA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40745>


This outputs the log in GNU ChangeLog format.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.c   |   18 +++++++++++---
 commit.h   |    1 +
 diff.c     |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 diff.h     |    1 +
 log-tree.c |   17 ++++++++++++-
 revision.c |    6 ++++
 6 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index fb75ae5..64ddb56 100644
--- a/commit.c
+++ b/commit.c
@@ -38,6 +38,7 @@ struct cmt_fmt_map {
 	{ "fuller",	5,	CMIT_FMT_FULLER },
 	{ "oneline",	1,	CMIT_FMT_ONELINE },
 	{ "format:",	7,	CMIT_FMT_USERFORMAT},
+	{ "changelog",	9,	CMIT_FMT_CHANGELOG}
 };
 
 static char *user_format;
@@ -563,6 +564,8 @@ static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 		ret += namelen - display_name_length;
 		buf[ret++] = '\n';
 	}
+	else if (fmt == CMIT_FMT_CHANGELOG)
+		ret = 0;
 	else {
 		ret = sprintf(buf, "%s: %.*s%.*s\n", what,
 			      (fmt == CMIT_FMT_FULLER) ? 4 : 0,
@@ -581,6 +584,11 @@ static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 		ret += sprintf(buf + ret, "%sDate: %s\n", what,
 			       show_date(time, tz, relative_date));
 		break;
+	case CMIT_FMT_CHANGELOG:
+		ret += sprintf(buf + ret, "%s  %.*s\n",
+				show_date(time, tz, DATE_SHORT),
+				namelen, line);
+		break;
 	default:
 		/* notin' */
 		break;
@@ -603,7 +611,7 @@ static int add_merge_info(enum cmit_fmt fmt, char *buf, const struct commit *com
 	int offset;
 
 	if ((fmt == CMIT_FMT_ONELINE) || (fmt == CMIT_FMT_EMAIL) ||
-	    !parent || !parent->next)
+	    fmt == CMIT_FMT_CHANGELOG || !parent || !parent->next)
 		return 0;
 
 	offset = sprintf(buf, "Merge:");
@@ -931,7 +939,8 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	if (reencoded)
 		msg = reencoded;
 
-	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
+	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL ||
+	    fmt == CMIT_FMT_CHANGELOG)
 		indent = 0;
 
 	/* After-subject is used to pass in Content-Type: multipart
@@ -982,7 +991,8 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 		if (hdr) {
 			if (linelen == 1) {
 				hdr = 0;
-				if ((fmt != CMIT_FMT_ONELINE) && !subject)
+				if (fmt != CMIT_FMT_ONELINE &&
+				    fmt != CMIT_FMT_CHANGELOG && !subject)
 					buf[offset++] = '\n';
 				continue;
 			}
@@ -1052,7 +1062,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 			offset += linelen + indent;
 		}
 		buf[offset++] = '\n';
-		if (fmt == CMIT_FMT_ONELINE)
+		if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_CHANGELOG)
 			break;
 		if (subject && plain_non_ascii) {
 			int sz;
diff --git a/commit.h b/commit.h
index 83507a0..9d59e0f 100644
--- a/commit.h
+++ b/commit.h
@@ -48,6 +48,7 @@ enum cmit_fmt {
 	CMIT_FMT_ONELINE,
 	CMIT_FMT_EMAIL,
 	CMIT_FMT_USERFORMAT,
+	CMIT_FMT_CHANGELOG,
 
 	CMIT_FMT_UNSPECIFIED,
 };
diff --git a/diff.c b/diff.c
index 5651152..aed5388 100644
--- a/diff.c
+++ b/diff.c
@@ -8,6 +8,7 @@
 #include "delta.h"
 #include "xdiff-interface.h"
 #include "color.h"
+#include "utf8.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1845,6 +1846,59 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, p->one, p->two, o);
 }
 
+#define CHANGELOG_TAB_SIZE 8
+#define CHANGELOG_WIDTH 76
+
+struct changelog_t {
+	int offset, seen_first;
+};
+
+static void run_changelog(struct diff_filepair *p, struct diff_options *o,
+	struct changelog_t *changelog)
+{
+	const char *name;
+	const char *other;
+	static char buffer[1024];
+
+	if (DIFF_PAIR_UNMERGED(p)) {
+		/* unmerged */
+		return;
+	}
+
+	if (changelog->seen_first)
+		buffer[0] = ',';
+	else {
+		buffer[0] = '*';
+		changelog->offset = -CHANGELOG_TAB_SIZE;
+		changelog->seen_first = 1;
+	}
+
+	name = p->one->path;
+	other = p->two->path;
+
+	if (!name) {
+		if (!other)
+			return;
+		snprintf(buffer + 1, sizeof(buffer) - 1, " %s", other);
+	} else if (!other || !strcmp(name, other))
+		snprintf(buffer + 1, sizeof(buffer) - 1, " %s", name);
+	else
+		snprintf(buffer + 1, sizeof(buffer) - 1, " %s => %s",
+				name, other);
+	changelog->offset = print_wrapped_text(buffer, -changelog->offset,
+		CHANGELOG_TAB_SIZE + 2, CHANGELOG_WIDTH);
+}
+
+static void finalize_changelog(struct diff_options *options,
+		struct changelog_t *changelog)
+{
+	changelog->offset = print_wrapped_text(": ", -changelog->offset,
+		CHANGELOG_TAB_SIZE + 2, CHANGELOG_WIDTH);
+	changelog->offset = print_wrapped_text(options->stat_sep,
+			-changelog->offset,
+			CHANGELOG_TAB_SIZE + 2, CHANGELOG_WIDTH);
+}
+
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
@@ -2366,6 +2420,19 @@ static void diff_flush_checkdiff(struct diff_filepair *p,
 	run_checkdiff(p, o);
 }
 
+static void diff_flush_changelog(struct diff_filepair *p,
+		struct diff_options *o, struct changelog_t *changelog)
+{
+	if (diff_unmodified_pair(p))
+		return;
+
+	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
+	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
+		return; /* no tree diffs in patch format */
+
+	run_changelog(p, o, changelog);
+}
+
 int diff_queue_is_empty(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -2752,6 +2819,16 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
+	if (output_format & DIFF_FORMAT_CHANGELOG) {
+		struct changelog_t changelog;
+		memset(&changelog, 0, sizeof(struct changelog_t));
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (check_pair_status(p))
+				diff_flush_changelog(p, options, &changelog);
+		}
+		finalize_changelog(options, &changelog);
+	}
 	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT)) {
 		struct diffstat_t diffstat;
 
diff --git a/diff.h b/diff.h
index 4043cec..df3b512 100644
--- a/diff.h
+++ b/diff.h
@@ -30,6 +30,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_SUMMARY	0x0008
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
+#define DIFF_FORMAT_CHANGELOG	0x0040
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
diff --git a/log-tree.c b/log-tree.c
index 6ce239d..b7006bf 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -211,7 +211,8 @@ void show_log(struct rev_info *opt, const char *sep)
 				 sha1, sha1);
 			opt->diffopt.stat_sep = buffer;
 		}
-	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
+	} else if (opt->commit_format != CMIT_FMT_USERFORMAT &&
+			opt->commit_format != CMIT_FMT_CHANGELOG) {
 		fputs(diff_get_color(opt->diffopt.color_diff, DIFF_COMMIT),
 		      stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
@@ -253,6 +254,20 @@ void show_log(struct rev_info *opt, const char *sep)
 				  sizeof(this_header), abbrev, subject,
 				  extra_headers, opt->relative_date);
 
+	if (opt->commit_format == CMIT_FMT_CHANGELOG) {
+		static char *oneline = NULL;
+		char *eol = strchr(this_header, '\n');
+
+		if (oneline)
+			free(oneline);
+		if (eol) {
+			oneline = xstrdup(eol + 1);
+			eol[1] = '\0';
+		} else
+			oneline = NULL;
+		opt->diffopt.stat_sep = oneline;
+	}
+
 	if (opt->add_signoff)
 		len = append_signoff(this_header, sizeof(this_header), len,
 				     opt->add_signoff);
diff --git a/revision.c b/revision.c
index 823bbd1..5bdc1fc 100644
--- a/revision.c
+++ b/revision.c
@@ -1119,6 +1119,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		if (revs->dense_combined_merges && !revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
+	if (revs->commit_format == CMIT_FMT_CHANGELOG) {
+		revs->diffopt.output_format |= DIFF_FORMAT_CHANGELOG;
+		revs->diff = 1;
+		revs->diffopt.recursive = 1;
+		revs->no_merges = 1;
+	}
 	revs->diffopt.abbrev = revs->abbrev;
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
-- 
1.5.0.2.2410.g737b
