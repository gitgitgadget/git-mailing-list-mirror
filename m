From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Update git-annotate/git-blame documentation
Date: Mon, 16 Apr 2007 01:20:34 -0500
Message-ID: <20070416062034.GC19759@localdomain>
References: <20070416053525.GA18821@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:20:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKZs-0008Cu-OC
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbXDPGUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbXDPGUg
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:20:36 -0400
Received: from www.aeruder.net ([65.254.53.245]:4080 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972AbXDPGUf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:20:35 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 45A0D40183;
	Mon, 16 Apr 2007 01:20:35 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070416053525.GA18821@localdomain>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44591>

Moved options that pertained to both git-blame and git-annotate to a
common file blame-options.txt.

builtin-blame.c: Removed --compatibility, --long, --time from the
short usage as they are not handled in the code.

Documentation/git-blame.txt: Removed common options to git-annotate.
Added documentation for --score-debug.  Removed --compatibility.
Adjusted usage at top to not wrap on 80 columns.

Documentation/git-annotate.txt: Using common options blame-options.txt.

Documentation/blame-options.txt: Added -b note about associated config
option, added --root note about associated config option, added
documentation for --show-stats.  Removed --long, --time, --rev-file as
those options do not really exist.  Added documentation for -M/-C taking
an optional score argument for detection of moved lines.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/blame-options.txt |   67 +++++++++++++++++++++++++++++++++++++++
 Documentation/git-annotate.txt  |   15 +--------
 Documentation/git-blame.txt     |   64 ++++++++-----------------------------
 builtin-blame.c                 |    6 ++--
 4 files changed, 85 insertions(+), 67 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
new file mode 100644
index 0000000..331f161
--- /dev/null
+++ b/Documentation/blame-options.txt
@@ -0,0 +1,67 @@
+-b::
+	Show blank SHA-1 for boundary commits.  This can also
+	be controlled via the `blame.blankboundary` config option.
+
+--root::
+	Do not treat root commits as boundaries.  This can also be
+	controlled via the `blame.showroot` config option.
+
+--show-stats::
+	Include additional statistics at the end of blame output.
+
+-L n,m::
+	Annotate only the specified line range (lines count from 1).
+
+-l::
+	Show long rev (Default: off).
+
+-t::
+	Show raw timestamp (Default: off).
+
+-S <revs-file>::
+	Use revs from revs-file instead of calling gitlink:git-rev-list[1].
+
+-p, --porcelain::
+	Show in a format designed for machine consumption.
+
+--incremental::
+	Show the result incrementally in a format designed for
+	machine consumption.
+
+--contents <file>::
+	When <rev> is not specified, the command annotates the
+	changes starting backwards from the working tree copy.
+	This flag makes the command pretend as if the working
+	tree copy has the contents of he named file (specify
+	`-` to make the command read from the standard input).
+
+-M|<num>|::
+	Detect moving lines in the file as well.  When a commit
+	moves a block of lines in a file (e.g. the original file
+	has A and then B, and the commit changes it to B and
+	then A), traditional 'blame' algorithm typically blames
+	the lines that were moved up (i.e. B) to the parent and
+	assigns blame to the lines that were moved down (i.e. A)
+	to the child commit.  With this option, both groups of lines
+	are blamed on the parent.
+
+	<num> is optional but it is the lower bound on the number of
+	alphanumeric characters that git must detect as moving
+	within a file for it to associate those lines with the parent
+	commit.
+
+-C|<num>|::
+	In addition to `-M`, detect lines copied from other
+	files that were modified in the same commit.  This is
+	useful when you reorganize your program and move code
+	around across files.  When this option is given twice,
+	the command looks for copies from all other files in the
+	parent for the commit that creates the file in addition.
+
+	<num> is optional but it is the lower bound on the number of
+	alphanumeric characters that git must detect as moving
+	between files for it to associate those lines with the parent
+	commit.
+
+-h, --help::
+	Show help message.
diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 7baf731..02dc474 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -16,20 +16,7 @@ which introduced the line. Optionally annotate from a given revision.
 
 OPTIONS
 -------
--l, --long::
-	Show long rev (Defaults off).
-
--t, --time::
-	Show raw timestamp (Defaults off).
-
--r, --rename::
-	Follow renames (Defaults on).
-
--S, --rev-file <revs-file>::
-	Use revs from revs-file instead of calling git-rev-list.
-
--h, --help::
-	Show help message.
+include::blame-options.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 5c9888d..8f9439a 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -8,8 +8,9 @@ git-blame - Show what revision and author last modified each line of a file
 SYNOPSIS
 --------
 [verse]
-'git-blame' [-c] [-l] [-t] [-f] [-n] [-p] [--incremental] [-L n,m] [-S <revs-file>]
-            [-M] [-C] [-C] [--since=<date>] [<rev> | --contents <file>] [--] <file>
+'git-blame' [-c] [-l] [-t] [-f] [-n] [-p] [--incremental] [-L n,m]
+            [-S <revs-file>] [-M] [-C] [-C] [--since=<date>]
+            [<rev> | --contents <file>] [--] <file>
 
 DESCRIPTION
 -----------
@@ -37,20 +38,19 @@ ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 
 OPTIONS
 -------
--c, --compatibility::
-	Use the same output mode as gitlink:git-annotate[1] (Default: off).
-
--L n,m::
-	Annotate only the specified line range (lines count from 1).
-
--l, --long::
-	Show long rev (Default: off).
+include::blame-options.txt[]
 
--t, --time::
-	Show raw timestamp (Default: off).
+-c::
+	Use the same output mode as gitlink:git-annotate[1] (Default: off).
 
--S, --rev-file <revs-file>::
-	Use revs from revs-file instead of calling gitlink:git-rev-list[1].
+--score-debug::
+	Include debugging information related to the movement of
+	lines between files (see `-C`) and lines moved within a
+	file (see `-M`).  The first number listed is the score.
+	This is the number of alphanumeric characters detected
+	to be moved between or within files.  This must be above
+	a certain threshold for git-blame to consider those lines
+	of code to have been moved.
 
 -f, --show-name::
 	Show filename in the original commit.  By default
@@ -60,42 +60,6 @@ OPTIONS
 -n, --show-number::
 	Show line number in the original commit (Default: off).
 
--p, --porcelain::
-	Show in a format designed for machine consumption.
-
---incremental::
-	Show the result incrementally in a format designed for
-	machine consumption.
-
---contents <file>::
-	When <rev> is not specified, the command annotates the
-	changes starting backwards from the working tree copy.
-	This flag makes the command pretend as if the working
-	tree copy has the contents of he named file (specify
-	`-` to make the command read from the standard input).
-
--M::
-	Detect moving lines in the file as well.  When a commit
-	moves a block of lines in a file (e.g. the original file
-	has A and then B, and the commit changes it to B and
-	then A), traditional 'blame' algorithm typically blames
-	the lines that were moved up (i.e. B) to the parent and
-	assigns blame to the lines that were moved down (i.e. A)
-	to the child commit.  With this option, both groups of
-	lines are blamed on the parent.
-
--C::
-	In addition to `-M`, detect lines copied from other
-	files that were modified in the same commit.  This is
-	useful when you reorganize your program and move code
-	around across files.  When this option is given twice,
-	the command looks for copies from all other files in the
-	parent for the commit that creates the file in addition.
-
--h, --help::
-	Show help message.
-
-
 THE PORCELAIN FORMAT
 --------------------
 
diff --git a/builtin-blame.c b/builtin-blame.c
index 60ec535..3a1a17f 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -19,11 +19,11 @@
 
 static char blame_usage[] =
 "git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
-"  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
+"  -c                  Use the same output mode as git-annotate (Default: off)\n"
 "  -b                  Show blank SHA-1 for boundary commits (Default: off)\n"
-"  -l, --long          Show long commit SHA1 (Default: off)\n"
+"  -l                  Show long commit SHA1 (Default: off)\n"
 "  --root              Do not treat root commits as boundaries (Default: off)\n"
-"  -t, --time          Show raw timestamp (Default: off)\n"
+"  -t                  Show raw timestamp (Default: off)\n"
 "  -f, --show-name     Show original filename (Default: auto)\n"
 "  -n, --show-number   Show original linenumber (Default: off)\n"
 "  -p, --porcelain     Show in a format designed for machine consumption\n"
-- 
1.5.1.1.98.gedb4f-dirty
