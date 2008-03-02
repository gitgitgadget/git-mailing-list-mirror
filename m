From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 2/4] git-submodule: New subcommand 'summary' (2) - show commit summary
Date: Mon,  3 Mar 2008 02:15:08 +0800
Message-ID: <1204481710-29791-2-git-send-email-pkufranky@gmail.com>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 19:16:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVsjL-0001qt-J5
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 19:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbYCBSPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 13:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbYCBSPT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 13:15:19 -0500
Received: from mail.qikoo.org ([60.28.205.235]:50499 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752425AbYCBSPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 13:15:13 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id D9D0F470AB; Mon,  3 Mar 2008 02:15:10 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75826>

This patch does the hard work to show submodule commit summary.

For a submodule in question, a series of commits will be shown as the path
from the src commit to the dst commit, where the src commit is from the given
super project commit, and the dst commit is from the index or working tree
(switched by --cached).

Example: commit summary for modified submodules sm1-sm5.
--------------------------------------------
 $ git submodule summary
 # Submodules modifiled: sm1 sm2 sm3 sm4 sm5
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
 # * sm4 354cd34(submodule)->235efa(blob):
 #   <one line message for G
 #
 # * sm5 354cd34(blob)->235efa(submodule):
 #   >one line message for H
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

sm4 and sm5 are submodules with typechanging (blob<->submodule).

If the src/dst commit for a submodule is missing in the submodule
directory, a warning will be issued (sm3 falls into this case)
except in two cases where the submodule directory is deleted
(type 'D') or typechanged to blob (one case of type 'T').

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 787d083..3313d6c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -375,7 +375,78 @@ cmd_summary() {
 	# TODO: quote module names containing space or tab
 	test -n "$modules" &&
 	echo "# Submodules modified: "$modules &&
-	echo "#"
+	echo "#" &&
+	git diff-index $cache_option --raw $head -- $modules |
+	grep -e '^:160000' -e '^:[0-7]* 160000' |
+	cut -c2- |
+	while read mod_src mod_dst sha1_src sha1_dst status name
+	do
+		if test -z "$cache_option" &&
+			test $sha1_dst = 0000000000000000000000000000000000000000 &&
+			( GIT_DIR="$name/.git" git rev-parse HEAD ) >/dev/null 2>&1
+		then
+			sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
+		fi
+		check_src=$(echo $mod_src | grep 160000)
+		check_dst=$(echo $mod_dst | grep 160000)
+		errmsg=
+		missing_src=
+		missing_dst=
+
+		test -z "$check_src" ||
+		GIT_DIR="$name/.git" git-rev-parse --verify $sha1_src >/dev/null 2>&1 ||
+		missing_src=t
+
+		test -z "$check_dst" ||
+		GIT_DIR="$name/.git" git-rev-parse --verify $sha1_dst >/dev/null 2>&1 ||
+		missing_dst=t
+
+		case "$missing_src,$missing_dst" in
+		t,)
+			errmsg="  Warn: $name doesn't contain commit $sha1_src"
+			;;
+		,t)
+			errmsg="  Warn: $name doesn't contain commit $sha1_dst"
+			;;
+		t,t)
+			errmsg="  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
+			;;
+		*)
+			left=
+			right=
+			test -n "$check_src" &&
+			left=$(GIT_DIR="$name/.git" git log --pretty=format:"  <%s" \
+			${check_dst:+$sha1_dst..}$sha1_src 2>/dev/null)
+
+			test -n "$check_dst" &&
+			right=$(GIT_DIR="$name/.git" git log --reverse --pretty=format:"  >%s" \
+			${check_src:+$sha1_src..}$sha1_dst 2>/dev/null)
+			;;
+		esac
+
+		sha1_src=$(echo $sha1_src | cut -c1-7)
+		sha1_dst=$(echo $sha1_dst | cut -c1-7)
+		if test $status = T
+		then
+			if test $mod_dst = 160000
+			then
+				echo "* $name $sha1_src(blob)->$sha1_dst(submodule):"
+			else
+				echo "* $name $sha1_src(submodule)->$sha1_dst(blob):"
+			fi
+		else
+			echo "* $name $sha1_src...$sha1_dst:"
+		fi
+		if test -n "$errmsg"
+		then
+			# Don't give error msg for modification whose dst is not submodule, i.e. deleted or changed to blob
+			test $mod_dst = 160000 && echo "$errmsg"
+		else
+			test -n "$left" && echo "$left"
+			test -n "$right" && echo "$right"
+		fi
+		echo
+	done | sed -e 's/^/# /'
 }
 #
 # List all submodules, prefixed with:
-- 
1.5.4.3.347.g5314c

