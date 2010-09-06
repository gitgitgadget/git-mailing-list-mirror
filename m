From: Mark Lodato <lodatom@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv3=5D=20completion=3A=20make=20compatible=20with=20zsh?=
Date: Mon,  6 Sep 2010 08:33:19 -0400
Message-ID: <1283776399-4632-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osau4-0006sk-4u
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab0IFMeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:34:09 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44678 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab0IFMeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:34:07 -0400
Received: by qyk36 with SMTP id 36so2326631qyk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=qGUslq0Ga2fa3mgHYzlSbBmtzeUFNATNWGUWjkXcd0Q=;
        b=NPtl5qKf2YNjAlBSlofMyHEN66AZo4QLiH+4ajZNjdND5hSGCTBitBo3wuTVSK2eJY
         3zHQku27nrZuskcv6n4R8xs1Apdm/9eCVzbaK9Ug6GpugbeRVMoXfxfSRUGBoCueaI7m
         9o89UpA1Xf0FIa7Yqa4vOpxKT5fGnVfGH7PGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=MqfAsE86Z6HGfb1AJYbcqjNMCaXhzPjQs3xizYSPpvp/Xt9BGOpAIK6LvMRiKnucOe
         DLDEhn2eqdxSYk9xbWIv4lheGM8xWZsnzsHMNqiiV+vKaZi0/rQs9Rq2mVwYl/MFOJOs
         C8O3ifg3KeiQ9ZzrEsQSh/QLmbgYRIWLjI+OU=
Received: by 10.224.28.137 with SMTP id m9mr532299qac.207.1283776445929;
        Mon, 06 Sep 2010 05:34:05 -0700 (PDT)
Received: from localhost.localdomain (c-69-137-229-191.hsd1.dc.comcast.net [69.137.229.191])
        by mx.google.com with ESMTPS id f15sm5545598qcr.13.2010.09.06.05.34.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:34:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155567>

Modify git-completion.bash so that it also works with zsh when using
bashcompinit.  In particular:

declare -F
    Zsh doesn't have the same 'declare -F' as bash, but 'declare -f'
    is the same, and it works just as well for our purposes.

${var:2}
    Zsh does not implement ${var:2} to skip the first 2 characters, but
    ${var#??} works in both shells to replace the first 2 characters
    with nothing.  Thanks to Jonathan Nieder for the suggestion.

for (( n=3D1; "$n" ... ))
    Zsh does not allow "$var" in arithmetic loops.  Instead, pre-comput=
e
    the endpoint and use the variables without $'s or quotes.

shopt
    Zsh uses 'setopt', which has a different syntax than 'shopt'.  Sinc=
e
    'shopt' is used infrequently in git-completion, we provide
    a bare-bones emulation.

emulate -L bash
KSH_TYPESET
    Zsh offers bash emulation, which turns on a set of features to
    closely resemble bash. In particular, this enables SH_WORDSPLIT,
    which splits scalar variables on word boundaries in 'for' loops.
    We also need to set KSH_TYPESET, to fix "local var=3D$(echo foo bar=
)"
    issues.

The last set of options are turned on only in _git and _gitk.  Some of
the sub-functions may not work correctly if called directly.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

I think this is now ready for inclusion.  The only change from PATCHv2
is that "-z" was changed to "-n" in the final test for ZSH_VERSION.

Not sure if I should put this in the actual commit message myself, but
PATCHv2 was:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>


 contrib/completion/git-completion.bash |   50 ++++++++++++++++++++++++=
+++++--
 1 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6756990..feab651 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -21,6 +21,11 @@
 #    2) Added the following line to your .bashrc:
 #        source ~/.git-completion.sh
 #
+#       Or, add the following lines to your .zshrc:
+#        autoload bashcompinit
+#        bashcompinit
+#        source ~/.git-completion.sh
+#
 #    3) Consider changing your PS1 to also show the current branch:
 #        PS1=3D'[\u@\h \W$(__git_ps1 " (%s)")]\$ '
 #
@@ -138,11 +143,12 @@ __git_ps1_show_upstream ()
 		# get the upstream from the "git-svn-id: ..." in a commit message
 		# (git-svn uses essentially the same procedure internally)
 		local svn_upstream=3D($(git log --first-parent -1 \
-					--grep=3D"^git-svn-id: \(${svn_url_pattern:2}\)" 2>/dev/null))
+					--grep=3D"^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
 		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
 			svn_upstream=3D${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
 			svn_upstream=3D${svn_upstream%@*}
-			for ((n=3D1; "$n" <=3D "${#svn_remote[@]}"; ++n)); do
+			local n_stop=3D"${#svn_remote[@]}"
+			for ((n=3D1; n <=3D n_stop; ++n)); do
 				svn_upstream=3D${svn_upstream#${svn_remote[$n]}}
 			done
=20
@@ -2339,6 +2345,11 @@ _git ()
 {
 	local i c=3D1 command __git_dir
=20
+	if [[ -n $ZSH_VERSION ]]; then
+		emulate -L bash
+		setopt KSH_TYPESET
+	fi
+
 	while [ $c -lt $COMP_CWORD ]; do
 		i=3D"${COMP_WORDS[c]}"
 		case "$i" in
@@ -2372,17 +2383,22 @@ _git ()
 	fi
=20
 	local completion_func=3D"_git_${command//-/_}"
-	declare -F $completion_func >/dev/null && $completion_func && return
+	declare -f $completion_func >/dev/null && $completion_func && return
=20
 	local expansion=3D$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		completion_func=3D"_git_${expansion//-/_}"
-		declare -F $completion_func >/dev/null && $completion_func
+		declare -f $completion_func >/dev/null && $completion_func
 	fi
 }
=20
 _gitk ()
 {
+	if [[ -n $ZSH_VERSION ]]; then
+		emulate -L bash
+		setopt KSH_TYPESET
+	fi
+
 	__git_has_doubledash && return
=20
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
@@ -2417,3 +2433,29 @@ if [ Cygwin =3D "$(uname -o 2>/dev/null)" ]; the=
n
 complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/n=
ull \
 	|| complete -o default -o nospace -F _git git.exe
 fi
+
+if [[ -n $ZSH_VERSION ]]; then
+	shopt () {
+		local option
+		if [ $# -ne 2 ]; then
+			echo "USAGE: $0 (-q|-s|-u) <option>" >&2
+			return 1
+		fi
+		case "$2" in
+		nullglob)
+			option=3D"$2"
+			;;
+		*)
+			echo "$0: invalid option: $2" >&2
+			return 1
+		esac
+		case "$1" in
+		-q)	setopt | grep -q "$option" ;;
+		-u)	unsetopt "$option" ;;
+		-s)	setopt "$option" ;;
+		*)
+			echo "$0: invalid flag: $1" >&2
+			return 1
+		esac
+	}
+fi
--=20
1.7.2.3
