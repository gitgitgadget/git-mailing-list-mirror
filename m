From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Mon, 18 Sep 2006 13:42:25 -0400
Message-ID: <20060918174225.GC31140@spearce.org>
References: <20060918004831.GA19851@spearce.org> <7virjlr3am.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 19:42:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPN8l-0004fW-OS
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 19:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbWIRRma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 13:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWIRRma
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 13:42:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48591 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751862AbWIRRm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 13:42:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPN8P-0008QE-Dk; Mon, 18 Sep 2006 13:42:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B4D4E20E48E; Mon, 18 Sep 2006 13:42:25 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virjlr3am.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27253>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > +_git_log ()
> > +{
> > +...
> > +}
> > +...
> > +_git_whatchanged ()
> > +{
> > +...
> > +}
> 
> These two look the same.  Probably not very easy to maintain in
> the long run.

They are the same.
 
> It would be nice to have git-show as well but it usually does
> not take ranges unlike these two. It is more like "git branch"
> from completion purposes.

Like this?  :-)

-- >8 --
Consolidated git_log and git_whatchanged; added git_show.

Minor requests from Junio: Consolidate the identical implementations of
git_log and git_whatchanged, especially since these two commands take
pretty much identical arguments.  This should make the completion package
a little easier to maintain.

Also added branch name completion for git-show.  I tried to implement
--pretty=oneline (etc.) but am apparently missing something as bash did
not want to complete it through the registered completion routine, so that's
still unsupported.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/bash-git-completion.sh |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/contrib/bash-git-completion.sh b/contrib/bash-git-completion.sh
index 4800185..e8cf6bb 100644
--- a/contrib/bash-git-completion.sh
+++ b/contrib/bash-git-completion.sh
@@ -254,19 +254,10 @@ _git_push ()
 	esac
 }
 
-_git_whatchanged ()
+_git_show ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	case "$cur" in
-	*..*)
-		local pfx=$(echo "$cur" | sed 's/\.\..*$/../')
-		cur=$(echo "$cur" | sed 's/^.*\.\.//')
-		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs .)" -- "$cur"))
-		;;
-	*)
-		COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
-		;;
-	esac
+	COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
 }
 
 _git ()
@@ -288,7 +279,8 @@ _git ()
 		ls-tree)     _git_ls_tree ;;
 		pull)        _git_pull ;;
 		push)        _git_push ;;
-		whatchanged) _git_whatchanged ;;
+		show)        _git_show ;;
+		whatchanged) _git_log ;;
 		*)           COMPREPLY=() ;;
 		esac
 	fi
@@ -314,7 +306,8 @@ complete -o default -o nospace -F _git_l
 complete -o default            -F _git_merge_base git-merge-base
 complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
-complete -o default -o nospace -F _git_whatchanged git-whatchanged
+complete -o default            -F _git_show git-show
+complete -o default -o nospace -F _git_log git-whatchanged
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
@@ -327,4 +320,4 @@ complete -o default -o nospace -F _git_l
 complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
 complete -o default            -F _git_merge_base git-merge-base.exe
 complete -o default -o nospace -F _git_push git-push.exe
-complete -o default -o nospace -F _git_whatchanged git-whatchanged.exe
+complete -o default -o nospace -F _git_log git-whatchanged.exe
-- 
1.4.2.1.ga817
