From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 18/21] completion: consolidate silencing errors from git commands
Date: Thu, 25 Feb 2016 23:50:47 +0100
Message-ID: <1456440650-32623-19-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:54:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4nW-0007AT-Ew
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbcBYWyK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:54:10 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35873 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWyJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:54:09 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4nM-0007uU-Fe; Thu, 25 Feb 2016 23:54:05 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440845.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287467>

Outputting error messages during completion is bad: they disrupt the
command line, can't be deleted, and the user is forced to Ctrl-C and
start over most of the time.  We already silence stderr of many git
commands in our Bash completion script, but there are still some in
there that can spew error messages when something goes wrong.

We could add the missing stderr redirections to all the remaining
places, but instead let's leverage that git commands are now executed
through the previously introduced __git() wrapper function, and
redirect standard error to /dev/null only in that function.  This way
we need only one redirection to take care of errors from almost all
git commands.  Redirecting standard error of the __git() wrapper
function thus became redundant, remove them.

The exceptions, i.e. the repo-independent git executions and those in
the __gitdir() function that don't go through __git() already have
their standard error silenced.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 28 ++++++++++++--------------=
--
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c496f4026fc8..2d0bd018701e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -66,7 +66,7 @@ __gitdir ()
 __git ()
 {
 	git ${__git_C_args:+"${__git_C_args[@]}"} \
-		${__git_dir:+--git-dir=3D"$__git_dir"} "$@"
+		${__git_dir:+--git-dir=3D"$__git_dir"} "$@" 2>/dev/null
 }
=20
 # The following function is based on code from:
@@ -300,7 +300,7 @@ __git_ls_files_helper ()
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
 		__git -C "$1" ls-files --exclude-standard $2
-	fi 2>/dev/null
+	fi
 }
=20
=20
@@ -412,7 +412,7 @@ __git_refs ()
 	fi
 	case "$cur" in
 	refs|refs/*)
-		__git ls-remote "$remote" "$cur*" 2>/dev/null | \
+		__git ls-remote "$remote" "$cur*" | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -424,10 +424,10 @@ __git_refs ()
 		if [ "$named_remote" =3D y ]; then
 			echo "HEAD"
 			__git for-each-ref --format=3D"%(refname:short)" -- \
-				"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
+				"refs/remotes/$remote/" | sed -e "s#^$remote/##"
 		else
 			__git ls-remote "$remote" HEAD \
-				'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' 2>/dev/null |
+				'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' |
 			while read -r hash i; do
 				case "$i" in
 				*^{})	;;
@@ -453,7 +453,7 @@ __git_refs2 ()
 __git_refs_remotes ()
 {
 	local i hash
-	__git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
+	__git ls-remote "$1" 'refs/heads/*' | \
 	while read -r hash i; do
 		echo "$i:refs/remotes/$1/${i#refs/heads/}"
 	done
@@ -529,7 +529,7 @@ __git_complete_revlist_file ()
 		*)   pfx=3D"$ref:$pfx" ;;
 		esac
=20
-		__gitcomp_nl "$(__git ls-tree "$ls" 2>/dev/null \
+		__gitcomp_nl "$(__git ls-tree "$ls" \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
@@ -807,7 +807,7 @@ __git_compute_porcelain_commands ()
 __git_get_config_variables ()
 {
 	local section=3D"$1" i IFS=3D$'\n'
-	for i in $(__git config --name-only --get-regexp "^$section\..*" 2>/d=
ev/null); do
+	for i in $(__git config --name-only --get-regexp "^$section\..*"); do
 		echo "${i#$section.}"
 	done
 }
@@ -825,7 +825,7 @@ __git_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local word cmdline=3D$(__git config --get "alias.$1" 2>/dev/null)
+	local word cmdline=3D$(__git config --get "alias.$1")
 	for word in $cmdline; do
 		case "$word" in
 		\!gitk|gitk)
@@ -1780,9 +1780,7 @@ _git_send_email ()
 {
 	case "$prev" in
 	--to|--cc|--bcc|--from)
-		__gitcomp "
-		$(__git send-email --dump-aliases 2>/dev/null)
-		"
+		__gitcomp "$(__git send-email --dump-aliases)"
 		return
 		;;
 	esac
@@ -1812,9 +1810,7 @@ _git_send_email ()
 		return
 		;;
 	--to=3D*|--cc=3D*|--bcc=3D*|--from=3D*)
-		__gitcomp "
-		$(__git send-email --dump-aliases 2>/dev/null)
-		" "" "${cur#--*=3D}"
+		__gitcomp "$(__git send-email --dump-aliases)" "" "${cur#--*=3D}"
 		return
 		;;
 	--*)
@@ -1858,7 +1854,7 @@ __git_config_get_set_variables ()
 		c=3D$((--c))
 	done
=20
-	__git config $config_file --name-only --list 2>/dev/null
+	__git config $config_file --name-only --list
 }
=20
 _git_config ()
--=20
2.7.2.410.g92cb358
