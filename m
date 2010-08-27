From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCHv2] completion: make compatible with zsh
Date: Thu, 26 Aug 2010 22:45:56 -0400
Message-ID: <1282877156-16149-1-git-send-email-lodatom@gmail.com>
Cc: git@vger.kernel.org, avarab@gmail.com,
	Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 04:46:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oooxq-0001ve-Cp
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 04:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab0H0Cqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 22:46:42 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38451 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab0H0Cqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 22:46:40 -0400
Received: by qwh6 with SMTP id 6so2300327qwh.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 19:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VYZCUU1+AGhVCb7d4hopQCxzrqNcCzNm9IPaolAie5s=;
        b=n4DNwDZ/zKW0qLTM6HKcQgX3RBiEC3lziqiw7k2Bv03u8i9RIRjZSz9I6hE5+qHecM
         fgivSWxuTUyOE3QcFW+WKRQoAWbhgFzbpXxexEfuUHTU2uhNStJlvuNHPiSrELhDwMeG
         qM6h42108D0NVQI25/ARAFFTwM5pOasOrK8hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ULx063rfFqHhGISceb7tXfxGjqAZ7TC/Ch26IZbWnr0edicd07qFphnLBX1xXDC/F5
         xe/UcBSIrz6c5OLAT2ppM1nV6PuI8XYm3WA3pmWYCywzNSMudW/UX9HS5uXCVutiyebU
         JWbTPk27P0W0e7slhLHKVdMt2xq7prQRneB0g=
Received: by 10.224.45.141 with SMTP id e13mr7357927qaf.59.1282877199945;
        Thu, 26 Aug 2010 19:46:39 -0700 (PDT)
Received: from localhost.localdomain (c-69-137-229-191.hsd1.dc.comcast.net [69.137.229.191])
        by mx.google.com with ESMTPS id f15sm3915852qcr.1.2010.08.26.19.46.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 19:46:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154575>

Modify git-completion.bash so that it also works with zsh when using
bashcompinit.  In particular:

declare -F
    Zsh doesn't have the same 'declare -F' as bash, but 'declare -f'
    is the same, and it works just as well for our purposes.

${var:2}
    Zsh does not implement ${var:2} to skip the first 2 characters, but
    ${var#??} works in both shells to replace the first 2 characters
    with nothing.  Thanks to Jonathan Nieder for the suggestion.

for (( n=1; "$n" ... ))
    Zsh does not allow "$var" in arithmetic loops.  Instead, pre-compute
    the endpoint and use the variables without $'s or quotes.

shopt
    Zsh uses 'setopt', which has a different syntax than 'shopt'.  Since
    'shopt' is used infrequently in git-completion, we provide
    a bare-bones emulation.

emulate -L bash
KSH_TYPESET
    Zsh offers bash emulation, which turns on a set of features to
    closely resemble bash. In particular, this enables SH_WORDSPLIT,
    which splits scalar variables on word boundaries in 'for' loops.
    We also need to set KSH_TYPESET, to fix "local var=$(echo foo bar)"
    issues.

The last set of options are turned on only in _git and _gitk.  Some of
the sub-functions may not work correctly if called directly.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

Those on the CC list either responded to the original patch or are the authors
of the lines affected by this patch:
    - Andrew wrote __git_ps1_show_upstream().
    - SZEDER wrote the part using 'declare -F'.

 contrib/completion/git-completion.bash |   50 +++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6756990..6a7aae6 100755
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
 #        PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
 #
@@ -138,11 +143,12 @@ __git_ps1_show_upstream ()
 		# get the upstream from the "git-svn-id: ..." in a commit message
 		# (git-svn uses essentially the same procedure internally)
 		local svn_upstream=($(git log --first-parent -1 \
-					--grep="^git-svn-id: \(${svn_url_pattern:2}\)" 2>/dev/null))
+					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
 		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
 			svn_upstream=${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
 			svn_upstream=${svn_upstream%@*}
-			for ((n=1; "$n" <= "${#svn_remote[@]}"; ++n)); do
+			local n_stop="${#svn_remote[@]}"
+			for ((n=1; n <= n_stop; ++n)); do
 				svn_upstream=${svn_upstream#${svn_remote[$n]}}
 			done
 
@@ -2339,6 +2345,11 @@ _git ()
 {
 	local i c=1 command __git_dir
 
+	if [[ -n $ZSH_VERSION ]]; then
+		emulate -L bash
+		setopt KSH_TYPESET
+	fi
+
 	while [ $c -lt $COMP_CWORD ]; do
 		i="${COMP_WORDS[c]}"
 		case "$i" in
@@ -2372,17 +2383,22 @@ _git ()
 	fi
 
 	local completion_func="_git_${command//-/_}"
-	declare -F $completion_func >/dev/null && $completion_func && return
+	declare -f $completion_func >/dev/null && $completion_func && return
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		completion_func="_git_${expansion//-/_}"
-		declare -F $completion_func >/dev/null && $completion_func
+		declare -f $completion_func >/dev/null && $completion_func
 	fi
 }
 
 _gitk ()
 {
+	if [[ -n $ZSH_VERSION ]]; then
+		emulate -L bash
+		setopt KSH_TYPESET
+	fi
+
 	__git_has_doubledash && return
 
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -2417,3 +2433,29 @@ if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
 complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
 	|| complete -o default -o nospace -F _git git.exe
 fi
+
+if [[ -z $ZSH_VERSION ]]; then
+	shopt () {
+		local option
+		if [ $# -ne 2 ]; then
+			echo "USAGE: $0 (-q|-s|-u) <option>" >&2
+			return 1
+		fi
+		case "$2" in
+		nullglob)
+			option="$2"
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
-- 
1.7.2.2
