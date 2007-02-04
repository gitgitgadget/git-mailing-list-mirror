From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/8] bash: Add space after unique command name is completed.
Date: Sun, 4 Feb 2007 02:38:27 -0500
Message-ID: <20070204073827.GD17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 08:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDbxJ-0007PP-Vk
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 08:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbXBDHic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 02:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbXBDHib
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 02:38:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55513 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbXBDHia (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 02:38:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDbxD-0008Vy-Ti; Sun, 04 Feb 2007 02:38:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 792E220FBAE; Sun,  4 Feb 2007 02:38:27 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38658>

Because we use the nospace option for our completion function for
the main 'git' wrapper bash won't automatically add a space after a
unique completion has been made by the user.  This has been pointed
out in the past by Linus Torvalds as an undesired behavior.  I agree.

We have to use the nospace option to ensure path completion for
a command such as `git show` works properly, but that breaks the
common case of getting the space for a unique completion.  So now we
set IFS=$'\n' (linefeed) and add a trailing space to every possible
completion option.  This causes bash to insert the space when the
completion is unique.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 93f2af5..1cf576e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -61,6 +61,20 @@ __git_ps1 ()
 	fi
 }
 
+__gitcomp ()
+{
+	local all c s=$'\n' IFS=' '$'\t'$'\n'
+	for c in $1; do
+		case "$c" in
+		--*=*) all="$all$c$s" ;;
+		*)     all="$all$c $s" ;;
+		esac
+	done
+	IFS=$s
+	COMPREPLY=($(compgen -W "$all" -- "${COMP_WORDS[COMP_CWORD]}"))
+	return
+}
+
 __git_heads ()
 {
 	local cmd i is_hash=y dir="$(__gitdir "$1")"
@@ -787,12 +801,12 @@ _git ()
 	done
 
 	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
-		COMPREPLY=($(compgen -W "
-			--git-dir= --version --exec-path
-			$(__git_commands)
-			$(__git_aliases)
-			" -- "${COMP_WORDS[COMP_CWORD]}"))
-		return;
+		case "${COMP_WORDS[COMP_CWORD]}" in
+		--*=*) COMPREPLY=() ;;
+		--*)   __gitcomp "--git-dir= --bare --version --exec-path" ;;
+		*)     __gitcomp "$(__git_commands) $(__git_aliases)" ;;
+		esac
+		return
 	fi
 
 	local expansion=$(__git_aliased_command "$command")
-- 
1.5.0.rc3.22.g5057
