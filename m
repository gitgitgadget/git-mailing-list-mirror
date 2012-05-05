From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3] completion: add new _GIT_complete helper
Date: Sat,  5 May 2012 17:23:20 +0200
Message-ID: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 17:24:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQgq6-0001mD-AU
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 17:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab2EEPYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 11:24:00 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60753 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937Ab2EEPX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 11:23:59 -0400
Received: by wibhj6 with SMTP id hj6so2195690wib.1
        for <git@vger.kernel.org>; Sat, 05 May 2012 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=zLx6PAXV2AED2dOg+cOAMdu8CVu5ka+acFp2vB+oTqc=;
        b=BcGVmwVTwtThC5bhyI7UMVVQrb2AYLrYnBo/0XFZfvo5e6ySKflqjgRn+cHs/xU5eS
         cOA/Rm6VUXbbuG+xIegEcfTJR3b/PPtF96CFLO7wY5Fgf6k95TJi/loH6Z9LIHs1NWqV
         LEJ8Tq3HmvnxbSpourTZypNosKkChgyJC5zrA5B7ReamnLZfeXd2YhzTqTFPtSYhHKJ9
         0BIMaw4ZCdxKSHZQKUEBrWESDewO4gIcMUCrw15Fd07DQ9X5+/JE/4P3fayY7NdJFoev
         pImWp3DEf4P0bD/SCrceqOqymSEBysIRZztnfg91ChiClz355PYoHSSySbvWCDBJoK9R
         IRZQ==
Received: by 10.216.134.145 with SMTP id s17mr6427353wei.22.1336231438820;
        Sat, 05 May 2012 08:23:58 -0700 (PDT)
Received: from localhost (ip-109-43-0-5.web.vodafone.de. [109.43.0.5])
        by mx.google.com with ESMTPS id ff9sm6494550wib.2.2012.05.05.08.23.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 08:23:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197118>

This simplifies the completions, and makes it easier to define aliases:

 _GIT_complete gf git_fetch

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Since v3:

 * Rename to _GIT_complete to follow bash completion "guidelines"
 * Get rid of foo_wrap name

Since v2:

 * Remove stuff related to aliases fixes; should work on top of master

 contrib/completion/git-completion.bash |   67 ++++++++++++++------------------
 t/t9902-completion.sh                  |    2 +-
 2 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f56ec7..f300b87 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2603,21 +2603,6 @@ _git ()
 {
 	local i c=1 command __git_dir
 
-	if [[ -n ${ZSH_VERSION-} ]]; then
-		emulate -L bash
-		setopt KSH_TYPESET
-
-		# workaround zsh's bug that leaves 'words' as a special
-		# variable in versions < 4.3.12
-		typeset -h words
-
-		# workaround zsh's bug that quotes spaces in the COMPREPLY
-		# array if IFS doesn't contain spaces.
-		typeset -h IFS
-	fi
-
-	local cur words cword prev
-	_get_comp_words_by_ref -n =: cur words cword prev
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
@@ -2667,22 +2652,6 @@ _git ()
 
 _gitk ()
 {
-	if [[ -n ${ZSH_VERSION-} ]]; then
-		emulate -L bash
-		setopt KSH_TYPESET
-
-		# workaround zsh's bug that leaves 'words' as a special
-		# variable in versions < 4.3.12
-		typeset -h words
-
-		# workaround zsh's bug that quotes spaces in the COMPREPLY
-		# array if IFS doesn't contain spaces.
-		typeset -h IFS
-	fi
-
-	local cur words cword prev
-	_get_comp_words_by_ref -n =: cur words cword prev
-
 	__git_has_doubledash && return
 
 	local g="$(__gitdir)"
@@ -2703,16 +2672,40 @@ _gitk ()
 	__git_complete_revlist
 }
 
-complete -o bashdefault -o default -o nospace -F _git git 2>/dev/null \
-	|| complete -o default -o nospace -F _git git
-complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/null \
-	|| complete -o default -o nospace -F _gitk gitk
+__git_func_wrap ()
+{
+	if [[ -n ${ZSH_VERSION-} ]]; then
+		emulate -L bash
+		setopt KSH_TYPESET
+
+		# workaround zsh's bug that leaves 'words' as a special
+		# variable in versions < 4.3.12
+		typeset -h words
+
+		# workaround zsh's bug that quotes spaces in the COMPREPLY
+		# array if IFS doesn't contain spaces.
+		typeset -h IFS
+	fi
+	local cur words cword prev
+	_get_comp_words_by_ref -n =: cur words cword prev
+	__git_func "$@"
+}
+
+_GIT_complete ()
+{
+	local name="${2-$1}"
+	eval "$(typeset -f __git_func_wrap | sed -e "s/__git_func/_$name/")"
+	complete -o bashdefault -o default -o nospace -F _${name}_wrap $1 2>/dev/null \
+		|| complete -o default -o nospace -F _${name}_wrap $1
+}
+
+_GIT_complete git
+_GIT_complete gitk
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
-	|| complete -o default -o nospace -F _git git.exe
+_GIT_complete git.exe git
 fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5bda6b6..331a5b9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -63,7 +63,7 @@ run_completion ()
 	local _cword
 	_words=( $1 )
 	(( _cword = ${#_words[@]} - 1 ))
-	_git && print_comp
+	_git_wrap && print_comp
 }
 
 test_completion ()
-- 
1.7.10
