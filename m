From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: [PATCH 1/2 (v2)] submodule: no [--merge|--rebase] when newly cloned
Date: Thu, 17 Feb 2011 09:18:45 -0700
Message-ID: <1297959526-8089-1-git-send-email-olsonse@umich.edu>
Cc: "Spencer E. Olson" <olsonse@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 17:19:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq6ZY-0005NY-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 17:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab1BQQTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 11:19:11 -0500
Received: from smtp.mail.umich.edu ([141.211.12.86]:34343 "EHLO
	tombraider.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754884Ab1BQQTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 11:19:09 -0500
Received: FROM localhost.localdomain (zektor.gpcc.itd.umich.edu [141.211.2.203])
	By tombraider.mr.itd.umich.edu ID 4D5D4A79.EBCD0.3644 ;
	Authuser olsonse;
	17 Feb 2011 11:19:06 EST
X-Mailer: git-send-email 1.7.4.1.42.g43f9f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167090>

Previously, when a new submodule is cloned by running "git submodule update
[--merge|--rebase]", the newly cloned submodule does not get checked out and a
rebase or merge is incorrectly attempted against an empty working directory.
This patch ignores --rebase or --merge for new submodules and instead simply
checks out the appropriate revision.

Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
---
 git-submodule.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b90589..7724885 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -365,6 +365,19 @@ cmd_init()
 }
 
 #
+# Test whether an element of the ';' separated list $2 matches $1
+#
+list_contains()
+{
+	case "$2;" in
+	*";$1;"*)
+		: yes ;;
+	*)
+		! : no ;;
+	esac
+}
+
+#
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
 # $@ = requested paths (default to all)
@@ -423,6 +436,7 @@ cmd_update()
 		cmd_init "--" "$@" || return
 	fi
 
+	cloned_modules=
 	module_list "$@" |
 	while read mode sha1 stage path
 	do
@@ -442,6 +456,7 @@ cmd_update()
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			module_clone "$path" "$url" "$reference"|| exit
+			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
 			subsha1=$(clear_local_git_env; cd "$path" &&
@@ -469,6 +484,12 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
+			list_contains "$name" "$cloned_modules"
+			if test "$?" = 0
+			then
+				update_module=
+			fi
+
 			case "$update_module" in
 			rebase)
 				command="git rebase"
-- 
1.7.4.1.42.g43f9f
