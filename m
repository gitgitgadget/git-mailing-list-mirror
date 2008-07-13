From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] bash completion: Improve responsiveness of git-log
	completion
Date: Sun, 13 Jul 2008 06:02:48 +0200
Message-ID: <20080713040248.GG10151@machine.or.cz>
References: <20080713023742.GA31760@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 06:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHsw1-0004qO-IC
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 06:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbYGMECv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 00:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbYGMECv
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 00:02:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60604 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbYGMECu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 00:02:50 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B0523393B32A; Sun, 13 Jul 2008 06:02:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080713023742.GA31760@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88284>

On Sun, Jul 13, 2008 at 02:37:42AM +0000, Shawn O. Pearce wrote:
> Junio noticed the bash completion has been taking a long time lately.
> Petr Baudis tracked it down to 72e5e989b ("bash: Add space after
> unique command name is completed.").  Tracing the code showed
> we spent significant time inside of this loop within __gitcomp,
> due to the string copying overhead.
> 
>   [28.146109654] _git common over
>   [28.164791148] gitrefs in
>   [28.280302268] gitrefs dir out
>   [28.300939737] gitcomp in
>   [28.308378112] gitcomp pre-case
> * [28.313407453] gitcomp iter in
> * [28.701270296] gitcomp iter out
>   [28.713370786] out normal
> 
> Since __git_refs avoids this string copying by forking and using
> echo we use the same trick here when we need to finish generating
> the names for the caller.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

I spent quite some time trying to optimize the run by heavy use of bash
arrays (either just in __gitcomp() and at later stage reusing
__git_refs() array within __gitcomp()), but it turned out I have made
few simple mistakes and in the end, the array is slower than Shawn's
approach - when reusing the array, the difference is even bigger.
I think that if a[i]=x is slower than echo x, bash is doing something
real weird, but that seems to be the case.


Someone might find my simple and noisy benchmarker useful:

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 27332ed..31f97c1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -45,6 +45,18 @@
 #       git@vger.kernel.org
 #
 
+
+benchmark_last=0
+benchmark_delta=0
+benchmark ()
+{
+	#return
+	local now=$(date +%S%N)
+	benchmark_diff=$(echo "($now-$benchmark_last)/1000000-($benchmark_delta)"|bc)
+	echo "[+${benchmark_diff}ms] $*" >&2
+	benchmark_last=$now
+}
+
 __gitdir ()
 {
 	if [ -z "$1" ]; then
@@ -116,6 +128,7 @@ __git_ps1 ()
 
 __gitcomp ()
 {
+	benchmark "gitcomp start"
 	local all c s=$'\n' IFS=' '$'\t'$'\n'
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	if [ $# -gt 2 ]; then
@@ -138,6 +151,7 @@ __gitcomp ()
 	esac
 	IFS=$s
 	COMPREPLY=($(compgen -P "$2" -W "$all" -- "$cur"))
+	benchmark "gitcomp end"
 	return
 }
 
@@ -185,12 +199,16 @@ __git_tags ()
 
 __git_refs ()
 {
+	benchmark "gitrefs in"
 	local cmd i is_hash=y dir="$(__gitdir "$1")"
 	if [ -d "$dir" ]; then
 		if [ -e "$dir/HEAD" ]; then echo HEAD; fi
-		for i in $(git --git-dir="$dir" \
+		benchmark "gitrefs dir a"
+		local a=($(git --git-dir="$dir" \
 			for-each-ref --format='%(refname)' \
-			refs/tags refs/heads refs/remotes); do
+			refs/tags refs/heads refs/remotes))
+		benchmark "gitrefs dir r"
+		for i in "${a[@]}"; do
 			case "$i" in
 				refs/tags/*)    echo "${i#refs/tags/}" ;;
 				refs/heads/*)   echo "${i#refs/heads/}" ;;
@@ -198,6 +216,7 @@ __git_refs ()
 				*)              echo "$i" ;;
 			esac
 		done
+		benchmark "gitrefs dir out"
 		return
 	fi
 	for i in $(git ls-remote "$dir" 2>/dev/null); do
@@ -210,6 +229,7 @@ __git_refs ()
 		n,*) is_hash=y; echo "$i" ;;
 		esac
 	done
+	benchmark "gitrefs out"
 }
 
 __git_refs2 ()
@@ -324,7 +344,9 @@ __git_complete_revlist ()
 		__gitcomp "$cur."
 		;;
 	*)
+		benchmark "revlist simple in"
 		__gitcomp "$(__git_refs)"
+		benchmark "revlist simple out"
 		;;
 	esac
 }
@@ -756,6 +778,8 @@ _git_log ()
 {
 	__git_has_doubledash && return
 
+	benchmark "doubledash over"
+
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--pretty=*)
@@ -791,6 +815,7 @@ _git_log ()
 		return
 		;;
 	esac
+	benchmark "gitcomp over"
 	__git_complete_revlist
 }
 
@@ -1303,6 +1328,9 @@ _git ()
 {
 	local i c=1 command __git_dir
 
+	benchmark "in"; benchmark_delta=0
+	benchmark "in netto"; benchmark_delta=$benchmark_diff
+
 	while [ $c -lt $COMP_CWORD ]; do
 		i="${COMP_WORDS[c]}"
 		case "$i" in
@@ -1314,6 +1342,8 @@ _git ()
 		c=$((++c))
 	done
 
+	#[ "$__git_dir" ] || __git_dir="$(__gitdir)"
+
 	if [ -z "$command" ]; then
 		case "${COMP_WORDS[COMP_CWORD]}" in
 		--*=*) COMPREPLY=() ;;
@@ -1330,12 +1360,16 @@ _git ()
 			;;
 		*)     __gitcomp "$(__git_commands) $(__git_aliases)" ;;
 		esac
+
+		benchmark "out cut $(date +%S.%N)"
 		return
 	fi
 
 	local expansion=$(__git_aliased_command "$command")
 	[ "$expansion" ] && command="$expansion"
 
+	benchmark "mark common"
+
 	case "$command" in
 	am)          _git_am ;;
 	add)         _git_add ;;
@@ -1374,6 +1408,8 @@ _git ()
 	whatchanged) _git_log ;;
 	*)           COMPREPLY=() ;;
 	esac
+
+	benchmark "out normal"
 }
 
 _gitk ()
