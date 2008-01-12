From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 2/5] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 12 Jan 2008 15:37:12 +0800
Message-ID: <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
 <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 08:53:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbBg-000493-Eu
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758588AbYALHxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759028AbYALHxE
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:53:04 -0500
Received: from mail.qikoo.org ([60.28.205.235]:51679 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758598AbYALHwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:52:47 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 63E7C47097; Sat, 12 Jan 2008 15:37:15 +0800 (CST)
X-Mailer: git-send-email 1.5.4.rc2.9.gf5146-dirty
In-Reply-To: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
In-Reply-To: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
References: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70291>

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
