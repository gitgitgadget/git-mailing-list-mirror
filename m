From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach the --cover-letter option to format-patch
Date: Tue, 10 Jul 2007 14:26:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707101424140.4047@racer.site>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org>
 <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 15:34:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8FrO-0007xH-Fq
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbXGJNeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 09:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbXGJNeb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:34:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:55578 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750708AbXGJNe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 09:34:29 -0400
Received: (qmail invoked by alias); 10 Jul 2007 13:34:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 10 Jul 2007 15:34:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rSFZ7Xg4rOBgYGU8rb1r0dklPPUDbHLzEpmiD8S
	LeK95idql12xZo
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52067>


You can now generate a template for the cover letter by calling

	git format-patch --cover-letter <...>

It will fill in the shortlog and diffstat for you.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 9 Jul 2007, Junio C Hamano wrote:

	> Daniel Barkalow <barkalow@iabervon.org> writes:
	> 
	> > I'd like to be able to get format-patch to produce a 
	> > [PATCH 0/N] message, with a message that's actually in my 
	> > repository, plus various goodies generated either from diffing 
	> > the ends of the series or by running through the log an extra 
	> > time to pick up summary information.
	> 
	>  $ work work work, commit commit commit, reorder and perfect
	>  $ git format-patch --with-cover origin..HEAD
	>  ... which notices --with-cover, and perhaps does
	>  ... $ git-shortlog origin..HEAD
	>  ... $ git diff --stat --summary origin..HEAD
	>  ... $ echo "*** BLURB HERE ***"
	>  ... to create 0/N which it did not do so far in
	>  ... 0000-cover-letter.txt
	>  $ $EDITOR 0000-cover-letter.txt
	>  $ git-send-email 0*.txt

	Voila.

	BTW format-patch does not complain when there are skipped merges. 
	It surprised me, since you do not stand a chance to pipe that to 
	git-am successfully...

 Documentation/git-format-patch.txt                 |    6 +
 builtin-log.c                                      |  202 ++++++++++++++------
 log-tree.c                                         |    2 +-
 log-tree.h                                         |    1 +
 t/t4013-diff-various.sh                            |    1 +
 ...tch_--stdout_--cover-letter_-n_initial..master^ |  101 ++++++++++
 6 files changed, 254 insertions(+), 59 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6cbcf93..aaae083 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -16,6 +16,7 @@ SYNOPSIS
                    [--in-reply-to=Message-Id] [--suffix=.<sfx>]
                    [--ignore-if-in-upstream]
                    [--subject-prefix=Subject-Prefix]
+		   [--cover-letter]
                    <since>[..<until>]
 
 DESCRIPTION
@@ -126,6 +127,11 @@ want a filename like `0001-description-of-my-change.patch`, and
 the first letter does not have to be a dot.  Leaving it empty would
 not add any suffix.
 
+--cover-letter::
+	Generate a cover letter template.  You still have to fill in
+	a description, but the shortlog and the diffstat will be
+	generated for you.
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each
diff --git a/builtin-log.c b/builtin-log.c
index 13bae31..e2b5e64 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -14,6 +14,7 @@
 #include "reflog-walk.h"
 #include "patch-ids.h"
 #include "refs.h"
+#include "run-command.h"
 
 static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
@@ -303,74 +304,77 @@ static int git_format_config(const char *var, const char *value)
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
-	int len = 0;
 	int suffix_len = strlen(fmt_patch_suffix) + 1;
+	int len = 0;
 
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
 
@@ -438,6 +442,70 @@ static void gen_message_id(char *dest, unsigned int length, char *base)
 		 (int)(email_end - email_start - 1), email_start + 1);
 }
 
+static void make_cover_letter(struct rev_info *rev,
+		int use_stdout, int numbered, int numbered_files,
+		struct commit *origin, struct commit *head)
+{
+	const char *committer, *sep;
+	const char *origin_sha1, *head_sha1;
+	const char *argv[7];
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
+	printf("From %s Mon Sep 17 00:00:00 2001\n", head_sha1);
+	if (rev->message_id)
+		printf("Message-Id: <%s>\n", rev->message_id);
+	if (rev->ref_message_id)
+		printf("In-Reply-To: <%s>\nReferences: <%s>\n",
+				rev->ref_message_id, rev->ref_message_id);
+	committer = git_committer_info(0);
+	sep = strchr(committer, '>');
+	if (sep)
+		sep++;
+	else
+		sep = committer + strlen(committer);
+	printf("From: %.*s\n", sep - committer, committer);
+	printf("Date:%s\n", sep);
+	if (rev->total)
+		printf("Subject: [%s %0*d/%d] *** SUBJECT HERE ***\n",
+				rev->subject_prefix,
+				digits_in_number(rev->total), 0, rev->total);
+	else
+		printf("Subject: *** SUBJECT HERE ***\n");
+	printf("\n\n");
+
+	printf("*** BLURB HERE ***\n\n");
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
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -452,6 +520,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int subject_prefix = 0;
 	int ignore_if_in_upstream = 0;
 	int thread = 0;
+	int cover_letter = 0;
+	struct commit *origin = NULL, *head = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
@@ -550,6 +620,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.subject_prefix = argv[i] + 17;
 		} else if (!prefixcmp(argv[i], "--suffix="))
 			fmt_patch_suffix = argv[i] + 9;
+		else if (!strcmp(argv[i], "--cover-letter"))
+			cover_letter = 1;
 		else
 			argv[j++] = argv[i];
 	}
@@ -594,6 +666,17 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		 * get_revision() would return only the specified count.
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
+	}
 
 	if (ignore_if_in_upstream)
 		get_patch_ids(&rev, &ids, prefix);
@@ -618,6 +701,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	total = nr;
 	if (numbered)
 		rev.total = total + start_number - 1;
+	if (cover_letter)
+		make_cover_letter(&rev, use_stdout, numbered, numbered_files,
+				origin, head);
 	rev.add_signoff = add_signoff;
 	rev.ref_message_id = in_reply_to;
 	while (0 <= --nr) {
@@ -636,10 +722,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				       sha1_to_hex(commit->object.sha1));
 			rev.message_id = message_id;
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
diff --git a/log-tree.c b/log-tree.c
index 8624d5a..5c20c74 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -130,7 +130,7 @@ static unsigned long append_signoff(char **buf_p, unsigned long *buf_sz_p,
 	return at;
 }
 
-static unsigned int digits_in_number(unsigned int number)
+unsigned int digits_in_number(unsigned int number)
 {
 	unsigned int i = 10, result = 1;
 	while (i <= number) {
diff --git a/log-tree.h b/log-tree.h
index e82b56a..fbab51f 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -12,5 +12,6 @@ int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt, const char *sep);
+unsigned int digits_in_number(unsigned int number);
 
 #endif
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
index 0000000..b66a568
--- /dev/null
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
@@ -0,0 +1,101 @@
+$ git format-patch --stdout --cover-letter -n initial..master^
+From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
+From: C O Mitter <committer@example.com>
+Date: 1151280300 +0000
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
1.5.3.rc0.2782.g192a9-dirty
