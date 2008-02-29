From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 3/3] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Sat,  1 Mar 2008 01:34:47 +0800
Message-ID: <18af168b52a735c33612c9c9e4778d8b8bef1cbc.1204306070.git.pkufranky@gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 19:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV9bu-0005g1-GA
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 19:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbYB2SEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 13:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756860AbYB2SEv
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 13:04:51 -0500
Received: from mail.qikoo.org ([60.28.205.235]:54450 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755143AbYB2SEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 13:04:50 -0500
X-Greylist: delayed 1794 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Feb 2008 13:04:49 EST
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 97793470AF; Sat,  1 Mar 2008 01:34:47 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
In-Reply-To: <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
References: <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75548>

This patches teaches git-submodule an option '--summary-limit|-n <number>'
to limit number of commits for the summary. Number 0 will disable summary
and minus number will not limit the summary size.

For beauty and clarification, the last commit for each section (backward
and forward) will always be shown disregarding the given limit. So actual
summary size may be greater than the given limit.

In the same super project of these patch series, 'git submodule -n 2
summary sm1' and 'git submodule -n 3 summary sm1' will show the same.

---------------------------------------
 $ git submodule -n 2 summary sm1
 # Submodules modifiled: sm1
 #
 # * sm1 354cd45...3f751e5:
 #   <one line message for C
 #   <one line message for B
 #   >... (1 more)
 #   >one line message for E
 #
---------------------------------------

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8322771..64f1f5c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,9 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update|summary [<commit>]] [--] [<path>...]'
+USAGE="[--quiet] [--cached] \
+[add <repo> [-b branch]|status|init|update|summary [-n|--summary-limit <number>] [<commit>]] \
+[--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -330,6 +332,8 @@ set_name_rev () {
 #
 cmd_summary()
 {
+	summary_limit=-1
+
 	# parse $args after "submodule ... summary".
 	while test $# -ne 0
 	do
@@ -337,6 +341,14 @@ cmd_summary()
 		--cached)
 			cached=1
 			;;
+		-n|--summary-limit)
+			if test -z "$2" || echo "$2" | grep --quiet -v '^-\?[0-9]\+$'
+			then
+				usage
+			fi
+			summary_limit="$2"
+			shift
+			;;
 		--)
 			shift
 			break
@@ -351,6 +363,8 @@ cmd_summary()
 		shift
 	done
 
+	test $summary_limit = 0 && return
+
 	cache_option=${cached:+--cached}
 
 	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
@@ -443,8 +457,44 @@ cmd_summary()
 			# Don't give error msg for modification whose dst is not submodule, i.e. deleted or changed to blob
 			test $mod_dst = 160000 && echo "$errmsg"
 		else
-			test -n "$left" && echo "$left"
-			test -n "$right" && echo "$right"
+			lc0=0
+			rc0=0
+			test -n "$left" && lc0=$(echo "$left" | wc -l)
+			test -n "$right" && rc0=$(echo "$right" | wc -l)
+
+			if (( $summary_limit < 0 ))
+			then
+				lc=$lc0
+				rc=$rc0
+			elif (( $lc0 < $summary_limit ))
+			then
+				lc=$lc0
+				rc=$(($summary_limit-$lc))
+			else
+				lc=$summary_limit
+				rc=1
+			fi
+
+			if (( $rc > $rc0 ))
+			then
+				rc=$rc0
+			fi
+
+			if test -n "$left"
+			then
+				skip=$(($lc0-$lc))
+				echo "$left" | head -$(($lc-1))
+				test $skip != 0 && echo "  <... ($skip more)"
+				echo "$left" | tail -1
+			fi
+
+			if test -n "$right"
+			then
+				skip=$(($rc0-$rc))
+				echo "$right" | head -$(($rc-1))
+				test $skip != 0 && echo "  >... ($skip more)"
+				echo "$right" | tail -1
+			fi
 		fi
 		echo
 	done | sed -e 's/^/# /'
-- 
1.5.4.3.347.g5314c

