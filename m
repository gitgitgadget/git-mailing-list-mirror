From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: [PATCH] submodule: no [--merge|--rebase] when newly cloned
Date: Wed, 16 Feb 2011 05:46:57 -0700
Message-ID: <1297860417-21895-1-git-send-email-olsonse@umich.edu>
Cc: "Spencer E. Olson" <olsonse@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 13:54:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpguD-0000iZ-QK
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 13:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab1BPMyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 07:54:49 -0500
Received: from 28dayslater.mr.itd.umich.edu ([141.211.12.118]:55212 "EHLO
	28dayslater.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754921Ab1BPMyr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 07:54:47 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Feb 2011 07:54:47 EST
Received: FROM tombraider.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.12.86])
	By 28dayslater.mr.itd.umich.edu ID 4D5BC75E.D824D.26482 ;
	16 Feb 2011 07:47:26 EST
Received: FROM olsonse-laptop.olson.home (zektor.gpcc.itd.umich.edu [141.211.2.203])
	By tombraider.mr.itd.umich.edu ID 4D5BC75C.A719F.4027 ;
	Authuser olsonse;
	16 Feb 2011 07:47:25 EST
X-Mailer: git-send-email 1.7.4.1.42.g43f9f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166963>

Previously, when a submodule was cloned in the same command execution, --rebase
or --merge would attempt to run (instead of and) before a checkout, resulting in
an empty working directory.  This patch ignores --rebase or --merge for a
particular submodule when that submodule is newly cloned and instead simply
checks out the appropriate revision.

Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
---
 git-submodule.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b90589..44d8741 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -365,6 +365,27 @@ cmd_init()
 }
 
 #
+# Test whether an element of the $3(=IFS) separated list $2 matches $1
+#
+str_contains()
+{
+	if test -n "$3"
+	then
+		local IFS="$3"
+	fi
+	for i in $2
+	do
+		if test "$i" = "$1"
+		then
+			echo "yes"
+			return
+		fi
+	done
+	echo "no"
+	return
+}
+
+#
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
 # $@ = requested paths (default to all)
@@ -423,6 +444,7 @@ cmd_update()
 		cmd_init "--" "$@" || return
 	fi
 
+	cloned_modules=
 	module_list "$@" |
 	while read mode sha1 stage path
 	do
@@ -442,6 +464,7 @@ cmd_update()
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			module_clone "$path" "$url" "$reference"|| exit
+			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
 			subsha1=$(clear_local_git_env; cd "$path" &&
@@ -469,6 +492,11 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
+			if test "$(str_contains "$name" "$cloned_modules" '\;')" = "yes"
+			then
+				update_module=
+			fi
+
 			case "$update_module" in
 			rebase)
 				command="git rebase"
-- 
1.7.4.1.42.g43f9f
