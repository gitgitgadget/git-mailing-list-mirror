From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fmt-patch: Support --attach
Date: Sat, 20 May 2006 15:40:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605201537290.17869@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat May 20 15:40:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhRhF-00017J-OI
	for gcvg-git@gmane.org; Sat, 20 May 2006 15:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWETNkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 09:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWETNkc
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 09:40:32 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1935 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964847AbWETNkb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 09:40:31 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 8C954C9C;
	Sat, 20 May 2006 15:40:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 807BEC95;
	Sat, 20 May 2006 15:40:29 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 5FF1AC20;
	Sat, 20 May 2006 15:40:29 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20379>


This patch touches a couple of files, because it adds options to print a 
custom text just after the subject of a commit, and just after the 
diffstat.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
	Maybe it would be a good idea to store the options to 
	pretty_print_commit() in a struct...

	Also, I realized that it might be necessary to check the commit
	message for a single "." in a line, since that has special meaning
	in emails.

 builtin-log.c      |   13 ++++++++++---
 builtin-rev-list.c |    2 +-
 commit.c           |   10 +++++++++-
 commit.h           |    2 +-
 diff.c             |    5 ++++-
 diff.h             |    1 +
 log-tree.c         |   35 +++++++++++++++++++++++++++++++----
 revision.h         |    1 +
 show-branch.c      |    2 +-
 9 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 12a6d19..a30e974 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -183,7 +183,9 @@ int cmd_format_patch(int argc, const cha
 						argv[i + 1]);
 			output_directory = strdup(argv[i + 1]);
 			i++;
-		} else
+		} else if (!strcmp(argv[i], "--attach"))
+			rev.mime_boundary = "050802040500080604070107";
+		else
 			argv[j++] = argv[i];
 	}
 	argc = j;
@@ -224,8 +226,13 @@ int cmd_format_patch(int argc, const cha
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
-		if (shown)
-			printf("-- \n%s\n\n", git_version_string);
+		if (shown) {
+			if (rev.mime_boundary)
+				printf("\n--------------%s--\n\n\n",
+						rev.mime_boundary);
+			else
+				printf("-- \n%s\n\n", git_version_string);
+		}
 		if (!use_stdout)
 			fclose(stdout);
 	}
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 6a2e874..78b9c23 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -84,7 +84,7 @@ static void show_commit(struct commit *c
 		static char pretty_header[16384];
 		pretty_print_commit(revs.commit_format, commit, ~0,
 				    pretty_header, sizeof(pretty_header),
-				    revs.abbrev, NULL);
+				    revs.abbrev, NULL, NULL);
 		printf("%s%c", pretty_header, hdr_termination);
 	}
 	fflush(stdout);
diff --git a/commit.c b/commit.c
index 84558ba..0b163d4 100644
--- a/commit.c
+++ b/commit.c
@@ -498,7 +498,7 @@ static int add_merge_info(enum cmit_fmt 
 	return offset;
 }
 
-unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject)
+unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject, const char *after_subject)
 {
 	int hdr = 1, body = 0;
 	unsigned long offset = 0;
@@ -591,6 +591,14 @@ unsigned long pretty_print_commit(enum c
 		buf[offset++] = '\n';
 		if (fmt == CMIT_FMT_ONELINE)
 			break;
+		if (after_subject) {
+			int slen = strlen(after_subject);
+			if (slen > space - offset - 1)
+				slen = space - offset - 1;
+			memcpy(buf + offset, after_subject, slen);
+			offset += slen;
+			after_subject = NULL;
+		}
 		subject = NULL;
 	}
 	while (offset && isspace(buf[offset-1]))
diff --git a/commit.h b/commit.h
index 8d7514c..c9de167 100644
--- a/commit.h
+++ b/commit.h
@@ -51,7 +51,7 @@ enum cmit_fmt {
 };
 
 extern enum cmit_fmt get_commit_format(const char *arg);
-extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject);
+extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject, const char *after_subject);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/diff.c b/diff.c
index e16e0bf..3e2828b 100644
--- a/diff.c
+++ b/diff.c
@@ -1867,7 +1867,10 @@ void diff_flush(struct diff_options *opt
 		show_stats(diffstat);
 		free(diffstat);
 		diffstat = NULL;
-		putchar(options->line_termination);
+		if (options->stat_sep)
+			fputs(options->stat_sep, stdout);
+		else
+			putchar(options->line_termination);
 	}
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
diff --git a/diff.h b/diff.h
index 7410607..83619eb 100644
--- a/diff.h
+++ b/diff.h
@@ -44,6 +44,7 @@ struct diff_options {
 	int rename_limit;
 	int setup;
 	int abbrev;
+	const char *stat_sep;
 
 	int nr_paths;
 	const char **paths;
diff --git a/log-tree.c b/log-tree.c
index 526d578..7f0f54b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -20,7 +20,7 @@ void show_log(struct rev_info *opt, stru
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
 	const char *extra;
 	int len;
-	char* subject = NULL;
+	char *subject = NULL, *after_subject = NULL;
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
@@ -52,6 +52,7 @@ void show_log(struct rev_info *opt, stru
 	 */
 
 	if (opt->commit_format == CMIT_FMT_EMAIL) {
+		char *sha1 = sha1_to_hex(commit->object.sha1);
 		if (opt->total > 0) {
 			static char buffer[64];
 			snprintf(buffer, sizeof(buffer),
@@ -63,8 +64,34 @@ void show_log(struct rev_info *opt, stru
 		else
 			subject = "Subject: ";
 
-		printf("From %s  Thu Apr 7 15:13:13 2005\n",
-		       sha1_to_hex(commit->object.sha1));
+		printf("From %s Mon Sep 17 00:00:00 2001\n", sha1);
+		if (opt->mime_boundary) {
+			static char subject_buffer[1024];
+			static char buffer[1024];
+			snprintf(subject_buffer, sizeof(subject_buffer) - 1,
+					"MIME-Version: 1.0\n"
+					"Content-Type: multipart/mixed;\n"
+					" boundary=\"------------%s\"\n"
+					"\n"
+					"This is a multi-part message in MIME "
+					"format.\n"
+					"--------------%s\n"
+					"Content-Type: text/plain; "
+					"charset=UTF-8; format=fixed\n"
+					"Content-Transfer-Encoding: 8bit\n\n",
+					opt->mime_boundary, opt->mime_boundary);
+			after_subject = subject_buffer;
+
+			snprintf(buffer, sizeof(buffer) - 1,
+					"--------------%s\n"
+					"Content-Type: text/x-patch;\n"
+					" name=\"%s.diff\"\n"
+					"Content-Transfer-Encoding: 8bit\n"
+					"Content-Disposition: inline;\n"
+					" filename=\"%s.diff\"\n\n",
+				opt->mime_boundary, sha1, sha1);
+			opt->diffopt.stat_sep = buffer;
+		}
 	} else {
 		printf("%s%s",
 		       opt->commit_format == CMIT_FMT_ONELINE ? "" : "commit ",
@@ -81,7 +108,7 @@ void show_log(struct rev_info *opt, stru
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev, subject);
+	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev, subject, after_subject);
 	printf("%s%s%s", this_header, extra, sep);
 }
 
diff --git a/revision.h b/revision.h
index 62759f7..bdbdd23 100644
--- a/revision.h
+++ b/revision.h
@@ -59,6 +59,7 @@ struct rev_info {
 	enum cmit_fmt	commit_format;
 	struct log_info *loginfo;
 	int		nr, total;
+	const char	*mime_boundary;
 
 	/* special limits */
 	int max_count;
diff --git a/show-branch.c b/show-branch.c
index bbe26c2..684ffd1 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -259,7 +259,7 @@ static void show_one_commit(struct commi
 	struct commit_name *name = commit->object.util;
 	if (commit->object.parsed)
 		pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-				    pretty, sizeof(pretty), 0, NULL);
+				    pretty, sizeof(pretty), 0, NULL, NULL);
 	else
 		strcpy(pretty, "(unavailable)");
 	if (!strncmp(pretty, "[PATCH] ", 8))
-- 
1.3.3.gea94-dirty
