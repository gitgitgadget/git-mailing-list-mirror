From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 2/2] completion: start moving to the new zsh completion
Date: Sun, 18 Nov 2012 12:08:09 +0100
Message-ID: <1353236889-15052-3-git-send-email-felipe.contreras@gmail.com>
References: <1353236889-15052-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Khouzam <marc.khouzam@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 12:08:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2k7-0006Du-W3
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 12:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab2KRLIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 06:08:38 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63037 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2KRLIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 06:08:37 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1601033bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 03:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7gFNi7mxVv8WEREf8zi1TRCTbGwXFHWdK2he3Xyccso=;
        b=08vTURQHkzgycFnAWYcxwmH8IL2qXkSASbai0nph4ncOWysXoCuwQiASV+jSXUq4rS
         suJWXauB503K7ujYvmw5d+gG3Ul7kQtAfrQZe72kysO1shBvKCkVfUpmmcZAwa594kmN
         xBpHk43OIn316i/xITeg5r/8x7JfRAMx44R+d2FNz09Qh0F2s1JTGSrZZOhfa3uBU08b
         yVG+R9Xbn1knMkpY1wVlY7sqiCvkNaWIcPcfNxTaLN6B4cELvP0kfrdE2M3qukSJ8+ap
         QefhxPOAqdbJ5eqvApeV5+ycUbRtt9g5FSz372ThJ8ROwpuefHlyJmfCkwmFRlL7gfrR
         O0DA==
Received: by 10.204.148.22 with SMTP id n22mr3869377bkv.6.1353236916822;
        Sun, 18 Nov 2012 03:08:36 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id t11sm2876758bkv.11.2012.11.18.03.08.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 03:08:36 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236889-15052-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210024>

Zsh's bash completion emulation is buggy, not properly maintained, and
we have some workarounds in place for different bugs that appeared in
various versions.

Since I'm the only one that has worked on that code lately[1], it might make
snese to use the code I wrote specifically for git.

The advantages are:

 1) Less workarounds

   * No need to hack __get_comp_words_by_ref
   * No need to hack IFS or words

 2) Improved features

   * 'git show master' now properly adds a space at the end (IFS bug)
   * 'git checkout --conflict=' now properly returns the sub-items
     (missing feature)

 3) Consolidated code

   * It's all now in a single chunk, and it's basically the same as
     git-completion.zsh

Since there's some interest in moving the zsh-specific code out of this
script, lets go ahead and warn the users that they should be using
git-completion.zsh.

[1] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=history;f=Completion/bashcompinit

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 104 +++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 43 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bc0657a..9cd58ca 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -23,10 +23,6 @@
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
 
-if [[ -n ${ZSH_VERSION-} ]]; then
-	autoload -U +X bashcompinit && bashcompinit
-fi
-
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
@@ -169,7 +165,6 @@ __git_reassemble_comp_words_by_ref()
 }
 
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
-if [[ -z ${ZSH_VERSION:+set} ]]; then
 _get_comp_words_by_ref ()
 {
 	local exclude cur_ words_ cword_
@@ -197,32 +192,6 @@ _get_comp_words_by_ref ()
 		shift
 	done
 }
-else
-_get_comp_words_by_ref ()
-{
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=${COMP_WORDS[COMP_CWORD]}
-			;;
-		prev)
-			prev=${COMP_WORDS[COMP_CWORD-1]}
-			;;
-		words)
-			words=("${COMP_WORDS[@]}")
-			;;
-		cword)
-			cword=$COMP_CWORD
-			;;
-		-n)
-			# assume COMP_WORDBREAKS is already set sanely
-			shift
-			;;
-		esac
-		shift
-	done
-}
-fi
 fi
 
 # Generates completion reply with compgen, appending a space to possible
@@ -2430,20 +2399,69 @@ __gitk_main ()
 	__git_complete_revlist
 }
 
-__git_func_wrap ()
-{
-	if [[ -n ${ZSH_VERSION-} ]]; then
-		emulate -L bash
-		setopt KSH_TYPESET
+if [[ -n ${ZSH_VERSION-} ]]; then
+	echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
 
-		# workaround zsh's bug that leaves 'words' as a special
-		# variable in versions < 4.3.12
-		typeset -h words
+	__gitcomp ()
+	{
+		emulate -L zsh
 
-		# workaround zsh's bug that quotes spaces in the COMPREPLY
-		# array if IFS doesn't contain spaces.
-		typeset -h IFS
-	fi
+		local cur_="${3-$cur}"
+
+		case "$cur_" in
+		--*=)
+			;;
+		*)
+			local c IFS=$' \t\n'
+			local -a array
+			for c in ${=1}; do
+				c="$c${4-}"
+				case $c in
+				--*=*|*.) ;;
+				*) c="$c " ;;
+				esac
+				array+=("$c")
+			done
+			compset -P '*[=:]'
+			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
+			;;
+		esac
+	}
+
+	__gitcomp_nl ()
+	{
+		emulate -L zsh
+
+		local IFS=$'\n'
+		compset -P '*[=:]'
+		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	}
+
+	__git_zsh_helper ()
+	{
+		emulate -L ksh
+		local cur cword prev
+		cur=${words[CURRENT-1]}
+		prev=${words[CURRENT-2]}
+		let cword=CURRENT-1
+		__${service}_main
+	}
+
+	_git ()
+	{
+		emulate -L zsh
+		local _ret=1
+		__git_zsh_helper
+		let _ret && _default -S '' && _ret=0
+		return _ret
+	}
+
+	compdef _git git gitk
+	return
+fi
+
+__git_func_wrap ()
+{
 	local cur words cword prev
 	_get_comp_words_by_ref -n =: cur words cword prev
 	$1
-- 
1.8.0
