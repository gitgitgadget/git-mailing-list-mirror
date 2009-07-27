From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Make 'git stash -k' a short form for 'git stash save
 --keep-index'
Date: Mon, 27 Jul 2009 20:37:10 +0200 (CEST)
Message-ID: <76cdda0d6cf911449d16ebb86f54641620135fca.1248719786u.git.johannes.schindelin@gmx.de>
References: <cover.1248719786u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 27 20:37:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVV4s-0001uR-UQ
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 20:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbZG0ShU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZG0ShT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 14:37:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:56095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753411AbZG0ShS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 14:37:18 -0400
Received: (qmail invoked by alias); 27 Jul 2009 18:37:16 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 27 Jul 2009 20:37:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DfGMUayJDGF1YIY/7V3bT+EELjPwNNxgKdsdq5v
	vkRWnYtQ2a6qvU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1248719786u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124182>

To save me from the carpal tunnel syndrome, make 'git stash' accept
the short option '-k' instead of '--keep-index', and for even more
convenience, let's DWIM when this developer forgot to type the 'save'
command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-stash.txt |    3 ++-
 git-stash.sh                |   16 +++++++++-------
 t/t3903-stash.sh            |    8 ++++++++
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1c64a02..a031836 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--keep-index] [-q|--quiet] [<message>]]
+'git stash' [save [-k|--keep-index] [-q|--quiet] [<message>]]
+'git stash' [-k|--keep-index]
 'git stash' clear
 'git stash' create
 
diff --git a/git-stash.sh b/git-stash.sh
index 03e589f..13edc0e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,8 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--keep-index] [-q|--quiet] [<message>]]
+   or: $dashless [save [-k|--keep-index] [-q|--quiet] [<message>]]
+   or: $dashless [-k|--keep-index]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -98,7 +99,7 @@ save_stash () {
 	while test $# != 0
 	do
 		case "$1" in
-		--keep-index)
+		-k|--keep-index)
 			keep_index=t
 			;;
 		-q|--quiet)
@@ -353,12 +354,13 @@ branch)
 	apply_to_branch "$@"
 	;;
 *)
-	if test $# -eq 0
-	then
-		save_stash &&
+	case $#,"$1" in
+	0,|1,-k|1,--keep-index)
+		save_stash "$@" &&
 		say '(To restore them type "git stash apply")'
-	else
+		;;
+	*)
 		usage
-	fi
+	esac
 	;;
 esac
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7a3fb67..e16ad93 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -200,4 +200,12 @@ test_expect_success 'drop -q is quiet' '
 	test ! -s output.out
 '
 
+test_expect_success 'stash -k' '
+	echo bar3 > file &&
+	echo bar4 > file2 &&
+	git add file2 &&
+	git stash -k &&
+	test bar,bar4 = $(cat file),$(cat file2)
+'
+
 test_done
-- 
1.6.3.2.734.g770e
