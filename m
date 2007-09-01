From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Teach bash about completing arguments for git-tag
Date: Fri, 31 Aug 2007 23:49:05 -0400
Message-ID: <20070901034905.GA22893@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 05:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRJzP-0002zM-MX
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 05:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbXIADtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 23:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbXIADtK
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 23:49:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59392 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbXIADtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 23:49:09 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IRJyg-0003dQ-T6; Fri, 31 Aug 2007 23:48:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AEB3520FBAE; Fri, 31 Aug 2007 23:49:05 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57249>

Please pull from:

   repo.or.cz:/srv/git/git/fastimport.git master

-->8--
Lately I have been doing a lot of calls to `git tag -d` and also to
`git tag -v`.  In both such cases being able to complete the names
of existing tags saves the fingers some typing effort.  We now look
for the -d or -v option to git-tag in the bash completion support
and offer up existing tag names as possible choices for these.

When creating a new tag we now also offer bash completion support
for the second argument to git-tag (the object to be tagged) as this
can often be a specific existing branch name and is not necessarily
the current HEAD.

If the -f option is being used to recreate an existing tag we now
also offer completion support on the existing tag names for the
first argument of git-tag, helping to the user to reselect the
prior tag name that they are trying to replace.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   58 ++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5ed1821..cad842a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -114,6 +114,27 @@ __git_heads ()
 	done
 }
 
+__git_tags ()
+{
+	local cmd i is_hash=y dir="$(__gitdir "$1")"
+	if [ -d "$dir" ]; then
+		for i in $(git --git-dir="$dir" \
+			for-each-ref --format='%(refname)' \
+			refs/tags ); do
+			echo "${i#refs/tags/}"
+		done
+		return
+	fi
+	for i in $(git-ls-remote "$1" 2>/dev/null); do
+		case "$is_hash,$i" in
+		y,*) is_hash=n ;;
+		n,*^{}) is_hash=y ;;
+		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}" ;;
+		n,*) is_hash=y; echo "$i" ;;
+		esac
+	done
+}
+
 __git_refs ()
 {
 	local cmd i is_hash=y dir="$(__gitdir "$1")"
@@ -1050,6 +1071,40 @@ _git_submodule ()
 	fi
 }
 
+_git_tag ()
+{
+	local i c=1 f=0
+	while [ $c -lt $COMP_CWORD ]; do
+		i="${COMP_WORDS[c]}"
+		case "$i" in
+		-d|-v)
+			__gitcomp "$(__git_tags)"
+			return
+			;;
+		-f)
+			f=1
+			;;
+		esac
+		c=$((++c))
+	done
+
+	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	-m|-F)
+		COMPREPLY=()
+		;;
+	-*|tag|git-tag)
+		if [ $f = 1 ]; then
+			__gitcomp "$(__git_tags)"
+		else
+			COMPREPLY=()
+		fi
+		;;
+	*)
+		__gitcomp "$(__git_refs)"
+		;;
+	esac
+}
+
 _git ()
 {
 	local i c=1 command __git_dir
@@ -1117,6 +1172,7 @@ _git ()
 	show-branch) _git_log ;;
 	stash)       _git_stash ;;
 	submodule)   _git_submodule ;;
+	tag)         _git_tag ;;
 	whatchanged) _git_log ;;
 	*)           COMPREPLY=() ;;
 	esac
@@ -1167,6 +1223,7 @@ complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_stash git-stash
 complete -o default -o nospace -F _git_submodule git-submodule
 complete -o default -o nospace -F _git_log git-show-branch
+complete -o default -o nospace -F _git_tag git-tag
 complete -o default -o nospace -F _git_log git-whatchanged
 
 # The following are necessary only for Cygwin, and only are needed
@@ -1192,5 +1249,6 @@ complete -o default -o nospace -F _git_config git-config
 complete -o default -o nospace -F _git_shortlog git-shortlog.exe
 complete -o default -o nospace -F _git_show git-show.exe
 complete -o default -o nospace -F _git_log git-show-branch.exe
+complete -o default -o nospace -F _git_tag git-tag.exe
 complete -o default -o nospace -F _git_log git-whatchanged.exe
 fi
-- 
1.5.3.rc7.16.ge340d
