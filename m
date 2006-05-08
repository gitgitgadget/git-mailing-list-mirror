From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] Teach git-clean optional <paths>... parameters.
Date: Mon, 08 May 2006 12:02:44 -0700
Message-ID: <7v1wv4gx0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 21:02:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdB0L-0004zn-5q
	for gcvg-git@gmane.org; Mon, 08 May 2006 21:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWEHTCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 15:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWEHTCp
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 15:02:45 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20200 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751278AbWEHTCp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 15:02:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508190244.UZTZ17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 15:02:44 -0400
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19774>

When optional paths arguments are given, git-clean passes them
to underlying git-ls-files; with this, you can say:

	git clean 'temp-*'

to clean only the garbage files whose names begin with 'temp-'.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I usually do not use clean myself, so I am not sure if this
   is the kind of thing people who do use 'clean' regularly
   would generally want, hence this RFC.

 Documentation/git-clean.txt |    5 ++++-
 git-clean.sh                |   13 +++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 36890c5..b95545f 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from 
 SYNOPSIS
 --------
 [verse]
-'git-clean' [-d] [-n] [-q] [-x | -X]
+'git-clean' [-d] [-n] [-q] [-x | -X] <paths>...
 
 DESCRIPTION
 -----------
@@ -16,6 +16,9 @@ Removes files unknown to git.  This allo
 from files that are not under version control.  If the '-x' option is
 specified, ignored files are also removed, allowing to remove all
 build products.
+When optional `<paths>...` arguments are given, the paths
+affected are further limited to those that match them.
+
 
 OPTIONS
 -------
diff --git a/git-clean.sh b/git-clean.sh
index b200868..6c818f4 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -3,13 +3,15 @@ #
 # Copyright (c) 2005-2006 Pavel Roskin
 #
 
-USAGE="[-d] [-n] [-q] [-x | -X]"
+USAGE="[-d] [-n] [-q] [-x | -X] <paths>..."
 LONG_USAGE='Clean untracked files from the working directory
 	-d	remove directories as well
 	-n 	don'\''t remove anything, just show what would be done
 	-q	be quiet, only report errors
 	-x	remove ignored files as well
-	-X	remove only ignored files as well'
+	-X	remove only ignored files as well
+When optional <paths>... arguments are given, the paths
+affected are further limited to those that match them.'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
@@ -44,8 +46,11 @@ do
 	-X)
 		ignoredonly=1
 		;;
-	*)
+	-*)
 		usage
+		;;
+	*)
+		break
 	esac
 	shift
 done
@@ -64,7 +69,7 @@ if [ -z "$ignored" ]; then
 	fi
 fi
 
-git-ls-files --others --directory $excl ${excl_info:+"$excl_info"} |
+git-ls-files --others --directory $excl ${excl_info:+"$excl_info"} "$@" |
 while read -r file; do
 	if [ -d "$file" -a ! -L "$file" ]; then
 		if [ -z "$cleandir" ]; then
-- 
1.3.2.gb012
