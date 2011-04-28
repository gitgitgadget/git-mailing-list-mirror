From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/3] bash: don't modify the $cur variable in completion
	functions
Date: Thu, 28 Apr 2011 18:01:51 +0200
Message-ID: <1304006513-19392-1-git-send-email-szeder@ira.uka.de>
References: <20110428160115.GA19003@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, Stefan Haller <lists@haller-berlin.de>,
	Mark Lodato <lodatom@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFTfU-0007a5-6u
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760662Ab1D1QCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 12:02:09 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:20333 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715Ab1D1QCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 12:02:08 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 28 Apr
 2011 18:02:02 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 28 Apr
 2011 18:02:05 +0200
X-Mailer: git-send-email 1.7.5.86.g799a6
In-Reply-To: <20110428160115.GA19003@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172370>

Since v1.7.4-rc0~11^2~2 (bash: get --pretty=3Dm<tab> completion to work
with bash v4, 2010-12-02) we use _get_comp_words_by_ref() to access
completion-related variables, and the $cur variable holds the word
containing the current cursor position in all completion functions.
This $cur variable is left unchanged in most completion functions;
there are only four functions modifying its value, namely __gitcomp(),
__git_complete_revlist_file(), __git_complete_remote_or_refspec(), and
_git_config().

If this variable were never modified, then it would allow us a nice
optimisation and cleanup.  Therefore, this patch assigns $cur to an
other local variable and uses that for later modifications in those
four functions.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |  107 +++++++++++++++---------=
--------
 1 files changed, 50 insertions(+), 57 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 840ae38..a594b40 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -491,10 +491,12 @@ __gitcomp ()
 {
 	local cur
 	_get_comp_words_by_ref -n =3D: cur
+	local cur_=3D"$cur"
+
 	if [ $# -gt 2 ]; then
-		cur=3D"$3"
+		cur_=3D"$3"
 	fi
-	case "$cur" in
+	case "$cur_" in
 	--*=3D)
 		COMPREPLY=3D()
 		;;
@@ -502,7 +504,7 @@ __gitcomp ()
 		local IFS=3D$'\n'
 		COMPREPLY=3D($(compgen -P "${2-}" \
 			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
-			-- "$cur"))
+			-- "$cur_"))
 		;;
 	esac
 }
@@ -668,17 +670,18 @@ __git_complete_revlist_file ()
 {
 	local pfx ls ref cur
 	_get_comp_words_by_ref -n =3D: cur
-	case "$cur" in
+	local cur_=3D"$cur"
+	case "$cur_" in
 	*..?*:*)
 		return
 		;;
 	?*:*)
-		ref=3D"${cur%%:*}"
-		cur=3D"${cur#*:}"
-		case "$cur" in
+		ref=3D"${cur_%%:*}"
+		cur_=3D"${cur_#*:}"
+		case "$cur_" in
 		?*/*)
-			pfx=3D"${cur%/*}"
-			cur=3D"${cur##*/}"
+			pfx=3D"${cur_%/*}"
+			cur_=3D"${cur_##*/}"
 			ls=3D"$ref:$pfx"
 			pfx=3D"$pfx/"
 			;;
@@ -708,17 +711,17 @@ __git_complete_revlist_file ()
 				           s,$,/,
 				       }
 				       s/^.*	//')" \
-			-- "$cur"))
+			-- "$cur_"))
 		;;
 	*...*)
-		pfx=3D"${cur%...*}..."
-		cur=3D"${cur#*...}"
-		__gitcomp "$(__git_refs)" "$pfx" "$cur"
+		pfx=3D"${cur_%...*}..."
+		cur_=3D"${cur_#*...}"
+		__gitcomp "$(__git_refs)" "$pfx" "$cur_"
 		;;
 	*..*)
-		pfx=3D"${cur%..*}.."
-		cur=3D"${cur#*..}"
-		__gitcomp "$(__git_refs)" "$pfx" "$cur"
+		pfx=3D"${cur_%..*}.."
+		cur_=3D"${cur_#*..}"
+		__gitcomp "$(__git_refs)" "$pfx" "$cur_"
 		;;
 	*)
 		__gitcomp "$(__git_refs)"
@@ -741,7 +744,7 @@ __git_complete_remote_or_refspec ()
 {
 	local cur words cword
 	_get_comp_words_by_ref -n =3D: cur words cword
-	local cmd=3D"${words[1]}"
+	local cur_=3D"$cur" cmd=3D"${words[1]}"
 	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
@@ -771,40 +774,40 @@ __git_complete_remote_or_refspec ()
 		return
 	fi
 	[ "$remote" =3D "." ] && remote=3D
-	case "$cur" in
+	case "$cur_" in
 	*:*)
 		case "$COMP_WORDBREAKS" in
 		*:*) : great ;;
-		*)   pfx=3D"${cur%%:*}:" ;;
+		*)   pfx=3D"${cur_%%:*}:" ;;
 		esac
-		cur=3D"${cur#*:}"
+		cur_=3D"${cur_#*:}"
 		lhs=3D0
 		;;
 	+*)
 		pfx=3D"+"
-		cur=3D"${cur#+}"
+		cur_=3D"${cur_#+}"
 		;;
 	esac
 	case "$cmd" in
 	fetch)
 		if [ $lhs =3D 1 ]; then
-			__gitcomp "$(__git_refs2 "$remote")" "$pfx" "$cur"
+			__gitcomp "$(__git_refs2 "$remote")" "$pfx" "$cur_"
 		else
-			__gitcomp "$(__git_refs)" "$pfx" "$cur"
+			__gitcomp "$(__git_refs)" "$pfx" "$cur_"
 		fi
 		;;
 	pull)
 		if [ $lhs =3D 1 ]; then
-			__gitcomp "$(__git_refs "$remote")" "$pfx" "$cur"
+			__gitcomp "$(__git_refs "$remote")" "$pfx" "$cur_"
 		else
-			__gitcomp "$(__git_refs)" "$pfx" "$cur"
+			__gitcomp "$(__git_refs)" "$pfx" "$cur_"
 		fi
 		;;
 	push)
 		if [ $lhs =3D 1 ]; then
-			__gitcomp "$(__git_refs)" "$pfx" "$cur"
+			__gitcomp "$(__git_refs)" "$pfx" "$cur_"
 		else
-			__gitcomp "$(__git_refs "$remote")" "$pfx" "$cur"
+			__gitcomp "$(__git_refs "$remote")" "$pfx" "$cur_"
 		fi
 		;;
 	esac
@@ -2012,70 +2015,60 @@ _git_config ()
 		return
 		;;
 	branch.*.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur##*.}"
-		__gitcomp "remote merge mergeoptions rebase" "$pfx" "$cur"
+		local pfx=3D"${cur%.*}." cur_=3D"${cur##*.}"
+		__gitcomp "remote merge mergeoptions rebase" "$pfx" "$cur_"
 		return
 		;;
 	branch.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur#*.}"
-		__gitcomp "$(__git_heads)" "$pfx" "$cur" "."
+		local pfx=3D"${cur%.*}." cur_=3D"${cur#*.}"
+		__gitcomp "$(__git_heads)" "$pfx" "$cur_" "."
 		return
 		;;
 	guitool.*.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur##*.}"
+		local pfx=3D"${cur%.*}." cur_=3D"${cur##*.}"
 		__gitcomp "
 			argprompt cmd confirm needsfile noconsole norescan
 			prompt revprompt revunmerged title
-			" "$pfx" "$cur"
+			" "$pfx" "$cur_"
 		return
 		;;
 	difftool.*.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur##*.}"
-		__gitcomp "cmd path" "$pfx" "$cur"
+		local pfx=3D"${cur%.*}." cur_=3D"${cur##*.}"
+		__gitcomp "cmd path" "$pfx" "$cur_"
 		return
 		;;
 	man.*.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur##*.}"
-		__gitcomp "cmd path" "$pfx" "$cur"
+		local pfx=3D"${cur%.*}." cur_=3D"${cur##*.}"
+		__gitcomp "cmd path" "$pfx" "$cur_"
 		return
 		;;
 	mergetool.*.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur##*.}"
-		__gitcomp "cmd path trustExitCode" "$pfx" "$cur"
+		local pfx=3D"${cur%.*}." cur_=3D"${cur##*.}"
+		__gitcomp "cmd path trustExitCode" "$pfx" "$cur_"
 		return
 		;;
 	pager.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur#*.}"
+		local pfx=3D"${cur%.*}." cur_=3D"${cur#*.}"
 		__git_compute_all_commands
-		__gitcomp "$__git_all_commands" "$pfx" "$cur"
+		__gitcomp "$__git_all_commands" "$pfx" "$cur_"
 		return
 		;;
 	remote.*.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur##*.}"
+		local pfx=3D"${cur%.*}." cur_=3D"${cur##*.}"
 		__gitcomp "
 			url proxy fetch push mirror skipDefaultUpdate
 			receivepack uploadpack tagopt pushurl
-			" "$pfx" "$cur"
+			" "$pfx" "$cur_"
 		return
 		;;
 	remote.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur#*.}"
-		__gitcomp "$(__git_remotes)" "$pfx" "$cur" "."
+		local pfx=3D"${cur%.*}." cur_=3D"${cur#*.}"
+		__gitcomp "$(__git_remotes)" "$pfx" "$cur_" "."
 		return
 		;;
 	url.*.*)
-		local pfx=3D"${cur%.*}."
-		cur=3D"${cur##*.}"
-		__gitcomp "insteadOf pushInsteadOf" "$pfx" "$cur"
+		local pfx=3D"${cur%.*}." cur_=3D"${cur##*.}"
+		__gitcomp "insteadOf pushInsteadOf" "$pfx" "$cur_"
 		return
 		;;
 	esac
--=20
1.7.5.86.g799a6
