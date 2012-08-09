From: Jerome Reybert <jreybert@gmail.com>
Subject: [PATCH] git bash completion handles alias options
Date: Thu,  9 Aug 2012 22:52:24 +0200
Message-ID: <1344545544-8538-2-git-send-email-jreybert@gmail.com>
References: <1344545544-8538-1-git-send-email-jreybert@gmail.com>
Cc: Jerome Reybert <jreybert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 22:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzZis-00054y-VZ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 22:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab2HIUwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 16:52:45 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39826 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab2HIUwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 16:52:44 -0400
Received: by wibhm11 with SMTP id hm11so721113wib.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XvJWaws6bOaooLLl9TnqdW5AlqRVg/PtngnqQr4Fpn0=;
        b=gDHdzIF+ueZ8Roq0p9kddkH45h16fiQM0IKv09OMHkU1GKawpwQ7mJrGRBvMwXQXL2
         y6mqwyIicEFGzGHPt0sgKMwECCd7JhmGOCe0Vu3bMJaKW19dU0gqn9zZRJo6QftFIjko
         LkUGbM5fJ/5R5jP8rbF/b60OJGnQ7SgtT3bSqDaglIAp9SHgKnEXvWEMyLbpzZkbDTrD
         O5HnOxj1/J5aSw1l9xUfZFjMxZWOP2tXVGXfINRpuolW55s08eoduPTE9k/IMj9waW0F
         /hAkaRdZV13sXbqNCsY6+va15h0XOJ7bDVFwZMOuK/EkijdhVz4z8Hu1JjkVMMVNV4DP
         iXyQ==
Received: by 10.180.82.39 with SMTP id f7mr1477015wiy.2.1344545563365;
        Thu, 09 Aug 2012 13:52:43 -0700 (PDT)
Received: from dionysos.lin.mbt.kalray.eu (mailhost.kalray.eu. [217.108.237.233])
        by mx.google.com with ESMTPS id l6sm3748100wiz.4.2012.08.09.13.52.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 13:52:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.91.gf4edd99
In-Reply-To: <1344545544-8538-1-git-send-email-jreybert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203182>

git bash completion now handles git alias options. It means that options
which change the completion behavior for complete commands will also
change the behavior of completion for aliased command.

bash completion now handle git alias options. I did a use case in another
commit: a checkout alias which only complete local branches, ie. only
'refs' ones, not 'remotes'. With this new alias completion, I added an
option to do that in checkout command and hacked _git_checkout complete
function.

This is a draft version, bash usage should be improved. To achieve this:
 * a global array $alias_words is filled. As it is global and this file
   sourced, this variable can be seen from the terminal
 * __git_aliased_command fills $alias_words
 * __git_aliased_command must be called differently (not in a subshell)
   to fill the global variable. The return value $expansion is
   passed by reference as a parameter
 * __git_find_on_cmdline now search in $words and $alias_words

Signed-off-by: Jerome Reybert <jreybert@gmail.com>
---
 contrib/completion/git-completion.bash | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ffedce7..dfceda0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -23,6 +23,9 @@
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
 
+alias_words=()
+alias_cword=0
+
 if [[ -n ${ZSH_VERSION-} ]]; then
 	autoload -U +X bashcompinit && bashcompinit
 fi
@@ -708,19 +711,22 @@ __git_aliased_command ()
 {
 	local word cmdline=$(git --git-dir="$(__gitdir)" \
 		config --get "alias.$1")
+
 	for word in $cmdline; do
 		case "$word" in
 		\!gitk|gitk)
-			echo "gitk"
+			eval "$2='gitk'"
 			return
 			;;
 		\!*)	: shell command alias ;;
-		-*)	: option ;;
+		-*)	: option
+			alias_words=("${alias_words[@]}" "$word")
+			((alias_cword++))
+			;;
 		*=*)	: setting env ;;
 		git)	: git itself ;;
 		*)
-			echo "$word"
-			return
+			eval "$2='$word'"
 		esac
 	done
 }
@@ -739,6 +745,17 @@ __git_find_on_cmdline ()
 		done
 		((c++))
 	done
+	c=0
+	while [ $c -lt $alias_cword ]; do
+		word="${alias_words[c]}"
+		for subcommand in $1; do
+			if [ "$subcommand" = "$word" ]; then
+				echo "$subcommand"
+				return
+			fi
+		done
+		((c++))
+	done
 }
 
 __git_has_doubledash ()
@@ -2353,6 +2370,8 @@ _git_whatchanged ()
 
 __git_main ()
 {
+	alias_words=()
+	alias_cword=0
 	local i c=1 command __git_dir
 
 	while [ $c -lt $cword ]; do
@@ -2394,8 +2413,8 @@ __git_main ()
 
 	local completion_func="_git_${command//-/_}"
 	declare -f $completion_func >/dev/null && $completion_func && return
-
-	local expansion=$(__git_aliased_command "$command")
+	local expansion=''
+	__git_aliased_command $command expansion
 	if [ -n "$expansion" ]; then
 		completion_func="_git_${expansion//-/_}"
 		declare -f $completion_func >/dev/null && $completion_func
-- 
1.7.12.rc0.91.gf4edd99
