From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 1/5] git-submodule: New subcommand 'summary' (1) - code framework
Date: Sat, 12 Jan 2008 15:37:11 +0800
Message-ID: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 08:53:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbBF-00043k-RI
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092AbYALHw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758804AbYALHwt
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:52:49 -0500
Received: from mail.qikoo.org ([60.28.205.235]:51682 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758092AbYALHwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:52:47 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 5A2A747094; Sat, 12 Jan 2008 15:37:15 +0800 (CST)
X-Mailer: git-send-email 1.5.4.rc2.9.gf5146-dirty
In-Reply-To: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70288>

Following patches teach git-submodule a new subcommand 'summary' to show
commit summary of user-cared (i.e. checked out) submodules since a given
commit (default HEAD) of super project.

For a submodule in question, a series of commits will be shown as the path
from the src commit to the dst commit, where the src commit is from the given
super project commit, and the dst commit is from the index or working tree
(switched by --cached).

.Example: a super project with modified/deleted submodules sm1 to sm3.
--------------------------------------------
 $ git submodule summary
 # Submodules modifiled: sm1 sm2 sm3
 #
 # * sm1 354cd45...3f751e5:
 #   <one line message for C
 #   <one line message for B
 #   >one line message for D
 #   >one line message for E
 #
 # * sm2 5c8bfb5...000000:
 #   <one line message for F
 #
 # * sm3 354cd45...3f751e5:
 #   Warn: sm3 doesn't contain commit 354cd45
 #
--------------------------------------------

sm1 has commit C as src (given commit or HEAD) and commit E as dst (index
or working tree) as following picture shows.
	--A-->B-->C (in src:354cd45)
	  \
	   -->D-->E (in dst:3f751e5)

The 'Submodules modified' section for sm1 shows how to change sm1 from
src commit C to dst commit E: firstly backward (<) to commit A from
commit C via commit B, and then forward (>) to commit E via commit D.

Illustration for output of deleted sm2 is similar.

If the src/dst commit for a submodule is not found in the work tree (say
the submodule respository in the work tree), a warning will be issued.
sm3 falls into this case.

This patch just gives the framework. It just finds the submodules to be
shown as follows.

--------------------------------------------
 $ git submodule summary
 # Submodules modifiled: sm1 sm2 sm3
 #
--------------------------------------------

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   57 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ad9fe62..0e81484 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
+USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update|summary <commit>] [--] [<path>...]'
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -255,7 +255,46 @@ set_name_rev () {
 	) )
 	test -z "$revname" || revname=" ($revname)"
 }
+#
+# Show commit summary for submodules in index or working tree relative to the given commit
+#
+# If '--cached' is given, show summary between index and given commit,
+# or between working tree and given commit
+#
+# @ = [head counting commits from (default 'HEAD'),] requested paths (default to all)
+#
+modules_summary()
+{
+	cache_option=${cached:+--cached}
+
+	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
+	then
+		head=$rev
+		shift
+	else
+		head=HEAD
+	fi
 
+	cwd=$(pwd)
+	cd_to_toplevel
+
+	# get modified modules which have been checked out (i.e. cared by user)
+	modules=$(git diff $cache_option --raw $head -- "$@" |
+		grep '^:160000\|:000000 160000' |
+		while read mod_src mod_dst sha1_src sha1_dst status name
+		do
+			test $status=D && echo "$name" && continue
+			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
+			echo "$name"
+		done
+	)
+
+	# TODO: quote module names containing space or tab
+	test -n "$modules" &&
+	echo "# Submodules modified: "$modules &&
+	echo "#"
+	cd "$cwd"
+}
 #
 # List all submodules, prefixed with:
 #  - submodule not initialized
@@ -305,6 +344,9 @@ do
 	update)
 		update=1
 		;;
+	summary)
+		summary=1
+		;;
 	status)
 		status=1
 		;;
@@ -345,17 +387,20 @@ case "$add,$branch" in
 	;;
 esac
 
-case "$add,$init,$update,$status,$cached" in
-1,,,,)
+case "$add,$init,$update,$summary,$status,$cached" in
+1,,,,,)
 	module_add "$@"
 	;;
-,1,,,)
+,1,,,,)
 	modules_init "$@"
 	;;
-,,1,,)
+,,1,,,)
 	modules_update "$@"
 	;;
-,,,*,*)
+,,,1,,*)
+	modules_summary "$@"
+	;;
+,,,,*,*)
 	modules_list "$@"
 	;;
 *)
-- 
1.5.4.rc2.9.gf5146-dirty
