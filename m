From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Tue,  1 Jan 2008 01:35:05 +0800
Message-ID: <1199122505-27478-4-git-send-email-pkufranky@gmail.com>
References: <1199122505-27478-1-git-send-email-pkufranky@gmail.com>
Cc: Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 19:15:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9PAF-0000Am-Pl
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 19:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbXLaSOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 13:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbXLaSOh
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 13:14:37 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43642 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750803AbXLaSOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 13:14:36 -0500
X-Greylist: delayed 1587 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2007 13:14:35 EST
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 543CA4708A; Tue,  1 Jan 2008 01:35:05 +0800 (CST)
X-Mailer: git-send-email 1.5.4.rc2.9.gf5146-dirty
In-Reply-To: <1199122505-27478-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69414>

This patches teaches git-submodule an option '--summary-limit|-n <number>'
to limit number of commits for the summary. Number 0 will disable summary
and minus number will not limit the summary size.

For beauty and clarification, the last commit for each section (backward
and forward) will always be shown disregarding the given limit. So actual
summary size may be greater than the given limit.

In the same super project of these patch series, 'git submodule -n 2' and
'git submodule -n 3' will both show
    # Submodules modifiled: sm1 sm2 sm3
    #
    # * sm1 354cd45...3f751e5:
    #   <one line message for C
    #   <one line message for B
    #   >... (1 more)
    #   >one line message for E
    #
    # * sm2 5c8bfb5...000000:
    #   <one line message for F
    #
    # * sm3 354cd45...3f751e5:
    #   Warn: sm3 doesn't contain commit 354cd45
    #

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index cccb539..58d0243 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,8 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update|summary <commit>] [--] [<path>...]'
+USAGE="[--quiet] [--cached] [-n|--summary-limit <number>] \
+[add <repo> [-b branch]|status|init|update|summary <commit>] [--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -16,6 +17,7 @@ update=
 status=
 quiet=
 cached=
+summary_limit=
 
 #
 # print stuff on stdout unless -q was specified
@@ -265,6 +267,10 @@ set_name_rev () {
 #
 modules_summary()
 {
+	summary_limit=${summary_limit:-1000000}
+	summary_limit=$((summary_limit<0?1000000:summary_limit))
+	test $summary_limit = 0 && return
+
 	cache_option=${cached:+--cached}
 
 	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
@@ -352,8 +358,29 @@ modules_summary()
 			then
 				echo "$errmsg"
 			else
-				test -n "$left" && echo "$left"
-				test -n "$right" && echo "$right"
+				lc0=0
+				rc0=0
+				test -n "$left" && lc0=$(echo "$left" | wc -l)
+				test -n "$right" && rc0=$(echo "$right" | wc -l)
+				lc=$((lc0<summary_limit?lc0:summary_limit))
+				rc=$((summary_limit>lc?summary_limit-lc:1))
+				rc=$((rc<rc0?rc:rc0))
+
+				if test -n "$left"
+				then
+					skip=$((lc0-lc))
+					echo "$left" | head -$((lc-1))
+					test $skip != 0 && echo "  <... ($skip more)"
+					echo "$left" | tail -1
+				fi
+
+				if test -n "$right"
+				then
+					skip=$((rc0-rc))
+					echo "$right" | head -$((rc-1))
+					test $skip != 0 && echo "  >... ($skip more)"
+					echo "$right" | tail -1
+				fi
 			fi
 			echo
 		) | sed 's/^/# /'
@@ -430,6 +457,13 @@ do
 	--cached)
 		cached=1
 		;;
+	-n|--summary-limit)
+		if [ -z "$2" ]; then
+			usage
+		fi
+		summary_limit="$2"
+		shift
+		;;
 	--)
 		break
 		;;
-- 
1.5.4.rc2.9.gf5146-dirty
