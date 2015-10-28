From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH 2/3] completion: pass --git-dir to more commands
Date: Wed, 28 Oct 2015 18:21:24 +0100
Message-ID: <1446052885-11173-3-git-send-email-peter@lekensteyn.nl>
References: <1446052885-11173-1-git-send-email-peter@lekensteyn.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 18:47:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrUp4-0001Pu-CO
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbJ1Rrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:47:37 -0400
Received: from lekensteyn.nl ([178.21.112.251]:38703 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbbJ1Rrg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:47:36 -0400
X-Greylist: delayed 1561 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2015 13:47:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
	h=References:In-Reply-To:Message-Id:Date:Subject:To:From; bh=TwPfqTeox34zpJFTY5lmxMF8uepSP+QHgoMiBARZYKM=;
	b=ZnM6Y71y0bTVGVSi3+oSm3Kr7noQCDHyifEb4dlnHCGX0+hl6h8F7sgqm8fFfgZqjcN1sqi9EEdAXgYV6aHlje6KHAs+axq7jOHsOYDbvmerB3vy+pvUIhhltV2/acEM+kwDcZ3Jvah6avT7WQ/7MjMwd0Jj53MW7Co4wqRWI1Rfiam8iCD8z1g3eVJl88rm/QSp7/v1//KSgqC8QyXvX5w6R7eLzdnG6RnRMOZmvSFOlsKcbA1LZ8vWAyHomjmuHGRRvUCmC72WMf0BMji4BqsfeCdyj6F/JbRp1G3BZjAuiI3hgiQw1Ws1R84FdSbFbBE7ZkKx1Q8/ztySWTQAZg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.84)
	(envelope-from <peter@lekensteyn.nl>)
	id 1ZrUPm-00064K-Hc; Wed, 28 Oct 2015 18:21:34 +0100
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446052885-11173-1-git-send-email-peter@lekensteyn.nl>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280383>

The --git-dir option influences more commands, but was not applied
during completions. For example:

    # previously empty because --git-dir was not passed to ls-remote
    git --git-dir=git/.git config merge.o<TAB>

Add --git-dir to more git commands (but not for repo-independent
commands such as git help) and add a new internal "__git_options"
array to store this option. In future patches, the -C option will also
be added.  (Alternatively, a new wrapper function can be added instead
of duplicating `${__git_options[@]}` all over the place, but let's keep
it simple for now.)

Add a variable and comments to __git_refs for clarity. (Note that
`--git-dir` needs to be kept there because it may not be the same as
the current repo, e.g. via `git fetch /tmp/repo <TAB>`.)

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 contrib/completion/git-completion.bash | 52 ++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bd9ef4c..fdf0f16 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -282,10 +282,10 @@ __gitcomp_file ()
 __git_ls_files_helper ()
 {
 	if [ "$2" == "--committable" ]; then
-		git -C "$1" diff-index --name-only --relative HEAD
+		git "${__git_options[@]}" -C "$1" diff-index --name-only --relative HEAD
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
-		git -C "$1" ls-files --exclude-standard $2
+		git "${__git_options[@]}" -C "$1" ls-files --exclude-standard $2
 	fi 2>/dev/null
 }
 
@@ -315,7 +315,7 @@ __git_heads ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir" ]; then
-		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
+		git "${__git_options[@]}" for-each-ref --format='%(refname:short)' \
 			refs/heads
 		return
 	fi
@@ -325,7 +325,7 @@ __git_tags ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir" ]; then
-		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
+		git "${__git_options[@]}" for-each-ref --format='%(refname:short)' \
 			refs/tags
 		return
 	fi
@@ -336,8 +336,9 @@ __git_tags ()
 # by checkout for tracking branches
 __git_refs ()
 {
-	local i hash dir="$(__gitdir "${1-}")" track="${2-}"
+	local i hash dir="$(__gitdir "${1-}")" track="${2-}" repo
 	local format refs
+	# Try refs from a local repository directory (e.g. "../linux")
 	if [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
@@ -353,14 +354,15 @@ __git_refs ()
 			refs="refs/tags refs/heads refs/remotes"
 			;;
 		esac
-		git --git-dir="$dir" for-each-ref --format="%($format)" \
-			$refs
+		git "${__git_options[@]}" --git-dir="$dir" \
+			for-each-ref --format="%($format)" $refs
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			local ref entry
-			git --git-dir="$dir" for-each-ref --shell --format="ref=%(refname:short)" \
+			git "${__git_options[@]}" --git-dir="$dir" \
+				for-each-ref --shell --format="ref=%(refname:short)" \
 				"refs/remotes/" | \
 			while read -r entry; do
 				eval "$entry"
@@ -372,9 +374,11 @@ __git_refs ()
 		fi
 		return
 	fi
+	# Try refs from a remote repository by name (e.g. "origin") or a URL
+	repo="${1-}"
 	case "$cur" in
 	refs|refs/*)
-		git ls-remote "$dir" "$cur*" 2>/dev/null | \
+		git "${__git_options[@]}" ls-remote "$repo" "$cur*" 2>/dev/null | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -384,8 +388,8 @@ __git_refs ()
 		;;
 	*)
 		echo "HEAD"
-		git for-each-ref --format="%(refname:short)" -- \
-			"refs/remotes/$dir/" 2>/dev/null | sed -e "s#^$dir/##"
+		git "${__git_options[@]}" for-each-ref --format="%(refname:short)" -- \
+			"refs/remotes/$repo/" 2>/dev/null | sed -e "s#^$repo/##"
 		;;
 	esac
 }
@@ -403,7 +407,7 @@ __git_refs2 ()
 __git_refs_remotes ()
 {
 	local i hash
-	git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
+	git "${__git_options[@]}" ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
 	while read -r hash i; do
 		echo "$i:refs/remotes/$1/${i#refs/heads/}"
 	done
@@ -413,7 +417,7 @@ __git_remotes ()
 {
 	local d="$(__gitdir)"
 	test -d "$d/remotes" && ls -1 "$d/remotes"
-	git --git-dir="$d" remote
+	git "${__git_options[@]}" remote
 }
 
 __git_list_merge_strategies ()
@@ -467,7 +471,7 @@ __git_complete_revlist_file ()
 		*)   pfx="$ref:$pfx" ;;
 		esac
 
-		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" 2>/dev/null \
+		__gitcomp_nl "$(git "${__git_options[@]}" ls-tree "$ls" 2>/dev/null \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
@@ -744,7 +748,7 @@ __git_compute_porcelain_commands ()
 __git_get_config_variables ()
 {
 	local section="$1" i IFS=$'\n'
-	for i in $(git --git-dir="$(__gitdir)" config --name-only --get-regexp "^$section\..*" 2>/dev/null); do
+	for i in $(git "${__git_options[@]}" config --name-only --get-regexp "^$section\..*" 2>/dev/null); do
 		echo "${i#$section.}"
 	done
 }
@@ -762,7 +766,7 @@ __git_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local word cmdline=$(git --git-dir="$(__gitdir)" \
+	local word cmdline=$(git "${__git_options[@]}" \
 		config --get "alias.$1")
 	for word in $cmdline; do
 		case "$word" in
@@ -1133,7 +1137,7 @@ _git_commit ()
 		return
 	esac
 
-	if git rev-parse --verify --quiet HEAD >/dev/null; then
+	if git "${__git_options[@]}" rev-parse --verify --quiet HEAD >/dev/null; then
 		__git_complete_index_file "--committable"
 	else
 		# This is the first commit
@@ -1425,7 +1429,7 @@ _git_log ()
 {
 	__git_has_doubledash && return
 
-	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	local g="$(git "${__git_options[@]}" rev-parse --git-dir 2>/dev/null)"
 	local merge=""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge="--merge"
@@ -1776,7 +1780,7 @@ __git_config_get_set_variables ()
 		c=$((--c))
 	done
 
-	git --git-dir="$(__gitdir)" config $config_file --name-only --list 2>/dev/null
+	git "${__git_options[@]}" config $config_file --name-only --list 2>/dev/null
 }
 
 _git_config ()
@@ -1811,7 +1815,7 @@ _git_config ()
 	remote.*.push)
 		local remote="${prev#remote.}"
 		remote="${remote%.push}"
-		__gitcomp_nl "$(git --git-dir="$(__gitdir)" \
+		__gitcomp_nl "$(git "${__git_options[@]}" \
 			for-each-ref --format='%(refname):%(refname)' \
 			refs/heads)"
 		return
@@ -2389,7 +2393,7 @@ _git_stash ()
 		show,--*|drop,--*|branch,--*)
 			;;
 		show,*|apply,*|drop,*|pop,*|branch,*)
-			__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
+			__gitcomp_nl "$(git "${__git_options[@]}" stash list \
 					| sed -n -e 's/:.*//p')"
 			;;
 		*)
@@ -2562,7 +2566,7 @@ _git_whatchanged ()
 
 __git_main ()
 {
-	local i c=1 command command_word_index __git_dir
+	local i c=1 command command_word_index __git_dir __git_options
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
@@ -2578,6 +2582,10 @@ __git_main ()
 		((c++))
 	done
 
+	__git_options=(
+		--git-dir="$(__gitdir)"
+	)
+
 	if [ -z "$command" ]; then
 		case "$cur" in
 		--*)   __gitcomp "
-- 
2.6.1
