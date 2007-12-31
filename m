From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule: New subcommand 'summary' (2) - hard work
Date: Tue,  1 Jan 2008 01:35:04 +0800
Message-ID: <1199122505-27478-3-git-send-email-pkufranky@gmail.com>
References: <1199122505-27478-1-git-send-email-pkufranky@gmail.com>
Cc: Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 19:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9PAd-0000IJ-4l
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 19:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbXLaSOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 13:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbXLaSOm
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 13:14:42 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43649 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750803AbXLaSOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 13:14:38 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 4B6AA47089; Tue,  1 Jan 2008 01:35:05 +0800 (CST)
X-Mailer: git-send-email 1.5.4.rc2.9.gf5146-dirty
In-Reply-To: <1199122505-27478-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69416>

This patch does the hard work of submodule summary and finally gives
output shown in last patch.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 0e81484..cccb539 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -292,7 +292,73 @@ modules_summary()
 	# TODO: quote module names containing space or tab
 	test -n "$modules" &&
 	echo "# Submodules modified: "$modules &&
-	echo "#"
+	echo "#" &&
+	git diff $cache_option --raw $head -- $modules |
+	grep '^:160000\|:000000 160000' |
+	cut -c2- |
+	while read mod_src mod_dst sha1_src sha1_dst status name
+	do
+		sha1_dst=$(echo $sha1_dst | cut -c1-7)
+		sha1_src=$(echo $sha1_src | cut -c1-7)
+		check_dst=t
+		check_src=t
+		case $status in
+		D)
+			check_dst=
+			;;
+		A)
+			check_src=
+			;;
+		esac
+
+		(
+			errmsg=
+			unfound_src=
+			unfound_dst=
+
+			test -z "$check_src" ||
+			GIT_DIR="$name/.git" git-rev-parse $sha1_src >&/dev/null ||
+			unfound_src=t
+
+			test -z "$check_dst" ||
+			GIT_DIR="$name/.git" git-rev-parse $sha1_dst >&/dev/null ||
+			unfound_dst=t
+
+			case "$unfound_src,$unfound_dst" in
+			t,)
+				errmsg="  Warn: $name doesn't contain commit $sha1_src"
+				;;
+			,t)
+				errmsg="  Warn: $name doesn't contain commit $sha1_dst"
+				;;
+			t,t)
+				errmsg="  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
+				;;
+			*)
+				left=
+				right=
+				test -n "$check_src" &&
+				left=$(GIT_DIR="$name/.git" git log --pretty=format:"  <%s" \
+				${check_dst:+$sha1_dst..}$sha1_src 2>/dev/null)
+
+				test -n "$check_dst" &&
+				right=$(GIT_DIR="$name/.git" git log --reverse --pretty=format:"  >%s" \
+				${check_src:+$sha1_src..}$sha1_dst 2>/dev/null)
+				;;
+			esac
+
+			echo "* $name $sha1_src...$sha1_dst:"
+			if test -n "$errmsg"
+			then
+				echo "$errmsg"
+			else
+				test -n "$left" && echo "$left"
+				test -n "$right" && echo "$right"
+			fi
+			echo
+		) | sed 's/^/# /'
+	done
+
 	cd "$cwd"
 }
 #
-- 
1.5.4.rc2.9.gf5146-dirty
