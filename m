From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/8] bash: Support unique completion on git-config.
Date: Sun, 4 Feb 2007 02:38:37 -0500
Message-ID: <20070204073837.GF17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 08:38:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDbxa-0007Y3-Bi
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 08:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbXBDHin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 02:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbXBDHin
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 02:38:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55528 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbXBDHim (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 02:38:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDbxO-0008WU-5m; Sun, 04 Feb 2007 02:38:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B32A920FBAE; Sun,  4 Feb 2007 02:38:37 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38662>

In many cases we know a completion will be unique, but we've disabled
bash's automatic space addition (-o nospace) so we need to do it
ourselves when necessary.

This change adds additional support for new configuration options
added in 1.5.0, as well as some extended completion support for
the color.* family of options.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |  120 ++++++++++++++++++++++----------
 1 files changed, 82 insertions(+), 38 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 382c817..38d6121 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -64,14 +64,19 @@ __git_ps1 ()
 __gitcomp ()
 {
 	local all c s=$'\n' IFS=' '$'\t'$'\n'
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	if [ -n "$2" ]; then
+		cur="$3"
+	fi
 	for c in $1; do
-		case "$c" in
-		--*=*) all="$all$c$s" ;;
-		*)     all="$all$c $s" ;;
+		case "$c$4" in
+		--*=*) all="$all$c$4$s" ;;
+		*.)    all="$all$c$4$s" ;;
+		*)     all="$all$c$4 $s" ;;
 		esac
 	done
 	IFS=$s
-	COMPREPLY=($(compgen -W "$all" -- "${COMP_WORDS[COMP_CWORD]}"))
+	COMPREPLY=($(compgen -P "$2" -W "$all" -- "$cur"))
 	return
 }
 
@@ -666,26 +671,40 @@ _git_config ()
 	local prv="${COMP_WORDS[COMP_CWORD-1]}"
 	case "$prv" in
 	branch.*.remote)
-		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		__gitcomp "$(__git_remotes)"
 		return
 		;;
 	branch.*.merge)
-		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+		__gitcomp "$(__git_refs)"
 		return
 		;;
 	remote.*.fetch)
 		local remote="${prv#remote.}"
 		remote="${remote%.fetch}"
-		COMPREPLY=($(compgen -W "$(__git_refs_remotes "$remote")" \
-			-- "$cur"))
+		__gitcomp "$(__git_refs_remotes "$remote")"
 		return
 		;;
 	remote.*.push)
 		local remote="${prv#remote.}"
 		remote="${remote%.push}"
-		COMPREPLY=($(compgen -W "$(git --git-dir="$(__gitdir)" \
+		__gitcomp "$(git --git-dir="$(__gitdir)" \
 			for-each-ref --format='%(refname):%(refname)' \
-			refs/heads)" -- "$cur"))
+			refs/heads)"
+		return
+		;;
+	pull.twohead|pull.octopus)
+		__gitcomp "$(__git_merge_strategies)"
+		return
+		;;
+	color.branch|color.diff|color.status)
+		__gitcomp "always never auto"
+		return
+		;;
+	color.*.*)
+		__gitcomp "
+			black red green yellow blue magenta cyan white
+			bold dim ul blink reverse
+			"
 		return
 		;;
 	*.*)
@@ -695,41 +714,39 @@ _git_config ()
 	esac
 	case "$cur" in
 	--*)
-		COMPREPLY=($(compgen -W "
+		__gitcomp "
 			--global --list --replace-all
 			--get --get-all --get-regexp
 			--unset --unset-all
-			" -- "$cur"))
+			"
 		return
 		;;
 	branch.*.*)
 		local pfx="${cur%.*}."
 		cur="${cur##*.}"
-		COMPREPLY=($(compgen -P "$pfx" -W "remote merge" -- "$cur"))
+		__gitcomp "remote merge" "$pfx" "$cur"
 		return
 		;;
 	branch.*)
 		local pfx="${cur%.*}."
 		cur="${cur#*.}"
-		COMPREPLY=($(compgen -P "$pfx" -S . \
-			-W "$(__git_heads)" -- "$cur"))
+		__gitcomp "$(__git_heads)" "$pfx" "$cur" "."
 		return
 		;;
 	remote.*.*)
 		local pfx="${cur%.*}."
 		cur="${cur##*.}"
-		COMPREPLY=($(compgen -P "$pfx" -W "url fetch push" -- "$cur"))
+		__gitcomp "url fetch push" "$pfx" "$cur"
 		return
 		;;
 	remote.*)
 		local pfx="${cur%.*}."
 		cur="${cur#*.}"
-		COMPREPLY=($(compgen -P "$pfx" -S . \
-			-W "$(__git_remotes)" -- "$cur"))
+		__gitcomp "$(__git_remotes)" "$pfx" "$cur" "."
 		return
 		;;
 	esac
-	COMPREPLY=($(compgen -W "
+	__gitcomp "
 		apply.whitespace
 		core.fileMode
 		core.gitProxy
@@ -741,40 +758,67 @@ _git_config ()
 		core.warnAmbiguousRefs
 		core.compression
 		core.legacyHeaders
-		i18n.commitEncoding
-		i18n.logOutputEncoding
-		diff.color
+		core.packedGitWindowSize
+		core.packedGitLimit
+		color.branch
+		color.branch.current
+		color.branch.local
+		color.branch.remote
+		color.branch.plain
 		color.diff
-		diff.renameLimit
-		diff.renames
-		pager.color
+		color.diff.plain
+		color.diff.meta
+		color.diff.frag
+		color.diff.old
+		color.diff.new
+		color.diff.commit
+		color.diff.whitespace
 		color.pager
-		status.color
 		color.status
-		log.showroot
-		show.difftree
-		showbranch.default
-		whatchanged.difftree
+		color.status.header
+		color.status.added
+		color.status.changed
+		color.status.untracked
+		diff.renameLimit
+		diff.renames
+		fetch.unpackLimit
+		format.headers
+		gitcvs.enabled
+		gitcvs.logfile
+		gc.reflogexpire
+		gc.reflogexpireunreachable
+		gc.rerereresolved
+		gc.rerereunresolved
 		http.sslVerify
 		http.sslCert
 		http.sslKey
 		http.sslCAInfo
 		http.sslCAPath
 		http.maxRequests
-		http.lowSpeedLimit http.lowSpeedTime
+		http.lowSpeedLimit
+		http.lowSpeedTime
 		http.noEPSV
+		i18n.commitEncoding
+		i18n.logOutputEncoding
+		log.showroot
+		merge.summary
+		merge.verbosity
 		pack.window
+		pull.octopus
+		pull.twohead
 		repack.useDeltaBaseOffset
-		pull.octopus pull.twohead
-		merge.summary
+		show.difftree
+		showbranch.default
+		tar.umask
+		transfer.unpackLimit
 		receive.unpackLimit
 		receive.denyNonFastForwards
-		user.name user.email
-		tar.umask
-		gitcvs.enabled
-		gitcvs.logfile
+		user.name
+		user.email
+		user.signingkey
+		whatchanged.difftree
 		branch. remote.
-	" -- "$cur"))
+	"
 }
 
 _git_reset ()
-- 
1.5.0.rc3.22.g5057
