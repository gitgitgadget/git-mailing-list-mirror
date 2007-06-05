From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Add the --numbered-files option to git-format-patch.
Date: Tue, 05 Jun 2007 15:06:53 -0500
Message-ID: <1181074013.2585.14.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 22:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvfJP-0004CU-68
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 22:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759965AbXFEUHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 16:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763027AbXFEUHP
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 16:07:15 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:38294 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbXFEUHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 16:07:12 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l55K6sei000063
	for <git@vger.kernel.org>; Tue, 5 Jun 2007 13:06:59 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l55K6sPC027423
	for <git@vger.kernel.org>; Tue, 5 Jun 2007 15:06:54 -0500 (CDT)
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49223>

With this option, git-format-patch will generate simple
numbered files as output instead of the default using
with the first commit line appended.

This simplifies the ability to generate an MH-style
drafts folder with each message to be sent.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

Most of this patch is indenting the "if (sol)"
clause by one level.  Maybe apply it and "diff -w"
to see if you believe the patch.

Amazingly, some old guys in the crowd still use MH.

Yep, I used the new option to set up sending this message!

And, yes, I debated a more generalized option like:

    --filenames=<fmt>

with <fmt> being generalized for interpolatable things,
but I don't know what other things would have been
interesting.  So I opted for KISS.

jdl


 Documentation/git-format-patch.txt |   14 ++++-
 builtin-log.c                      |   97 +++++++++++++++++++++---------------
 2 files changed, 67 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index a33d157..363edb0 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 [verse]
 'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--thread]
                    [--attach[=<boundary>] | --inline[=<boundary>]]
-                   [-s | --signoff] [<common diff options>] [--start-number <n>]
+                   [-s | --signoff] [<common diff options>]
+                   [--start-number <n>] [--numbered-files]
                    [--in-reply-to=Message-Id] [--suffix=.<sfx>]
                    [--ignore-if-in-upstream]
                    [--subject-prefix=Subject-Prefix]
@@ -30,9 +31,11 @@ gitlink:git-rev-parse[1].
 The output of this command is convenient for e-mail submission or
 for use with gitlink:git-am[1].
 
-Each output file is numbered sequentially from 1, and uses the
+By default, each output file is numbered sequentially from 1, and uses the
 first line of the commit message (massaged for pathname safety) as
-the filename. The names of the output files are printed to standard
+the filename. With the --numbered-files option, the output file names
+will only be numbers, without the first line of the commit appended.
+The names of the output files are printed to standard
 output, unless the --stdout option is specified.
 
 If -o is specified, output files are created in <dir>.  Otherwise
@@ -60,6 +63,11 @@ include::diff-options.txt[]
 --start-number <n>::
 	Start numbering the patches at <n> instead of 1.
 
+--numbered-files::
+	Output file names will be a simple number sequence
+	without the default first line of the commit appended.
+	Mutually exclusive with the --stdout option.
+
 -k|--keep-subject::
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
diff --git a/builtin-log.c b/builtin-log.c
index 3744712..212cdfc 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -298,7 +298,8 @@ static int git_format_config(const char *var, const char *value)
 static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 
-static int reopen_stdout(struct commit *commit, int nr, int keep_subject)
+static int reopen_stdout(struct commit *commit, int nr, int keep_subject,
+			 int numbered_files)
 {
 	char filename[PATH_MAX];
 	char *sol;
@@ -315,53 +316,61 @@ static int reopen_stdout(struct commit *commit, int nr, int keep_subject)
 			filename[len++] = '/';
 	}
 
-	sprintf(filename + len, "%04d", nr);
-	len = strlen(filename);
-
-	sol = strstr(commit->buffer, "\n\n");
-	if (sol) {
-		int j, space = 1;
-
-		sol += 2;
-		/* strip [PATCH] or [PATCH blabla] */
-		if (!keep_subject && !prefixcmp(sol, "[PATCH")) {
-			char *eos = strchr(sol + 6, ']');
-			if (eos) {
-				while (isspace(*eos))
-					eos++;
-				sol = eos;
-			}
-		}
+	if (numbered_files) {
+		sprintf(filename + len, "%d", nr);
+		len = strlen(filename);
 
-		for (j = 0;
-		     j < FORMAT_PATCH_NAME_MAX - suffix_len - 5 &&
-			     len < sizeof(filename) - suffix_len &&
-			     sol[j] && sol[j] != '\n';
-		     j++) {
-			if (istitlechar(sol[j])) {
-				if (space) {
-					filename[len++] = '-';
-					space = 0;
+	} else {
+		sprintf(filename + len, "%04d", nr);
+		len = strlen(filename);
+
+		sol = strstr(commit->buffer, "\n\n");
+		if (sol) {
+			int j, space = 1;
+
+			sol += 2;
+			/* strip [PATCH] or [PATCH blabla] */
+			if (!keep_subject && !prefixcmp(sol, "[PATCH")) {
+				char *eos = strchr(sol + 6, ']');
+				if (eos) {
+					while (isspace(*eos))
+						eos++;
+					sol = eos;
 				}
-				filename[len++] = sol[j];
-				if (sol[j] == '.')
-					while (sol[j + 1] == '.')
-						j++;
-			} else
-				space = 1;
+			}
+
+			for (j = 0;
+			     j < FORMAT_PATCH_NAME_MAX - suffix_len - 5 &&
+				     len < sizeof(filename) - suffix_len &&
+				     sol[j] && sol[j] != '\n';
+			     j++) {
+				if (istitlechar(sol[j])) {
+					if (space) {
+						filename[len++] = '-';
+						space = 0;
+					}
+					filename[len++] = sol[j];
+					if (sol[j] == '.')
+						while (sol[j + 1] == '.')
+							j++;
+				} else
+					space = 1;
+			}
+			while (filename[len - 1] == '.'
+			       || filename[len - 1] == '-')
+				len--;
+			filename[len] = 0;
 		}
-		while (filename[len - 1] == '.' || filename[len - 1] == '-')
-			len--;
-		filename[len] = 0;
+		if (len + suffix_len >= sizeof(filename))
+			return error("Patch pathname too long");
+		strcpy(filename + len, fmt_patch_suffix);
 	}
-	if (len + suffix_len >= sizeof(filename))
-		return error("Patch pathname too long");
-	strcpy(filename + len, fmt_patch_suffix);
+
 	fprintf(realstdout, "%s\n", filename);
 	if (freopen(filename, "w", stdout) == NULL)
 		return error("Cannot open patch file %s",filename);
-	return 0;
 
+	return 0;
 }
 
 static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const char *prefix)
@@ -431,6 +440,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int numbered = 0;
 	int start_number = -1;
 	int keep_subject = 0;
+	int numbered_files = 0;		/* _just_ numbers */
 	int subject_prefix = 0;
 	int ignore_if_in_upstream = 0;
 	int thread = 0;
@@ -465,6 +475,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			numbered = 1;
 		else if (!prefixcmp(argv[i], "--start-number="))
 			start_number = strtol(argv[i] + 15, NULL, 10);
+		else if (!strcmp(argv[i], "--numbered-files"))
+			numbered_files = 1;
 		else if (!strcmp(argv[i], "--start-number")) {
 			i++;
 			if (i == argc)
@@ -540,6 +552,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die ("-n and -k are mutually exclusive.");
 	if (keep_subject && subject_prefix)
 		die ("--subject-prefix and -k are mutually exclusive.");
+	if (numbered_files && use_stdout)
+		die ("--numbered-files and --stdout are mutually exclusive.");
 
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
 	if (argc > 1)
@@ -614,7 +628,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.message_id = message_id;
 		}
 		if (!use_stdout)
-			if (reopen_stdout(commit, rev.nr, keep_subject))
+			if (reopen_stdout(commit, rev.nr, keep_subject,
+					  numbered_files))
 				die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
-- 
1.5.2.1.116.g9f308-dirty
