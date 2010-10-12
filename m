From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH v2] completion: Support the DWIM mode for git checkout
Date: Tue, 12 Oct 2010 14:38:12 -0700
Message-ID: <1286919493-8397-1-git-send-email-kevin@sb.org>
References: <DE3CFB0F-A774-4170-A74D-3BE400E33CEC@sb.org>
Cc: Kevin Ballard <kevin@sb.org>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 23:39:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5mYu-0000qw-Vz
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233Ab0JLVjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 17:39:03 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40693 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0JLVjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 17:39:02 -0400
Received: by pxi16 with SMTP id 16so638744pxi.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 14:39:01 -0700 (PDT)
Received: by 10.142.171.2 with SMTP id t2mr6896218wfe.91.1286919538269;
        Tue, 12 Oct 2010 14:38:58 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id x8sm10071039wff.11.2010.10.12.14.38.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 14:38:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.185.gd09c4
In-Reply-To: <DE3CFB0F-A774-4170-A74D-3BE400E33CEC@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158880>

Ever since commit 70c9ac2 (DWIM: "git checkout frotz" to "git checkout
-b frotz origin/frotz"), git checkout has supported a DWIM mode where
it creates a local tracking branch for a remote branch if just the name
of the remote branch is specified on the command-line and only one remote
has a branch with that name. Teach the bash completion script to understand
this DWIM mode and provide such remote-tracking branch names as possible
completions.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 contrib/completion/git-completion.bash |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 64341d5..59ed345 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -386,16 +386,19 @@ __git_tags ()
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
@@ -407,6 +410,21 @@ __git_refs ()
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
@@ -994,7 +1012,13 @@ _git_checkout ()
 			"
 		;;
 	*)
-		__gitcomp "$(__git_refs)"
+		# check if --track, --no-track, or --no-guess was specified
+		# if so, disable DWIM mode
+		local flags="--track --no-track --no-guess" track=1
+		if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
+			track=''
+		fi
+		__gitcomp "$(__git_refs '' $track)"
 		;;
 	esac
 }
-- 
1.7.3.1.185.gd09c4
