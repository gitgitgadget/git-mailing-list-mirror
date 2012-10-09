From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] submodule: teach "foreach" command a --revision <tree-ish> option
Date: Mon,  8 Oct 2012 20:50:10 -0400
Message-ID: <1349743810-10753-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 02:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLO1q-0005EC-21
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 02:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab2JIAuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 20:50:24 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:64403 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183Ab2JIAuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 20:50:23 -0400
Received: by mail-gh0-f174.google.com with SMTP id g15so1356562ghb.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 17:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yMDHENnsHPUYD7U6gH8V6hJV6ZGrNzgS1zsUgmE5T1s=;
        b=DOx/tGNUjLCvhGnH1PlAA9CRz2V8dfGya+x+WjAvfX4EKYHtLkHchl5G+VntsSvoGD
         HNYs1KtPtVAzRDkValJJ+TD4rK+hausZ0M+3KdMknRKSSAQKYMKTRi7Dqs4SmYDnHnUG
         HWuk5FREpNhjZeHRyYdxA78Aj2IVU76tg7eqdGY/x01eb7DmKjeDLym+uZIwnb9vDXiy
         u6GLy1BqNT0vJYRUsDNoou6Q6IgsXqaSabqmGwBNZ5yfw1/oSoz4nlwNkTx64bhJumvR
         8LxaDVtX8eZJNMQSqpbkIJK8XmuC0FX8c3ruDOR4JEG5iVqUOSrSBABfkMvuiJCbXwyQ
         7VkA==
Received: by 10.236.182.197 with SMTP id o45mr18052457yhm.23.1349743822358;
        Mon, 08 Oct 2012 17:50:22 -0700 (PDT)
Received: from localhost (cpe-174-097-217-221.nc.res.rr.com. [174.97.217.221])
        by mx.google.com with ESMTPS id i20sm1579710ank.17.2012.10.08.17.50.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 17:50:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207281>

Teach "git submodule foreach" a --revision <tree-ish> option. This
is useful in combination with $sha1 to perform git commands that
take a revision argument. For example:

  $ git submodule foreach --revision v1.0 'git tag v1.0 $sha1'

Previously, this would have required multiple steps:

  $ git checkout v1.0
  $ git submodule update
  $ git submodule foreach 'git tag v1.0'

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-submodule.txt |  7 ++++++-
 git-submodule.sh                | 27 ++++++++++++++++++++++++---
 t/t7407-submodule-foreach.sh    | 15 +++++++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b4683bba1b..6c889f5fd6 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -17,7 +17,8 @@ SYNOPSIS
 	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
-'git submodule' [--quiet] foreach [--recursive] <command>
+'git submodule' [--quiet] foreach [--recursive] [--revision <tree-ish>]
+	      <command>
 'git submodule' [--quiet] sync [--] [<path>...]
 
 
@@ -180,6 +181,10 @@ foreach::
 	of each submodule before evaluating the command.
 	If `--recursive` is given, submodules are traversed recursively (i.e.
 	the given shell command is evaluated in nested submodules as well).
+	If `--revision <tree-ish>` is given, submodules are traversed starting
+	at the given <tree-ish>. Though this does not alter the submodule check
+	outs, it may be combined with $sha1 to perform git commands that can
+	operate	on a particular commit, such as linkgit:git-tag[1].
 	A non-zero return from the command in any submodule causes
 	the processing to terminate. This can be overridden by adding '|| :'
 	to the end of the command.
diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b1107b6..5e7458e155 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <r
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
-   or: $dashless [--quiet] foreach [--recursive] <command>
+   or: $dashless [--quiet] foreach [--recursive] [--revision <tree-ish>] <command>
    or: $dashless [--quiet] sync [--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -379,6 +379,7 @@ Use -f if you really want to add it." >&2
 cmd_foreach()
 {
 	# parse $args after "submodule ... foreach".
+	revision=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -388,6 +389,11 @@ cmd_foreach()
 		--recursive)
 			recursive=1
 			;;
+		--revision)
+			git rev-parse --quiet --verify "$2" >/dev/null || usage
+			revision=$2
+			shift
+			;;
 		-*)
 			usage
 			;;
@@ -404,7 +410,17 @@ cmd_foreach()
 	# command in the subshell (and a recursive call to this function)
 	exec 3<&0
 
-	module_list |
+	if test -n "$revision"
+	then
+		# make ls-tree output look like ls-files output
+		git ls-tree -r $revision | grep '^160000 ' |
+		while read mode unused sha1 sm_path
+		do
+			echo "$mode $sha1 0 $sm_path"
+		done
+	else
+		module_list
+	fi |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -421,7 +437,12 @@ cmd_foreach()
 				eval "$@" &&
 				if test -n "$recursive"
 				then
-					cmd_foreach "--recursive" "$@"
+					if test -n "$revision"
+					then
+						cmd_foreach "--recursive" "--revision" "$sha1" "$@"
+					else
+						cmd_foreach "--recursive" "$@"
+					fi
 				fi
 			) <&3 3<&- ||
 			die "$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 9b69fe2e14..5c798b901b 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -179,6 +179,21 @@ test_expect_success 'test "foreach --quiet --recursive"' '
 	test_cmp expect actual
 '
 
+sha1=$(cd submodule && git rev-parse HEAD~1)
+cat > expect <<EOF
+sub1 $sha1
+sub2 $sha1
+sub3 $sha1
+EOF
+
+test_expect_success 'test "foreach --quiet --revision"' '
+	(
+		cd clone2 &&
+		git submodule foreach -q --revision HEAD~2 "echo \$path \$sha1" > ../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'use "update --recursive" to checkout all submodules' '
 	git clone super clone3 &&
 	(
-- 
1.7.12.2
