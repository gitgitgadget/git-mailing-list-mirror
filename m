From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5] completion: add new __git_complete helper
Date: Mon, 14 May 2012 17:35:18 +0200
Message-ID: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 16:35:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STwN2-0007Lc-LU
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 16:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab2ENOf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 10:35:27 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47126 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab2ENOf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 10:35:27 -0400
Received: by wibhn6 with SMTP id hn6so2524383wib.1
        for <git@vger.kernel.org>; Mon, 14 May 2012 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=eJuM+dTOt0cuvnJyQ95ULF7eAc9fdocMhs4t1MuJsWg=;
        b=bvelSi0MhCWpYoy1FcctT/Y8yn0QAQHdQQvk0ND/MAqS/jSiCrUpiPC+ofx2f6uzJY
         ZXt8XqyMJOGQbIoIdOUN8UZwGlQkZQT6Oi117HYF2K1uhhTH2cwvG52fOBmcS0g5E2FI
         wOkljSSJsQteObP7B38heJybFZiZwsY2EN42/uO9exzx020Tdct44bKP5dQLdet6IfL5
         AZwdJh1dwh85tjLm6zHiTLs2LXUGqUXfw3ds/elmxkGY7irjIKGJ7UGmgLSqWEfPkPad
         yacFxU0jzlmERnhF7gPskn7yodiZ82vZA7Ir9HLSW46v5kLOUI8UfqRw62vklSp1lCR6
         +oPQ==
Received: by 10.216.150.225 with SMTP id z75mr5362916wej.77.1337006125830;
        Mon, 14 May 2012 07:35:25 -0700 (PDT)
Received: from localhost ([192.100.124.156])
        by mx.google.com with ESMTPS id h8sm55562869wix.4.2012.05.14.07.35.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 07:35:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197771>

This simplifies the completions, and would make it easier to define
aliases in the future.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   70 +++++++++++++++-----------------
 t/t9902-completion.sh                  |    2 +-
 2 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f56ec7..d60bb8a 100755
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
@@ -2703,16 +2672,43 @@ _gitk ()
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
+	$1
+}
+
+# Setup completion for certain functions defined above by setting common
+# variables and workarounds.
+# This is NOT a public function; use at your own risk.
+__git_complete ()
+{
+	local wrapper="__git_wrap${2}"
+	eval "$wrapper () { __git_func_wrap $2 ; }"
+	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
+		|| complete -o default -o nospace -F $wrapper $1
+}
+
+__git_complete git _git
+__git_complete gitk _gitk
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
-	|| complete -o default -o nospace -F _git git.exe
+__git_complete git.exe _git
 fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5bda6b6..0f09fd6 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -63,7 +63,7 @@ run_completion ()
 	local _cword
 	_words=( $1 )
 	(( _cword = ${#_words[@]} - 1 ))
-	_git && print_comp
+	__git_wrap_git && print_comp
 }
 
 test_completion ()
-- 
1.7.10.1
