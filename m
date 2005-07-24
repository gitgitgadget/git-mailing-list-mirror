From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: describe git-ls-files --exclude patterns.
Date: Sun, 24 Jul 2005 15:51:38 -0700
Message-ID: <7vwtnf24xx.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
	<7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 00:54:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwpM5-0006Qa-Nr
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 00:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVGXWx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 18:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVGXWxQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 18:53:16 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:12688 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261517AbVGXWvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2005 18:51:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724225134.YERW1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 24 Jul 2005 18:51:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun, 24 Jul 2005 15:49:33 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-ls-files.txt |   96 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 92 insertions(+), 4 deletions(-)

d9296497b70d9007da94cec453ecb5c6c7173140
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 		(-[c|d|o|i|s|u|k])\*
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
+		[--exclude-per-directory=<file>]
 
 DESCRIPTION
 -----------
@@ -59,10 +60,10 @@ OPTIONS
 
 -X|--exclude-from=<file>::
 	exclude patterns are read from <file>; 1 per line.
-	Allows the use of the famous dontdiff file as follows to find
-	out about uncommitted files just as dontdiff is used with
-	the diff command:
-	     git-ls-files --others --exclude-from=dontdiff
+
+--exclude-per-directory=<file>::
+	read additional exclude patterns that apply only to the
+	directory and its subdirectories in <file>.
 
 -t::
 	Identify the file status with the following tags (followed by
@@ -89,6 +90,93 @@ the dircache records up to three such pa
 the user (or Cogito) to see what should eventually be recorded at the
 path. (see read-cache for more information on state)
 
+
+Exclude Patterns
+----------------
+
+'git-ls-files' can use a list of "exclude patterns" when
+traversing the directory tree and finding files to show when the
+flags --others or --ignored are specified.
+
+These exclude patterns come from these places:
+
+ (1) command line flag --exclude=<pattern> specifies a single
+     pattern.
+
+ (2) command line flag --exclude-from=<file> specifies a list of
+     patterns stored in a file.
+
+ (3) command line flag --exclude-per-directory=<name> specifies
+     a name of the file in each directory 'git-ls-files'
+     examines, and if exists, its contents are used as an
+     additional list of patterns.
+
+An exclude pattern file used by (2) and (3) contains one pattern
+per line.  A line that starts with a '#' can be used as comment
+for readability.
+
+The list of patterns that is in effect at a given time is
+built and ordered in the following way:
+
+ * --exclude=<pattern> and lines read from --exclude-from=<file>
+   come at the beginning of the list of patterns, in the order
+   given on the command line.  Patterns that come from the file
+   specified with --exclude-from are ordered in the same order
+   as they appear in the file.
+
+ * When --exclude-per-directory=<name> is specified, upon
+   entering a directory that has such a file, its contents are
+   appended at the end of the current "list of patterns".  They
+   are popped off when leaving the directory.
+
+Each pattern in the pattern list specifies "a match pattern" and
+optionally the fate --- either a file that matches the pattern
+is considered excluded or included.  By default, this being
+"exclude" mechanism, the fate is "excluded".  A filename is
+examined against the patterns in the list, and the first match
+determines its fate.
+
+A pattern specified on the command line with --exclude or read
+from the file specified with --exclude-from is relative to the
+top of the directory tree.  A pattern read from a file specified
+by --exclude-per-directory is relative to the directory that the
+pattern file appears in.
+
+An exclude pattern is of the following format:
+
+ - an optional prefix '!' which means that the fate this pattern
+   specifies is "include", not the usual "exclude"; the
+   remainder of the pattern string is interpreted according to
+   the following rules.
+
+ - if it does not contain a slash '/', it is a shell glob
+   pattern and used to match against the filename without
+   leading directories (i.e. the same way as the current
+   implementation).
+
+ - otherwise, it is a shell glob pattern, suitable for
+   consumption by fnmatch(3) with FNM_PATHNAME flag.  I.e. a
+   slash in the pattern must match a slash in the pathname.
+   "Documentation/*.html" matches "Documentation/git.html" but
+   not "ppc/ppc.html".  As a natural exception, "/*.c" matches
+   "cat-file.c" but not "mozilla-sha1/sha1.c".
+
+An example:
+
+    $ cat .git/ignore
+    # ignore objects and archives, anywhere in the tree.
+    *.[oa]
+    $ cat Documentation/.gitignore
+    # ignore generated html files,
+    # except foo.html which is maintained by hand
+    !foo.html
+    *.html
+    $ git-ls-files --ignored \
+        --exclude='Documentation/*.[0-9]' \
+        --exclude-from=.git/ignore \
+        --exclude-per-directory=.gitignore
+
+
 See Also
 --------
 link:read-cache.html[read-cache]
