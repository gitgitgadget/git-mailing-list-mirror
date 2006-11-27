X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 12/10] Teach bash about git-repo-config.
Date: Mon, 27 Nov 2006 04:44:47 -0500
Message-ID: <20061127094447.GA19273@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 09:45:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
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
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32407>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1God2o-000425-EN for gcvg-git@gmane.org; Mon, 27 Nov
 2006 10:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757655AbWK0Joz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 04:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757658AbWK0Joz
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 04:44:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:29075 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757655AbWK0Joy
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 04:44:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1God2g-0007v5-7P; Mon, 27 Nov 2006 04:44:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9BC2D20FB7F; Mon, 27 Nov 2006 04:44:48 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This is a really ugly completion script for git-repo-config, but it has
some nice properties.  I've added all of the documented configuration
parameters from Documentation/config.txt to the script, allowing the
user to complete any standard configuration parameter name.

We also have some intelligence for the remote.*.* and branch.*.* keys
by completing not only the key name (e.g. remote.origin) but also the
values (e.g. remote.*.fetch completes to the branches available on the
corresponding remote).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Yes, that's it.  I'm finally done tinkering with bash
 completion support for this week.  Total of 12 patches.
 Sorry about the numbering Junio; when I sent the first 10
 I thought I was going to bed, but then decided to stay
 up and hack a bit more...

 I know Linus would like to see the space thing corrected.
 I'll try to look at it next week if nobody beats me to it.

 contrib/completion/git-completion.bash |  154 ++++++++++++++++++++++++++++++++
 1 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 47b393d..a957165 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -43,6 +43,27 @@ __git_ps1 ()
 	fi
 }
 
+__git_heads ()
+{
+	local cmd i is_hash=y dir="${1:-$(__gitdir)}"
+	if [ -d "$dir" ]; then
+		for i in $(git --git-dir="$dir" \
+			for-each-ref --format='%(refname)' \
+			refs/heads ); do
+			echo "${i#refs/heads/}"
+		done
+		return
+	fi
+	for i in $(git-ls-remote "$dir" 2>/dev/null); do
+		case "$is_hash,$i" in
+		y,*) is_hash=n ;;
+		n,*^{}) is_hash=y ;;
+		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}" ;;
+		n,*) is_hash=y; echo "$i" ;;
+		esac
+	done
+}
+
 __git_refs ()
 {
 	local cmd i is_hash=y dir="${1:-$(__gitdir)}"
@@ -91,6 +112,23 @@ __git_refs2 ()
 	done
 }
 
+__git_refs_remotes ()
+{
+	local cmd i is_hash=y
+	for i in $(git-ls-remote "$1" 2>/dev/null); do
+		case "$is_hash,$i" in
+		n,refs/heads/*)
+			is_hash=y
+			echo "$i:refs/remotes/$1/${i#refs/heads/}"
+			;;
+		y,*) is_hash=n ;;
+		n,*^{}) is_hash=y ;;
+		n,refs/tags/*) is_hash=y;;
+		n,*) is_hash=y; ;;
+		esac
+	done
+}
+
 __git_remotes ()
 {
 	local i ngoff IFS=$'\n' d="$(__gitdir)"
@@ -520,6 +558,119 @@ _git_rebase ()
 	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
+_git_repo_config ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local prv="${COMP_WORDS[COMP_CWORD-1]}"
+	case "$prv" in
+	branch.*.remote)
+		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		return
+		;;
+	branch.*.merge)
+		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+		return
+		;;
+	remote.*.fetch)
+		local remote="${prv#remote.}"
+		remote="${remote%.fetch}"
+		COMPREPLY=($(compgen -W "$(__git_refs_remotes "$remote")" \
+			-- "$cur"))
+		return
+		;;
+	remote.*.push)
+		local remote="${prv#remote.}"
+		remote="${remote%.push}"
+		COMPREPLY=($(compgen -W "$(git --git-dir="$(__gitdir)" \
+			for-each-ref --format='%(refname):%(refname)' \
+			refs/heads)" -- "$cur"))
+		return
+		;;
+	*.*)
+		COMPREPLY=()
+		return
+		;;
+	esac
+	case "$cur" in
+	--*)
+		COMPREPLY=($(compgen -W "
+			--global --list --replace-all
+			--get --get-all --get-regexp
+			--unset --unset-all
+			" -- "$cur"))
+		return
+		;;
+	branch.*.*)
+		local pfx="${cur%.*}."
+		cur="${cur##*.}"
+		COMPREPLY=($(compgen -P "$pfx" -W "remote merge" -- "$cur"))
+		return
+		;;
+	branch.*)
+		local pfx="${cur%.*}."
+		cur="${cur#*.}"
+		COMPREPLY=($(compgen -P "$pfx" -S . \
+			-W "$(__git_heads)" -- "$cur"))
+		return
+		;;
+	remote.*.*)
+		local pfx="${cur%.*}."
+		cur="${cur##*.}"
+		COMPREPLY=($(compgen -P "$pfx" -W "url fetch push" -- "$cur"))
+		return
+		;;
+	remote.*)
+		local pfx="${cur%.*}."
+		cur="${cur#*.}"
+		COMPREPLY=($(compgen -P "$pfx" -S . \
+			-W "$(__git_remotes)" -- "$cur"))
+		return
+		;;
+	esac
+	COMPREPLY=($(compgen -W "
+		apply.whitespace
+		core.fileMode
+		core.gitProxy
+		core.ignoreStat
+		core.preferSymlinkRefs
+		core.logAllRefUpdates
+		core.repositoryFormatVersion
+		core.sharedRepository
+		core.warnAmbiguousRefs
+		core.compression
+		core.legacyHeaders
+		i18n.commitEncoding
+		diff.color
+		diff.renameLimit
+		diff.renames
+		pager.color
+		status.color
+		log.showroot
+		show.difftree
+		showbranch.default
+		whatchanged.difftree
+		http.sslVerify
+		http.sslCert
+		http.sslKey
+		http.sslCAInfo
+		http.sslCAPath
+		http.maxRequests
+		http.lowSpeedLimit http.lowSpeedTime
+		http.noEPSV
+		pack.window
+		repack.useDeltaBaseOffset
+		pull.octopus pull.twohead
+		merge.summary
+		receive.unpackLimit
+		receive.denyNonFastForwards
+		user.name user.email
+		tar.umask
+		gitcvs.enabled
+		gitcvs.logfile
+		branch. remote.
+	" -- "$cur"))
+}
+
 _git_reset ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -572,6 +723,7 @@ _git ()
 	pull)        _git_pull ;;
 	push)        _git_push ;;
 	rebase)      _git_rebase ;;
+	repo-config) _git_repo_config ;;
 	reset)       _git_reset ;;
 	show)        _git_log ;;
 	show-branch) _git_log ;;
@@ -605,6 +757,7 @@ complete -o default            -F _git_name_rev git-name-rev
 complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
 complete -o default            -F _git_rebase git-rebase
+complete -o default            -F _git_repo_config git-repo-config
 complete -o default            -F _git_reset git-reset
 complete -o default            -F _git_log git-show
 complete -o default -o nospace -F _git_log git-show-branch
@@ -626,6 +779,7 @@ complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
 complete -o default            -F _git_merge_base git-merge-base.exe
 complete -o default            -F _git_name_rev git-name-rev.exe
 complete -o default -o nospace -F _git_push git-push.exe
+complete -o default            -F _git_repo_config git-repo-config
 complete -o default -o nospace -F _git_log git-show.exe
 complete -o default -o nospace -F _git_log git-show-branch.exe
 complete -o default -o nospace -F _git_log git-whatchanged.exe
-- 
