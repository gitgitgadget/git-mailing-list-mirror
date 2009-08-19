From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 5/6] git submodule update: Introduce --recursive to update
 nested submodules
Date: Wed, 19 Aug 2009 03:45:23 +0200
Message-ID: <1250646324-961-6-git-send-email-johan@herland.net>
References: <1250646324-961-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	mlevedahl@gmail.com, hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 03:46:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdaFU-0006td-Vl
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 03:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZHSBpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 21:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbZHSBpv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 21:45:51 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33199 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751477AbZHSBps (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 21:45:48 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL0048IOWDN560@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:49 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00EC4OW53WE0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:49 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.19.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1250646324-961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126494>

In very large and hierarchically structured projects, one may encounter
nested submodules. In these situations, it is valuable to not only update
the submodules in the current repo (which is what is currently done by
'git submodule update'), but also to operate on all submodules at all
levels (i.e. recursing into nested submodules as well).

This patch teaches the new --recursive option to the 'git submodule update'
command. The patch also includes documentation and selftests.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-submodule.txt |    7 +++++--
 git-submodule.sh                |   13 ++++++++++++-
 t/t7407-submodule-foreach.sh    |   19 +++++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index c604550..cd74da9 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
-	      [--reference <repository>] [--merge] [--] [<path>...]
+	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -122,6 +122,9 @@ update::
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the --init option.
++
+If '--recursive' is specified, this command will recurse into the
+registered submodules, and update any nested submodules within.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
@@ -222,7 +225,7 @@ OPTIONS
 for linkgit:git-clone[1]'s --reference and --shared options carefully.
 
 --recursive::
-	This option is only valid for the foreach command.
+	This option is only valid for foreach and update commands.
 	Traverse submodules recursively. The operation is performed not
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
diff --git a/git-submodule.sh b/git-submodule.sh
index dbfc483..e48c309 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b branch] [--reference <repository>] [--] <repository> <path>
    or: $dashless [--quiet] status [--cached] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--] [<path>...]"
@@ -353,6 +353,7 @@ cmd_init()
 cmd_update()
 {
 	# parse $args after "submodule ... update".
+	orig_args="$@"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -385,6 +386,10 @@ cmd_update()
 			shift
 			update="merge"
 			;;
+		--recursive)
+			shift
+			recursive=1
+			;;
 		--)
 			shift
 			break
@@ -471,6 +476,12 @@ cmd_update()
 			die "Unable to $action '$sha1' in submodule path '$path'"
 			say "Submodule path '$path': $msg '$sha1'"
 		fi
+
+		if test -n "$recursive"
+		then
+			(unset GIT_DIR; cd "$path" && cmd_update $orig_args) ||
+			die "Failed to recurse into submodule path '$path'"
+		fi
 	done
 }
 
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index be122c7..9122bfe 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -175,4 +175,23 @@ test_expect_success 'test "foreach --quiet --recursive"' '
 	test_cmp expect actual
 '
 
+test_expect_success 'use "update --recursive" to checkout all submodules' '
+	git clone super clone3 &&
+	(
+		cd clone3 &&
+		test ! -d sub1/.git &&
+		test ! -d sub2/.git &&
+		test ! -d sub3/.git &&
+		test ! -d nested1/.git &&
+		git submodule update --init --recursive &&
+		test -d sub1/.git &&
+		test -d sub2/.git &&
+		test -d sub3/.git &&
+		test -d nested1/.git &&
+		test -d nested1/nested2/.git &&
+		test -d nested1/nested2/nested3/.git &&
+		test -d nested1/nested2/nested3/submodule/.git
+	)
+'
+
 test_done
-- 
1.6.4.304.g1365c.dirty
