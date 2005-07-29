From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation and tests: ls-files exclude pattern.
Date: Fri, 29 Jul 2005 00:51:56 -0700
Message-ID: <7vack6jbhf.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
	<7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
	<20050728155210.GA17952@pasky.ji.cz>
	<7vack6mcd7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Fri Jul 29 09:54:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyPh7-0006H8-R8
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVG2Hx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVG2Hxr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:53:47 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17339 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262505AbVG2Hv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 03:51:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729075145.JYYY19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 03:51:45 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vack6mcd7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 28 Jul 2005 22:04:36 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update the tests and documentation to match the new "last one
determines its fate" semantics.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-ls-files.txt     |   27 ++++++++++++++-------------
 t/t3001-ls-files-others-exclude.sh |   23 ++++++++++++++++++-----
 2 files changed, 32 insertions(+), 18 deletions(-)

4ae2315518ee4017c6646a4421cf448297fc6dcc
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -115,14 +115,14 @@ An exclude pattern file used by (2) and 
 per line.  A line that starts with a '#' can be used as comment
 for readability.
 
-The list of patterns that is in effect at a given time is
-built and ordered in the following way:
+There are three lists of patterns that are in effect at a given
+time.  They are built and ordered in the following way:
 
- * --exclude=<pattern> and lines read from --exclude-from=<file>
-   come at the beginning of the list of patterns, in the order
-   given on the command line.  Patterns that come from the file
-   specified with --exclude-from are ordered in the same order
-   as they appear in the file.
+ * --exclude=<pattern> from the command line; patterns are
+   ordered in the same order as they appear on the command line.
+
+ * lines read from --exclude-from=<file>; patterns are ordered
+   in the same order as they appear in the file.
 
  * When --exclude-per-directory=<name> is specified, upon
    entering a directory that has such a file, its contents are
@@ -130,11 +130,12 @@ built and ordered in the following way:
    are popped off when leaving the directory.
 
 Each pattern in the pattern list specifies "a match pattern" and
-optionally the fate --- either a file that matches the pattern
-is considered excluded or included.  By default, this being
-"exclude" mechanism, the fate is "excluded".  A filename is
-examined against the patterns in the list, and the first match
-determines its fate.
+optionally the fate;n either a file that matches the pattern is
+considered excluded or included.  A filename is matched against
+the patterns in the three lists; the --exclude-from list is
+checked first, then the --exclude-per-directory list, and then
+finally the --exclude list. The last match determines its fate.
+If there is no match in the three lists, the fate is "included".
 
 A pattern specified on the command line with --exclude or read
 from the file specified with --exclude-from is relative to the
@@ -168,9 +169,9 @@ An example:
     *.[oa]
     $ cat Documentation/.gitignore
     # ignore generated html files,
+    *.html
     # except foo.html which is maintained by hand
     !foo.html
-    *.html
     $ git-ls-files --ignored \
         --exclude='Documentation/*.[0-9]' \
         --exclude-from=.git/ignore \
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -14,7 +14,7 @@ rm -fr one three
 for dir in . one one/two three
 do
   mkdir -p $dir &&
-  for i in 1 2 3 4 5
+  for i in 1 2 3 4 5 6 7 8
   do
     >$dir/a.$i
   done
@@ -24,31 +24,44 @@ cat >expect <<EOF
 a.2
 a.4
 a.5
+a.8
 one/a.3
 one/a.4
 one/a.5
+one/a.7
+one/two/a.2
 one/two/a.3
 one/two/a.5
+one/two/a.7
+one/two/a.8
 three/a.2
 three/a.3
 three/a.4
 three/a.5
+three/a.8
 EOF
 
 echo '.gitignore
 output
 expect
 .gitignore
-' >.git/ignore
+*.7
+!*.8' >.git/ignore
 
 echo '*.1
-/*.3' >.gitignore
+/*.3
+!*.6' >.gitignore
 echo '*.2
-two/*.4' >one/.gitignore
+two/*.4
+!*.7
+*.8' >one/.gitignore
+echo '!*.2
+!*.8' >one/two/.gitignore
 
 test_expect_success \
-    'git-ls-files --others --exclude.' \
+    'git-ls-files --others with various exclude options.' \
     'git-ls-files --others \
+       --exclude=\*.6 \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
        >output &&
