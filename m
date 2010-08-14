From: Mark Lodato <lodatom@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20completion=3A=20make=20compatible=20with=20zsh?=
Date: Fri, 13 Aug 2010 23:40:37 -0400
Message-ID: <1281757237-32656-1-git-send-email-lodatom@gmail.com>
References: <AANLkTimknF-m4_TYt+-vBBW0e3A-DY1nY93k7mPybdaD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, spearce@spearce.org,
	avarab@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 05:41:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok7ce-0005Bw-0y
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 05:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578Ab0HNDlS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 23:41:18 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38831 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756933Ab0HNDlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 23:41:18 -0400
Received: by qwh6 with SMTP id 6so3458949qwh.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 20:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=n41jASNaWHNubp5U1hNnCS/vs9n2O3S/D+wdAoyWW6w=;
        b=d/Mv1ZOwDf7Kinuiawr9On2IkP5GkWYSXSE3PPDMeQIZm7K/g6h0yqa0+whqa/UQu+
         EjeP+fc23gMm4fDyFBbl2FRPzOLRapH+EsmgyzjjbSlO1g9buUF56pYM0oFdsd/YJ5+S
         kL8XLfzoQQpknAK/pAr45hhDdQettIs/k/GlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ekPNlXenbp0j4TNr1m2WkET35yHWsmdrVsqA9dw6fgp1YBeWEssGY2bulng3gZ3G8g
         EkedWDORKFvnokLluHUyPuLb3Na6UEyBIF8MGBUsy6XEh4iYQqa2T3xEIW9vQglzqM+x
         UhPrsMTh41cdwnyRCMcFFMwmp4cvJu7kMCbKc=
Received: by 10.224.96.150 with SMTP id h22mr1581761qan.173.1281757277244;
        Fri, 13 Aug 2010 20:41:17 -0700 (PDT)
Received: from localhost.localdomain (c-69-137-229-191.hsd1.dc.comcast.net [69.137.229.191])
        by mx.google.com with ESMTPS id t24sm4322268qcs.23.2010.08.13.20.41.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 20:41:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <AANLkTimknF-m4_TYt+-vBBW0e3A-DY1nY93k7mPybdaD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153545>

Modify git-completion.bash to work with both bash and zsh.  Most code
works fine, but a few things need tweaking.  Where possible, code is
written in such a way that both shells interpret fine, but some areas
need special-casing.

declare -F
    Zsh doesn't have the same 'declare -F' as bash, but 'declare -f'
    is the same, and it works just as well for our purposes.

${var:2}
    Zsh uses $var[3,-1] to trim the first two characters.  There is no
    way to write cross-shell code to accomplish this, so we must wrap
    this in a check for zsh.

for (( n=3D1; "$n" ... ))
    Zsh does not allow "$var" in arithmetic loops.  Instead, pre-comput=
e
    the endpoint and use the variables without $'s or quotes.

shopt
    Zsh uses 'setopt', which has a different syntax than 'shopt.  Since
    'shopt' is used infrequently in git-completion, we provide
    a bare-bones emulation.

emulate -L bash
KSH_TYPESET
    Zsh offers bash emulation, which turns on a set of features to
    closely resemble bash; in particular, this turns on SH_WORDSPLIT.
    We also need to set KSH_TYPESET, to fix "local var=3D$(echo foo bar=
)"
    issues.

The last set of options are turned on only in _git and _gitk.  Some of
the sub-functions may not work correctly if called directly.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

On Fri, Aug 13, 2010 at 11:23 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
> On Sat, Aug 14, 2010 at 03:17, Mark Lodato <lodatom@gmail.com> wrote:
>> On Tue, Aug 3, 2010 at 10:57 PM, Mark Lodato <lodatom@gmail.com> wro=
te:
>>> Modify git-completion.bash to work with both bash and zsh.  Most co=
de
>>> works fine, but a few things need tweaking.  Where possible, code i=
s
>>> written in such a way that both shells interpret fine, but some are=
as
>>> need special-casing.
>>
>> Is there any interest in this patch, or anything I could do that wou=
ld
>> make it more likely to be accepted?  Perhaps at least some of these
>> changes could be implemented.
>
> What's the Message-ID for that patch? I can't find it in my mailbox o=
r
> in a public archive (via Google).

Thanks for letting me know.

It appears that my initial message didn't go through.  I used the --to
argument with 'git format-patch', but 'git send-email' didn't seem to
parse it properly.  It stuck an empty "To:" line at the normal position=
,
and then put an additional "To: git@vger.kernel.org" at the bottom of
the headers.  Gmail must not have liked this.

So, here's another shot.  I am not too familiar with how the completion
works, so the changed parts ought to be tested on both zsh and bash.
Any suggestions on how to do so - or results from doing so - would be
greatly appreciated.

I tried to make as few changes to the main part of the script as
possible, so that zsh compatibility does not get in the way of normal
development.  If anyone has any suggestions for improvement, please let
me know.

If this should be split into separate patches, I can do that.  Each
change is so small, I thought it would make more sense to roll them all
into one.


 contrib/completion/git-completion.bash |   53 ++++++++++++++++++++++++=
+++++---
 1 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6756990..dde796e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -137,12 +137,19 @@ __git_ps1_show_upstream ()
 	svn*)
 		# get the upstream from the "git-svn-id: ..." in a commit message
 		# (git-svn uses essentially the same procedure internally)
-		local svn_upstream=3D($(git log --first-parent -1 \
-					--grep=3D"^git-svn-id: \(${svn_url_pattern:2}\)" 2>/dev/null))
+		local svn_upstream pattern n_stop
+		if [[ -n $ZSH_VERSION ]]; then
+			pattern=3D"$svn_url_pattern[3,-1]"
+		else
+			pattern=3D"${svn_url_pattern:2}"
+		fi
+		svn_upstream=3D($(git log --first-parent -1 \
+				--grep=3D"^git-svn-id: \($pattern\)" 2>/dev/null))
 		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
 			svn_upstream=3D${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
 			svn_upstream=3D${svn_upstream%@*}
-			for ((n=3D1; "$n" <=3D "${#svn_remote[@]}"; ++n)); do
+			n_stop=3D"${#svn_remote[@]}"
+			for ((n=3D1; n <=3D n_stop; ++n)); do
 				svn_upstream=3D${svn_upstream#${svn_remote[$n]}}
 			done
=20
@@ -2339,6 +2346,11 @@ _git ()
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
@@ -2372,17 +2384,22 @@ _git ()
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
@@ -2417,3 +2434,29 @@ if [ Cygwin =3D "$(uname -o 2>/dev/null)" ]; the=
n
 complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/n=
ull \
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
1.7.2.1
