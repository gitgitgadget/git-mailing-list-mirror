From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] bash-completion: Support running with set -u in bash
 4.0
Date: Sat, 6 Mar 2010 14:17:53 -0600
Message-ID: <20100306201753.GA4704@progeny.tock>
References: <20100306181655.GA2261@progeny.tock>
 <7vtystfdu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>,
	Thomas Nilsson <thomas.nilsson@unixangst.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:29:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No17I-0004YU-Qj
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab0CFURt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 15:17:49 -0500
Received: from mail-iw0-f202.google.com ([209.85.223.202]:42314 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0CFURs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 15:17:48 -0500
Received: by iwn40 with SMTP id 40so1218736iwn.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 12:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ed0ZvQXjGUckSXtT2aosyFQoq23wCgF+IS+bH5OTw8Q=;
        b=PESGcWXVgmqsKTkb2WckMqhQHjU/iytrfyfjQKhAzIkZARX6Ft2/2sIfHQAOB5nOQR
         LBSscs38CNiw8k3aU4KHs4mP/PRd12WEdftb+Bg51hob1lRYXpd3xX7QLVfPOmtDA7Zj
         Wckhd0sCVs/y3Sln1bGFRNVWOaW/3aqaQT0aY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CPyRRJrRYBXeQo9JHjQas90K27vf7K/JAC4N1ttqpV2n9FSY3d5O1D902ubyFxMOav
         ft3b+c0iC3zXAsb/gZwdpD+Q5kQjxaC8YbtVxPE+BHbPs9QcfD2ruXRprAPk7to8e/zE
         Va3zoCYbodjn/rsoibLrWMKIwcyUfkOrvLxp0=
Received: by 10.231.151.207 with SMTP id d15mr954693ibw.44.1267906667600;
        Sat, 06 Mar 2010 12:17:47 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2752095iwn.3.2010.03.06.12.17.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 12:17:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtystfdu5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -2181,7 +2181,7 @@ _git ()
>>  		c=3D$((++c))
>>  	done
>> =20
>> -	if [ -z "$command" ]; then
>> +	if [ -z "${command-}" ]; then
>>  		case "${COMP_WORDS[COMP_CWORD]}" in
>>  		--*)   __gitcomp "
>>  			--paginate
>
> Why not this patch, instead of the above hunk?

My mistake.  The original patch was as you suggest, then I changed it
to the above to make it follow the style of surrounding code.

If one makes it a goal to lose the ${foo-} lines:

 - In __gitdir, [ -z "${1-}" ] should be [ $# -eq 0 ]
 - In __gitdir callers, "${1-}" should be replaced by "$@"
 - In _git, __git_dir should be initialized to ""
 - In _gitk and __git_ps1, __git_dir should be made local and
   initialized (independent bugfix)
 - In __git_ps1, the code examining $GIT_PS1_DESCRIBE_STYLE
   should be protected by an if [ -n "${GIT_PS1_DESCRIBE_STYLE:+set}" ]
 - The checks for GIT_PS1_SHOWDIRTYSTATE and GIT_PS1_SHOWUNTRACKEDFILES
   would also be adjusted
 - __gitcomp should get some local variables set to "" and then
   conditionally set to its arguments
 - "${1-}" in __git_heads and __git_tags should be "$dir"

These look like good things to do anyway.  Assuming your change
has already been made, the follow-up patch would look something
like this.

-- %< --
Subject: bash-completion: Avoid using uninitialized values

The "${var-}" idiom is obscure and makes it easy to hide uses of
values not initialized by the completion script that could have leaked
from the user=E2=80=99s environment.

Untested.  The only intentional change in functionality from this
patch is that __git_dir has been made local to _gitk() and __git_ps1.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |   52 +++++++++++++++++++++---=
--------
 1 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2682f52..e291d8d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -63,8 +63,8 @@ esac
 # returns location of .git repo
 __gitdir ()
 {
-	if [ -z "${1-}" ]; then
-		if [ -n "${__git_dir-}" ]; then
+	if [ $# -eq 0 ]; then
+		if [ -n "$__git_dir" ]; then
 			echo "$__git_dir"
 		elif [ -d .git ]; then
 			echo .git
@@ -82,6 +82,7 @@ __gitdir ()
 # returns text to add to bash PS1 prompt (includes branch name)
 __git_ps1 ()
 {
+	local __git_dir=3D""
 	local g=3D"$(__gitdir)"
 	if [ -n "$g" ]; then
 		local r=3D""
@@ -108,18 +109,20 @@ __git_ps1 ()
 			fi
=20
 			b=3D"$(git symbolic-ref HEAD 2>/dev/null)" || {
-
-				b=3D"$(
-				case "${GIT_PS1_DESCRIBE_STYLE-}" in
+				if [ -z "${GIT_PS1_DESCRIBE_STYLE:+set}" ] ||
+					[ "$GIT_PS1_DESCRIBE_STYLE" =3D default ]; then
+					b=3D$(git describe --exact-match HEAD 2>/dev/null)
+				else b=3D$(case "$GIT_PS1_DESCRIBE_STYLE" in
 				(contains)
 					git describe --contains HEAD ;;
 				(branch)
 					git describe --contains --all HEAD ;;
 				(describe)
 					git describe HEAD ;;
-				(* | default)
+				(*)
 					git describe --exact-match HEAD ;;
-				esac 2>/dev/null)" ||
+				esac 2>/dev/null)
+				fi ||
=20
 				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
 				b=3D"unknown"
@@ -140,7 +143,7 @@ __git_ps1 ()
 				b=3D"GIT_DIR!"
 			fi
 		elif [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null=
)" ]; then
-			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
+			if [ -n "${GIT_PS1_SHOWDIRTYSTATE:+set}" ]; then
 				if [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]; th=
en
 					git diff --no-ext-diff --quiet --exit-code || w=3D"*"
 					if git rev-parse --quiet --verify HEAD >/dev/null; then
@@ -150,11 +153,11 @@ __git_ps1 ()
 					fi
 				fi
 			fi
-			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
+			if [ -n "${GIT_PS1_SHOWSTASHSTATE:+set}" ]; then
 			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$=
"
 			fi
=20
-			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
+			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES:+set}" ]; then
 			   if [ -n "$(git ls-files --others --exclude-standard)" ]; then
 			      u=3D"%"
 			   fi
@@ -183,18 +186,30 @@ __gitcomp_1 ()
 # generates completion reply with compgen
 __gitcomp ()
 {
+	local replies=3D""
+	local pfx=3D""
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local sfx=3D""
+	if [ $# -gt 3 ]; then
+		sfx=3D$4
+	fi
 	if [ $# -gt 2 ]; then
 		cur=3D"$3"
 	fi
+	if [ $# -gt 1 ]; then
+		pfx=3D$2
+	fi
+	if [ $# -gt 0 ]; then
+		replies=3D$1
+	fi
 	case "$cur" in
 	--*=3D)
 		COMPREPLY=3D()
 		;;
 	*)
 		local IFS=3D$'\n'
-		COMPREPLY=3D($(compgen -P "${2-}" \
-			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
+		COMPREPLY=3D($(compgen -P "$pfx" \
+			-W "$(__gitcomp_1 "$replies" "$sfx")" \
 			-- "$cur"))
 		;;
 	esac
@@ -203,13 +218,13 @@ __gitcomp ()
 # __git_heads accepts 0 or 1 arguments (to pass to __gitdir)
 __git_heads ()
 {
-	local cmd i is_hash=3Dy dir=3D"$(__gitdir "${1-}")"
+	local cmd i is_hash=3Dy dir=3D"$(__gitdir "$@")"
 	if [ -d "$dir" ]; then
 		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
 			refs/heads
 		return
 	fi
-	for i in $(git ls-remote "${1-}" 2>/dev/null); do
+	for i in $(git ls-remote "$dir" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=3Dn ;;
 		n,*^{}) is_hash=3Dy ;;
@@ -222,13 +237,13 @@ __git_heads ()
 # __git_tags accepts 0 or 1 arguments (to pass to __gitdir)
 __git_tags ()
 {
-	local cmd i is_hash=3Dy dir=3D"$(__gitdir "${1-}")"
+	local cmd i is_hash=3Dy dir=3D"$(__gitdir "$@")"
 	if [ -d "$dir" ]; then
 		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
 			refs/tags
 		return
 	fi
-	for i in $(git ls-remote "${1-}" 2>/dev/null); do
+	for i in $(git ls-remote "$dir" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=3Dn ;;
 		n,*^{}) is_hash=3Dy ;;
@@ -241,7 +256,7 @@ __git_tags ()
 # __git_refs accepts 0 or 1 arguments (to pass to __gitdir)
 __git_refs ()
 {
-	local i is_hash=3Dy dir=3D"$(__gitdir "${1-}")"
+	local i is_hash=3Dy dir=3D"$(__gitdir "$@")"
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}" format refs
 	if [ -d "$dir" ]; then
 		case "$cur" in
@@ -2167,7 +2182,7 @@ _git_tag ()
=20
 _git ()
 {
-	local i c=3D1 command=3D"" __git_dir
+	local i c=3D1 command=3D"" __git_dir=3D""
=20
 	while [ $c -lt $COMP_CWORD ]; do
 		i=3D"${COMP_WORDS[c]}"
@@ -2265,6 +2280,7 @@ _gitk ()
 {
 	__git_has_doubledash && return
=20
+	local __git_dir=3D""
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	local g=3D"$(__gitdir)"
 	local merge=3D""
--=20
1.7.0
