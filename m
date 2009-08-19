From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 6/6] git submodule status: Add --recursive to recurse into
 nested submodules
Date: Wed, 19 Aug 2009 03:45:24 +0200
Message-ID: <1250646324-961-7-git-send-email-johan@herland.net>
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
	id 1MdaFV-0006td-OJ
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 03:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbZHSBpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 21:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZHSBpy
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 21:45:54 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43491 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751312AbZHSBpu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 21:45:50 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL004D5OWFVN10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:51 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00EC4OW53WE0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:51 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.19.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1250646324-961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126492>

In very large and hierarchically structured projects, one may encounter
nested submodules. In these situations, it is valuable to not only show
status for all the submodules in the current repo (which is what is
currently done by 'git submodule status'), but also to show status for
all submodules at all levels (i.e. recursing into nested submodules as
well).

This patch teaches the new --recursive option to the 'git submodule status'
command. The patch also includes documentation and selftests.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-submodule.txt |    7 +++++--
 git-submodule.sh                |   24 ++++++++++++++++++++----
 t/t7407-submodule-foreach.sh    |   26 ++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cd74da9..5ccdd18 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git submodule' [--quiet] add [-b branch]
 	      [--reference <repository>] [--] <repository> <path>
-'git submodule' [--quiet] status [--cached] [--] [<path>...]
+'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
 	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
@@ -100,6 +100,9 @@ status::
 	initialized and `+` if the currently checked out submodule commit
 	does not match the SHA-1 found in the index of the containing
 	repository. This command is the default command for 'git-submodule'.
++
+If '--recursive' is specified, this command will recurse into nested
+submodules, and show their status as well.
 
 init::
 	Initialize the submodules, i.e. register each submodule name
@@ -225,7 +228,7 @@ OPTIONS
 for linkgit:git-clone[1]'s --reference and --shared options carefully.
 
 --recursive::
-	This option is only valid for foreach and update commands.
+	This option is only valid for foreach, update and status commands.
 	Traverse submodules recursively. The operation is performed not
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
diff --git a/git-submodule.sh b/git-submodule.sh
index e48c309..bfbd36b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,7 +6,7 @@
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b branch] [--reference <repository>] [--] <repository> <path>
-   or: $dashless [--quiet] status [--cached] [--] [<path>...]
+   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
@@ -703,6 +703,7 @@ cmd_summary() {
 cmd_status()
 {
 	# parse $args after "submodule ... status".
+	orig_args="$@"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -712,6 +713,9 @@ cmd_status()
 		--cached)
 			cached=1
 			;;
+		--recursive)
+			recursive=1
+			;;
 		--)
 			shift
 			break
@@ -731,22 +735,34 @@ cmd_status()
 	do
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
+		displaypath="$prefix$path"
 		if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
 		then
-			say "-$sha1 $path"
+			say "-$sha1 $displaypath"
 			continue;
 		fi
 		set_name_rev "$path" "$sha1"
 		if git diff-files --quiet -- "$path"
 		then
-			say " $sha1 $path$revname"
+			say " $sha1 $displaypath$revname"
 		else
 			if test -z "$cached"
 			then
 				sha1=$(unset GIT_DIR; cd "$path" && git rev-parse --verify HEAD)
 				set_name_rev "$path" "$sha1"
 			fi
-			say "+$sha1 $path$revname"
+			say "+$sha1 $displaypath$revname"
+		fi
+
+		if test -n "$recursive"
+		then
+			(
+				prefix="$displaypath/"
+				unset GIT_DIR
+				cd "$path" &&
+				cmd_status $orig_args
+			) ||
+			die "Failed to recurse into submodule path '$path'"
 		fi
 	done
 }
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 9122bfe..de1730d 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -194,4 +194,30 @@ test_expect_success 'use "update --recursive" to checkout all submodules' '
 	)
 '
 
+nested1sha1=$(cd clone3/nested1 && git rev-parse HEAD)
+nested2sha1=$(cd clone3/nested1/nested2 && git rev-parse HEAD)
+nested3sha1=$(cd clone3/nested1/nested2/nested3 && git rev-parse HEAD)
+submodulesha1=$(cd clone3/nested1/nested2/nested3/submodule && git rev-parse HEAD)
+sub1sha1=$(cd clone3/sub1 && git rev-parse HEAD)
+sub2sha1=$(cd clone3/sub2 && git rev-parse HEAD)
+sub3sha1=$(cd clone3/sub3 && git rev-parse HEAD)
+
+cat > expect <<EOF
+ $nested1sha1 nested1 (heads/master)
+ $nested2sha1 nested1/nested2 (heads/master)
+ $nested3sha1 nested1/nested2/nested3 (heads/master)
+ $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
+ $sub1sha1 sub1 (${sub1sha1:0:7})
+ $sub2sha1 sub2 (${sub1sha1:0:7})
+ $sub3sha1 sub3 (heads/master)
+EOF
+
+test_expect_success 'test "status --recursive"' '
+	(
+		cd clone3 &&
+		git submodule status --recursive > ../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.4.304.g1365c.dirty
