From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 2/4] git-submodule summary: show commit summary
Date: Sat,  8 Mar 2008 02:27:17 +0800
Message-ID: <1204914439-23145-2-git-send-email-pkufranky@gmail.com>
References: <1204914439-23145-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 07 19:29:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXhJM-0006ub-CC
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 19:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbYCGS13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 13:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbYCGS11
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 13:27:27 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43650 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932298AbYCGS1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 13:27:23 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 5518B470AD; Sat,  8 Mar 2008 02:27:19 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1204914439-23145-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76511>

This patch does the hard work to show submodule commit summary.

For a modified submodule, a series of commits will be shown with
the following command

	git log --pretty='format:%m %s' --left-right \
	--first-parent sha1_src...sha1_dst

where the src sha1 is from the given super project commit and the
dst sha1 is from the index or working tree (switched by --cached).

For a deleted, added, or typechanged (blob<->submodule) submodule,
only one single newest commit from the existing end (for example,
src end for submodule deleted or type changed from submodule to blob)
will be shown.

If the src/dst sha1 for a submodule is missing in the submodule
directory, a warning will be issued except in two cases where the
submodule directory is deleted (type 'D') or typechanged to blob
(one case of type 'T').

In the title line for a submodule, the src/dst sha1 and the number
of commits (--first-parent) between the two sha1s will be shown.

The following example demonstrates most cases.

Example: commit summary for modified submodules sm1-sm5.
--------------------------------------------
$ git submodule summary
* sm1 354cd45...3f751e5 (4):
  < one line message for C
  < one line message for B
  > one line message for D
  > one line message for E

* sm2 5c8bfb5...000000 (3):
  < one line message for F

* sm3 354cd45...3f751e5:
  Warn: sm3 doesn't contain commit 354cd45

* sm4 354cd34(submodule)-> 235efa(blob) (1):
  < one line message for G

* sm5 354cd34(blob)-> 235efa(submodule) (5):
  > one line message for H

--------------------------------------------

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 0a48f57..1751ab2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -371,6 +371,94 @@ cmd_summary() {
 			echo "$name"
 		done
 	)
+
+	test -n "$modules" &&
+	git diff-index $cached --raw $head -- $modules |
+	grep -e '^:160000' -e '^:[0-7]* 160000' |
+	cut -c2- |
+	while read mod_src mod_dst sha1_src sha1_dst status name
+	do
+		if test -z "$cached" &&
+			test $sha1_dst = 0000000000000000000000000000000000000000
+		then
+			sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD) || continue
+		fi
+		missing_src=
+		missing_dst=
+
+		test $mod_src = 160000 &&
+		! GIT_DIR="$name/.git" git-rev-parse --verify $sha1_src^0 >/dev/null 2>&1 &&
+		missing_src=t
+
+		test $mod_dst = 160000 &&
+		! GIT_DIR="$name/.git" git-rev-parse --verify $sha1_dst^0 >/dev/null 2>&1 &&
+		missing_dst=t
+
+		total_commits=
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
+			errmsg=
+			total_commits=$(
+			if test $mod_src = 160000 -a $mod_dst = 160000
+			then
+				range="$sha1_src...$sha1_dst"
+			elif test $mod_src = 160000
+			then
+				range=$sha1_src
+			else
+				range=$sha1_dst
+			fi
+			GIT_DIR="$name/.git" \
+			git log --pretty=oneline --first-parent $range | wc -l
+			)
+			total_commits=" ($total_commits)"
+			;;
+		esac
+
+		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
+		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
+		if test $status = T
+		then
+			if test $mod_dst = 160000
+			then
+				echo "* $name $sha1_abbr_src(blob)->$sha1_abbr_dst(submodule)$total_commits:"
+			else
+				echo "* $name $sha1_abbr_src(submodule)->$sha1_abbr_dst(blob)$total_commits:"
+			fi
+		else
+			echo "* $name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
+		fi
+		if test -n "$errmsg"
+		then
+			# Don't give error msg for modification whose dst is not submodule
+			# i.e. deleted or changed to blob
+			test $mod_dst = 160000 && echo "$errmsg"
+		else
+			if test $mod_src = 160000 -a $mod_dst = 160000
+			then
+				GIT_DIR="$name/.git" \
+				git log --pretty='format:  %m %s' \
+				--left-right --first-parent $sha1_src...$sha1_dst
+			elif test $mod_dst = 160000
+			then
+				GIT_DIR="$name/.git" \
+				git log --pretty='format:  > %h %s' -1 $sha1_dst
+			else
+				GIT_DIR="$name/.git" \
+				git log --pretty='format:  < %h %s' -1 $sha1_src
+			fi
+		fi
+		echo
+	done
 }
 #
 # List all submodules, prefixed with:
-- 
1.5.4.3.347.g5314c

