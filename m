From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Wed, 6 Feb 2008 11:43:28 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802061141410.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:44:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMnOD-00049s-I1
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 17:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbYBFQni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYBFQni
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 11:43:38 -0500
Received: from iabervon.org ([66.92.72.58]:58420 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995AbYBFQne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 11:43:34 -0500
Received: (qmail 27692 invoked by uid 1000); 6 Feb 2008 16:43:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 16:43:28 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72816>

If --cover-letter is provided, generate a cover letter message before
the patches, numbered 0.

Original patch thanks to Johannes Schindelin

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-format-patch.txt                 |    6 +
 builtin-log.c                                      |  215 ++++++++++++++------
 t/t4013-diff-various.sh                            |    1 +
 ...tch_--stdout_--cover-letter_-n_initial..master^ |  101 +++++++++
 4 files changed, 265 insertions(+), 58 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 651efe6..7ec01a0 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -17,6 +17,7 @@ SYNOPSIS
                    [--in-reply-to=Message-Id] [--suffix=.<sfx>]
                    [--ignore-if-in-upstream]
                    [--subject-prefix=Subject-Prefix]
+                   [--cover-letter]
 		   [ <since> | <revision range> ]
 
 DESCRIPTION
@@ -139,6 +140,11 @@ include::diff-options.txt[]
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
 	`--suffix=.txt`.
+
+--cover-letter::
+	Generate a cover letter template.  You still have to fill in
+	a description, but the shortlog and the diffstat will be
+	generated for you.
 +
 Note that you would need to include the leading dot `.` if you
 want a filename like `0001-description-of-my-change.patch`, and
diff --git a/builtin-log.c b/builtin-log.c
index 1f74d66..c6e3f91 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -14,6 +14,7 @@
 #include "reflog-walk.h"
 #include "patch-ids.h"
 #include "refs.h"
+#include "run-command.h"
 
 static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
@@ -453,74 +454,77 @@ static int git_format_config(const char *var, const char *value)
 }
 
 
+static const char *get_oneline_for_filename(struct commit *commit,
+		int keep_subject)
+{
+	static char filename[PATH_MAX];
+	char *sol;
+	int len = 0;
+
+	sol = strstr(commit->buffer, "\n\n");
+	if (!sol)
+		filename[0] = '\0';
+	else {
+		int j, space = 0;
+
+		sol += 2;
+		/* strip [PATCH] or [PATCH blabla] */
+		if (!keep_subject && !prefixcmp(sol, "[PATCH")) {
+			char *eos = strchr(sol + 6, ']');
+			if (eos) {
+				while (isspace(*eos))
+					eos++;
+				sol = eos;
+			}
+		}
+
+		for (j = 0; len < sizeof(filename) &&
+				sol[j] && sol[j] != '\n'; j++) {
+			if (istitlechar(sol[j])) {
+				if (space) {
+					filename[len++] = '-';
+					space = 0;
+				}
+				filename[len++] = sol[j];
+				if (sol[j] == '.')
+					while (sol[j + 1] == '.')
+						j++;
+			} else
+				space = 1;
+		}
+		while (filename[len - 1] == '.'
+		       || filename[len - 1] == '-')
+			len--;
+		filename[len] = '\0';
+	}
+	return filename;
+}
+
 static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 
-static int reopen_stdout(struct commit *commit, int nr, int keep_subject,
-			 int numbered_files)
+static int reopen_stdout(const char *oneline, int nr, int total)
 {
 	char filename[PATH_MAX];
-	char *sol;
 	int len = 0;
 	int suffix_len = strlen(fmt_patch_suffix) + 1;
 
 	if (output_directory) {
-		if (strlen(output_directory) >=
+		len = snprintf(filename, sizeof(filename), "%s",
+				output_directory);
+		if (len >=
 		    sizeof(filename) - FORMAT_PATCH_NAME_MAX - suffix_len)
 			return error("name of output directory is too long");
-		strlcpy(filename, output_directory, sizeof(filename) - suffix_len);
-		len = strlen(filename);
 		if (filename[len - 1] != '/')
 			filename[len++] = '/';
 	}
 
-	if (numbered_files) {
-		sprintf(filename + len, "%d", nr);
-		len = strlen(filename);
-
-	} else {
-		sprintf(filename + len, "%04d", nr);
-		len = strlen(filename);
-
-		sol = strstr(commit->buffer, "\n\n");
-		if (sol) {
-			int j, space = 1;
-
-			sol += 2;
-			/* strip [PATCH] or [PATCH blabla] */
-			if (!keep_subject && !prefixcmp(sol, "[PATCH")) {
-				char *eos = strchr(sol + 6, ']');
-				if (eos) {
-					while (isspace(*eos))
-						eos++;
-					sol = eos;
-				}
-			}
-
-			for (j = 0;
-			     j < FORMAT_PATCH_NAME_MAX - suffix_len - 5 &&
-				     len < sizeof(filename) - suffix_len &&
-				     sol[j] && sol[j] != '\n';
-			     j++) {
-				if (istitlechar(sol[j])) {
-					if (space) {
-						filename[len++] = '-';
-						space = 0;
-					}
-					filename[len++] = sol[j];
-					if (sol[j] == '.')
-						while (sol[j + 1] == '.')
-							j++;
-				} else
-					space = 1;
-			}
-			while (filename[len - 1] == '.'
-			       || filename[len - 1] == '-')
-				len--;
-			filename[len] = 0;
-		}
-		if (len + suffix_len >= sizeof(filename))
-			return error("Patch pathname too long");
+	if (!filename)
+		len += sprintf(filename + len, "%d", nr);
+	else {
+		len += sprintf(filename + len, "%04d-", nr);
+		len += snprintf(filename + len, sizeof(filename) - len - 1
+				- suffix_len, "%s", oneline);
 		strcpy(filename + len, fmt_patch_suffix);
 	}
 
@@ -591,6 +595,74 @@ static void gen_message_id(struct rev_info *info, char *base)
 	info->message_id = buf.buf;
 }
 
+static void make_cover_letter(struct rev_info *rev,
+		int use_stdout, int numbered, int numbered_files,
+			      struct commit *origin, struct commit *head)
+{
+	const char *committer;
+	const char *origin_sha1, *head_sha1;
+	const char *argv[7];
+	const char *subject_start = NULL;
+	const char *body = "*** SUBJECT HERE ***\n\n\n*** BLURB HERE ***\n";
+	const char *msg;
+	const char *extra_headers = rev->extra_headers;
+	struct strbuf sb;
+	const char *encoding = "utf-8";
+
+	if (rev->commit_format != CMIT_FMT_EMAIL)
+		die("Cover letter needs email format");
+
+	if (!use_stdout && reopen_stdout(numbered_files ?
+				NULL : "cover-letter", 0, rev->total))
+		return;
+
+	origin_sha1 = sha1_to_hex(origin ? origin->object.sha1 : null_sha1);
+	head_sha1 = sha1_to_hex(head->object.sha1);
+
+	write_email_headers(rev, head_sha1, &subject_start, &extra_headers);
+
+	committer = git_committer_info(0);
+
+	msg = body;
+	strbuf_init(&sb, 0);
+	add_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
+		      encoding);
+	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
+		      encoding, 0);
+	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0);
+	printf("%s\n", sb.buf);
+
+	strbuf_release(&sb);
+
+	/*
+	 * We can only do diffstat with a unique reference point, and
+	 * log is a bit tricky, so just skip it.
+	 */
+	if (!origin)
+		return;
+
+	argv[0] = "shortlog";
+	argv[1] = head_sha1;
+	argv[2] = "--not";
+	argv[3] = origin_sha1;
+	argv[4] = NULL;
+	fflush(stdout);
+	run_command_v_opt(argv, RUN_GIT_CMD);
+
+	argv[0] = "diff";
+	argv[1] = "--stat";
+	argv[2] = "--summary";
+	argv[3] = head_sha1;
+	argv[4] = "--not";
+	argv[5] = origin_sha1;
+	argv[6] = NULL;
+	fflush(stdout);
+	run_command_v_opt(argv, RUN_GIT_CMD);
+
+	fflush(stdout);
+	printf("\n");
+}
+
 static const char *clean_message_id(const char *msg_id)
 {
 	char ch;
@@ -626,6 +698,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int subject_prefix = 0;
 	int ignore_if_in_upstream = 0;
 	int thread = 0;
+	int cover_letter = 0;
+	struct commit *origin = NULL, *head = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
@@ -725,6 +799,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.subject_prefix = argv[i] + 17;
 		} else if (!prefixcmp(argv[i], "--suffix="))
 			fmt_patch_suffix = argv[i] + 9;
+		else if (!strcmp(argv[i], "--cover-letter"))
+			cover_letter = 1;
 		else
 			argv[j++] = argv[i];
 	}
@@ -776,6 +852,20 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		 * get_revision() to do the usual traversal.
 		 */
 	}
+	if (cover_letter) {
+		/* remember the range */
+		int i;
+		for (i = 0; i < rev.pending.nr; i++) {
+			struct object *o = rev.pending.objects[i].item;
+			if (o->flags & UNINTERESTING)
+				origin = (struct commit *)o;
+			else
+				head = (struct commit *)o;
+		}
+		/* We can't generate a cover letter without any patches */
+		if (!head)
+			return 0;
+	}
 
 	if (ignore_if_in_upstream)
 		get_patch_ids(&rev, &ids, prefix);
@@ -802,9 +892,18 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		numbered = 1;
 	if (numbered)
 		rev.total = total + start_number - 1;
-	rev.add_signoff = add_signoff;
 	if (in_reply_to)
 		rev.ref_message_id = clean_message_id(in_reply_to);
+	if (cover_letter) {
+		if (thread) {
+			gen_message_id(&rev, "cover");
+		}
+		make_cover_letter(&rev, use_stdout, numbered, numbered_files,
+				  origin, head);
+		total++;
+		start_number--;
+	}
+	rev.add_signoff = add_signoff;
 	while (0 <= --nr) {
 		int shown;
 		commit = list[nr];
@@ -819,10 +918,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			}
 			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
-		if (!use_stdout)
-			if (reopen_stdout(commit, rev.nr, keep_subject,
-					  numbered_files))
-				die("Failed to create output files");
+		if (!use_stdout && reopen_stdout(numbered_files ? NULL :
+				get_oneline_for_filename(commit, keep_subject),
+				rev.nr, rev.total))
+			die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9eec754..6b4d1c5 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -245,6 +245,7 @@ format-patch --inline --stdout initial..master
 format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
 config format.subjectprefix DIFFERENT_PREFIX
 format-patch --inline --stdout initial..master^^
+format-patch --stdout --cover-letter -n initial..master^
 
 diff --abbrev initial..side
 diff -r initial..side
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
new file mode 100644
index 0000000..311e207
--- /dev/null
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
@@ -0,0 +1,101 @@
+$ git format-patch --stdout --cover-letter -n initial..master^
+From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
+From: C O Mitter <committer@example.com>
+Date: Mon, 26 Jun 2006 00:05:00 +0000
+Subject: [DIFFERENT_PREFIX 0/2] *** SUBJECT HERE ***
+
+
+*** BLURB HERE ***
+
+A U Thor (2):
+      Second
+      Third
+
+ dir/sub |    4 ++++
+ file0   |    3 +++
+ file1   |    3 +++
+ file2   |    3 ---
+ 4 files changed, 10 insertions(+), 3 deletions(-)
+ create mode 100644 file1
+ delete mode 100644 file2
+
+From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:01:00 +0000
+Subject: [DIFFERENT_PREFIX 1/2] Second
+
+This is the second commit.
+---
+ dir/sub |    2 ++
+ file0   |    3 +++
+ file2   |    3 ---
+ 3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..8422d40 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++C
++D
+diff --git a/file0 b/file0
+index 01e79c3..b414108 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++4
++5
++6
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+-- 
+g-i-t--v-e-r-s-i-o-n
+
+
+From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:02:00 +0000
+Subject: [DIFFERENT_PREFIX 2/2] Third
+
+---
+ dir/sub |    2 ++
+ file1   |    3 +++
+ 2 files changed, 5 insertions(+), 0 deletions(-)
+ create mode 100644 file1
+
+diff --git a/dir/sub b/dir/sub
+index 8422d40..cead32e 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2,3 +2,5 @@ A
+ B
+ C
+ D
++E
++F
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+-- 
+g-i-t--v-e-r-s-i-o-n
+
+$
-- 
1.5.4.27.gf6864
