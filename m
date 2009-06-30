From: Joe Perches <joe@perches.com>
Subject: [PATCH 2/2] format-patch: Add --cover-letter-wrap
Date: Tue, 30 Jun 2009 16:40:39 -0700
Message-ID: <5035332845f173ac9c236a90621ca04ea6633b10.1246404999.git.joe@perches.com>
References: <cover.1246404999.git.joe@perches.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 01:41:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLmxC-0006TN-KJ
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 01:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbZF3Xkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 19:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755454AbZF3Xkk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 19:40:40 -0400
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:4953 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbZF3Xkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 19:40:37 -0400
Received: from localhost.localdomain ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id QAA23718
	for <git@vger.kernel.org>; Tue, 30 Jun 2009 16:40:23 -0700
X-Mailer: git-send-email 1.6.3.1.10.g659a0.dirty
In-Reply-To: <cover.1246404999.git.joe@perches.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122556>

--cover-letter does not give control over the column wrap
position.  This adds --cover-letter-wrap with 3 arguments
position as well as indent and additional_indent.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/git-format-patch.txt     |   13 +++++++++
 builtin-log.c                          |   46 +++++++++++++++++++++++++++++---
 contrib/completion/git-completion.bash |    1 +
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6f1fc80..f6b34ff 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,6 +20,8 @@ SYNOPSIS
 		   [--subject-prefix=Subject-Prefix]
 		   [--cc=<email>]
 		   [--cover-letter]
+		   [--cover-letter-wrap=width[,indent1[,indent2]]]
+		   [--no-cover-letter-wrap]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -168,6 +170,17 @@ if that is not set.
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--cover-letter-wrap=<width>[,<indent1>[,<indent2>]]]::
+	Linewrap the cover-letter shortlog output by wrapping each line at
+	`width`.  The first line of each entry is indented by `indent1`
+	spaces, and the second and subsequent lines are indented by
+	`indent2` spaces.
+	`width`, `indent1`, and `indent2` default to 72, 2 and 4 respectively.
+
+--no-cover-letter-wrap::
+	Do not linewrap the cover-letter shortlog output.
+	indent is fixed at 6.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
diff --git a/builtin-log.c b/builtin-log.c
index 44f9a27..ec89823 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -461,6 +461,20 @@ static void add_header(const char *value)
 static int thread = 0;
 static int do_signoff = 0;
 
+struct cover_letter_style {
+	int cover_letter_wrap;
+	int cover_letter_wrappos;
+	int cover_letter_indent1;
+	int cover_letter_indent2;
+};
+
+static struct cover_letter_style cls = {
+	.cover_letter_wrap = 1,
+	.cover_letter_wrappos = 72,
+	.cover_letter_indent1 = 2,
+	.cover_letter_indent2 = 4,
+};
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -669,10 +683,10 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	strbuf_release(&sb);
 
 	shortlog_init(&log);
-	log.wrap_lines = 1;
-	log.wrap = 72;
-	log.in1 = 2;
-	log.in2 = 4;
+	log.wrap_lines = cls.cover_letter_wrap;
+	log.wrap = cls.cover_letter_wrappos;
+	log.in1 = cls.cover_letter_indent1;
+	log.in2 = cls.cover_letter_indent2;
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
@@ -792,6 +806,27 @@ static int output_directory_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int cls_callback(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		cls.cover_letter_wrap = 0;
+	else {
+		int i1, i2, i3;
+		if (!arg)
+			return 1;
+		int arg_count = sscanf(arg, "%d,%d,%d", &i1, &i2, &i3);
+		if (arg_count <= 0)
+			return 1;
+		if (arg_count >= 1)
+			cls.cover_letter_wrappos = i1;
+		if (arg_count >= 2)
+			cls.cover_letter_indent1 = i2;
+		if (arg_count >= 3)
+			cls.cover_letter_indent2 = i3;
+		}
+	return 0;
+}
+
 static int thread_callback(const struct option *opt, const char *arg, int unset)
 {
 	int *thread = (int *)opt->value;
@@ -875,6 +910,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    "print patches to standard out"),
 		OPT_BOOLEAN(0, "cover-letter", &cover_letter,
 			    "generate a cover letter"),
+		{ OPTION_CALLBACK, 0, "cover-letter-wrap", &cls, NULL,
+			    "control the cover letter format",
+			    PARSE_OPT_OPTARG, cls_callback },
 		OPT_BOOLEAN(0, "numbered-files", &numbered_files,
 			    "use simple number sequence for output file names"),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, "sfx",
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b60cb68..aede61c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -985,6 +985,7 @@ _git_format_patch ()
 			--full-index --binary
 			--not --all
 			--cover-letter
+			--no-cover-letter-wrap --cover-letter-wrap=
 			--no-prefix --src-prefix= --dst-prefix=
 			--inline --suffix= --ignore-if-in-upstream
 			--subject-prefix=
-- 
1.6.3.1.10.g659a0.dirty
