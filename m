From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] completion: Support the DWIM mode for git checkout
Date: Thu,  7 Oct 2010 17:08:12 -0700
Message-ID: <1286496492-65221-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 02:08:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P40Vu-0001fr-VJ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 02:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab0JHAIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 20:08:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:33223 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab0JHAI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 20:08:28 -0400
Received: by pxi15 with SMTP id 15so4348pxi.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 17:08:28 -0700 (PDT)
Received: by 10.142.207.6 with SMTP id e6mr1320304wfg.15.1286496508415;
        Thu, 07 Oct 2010 17:08:28 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id c22sm1833586waa.13.2010.10.07.17.08.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 17:08:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.184.g5b1fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158466>

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 contrib/completion/git-completion.bash |   35 +++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f83f019..be0498c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -380,16 +380,19 @@ __git_tags ()
 	done
 }
 
-# __git_refs accepts 0 or 1 arguments (to pass to __gitdir)
+# __git_refs accepts 0, 1 (to pass to __gitdir), or 2 arguments
+# presence of 2nd argument means use the guess heuristic employed
+# by checkout for tracking branches
 __git_refs ()
 {
-	local i is_hash=y dir="$(__gitdir "${1-}")"
+	local i is_hash=y dir="$(__gitdir "${1-}")" track="${2-}"
 	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
 	if [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
 			format="refname"
 			refs="${cur%/*}"
+			track=""
 			;;
 		*)
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
@@ -397,10 +400,26 @@ __git_refs ()
 			done
 			format="refname:short"
 			refs="refs/tags refs/heads refs/remotes"
+			if [ -z "$cur" ]; then track=""; fi
 			;;
 		esac
 		git --git-dir="$dir" for-each-ref --format="%($format)" \
 			$refs
+		if [ -n "$track" ]; then
+			# employ the heuristic used by git checkout
+			# Try to find a remote branch that matches the completion word
+			# but only output if the branch name is unique
+			local ref entry
+			git --git-dir="$dir" for-each-ref --shell --format="ref=%(refname:short)" \
+				"refs/remotes/" | \
+			while read entry; do
+				eval "$entry"
+				ref="${ref#*/}"
+				if [[ "$ref" == "$cur"* ]]; then
+					echo "$ref"
+				fi
+			done | uniq -u
+		fi
 		return
 	fi
 	for i in $(git ls-remote "$dir" 2>/dev/null); do
@@ -988,7 +1007,17 @@ _git_checkout ()
 			"
 		;;
 	*)
-		__gitcomp "$(__git_refs)"
+		# check if --track, --no-track, or --no-guess was specified
+		# if so, disable DWIM mode
+		local i c=1 track=1
+		while [ $c -lt $COMP_CWORD ]; do
+			i="${COMP_WORDS[c]}"
+			case "$i" in
+			--track|--no-track|--no-guess) track=''; break ;;
+			esac
+			c=$((++c))
+		done
+		__gitcomp "$(__git_refs '' $track)"
 		;;
 	esac
 }
-- 
1.7.3.1.184.g5b1fd
