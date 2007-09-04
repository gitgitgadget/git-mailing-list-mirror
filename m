From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Tue, 4 Sep 2007 03:13:01 -0400
Message-ID: <20070904071301.GA18160@spearce.org>
References: <11886421573285-git-send-email-robin.rosenberg@dewire.com> <200709020152.30070.robin.rosenberg@dewire.com> <20070902101825.1938C576FA@dx.sixt.local> <200709021240.36807.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 09:13:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISSbG-0006RV-FV
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 09:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbXIDHNW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 03:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXIDHNV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 03:13:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37577 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbXIDHNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 03:13:21 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ISSas-0006NX-IS; Tue, 04 Sep 2007 03:13:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EEA5120FBAE; Tue,  4 Sep 2007 03:13:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200709021240.36807.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57536>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This patch makes the git prompt (when enabled) show if a merge or a
> rebase is unfinished. It also detects if a bisect is being done as
> well as detached checkouts.
 
What about this instead?

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cad842a..41a558c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -64,12 +64,41 @@ __gitdir ()
 
 __git_ps1 ()
 {
-	local b="$(git symbolic-ref HEAD 2>/dev/null)"
-	if [ -n "$b" ]; then
+	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	if [ -n "$g" ]; then
+		local r
+		local b
+		if [ -d "$g/../.dotest" ]
+		then
+			r="|AM/REBASE"
+			b="$(git symbolic-ref HEAD 2>/dev/null)"
+		elif [ -f "$g/.dotest-merge/interactive" ]
+		then
+			r="|REBASE-i"
+			b="$(cat $g/.dotest-merge/head-name)"
+		elif [ -d "$g/.dotest-merge" ]
+		then
+			r="|REBASE-m"
+			b="$(cat $g/.dotest-merge/head-name)"
+		elif [ -f "$g/MERGE_HEAD" ]
+		then
+			r="|MERGING"
+			b="$(git symbolic-ref HEAD 2>/dev/null)"
+		else
+			if [ -f $g/BISECT_LOG ]
+			then
+				r="|BISECTING"
+			fi
+			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
+			then
+				b="$(cut -c1-7 $g/HEAD)..."
+			fi
+		fi
+
 		if [ -n "$1" ]; then
-			printf "$1" "${b##refs/heads/}"
+			printf "$1" "${b##refs/heads/}$r"
 		else
-			printf " (%s)" "${b##refs/heads/}"
+			printf " (%s)" "${b##refs/heads/}$r"
 		fi
 	fi
 }

-- 
Shawn.
