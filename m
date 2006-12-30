From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Move commit reencoding parameter parsing to revision.c
Date: Sat, 30 Dec 2006 12:22:00 -0800
Message-ID: <7v3b6xjfrr.fsf_-_@assigned-by-dhcp.cox.net>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	<Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 30 21:22:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0kiW-0005Is-Q0
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 21:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWL3UWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 15:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWL3UWF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 15:22:05 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:57060 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030331AbWL3UWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 15:22:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061230202201.RKPU2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Dec 2006 15:22:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 58MF1W00a1kojtg0000000; Sat, 30 Dec 2006 15:21:16 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 30 Dec 2006 19:57:39 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35633>

Also I think we need this patch for completeness on top of what
we have in 'master'.

-- >8 --
[PATCH] Move commit reencoding parameter parsing to revision.c

This way, git-rev-list and git-diff-tree with --pretty can use
it.  Because they are both plumbing, we default not to do any
conversion unless --encoding=<encoding> is explicitly given from
the command line.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-rev-list.txt   |    1 +
 Documentation/pretty-formats.txt |    8 ++++++++
 builtin-diff-tree.c              |    6 ++++++
 builtin-rev-list.c               |    6 ++++++
 revision.c                       |    8 ++++++++
 5 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 9e0dcf8..86c94e7 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -21,6 +21,7 @@ SYNOPSIS
 	     [ \--stdin ]
 	     [ \--topo-order ]
 	     [ \--parents ]
+	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 996f628..8cba13f 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -76,3 +76,11 @@ displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts nor history
 simplification into account.
+
+
+--encoding[=<encoding>]::
+	The commit objects record the encoding used for the log message
+	in their encoding header; this option can be used to tell the
+	command to re-code the commit log message in the encoding
+	preferred by the user.  For non plumbing commands this
+	defaults to UTF-8.
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 24cb2d7..6ce2c0f 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -67,6 +67,12 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	static struct rev_info *opt = &log_tree_opt;
 	int read_stdin = 0;
 
+	/* default to turn the conversion off -- diff-tree is not a
+	 * Porcelain but as low plumbing as it can go, as far as
+	 * two-tree comparison is concerned.
+	 */
+	git_log_output_encoding = "";
+
 	init_revisions(opt, prefix);
 	git_config(git_default_config); /* no "diff" UI options */
 	nr_sha1 = 0;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 1bb3a06..0c3dce6 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -226,6 +226,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int i;
 	int read_from_stdin = 0;
 
+	/* default to turn the conversion off -- rev-list is not a
+	 * Porcelain but as low plumbing as it can go, as far as
+	 * revision traversal is concerned.
+	 */
+	git_log_output_encoding = "";
+
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
diff --git a/revision.c b/revision.c
index af9f874..6e4ec46 100644
--- a/revision.c
+++ b/revision.c
@@ -1039,6 +1039,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				all_match = 1;
 				continue;
 			}
+			if (!strncmp(arg, "--encoding=", 11)) {
+				arg += 11;
+				if (strcmp(arg, "none"))
+					git_log_output_encoding = strdup(arg);
+				else
+					git_log_output_encoding = "";
+				continue;
+			}
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
-- 
1.5.0.rc0.g6bb1
