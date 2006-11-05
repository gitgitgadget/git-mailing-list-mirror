X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/6] Remove more sed invocations from within bash completion.
Date: Sun, 5 Nov 2006 06:25:25 -0500
Message-ID: <20061105112525.GF20495@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 11:25:42 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30971>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggg83-0007t0-Ni for gcvg-git@gmane.org; Sun, 05 Nov
 2006 12:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932652AbWKELZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 06:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWKELZ2
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 06:25:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:25217 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932652AbWKELZ2
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 06:25:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggg7v-000092-2V; Sun, 05 Nov 2006 06:25:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 355CF20E491; Sun,  5 Nov 2006 06:25:25 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This change removes between 1 and 4 sed invocations per completion
entered by the user.  In the case of cat-file the 4 invocations per
completion can take a while on Cygwin; running these replacements
directly within bash saves some time for the end user.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 74be651..f3be132 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -83,15 +83,15 @@ __git_remotes ()
 
 __git_complete_file ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local pfx ls ref cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	?*:*)
-		local pfx ls ref="$(echo "$cur" | sed 's,:.*$,,')"
-		cur="$(echo "$cur" | sed 's,^.*:,,')"
+		ref="${cur%%:*}"
+		cur="${cur#*:}"
 		case "$cur" in
 		?*/*)
-			pfx="$(echo "$cur" | sed 's,/[^/]*$,,')"
-			cur="$(echo "$cur" | sed 's,^.*/,,')"
+			pfx="${cur%/*}"
+			cur="${cur##*/}"
 			ls="$ref:$pfx"
 			pfx="$pfx/"
 			;;
@@ -193,7 +193,7 @@ _git_fetch ()
 	*)
 		case "$cur" in
 		*:*)
-	        cur=$(echo "$cur" | sed 's/^.*://')
+			cur="${cur#*:}"
 			COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 			;;
 		*)
@@ -287,7 +287,7 @@ _git_push ()
 			git-push)  remote="${COMP_WORDS[1]}" ;;
 			git)       remote="${COMP_WORDS[2]}" ;;
 			esac
-	        cur=$(echo "$cur" | sed 's/^.*://')
+			cur="${cur#*:}"
 			COMPREPLY=($(compgen -W "$(__git_refs "$remote")" -- "$cur"))
 			;;
 		*)
-- 
