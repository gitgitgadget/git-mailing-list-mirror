X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/4] Cache the list of merge strategies and available commands during load.
Date: Mon, 27 Nov 2006 15:11:52 -0500
Message-ID: <20061127201152.GC7308@spearce.org>
References: <139669072795537547ec26b69115509100dcd7ec.1164658223.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 20:12:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <139669072795537547ec26b69115509100dcd7ec.1164658223.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32444>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gompf-0000yR-3t for gcvg-git@gmane.org; Mon, 27 Nov
 2006 21:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758554AbWK0UMA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 15:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758558AbWK0UL7
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 15:11:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57503 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758554AbWK0UL7
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 15:11:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GompQ-0006QQ-JL; Mon, 27 Nov 2006 15:11:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1398420FB7F; Mon, 27 Nov 2006 15:11:52 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Since the user's git installation is not likely to grow a new command
or merge strategy in the lifespan of the current shell process we can
save time during completion operations by caching these lists during
sourcing of the completion support.

If the git executable is not available or we run into errors while
caching at load time then we defer these to runtime and generate
the list on the fly.  This might happen if the user doesn't put git
into their PATH until after the completion script gets sourced.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 This is by request of Junio.  :-)

 contrib/completion/git-completion.bash |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d4eb138..ba3adb6 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -18,7 +18,13 @@
 #    2) Added the following line to your .bashrc:
 #        source ~/.git-completion.sh
 #
-#    3) Consider changing your PS1 to also show the current branch:
+#    3) You may want to make sure the git executable is available
+#       in your PATH before this script is sourced, as some caching
+#       is performed while the script loads.  If git isn't found
+#       at source time then all lookups will be done on demand,
+#       which may be slightly slower.
+#
+#    4) Consider changing your PS1 to also show the current branch:
 #        PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
 #
 #       The argument to __git_ps1 will be displayed only if you
@@ -150,6 +156,10 @@ __git_remotes ()
 
 __git_merge_strategies ()
 {
+	if [ -n "$__git_merge_strategylist" ]; then
+		echo "$__git_merge_strategylist"
+		return
+	fi
 	sed -n "/^all_strategies='/{
 		s/^all_strategies='//
 		s/'//
@@ -157,6 +167,8 @@ __git_merge_strategies ()
 		q
 		}" "$(git --exec-path)/git-merge"
 }
+__git_merge_strategylist=
+__git_merge_strategylist="$(__git_merge_strategies 2>/dev/null)"
 
 __git_complete_file ()
 {
@@ -214,6 +226,10 @@ __git_complete_revlist ()
 
 __git_commands ()
 {
+	if [ -n "$__git_commandlist" ]; then
+		echo "$__git_commandlist"
+		return
+	fi
 	local i IFS=" "$'\n'
 	for i in $(git help -a|egrep '^ ')
 	do
@@ -263,6 +279,8 @@ __git_commands ()
 		esac
 	done
 }
+__git_commandlist=
+__git_commandlist="$(__git_commands 2>/dev/null)"
 
 __git_aliases ()
 {
-- 
1.4.4.1.ge3fb
