From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 2/3] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat,  1 Mar 2008 01:34:46 +0800
Message-ID: <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 19:06:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV9cG-0005g1-S5
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 19:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117AbYB2SEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 13:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757004AbYB2SEw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 13:04:52 -0500
Received: from mail.qikoo.org ([60.28.205.235]:54456 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756274AbYB2SEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 13:04:50 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 7645B470AE; Sat,  1 Mar 2008 01:34:47 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
In-Reply-To: <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
References: <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75547>

This patch does the hard work of submodule summary and finally gives
output shown in last patch.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8009a8d..8322771 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -380,7 +380,75 @@ cmd_summary()
 	# TODO: quote module names containing space or tab
 	test -n "$modules" &&
 	echo "# Submodules modified: "$modules &&
-	echo "#"
+	echo "#" &&
+	git diff $cache_option --raw $head -- $modules |
+	grep '^:160000\|:[0-9]\+ 160000' |
+	cut -c2- |
+	while read mod_src mod_dst sha1_src sha1_dst status name
+	do
+		sha1_src=$(echo $sha1_src | sed -e 's/\.\.\.//')
+		sha1_dst=$(echo $sha1_dst | sed -e 's/\.\.\.//')
+		check_src=$(echo $mod_src | grep 160000)
+		check_dst=$(echo $mod_dst | grep 160000)
+		errmsg=
+		unfound_src=
+		unfound_dst=
+
+		test -z "$check_src" ||
+		GIT_DIR="$name/.git" git-rev-parse --verify $sha1_src^0 >/dev/null 2>&1 ||
+		unfound_src=t
+
+		test -z "$check_dst" ||
+		GIT_DIR="$name/.git" git-rev-parse --verify $sha1_dst^0 >/dev/null 2>&1 ||
+		unfound_dst=t
+
+		case "$unfound_src,$unfound_dst" in
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
+
 	cd "$cwd"
 }
 #
-- 
1.5.4.3.347.g5314c

