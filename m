From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v4 1/6] completion: add new __git_complete helper
Date: Mon,  7 May 2012 03:23:15 +0200
Message-ID: <1336353800-17323-2-git-send-email-felipe.contreras@gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 03:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRCfs-0004IR-JR
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 03:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab2EGBXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 21:23:31 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32775 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189Ab2EGBXa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 21:23:30 -0400
Received: by wibhj6 with SMTP id hj6so2959089wib.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=54+SkDz/xqAfWcl1fhtABEXOwaGIbE+yvNg5vKlxjsE=;
        b=X293Ip4e0lcllfmICTKeFv7BO48SlnykahPmHqNRox3sM14eVTPwhc7bscsVbQy8vy
         sSypPntbsWge1TEr1MOoh4EnvvWeT5cQabzX0h6JiuLwgGRPEGdAe6SCwyF3B45qoJQZ
         IRb7uNV2bCUEzwpruZWG2sj0HfJR+Oifp47sy3EJdTW+NUXOCQNobIbRgpC6UY8A5g/N
         zAk6YvsFCfSVI4ILZO58EiG8+mAXH4/ZjuYn53TvrfSPWH0p90WFokev7GJxF1jWsIBP
         TErwHeMlLypn1OVId82trkckV6NwNgAs+Taacdqtg7ki4LWBUIUrv411qZPpBGHpBrg0
         RZ8w==
Received: by 10.180.94.7 with SMTP id cy7mr9198703wib.3.1336353809077;
        Sun, 06 May 2012 18:23:29 -0700 (PDT)
Received: from localhost (ip-109-43-0-55.web.vodafone.de. [109.43.0.55])
        by mx.google.com with ESMTPS id ff2sm28304513wib.9.2012.05.06.18.23.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 18:23:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197227>

This simplifies the completions, and would make it easier to define
aliases in the future.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
Since v3:

 * Get rid of typeset and subshell

Since v2:

 * Rename to _GIT_complete to follow bash completion "guidelines"
 * Get rid of foo_wrap name

Since v1:

 * Remove stuff related to aliases fixes; should work on top of master

 contrib/completion/git-completion.bash |   69 +++++++++++++++-----------------
 t/t9902-completion.sh                  |    2 +-
 2 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f56ec7..4098902 100755
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
@@ -2703,16 +2672,42 @@ _gitk ()
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
+	_$1
+}
+
+# this is NOT a public function; use at your own risk
+__git_complete ()
+{
+	local name="${2-$1}"
+	local wrapper="_${name}_wrap"
+	eval "$wrapper () { __git_func_wrap $name ; }"
+	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
+		|| complete -o default -o nospace -F $wrapper $1
+}
+
+__git_complete git
+__git_complete gitk
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
-	|| complete -o default -o nospace -F _git git.exe
+__git_complete git.exe git
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
