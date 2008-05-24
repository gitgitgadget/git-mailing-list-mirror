From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 2/3] diff-files: do not play --no-index games
Date: Sat, 24 May 2008 00:26:16 -0700
Message-ID: <7vhccomacn.fsf@gitster.siamese.dyndns.org>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com>
 <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805230942480.3081@woody.linux-foundation.org>
 <7vbq2wsxnk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805232309350.30431@racer>
 <alpine.DEB.1.00.0805232349410.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 24 09:27:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzoA1-0007LI-6c
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 09:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbYEXH0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 03:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbYEXH0h
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 03:26:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbYEXH0g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 03:26:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F04783E36;
	Sat, 24 May 2008 03:26:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 22A753E34; Sat, 24 May 2008 03:26:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BCA93B8A-2962-11DD-A203-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82799>

Being able to say "git diff A B" outside a git repository and getting a
colourful version of "diff -u A B" may be nice, but such a cute hack
should not give bogus results to scripts that want to give two paths,
either or both of which happen to have been removed from the work tree,
to "git diff-files".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-diff-files.txt |    5 +---
 builtin-diff-files.c             |   44 +++++++++++++++++++++++++++++++-------
 git.c                            |    2 +-
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 6d2ea16..ca1bb6a 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -8,7 +8,7 @@ git-diff-files - Compares files in the working tree and the index
 
 SYNOPSIS
 --------
-'git-diff-files' [-q] [-0|-1|-2|-3|-c|--cc|--no-index] [<common diff options>] [<path>...]
+'git-diff-files' [-q] [-0|-1|-2|-3|-c|--cc] [<common diff options>] [<path>...]
 
 DESCRIPTION
 -----------
@@ -36,9 +36,6 @@ omit diff output for unmerged entries and just show "Unmerged".
 	diff, similar to the way 'diff-tree' shows a merge
 	commit with these flags.
 
---no-index::
-	Compare the two given files / directories.
-
 -q::
 	Remain silent even on nonexistent files
 
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index e2306c1..3aa031f 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -10,26 +10,54 @@
 #include "builtin.h"
 
 static const char diff_files_usage[] =
-"git-diff-files [-q] [-0/-1/2/3 |-c|--cc|--no-index] [<common diff options>] [<path>...]"
+"git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	int nongit;
 	int result;
+	unsigned options = 0;
 
-	prefix = setup_git_directory_gently(&nongit);
 	init_revisions(&rev, prefix);
 	git_config(git_diff_basic_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
-	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
-		argc = 0;
-	else
-		argc = setup_revisions(argc, argv, &rev, NULL);
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	while (1 < argc && argv[1][0] == '-') {
+		if (!strcmp(argv[1], "--base"))
+			rev.max_count = 1;
+		else if (!strcmp(argv[1], "--ours"))
+			rev.max_count = 2;
+		else if (!strcmp(argv[1], "--theirs"))
+			rev.max_count = 3;
+		else if (!strcmp(argv[1], "-q"))
+			options |= DIFF_SILENT_ON_REMOVED;
+		else
+			usage(diff_files_usage);
+		argv++; argc--;
+	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
-	result = run_diff_files_cmd(&rev, argc, argv);
+
+	/*
+	 * Make sure there are NO revision (i.e. pending object) parameter,
+	 * rev.max_count is reasonable (0 <= n <= 3), and
+	 * there is no other revision filtering parameters.
+	 */
+	if (rev.pending.nr ||
+	    rev.min_age != -1 || rev.max_age != -1 ||
+	    3 < rev.max_count)
+		usage(diff_files_usage);
+
+	if (rev.max_count == -1 &&
+	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
+		rev.combine_merges = rev.dense_combined_merges = 1;
+
+	if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
+	result = run_diff_files(&rev, options);
 	return diff_result_code(&rev.diffopt, result);
 }
diff --git a/git.c b/git.c
index 89b431f..4b79380 100644
--- a/git.c
+++ b/git.c
@@ -293,7 +293,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
-		{ "diff-files", cmd_diff_files },
+		{ "diff-files", cmd_diff_files, RUN_SETUP },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 		{ "fast-export", cmd_fast_export, RUN_SETUP },
-- 
1.5.5.1.540.g57780
