From: Josh Micich <josh.micich@gmail.com>
Subject: [PATCH 2/3] added --batch option to mktree
Date: Thu, 14 May 2009 05:10:38 +0000 (UTC)
Message-ID: <loom.20090514T051004-665@post.gmane.org>
References: <loom.20090514T050424-673@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 07:20:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4TMb-0006Tu-J6
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 07:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZENFUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 01:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZENFUF
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 01:20:05 -0400
Received: from main.gmane.org ([80.91.229.2]:57633 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbZENFUC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 01:20:02 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M4TMQ-00074H-Ao
	for git@vger.kernel.org; Thu, 14 May 2009 05:20:02 +0000
Received: from adsl-69-104-91-41.dsl.pltn13.pacbell.net ([69.104.91.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:20:02 +0000
Received: from josh.micich by adsl-69-104-91-41.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.104.91.41 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119139>

This option enables creation of many tree objects with a single process

Signed-off-by: Josh Micich <josh.micich@gmail.com>
---
 Documentation/git-mktree.txt |    7 ++++++-
 builtin-mktree.c             |   36 +++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 0461062..3d2237a 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -8,7 +8,7 @@ git-mktree - Build a tree-object from ls-tree formatted text
 
 SYNOPSIS
 --------
-'git mktree' [-z] [--missing]
+'git mktree' [-z] [--missing] [--batch]
 
 DESCRIPTION
 -----------
@@ -25,6 +25,11 @@ OPTIONS
 	Allow missing objects.  The default behaviour (without this option)
 	is to verify that each tree entry's sha1 identifies an existing
 	object.
+--batch::
+	Allow building of more than one tree object before exiting.  Each
+	tree is separated by as single blank line. The final new-line is
+	optional.  Note - if the '-z' option is used, lines are terminated
+	with NUL.
 
 Author
 ------
diff --git a/builtin-mktree.c b/builtin-mktree.c
index db647ce..a56c917 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -63,7 +63,7 @@ static void write_tree(unsigned char *sha1)
 }
 
 static const char *mktree_usage[] = {
-	"git mktree [-z] [--missing]",
+	"git mktree [-z] [--missing] [--batch]",
 	NULL
 };
 
@@ -125,20 +125,42 @@ int cmd_mktree(int ac, const char **av, const char 
*prefix)
 	unsigned char sha1[20];
 	int line_termination = '\n';
 	int allow_missing = 0;
+	int is_batch_mode = 0;
+
 	const struct option option[] = {
 		OPT_SET_INT('z', NULL, &line_termination, "input is NUL 
terminated", '\0'),
 		OPT_SET_INT( 0 , "missing", &allow_missing, "allow missing 
objects", 1),
+		OPT_SET_INT( 0 , "batch", &is_batch_mode, "interactively create 
more than one tree", 1),
 		OPT_END()
 	};
 
 	ac = parse_options(ac, av, option, mktree_usage, 0);
 
-	while (strbuf_getline(&sb, stdin, line_termination) != EOF)
-		mktree_line(sb.buf, sb.len, line_termination, allow_missing);
-
+	int got_eof = 0;
+	while (!got_eof) {
+		while (1) {
+			if (strbuf_getline(&sb, stdin, line_termination) == 
EOF) {
+				got_eof = 1;
+				break;
+			}
+			if (sb.buf[0] == '\0') {
+				// empty lines denote tree boundaries in batch 
mode
+				if (is_batch_mode) {
+					break;
+				}
+				die("input format error: (blank line only valid 
in batch mode)");
+			}
+			mktree_line(sb.buf, sb.len, line_termination, 
allow_missing);
+		}
+		if (is_batch_mode && got_eof && used < 1) {
+			// allow input to finish with a new-line (or not)
+		} else {
+			write_tree(sha1);
+			puts(sha1_to_hex(sha1));
+			fflush(stdout);
+		}
+		used=0; // reset tree entry buffer for re-use in batch mode
+	}
 	strbuf_release(&sb);
-
-	write_tree(sha1);
-	puts(sha1_to_hex(sha1));
 	exit(0);
 }
-- 
1.6.3.165.g2cce5.dirty
