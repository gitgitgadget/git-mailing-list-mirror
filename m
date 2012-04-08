From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/12] completion: add new git_complete helper
Date: Sun,  8 Apr 2012 06:07:57 +0300
Message-ID: <1333854479-23260-11-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiV7-0007HT-O7
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab2DHDI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:57 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53218 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754308Ab2DHDIi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 23:08:38 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so2813271lah.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zwGILsBpg36i2TL4hh4b6jyyx2AOX6jd+ZMS5JQYELo=;
        b=gbgh4pkhqKc8UBA+Cyfe0IOr/cm5/F7qj5xa3fNGWXRgbjhiiR0IRe6QHoemsUQ2b9
         lQJi8ft/T48AR7LPug3OiHn8jl/rK+4q+/PkzgSysrVx7Z1v7cFtSzfwYyF0g8SF8zy1
         C7i41kug9KNEGtkQWH0Y1PNJKWoqmmO4B//iLkV8a1KekkDboDmENwT2wh1naqQMiJ2L
         brLAOeDVJjG9lnWLEFQauTJQTze01Aqp1uTRM2w/zh2RtEyNn9AWD+xCBgzMsTGqNh08
         9g3sMh0SXfsK85ME4Z4GhrngUwyCqQzDLfZpNv+KO1rs5vbnneXdQopx7ic4vqbBc55V
         iTzA==
Received: by 10.152.127.163 with SMTP id nh3mr4757726lab.15.1333854517752;
        Sat, 07 Apr 2012 20:08:37 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id nq2sm11394093lab.6.2012.04.07.20.08.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194960>

This simplifies the completions, and makes it easier to define aliases:

 git_complete gf git_fetch

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   69 +++++++++++++++-----------------
 t/t9902-completion.sh                  |    2 +-
 2 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 60ea224..6cf1d98 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2616,21 +2616,6 @@ _git ()
 {
 	local i c=1 cmd cmd_pos __git_dir
 
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
@@ -2683,22 +2668,6 @@ _git ()
 
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
@@ -2719,16 +2688,42 @@ _gitk ()
 	__git_complete_revlist
 }
 
-complete -o bashdefault -o default -o nospace -F _git git 2>/dev/null \
-	|| complete -o default -o nospace -F _git git
-complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/null \
-	|| complete -o default -o nospace -F _gitk gitk
+foo_wrap ()
+{
+	local cmd=foo_cmd cmd_pos=1
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
+	local cmd="${name#git_}"
+	eval "$(typeset -f foo_wrap | sed -e "s/foo_cmd/$cmd/" -e "s/foo/_$name/")"
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
index b99fb88..7b87f4c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -58,7 +58,7 @@ test_completion ()
 	_words=( $1 )
 	test $# -gt 1 && echo "$2" > expected
 	(( _cword = ${#_words[@]} - 1 ))
-	_git && print_comp &&
+	_git_wrap && print_comp &&
 	test_cmp expected out
 }
 
-- 
1.7.10.3.g5a738d
