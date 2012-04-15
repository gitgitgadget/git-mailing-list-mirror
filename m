From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 00:20:14 +0300
Message-ID: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 23:20:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJWsG-0004ps-Il
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 23:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab2DOVUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 17:20:39 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65295 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab2DOVUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 17:20:39 -0400
Received: by lbom4 with SMTP id m4so8941lbo.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 14:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=X+5mlgo5A9dxo2lTO12Ha0+9ZSUJZuCFQwbT42Qj2gs=;
        b=DBGGCyMegQfN9Z91Ik+DtNFoP5Ccc4hUX6TuduUNEgN/8r13o1C2VSaFFGgmCeA3yd
         6VtmPLHhTVcih+y1rj+8Ds0MMV2ZPg1N99us7yBX8zLsb/MK/CkD4n80Atg0kSbbeufZ
         qRs977peRTTuowh6GaXIo/CiNKX9anl2gC4rm9oQEgFALwpXIVXNaRTVK1j1huBS1LeE
         uJ3EJMh+cP/22R2z6s+zUc8UY3HKRkIwyBo8isB/3ExyeolXsVo6B1HMmmYNZYVMeq2D
         6+IXW0I8p1UnYyhRFowdzhi2sUBmD7C09dheYhny3ZxDSHjC8/Qj7g1edxuaWjcH11ow
         AmZw==
Received: by 10.112.86.229 with SMTP id s5mr4122460lbz.0.1334524837658;
        Sun, 15 Apr 2012 14:20:37 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id p2sm21836494lbj.0.2012.04.15.14.20.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 14:20:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195590>

This simplifies the completions, and makes it easier to define aliases:

 git_complete gf git_fetch

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Since v2:

 * Remove stuff related to aliases fixes; should work on top of master

 contrib/completion/git-completion.bash |   68 +++++++++++++++-----------------
 t/t9902-completion.sh                  |    2 +-
 2 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714d..abb4ccb 100755
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
@@ -2663,22 +2648,6 @@ _git ()
 
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
@@ -2699,16 +2668,41 @@ _gitk ()
 	__git_complete_revlist
 }
 
-complete -o bashdefault -o default -o nospace -F _git git 2>/dev/null \
-	|| complete -o default -o nospace -F _git git
-complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/null \
-	|| complete -o default -o nospace -F _gitk gitk
+foo_wrap ()
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
+	foo "$@"
+}
+
+git_complete ()
+{
+	local name="${2-$1}"
+	eval "$(typeset -f foo_wrap | sed -e "s/foo/_$name/")"
+	complete -o bashdefault -o default -o nospace -F _${name}_wrap $1 2>/dev/null \
+		|| complete -o default -o nospace -F _${name}_wrap $1
+}
+
+git_complete git
+git_complete gitk
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
-	|| complete -o default -o nospace -F _git git.exe
+git_complete git.exe git
 fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7bd37f5..0f1a9ec 100755
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
