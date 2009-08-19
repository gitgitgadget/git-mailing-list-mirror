From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 4/6] git submodule foreach: Add --recursive to recurse into
 nested submodules
Date: Wed, 19 Aug 2009 03:45:22 +0200
Message-ID: <1250646324-961-5-git-send-email-johan@herland.net>
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
	id 1MdaFU-0006td-8A
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 03:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbZHSBpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 21:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbZHSBpt
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 21:45:49 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64245 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751314AbZHSBpr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 21:45:47 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00MK0OWCEU70@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:48 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00EC4OW53WE0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:48 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.19.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1250646324-961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126493>

In very large and hierarchically structured projects, one may encounter
nested submodules. In these situations, it is valuable to not only operate
on all the submodules in the current repo (which is what is currently done
by 'git submodule foreach'), but also to operate on all submodules at all
levels (i.e. recursing into nested submodules as well).

This patch teaches the new --recursive option to the 'git submodule foreach'
command. The patch also includes documentation and selftests.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-submodule.txt |   10 ++++-
 git-submodule.sh                |   19 ++++++-
 t/t7407-submodule-foreach.sh    |   99 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cfa8d73..c604550 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
 	      [--reference <repository>] [--merge] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
-'git submodule' [--quiet] foreach <command>
+'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--] [<path>...]
 
 
@@ -142,6 +142,8 @@ foreach::
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given --quiet, foreach prints the name
 	of each submodule before evaluating the command.
+	If --recursive is given, submodules are traversed recursively (i.e.
+	the given shell command is evaluated in nested submodules as well).
 	A non-zero return from the command in any submodule causes
 	the processing to terminate. This can be overridden by adding '|| :'
 	to the end of the command.
@@ -219,6 +221,12 @@ OPTIONS
 *NOTE*: Do *not* use this option unless you have read the note
 for linkgit:git-clone[1]'s --reference and --shared options carefully.
 
+--recursive::
+	This option is only valid for the foreach command.
+	Traverse submodules recursively. The operation is performed not
+	only in the submodules of the current repo, but also
+	in any nested submodules inside those submodules (and so on).
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 6163d01..dbfc483 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] add [-b branch] [--reference <repository>] [--] <repository> <p
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
-   or: $dashless [--quiet] foreach <command>
+   or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -24,6 +24,7 @@ cached=
 files=
 nofetch=
 update=
+prefix=
 
 # Resolve relative url by appending to parent's url
 resolve_relative_url ()
@@ -250,6 +251,9 @@ cmd_foreach()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		--recursive)
+			recursive=1
+			;;
 		-*)
 			usage
 			;;
@@ -265,9 +269,18 @@ cmd_foreach()
 	do
 		if test -e "$path"/.git
 		then
-			say "Entering '$path'"
+			say "Entering '$prefix$path'"
 			name=$(module_name "$path")
-			(cd "$path" && eval "$@") ||
+			(
+				prefix="$prefix$path/"
+				unset GIT_DIR
+				cd "$path" &&
+				eval "$@" &&
+				if test -n "$recursive"
+				then
+					cmd_foreach "--recursive" "$@"
+				fi
+			) ||
 			die "Stopping at '$path'; script returned non-zero status."
 		fi
 	done
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 991aa80..be122c7 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -76,4 +76,103 @@ test_expect_success 'test basic "submodule foreach" usage' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup nested submodules' '
+	git clone submodule nested1 &&
+	git clone submodule nested2 &&
+	git clone submodule nested3 &&
+	(
+		cd nested3 &&
+		git submodule add ../submodule submodule &&
+		test_tick &&
+		git commit -m "submodule" &&
+		git submodule init submodule
+	) &&
+	(
+		cd nested2 &&
+		git submodule add ../nested3 nested3 &&
+		test_tick &&
+		git commit -m "nested3" &&
+		git submodule init nested3
+	) &&
+	(
+		cd nested1 &&
+		git submodule add ../nested2 nested2 &&
+		test_tick &&
+		git commit -m "nested2" &&
+		git submodule init nested2
+	) &&
+	(
+		cd super &&
+		git submodule add ../nested1 nested1 &&
+		test_tick &&
+		git commit -m "nested1" &&
+		git submodule init nested1
+	)
+'
+
+test_expect_success 'use "submodule foreach" to checkout 2nd level submodule' '
+	git clone super clone2 &&
+	(
+		cd clone2 &&
+		test ! -d sub1/.git &&
+		test ! -d sub2/.git &&
+		test ! -d sub3/.git &&
+		test ! -d nested1/.git &&
+		git submodule update --init &&
+		test -d sub1/.git &&
+		test -d sub2/.git &&
+		test -d sub3/.git &&
+		test -d nested1/.git &&
+		test ! -d nested1/nested2/.git &&
+		git submodule foreach "git submodule update --init" &&
+		test -d nested1/nested2/.git &&
+		test ! -d nested1/nested2/nested3/.git
+	)
+'
+
+test_expect_success 'use "foreach --recursive" to checkout all submodules' '
+	(
+		cd clone2 &&
+		git submodule foreach --recursive "git submodule update --init" &&
+		test -d nested1/nested2/nested3/.git &&
+		test -d nested1/nested2/nested3/submodule/.git
+	)
+'
+
+cat > expect <<EOF
+Entering 'nested1'
+Entering 'nested1/nested2'
+Entering 'nested1/nested2/nested3'
+Entering 'nested1/nested2/nested3/submodule'
+Entering 'sub1'
+Entering 'sub2'
+Entering 'sub3'
+EOF
+
+test_expect_success 'test messages from "foreach --recursive"' '
+	(
+		cd clone2 &&
+		git submodule foreach --recursive "true" > ../actual
+	) &&
+	test_cmp expect actual
+'
+
+cat > expect <<EOF
+nested1-nested1
+nested2-nested2
+nested3-nested3
+submodule-submodule
+foo1-sub1
+foo2-sub2
+foo3-sub3
+EOF
+
+test_expect_success 'test "foreach --quiet --recursive"' '
+	(
+		cd clone2 &&
+		git submodule foreach -q --recursive "echo \$name-\$path" > ../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.4.304.g1365c.dirty
