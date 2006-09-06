From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Teach rev-list an option to read revs from the standard input.
Date: Tue, 05 Sep 2006 21:47:08 -0700
Message-ID: <7v64g1a9f7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 06:47:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKpJi-0007lF-Ut
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 06:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWIFErL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 00:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWIFErK
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 00:47:10 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:15007 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751718AbWIFErH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 00:47:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906044706.MMV27846.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 Sep 2006 00:47:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jsmz1V00W1kojtg0000000
	Wed, 06 Sep 2006 00:47:00 -0400
To: Andy Whitcroft <apw@shadowen.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26501>

When --stdin option is given, in addition to the <rev>s listed
on the command line, the command can read one rev parameter per
line from the standard input.  The list of revs ends at the
first empty line or EOF.

Note that you still have to give all the flags from the command
line; only rev arguments (including A..B, A...B, and A^@ notations)
can be give from the standard input.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-rev-list.txt |    6 ++++++
 builtin-rev-list.c             |   25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 3c4c2fb..28966ad 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [ \--remove-empty ]
 	     [ \--not ]
 	     [ \--all ]
+	     [ \--stdin ]
 	     [ \--topo-order ]
 	     [ \--parents ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
@@ -171,6 +172,11 @@ limiting may be applied.
 	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
 	command line as '<commit>'.
 
+--stdin::
+
+	In addition to the '<commit>' listed on the command
+	line, read them from the standard input.
+
 --merge::
 
 	After a failed merge, show refs that touch files having a
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 8437454..8fe8afb 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -23,6 +23,7 @@ static const char rev_list_usage[] =
 "    --no-merges\n"
 "    --remove-empty\n"
 "    --all\n"
+"    --stdin\n"
 "  ordering output:\n"
 "    --topo-order\n"
 "    --date-order\n"
@@ -304,10 +305,28 @@ static void mark_edges_uninteresting(str
 	}
 }
 
+static void read_revisions_from_stdin(struct rev_info *revs)
+{
+	char line[1000];
+
+	while (fgets(line, sizeof(line), stdin) != NULL) {
+		int len = strlen(line);
+		if (line[len - 1] == '\n')
+			line[--len] = 0;
+		if (!len)
+			break;
+		if (line[0] == '-')
+			die("options not supported in --stdin mode");
+		if (handle_revision_arg(line, revs, 0, 1))
+			die("bad revision '%s'", line);
+	}
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
 	int i;
+	int read_from_stdin = 0;
 
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
@@ -329,6 +348,12 @@ int cmd_rev_list(int argc, const char **
 			bisect_list = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--stdin")) {
+			if (read_from_stdin++)
+				die("--stdin given twice?");
+			read_revisions_from_stdin(&revs);
+			continue;
+		}
 		usage(rev_list_usage);
 
 	}
-- 
1.4.2.g980c3
