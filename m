From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH 3/3] completion: handle git -C option
Date: Wed, 28 Oct 2015 18:21:25 +0100
Message-ID: <1446052885-11173-4-git-send-email-peter@lekensteyn.nl>
References: <1446052885-11173-1-git-send-email-peter@lekensteyn.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 18:47:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrUpC-0001Xm-GF
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbbJ1Rrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:47:42 -0400
Received: from lekensteyn.nl ([178.21.112.251]:48608 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754946AbbJ1Rrl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
	h=References:In-Reply-To:Message-Id:Date:Subject:To:From; bh=pkz0nC7VtIBq3lpVCpF10vrxNVeGWxjn3stA+H8Sw9A=;
	b=Ac5VaHBIycis63yOFyfBQ7gG+bbcwOgHMhTPcyEDaXEv4RBgMOAOwEaHc1dFqLR5q9q1U8nQx+XJuyWq8h32O5eiLUPcwctmCn0y334W4bW5+Jq2QQG0WTiwAS/7/Qj22PgmkLTZg5c2bW503wQddBPoxlvkoOhbW62F0CNRJLB6TlKPT+V7HVqmupmCiB7TVoGd+qJAFbhQwwsFthSW2eV42f/Sr+muBkohEtrQ/62TKqvCHxXkXXY2gwm1WJk23hW8zfKZVYi/QQ7AqGM7JoSaK8laEBTNgd8ee6F1LFnjKF1E7z61luyefN5KyslkXIq4h7dx5dk9nLV+EDYXDQ==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.84)
	(envelope-from <peter@lekensteyn.nl>)
	id 1ZrUPn-00064K-1z; Wed, 28 Oct 2015 18:21:35 +0100
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446052885-11173-1-git-send-email-peter@lekensteyn.nl>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280382>

Avoid the "fatal: bad config file line 5 in config" message and properly
complete git commands having the "-C" option.

Besides the trivial command parsing, __gitdir is rewritten to apply any
directory changes requested via `git -C otherdir ...`.

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 contrib/completion/git-completion.bash | 45 +++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fdf0f16..1646f61 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -34,24 +34,39 @@ case "$COMP_WORDBREAKS" in
 esac
 
 # __gitdir accepts 0 or 1 arguments (i.e., location)
-# returns location of .git repo
+# outputs location of .git repo if it exists, nothing otherwise.
 __gitdir ()
 {
-	if [ -z "${1-}" ]; then
-		if [ -n "${__git_dir-}" ]; then
-			echo "$__git_dir"
-		elif [ -n "${GIT_DIR-}" ]; then
-			test -d "${GIT_DIR-}" || return 1
-			echo "$GIT_DIR"
-		elif [ -d .git ]; then
-			echo .git
+	local gitdir=${1:-}
+
+	if [ -z "$gitdir" ]; then
+		# Try the first matching --git-dir or GIT_DIR, print nothing if these
+		# directories are invalid.
+		for gitdir in "${__git_dir-}" "${GIT_DIR-}"; do
+			[ -n "$gitdir" ] || continue
+			if [[ "$gitdir" != /* ]]; then
+				gitdir="${__git_cd:-.}/$gitdir"
+			fi
+			if [ -d "$gitdir" ]; then
+				echo "$gitdir"
+			fi
+			return
+		done
+
+		if [ -d "${__git_cd:-.}/.git" ]; then
+			echo "${__git_cd:-.}/.git"
 		else
-			git rev-parse --git-dir 2>/dev/null
+			git -C "$__git_cd" rev-parse --git-dir 2>/dev/null
 		fi
-	elif [ -d "$1/.git" ]; then
-		echo "$1/.git"
 	else
-		echo "$1"
+		if [[ "$gitdir" != /* ]]; then
+			gitdir="${__git_cd:-.}/$gitdir"
+		fi
+		if [ -d "$gitdir/.git" ]; then
+			echo "$gitdir/.git"
+		elif [ -d "$gitdir" ]; then
+			echo "$gitdir"
+		fi
 	fi
 }
 
@@ -2566,11 +2581,12 @@ _git_whatchanged ()
 
 __git_main ()
 {
-	local i c=1 command command_word_index __git_dir __git_options
+	local i c=1 command command_word_index __git_dir __git_options __git_cd=.
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
+		-C)          ((c++)) ; __git_cd="${words[c]}" ;;
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--git-dir)   ((c++)) ; __git_dir="${words[c]}" ;;
 		--bare)      __git_dir="." ;;
@@ -2583,6 +2599,7 @@ __git_main ()
 	done
 
 	__git_options=(
+		-C "$__git_cd"
 		--git-dir="$(__gitdir)"
 	)
 
-- 
2.6.1
