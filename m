X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 10/10] Support bash completion of refs/remote.
Date: Mon, 27 Nov 2006 03:42:32 -0500
Message-ID: <20061127084232.GJ19745@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:42:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32399>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc4W-0007lZ-3I for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757441AbWK0Img (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757443AbWK0Img
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:42:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:13964 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757441AbWK0Imf
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:42:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc4O-0004WG-34; Mon, 27 Nov 2006 03:42:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8E80120FB7F; Mon, 27 Nov 2006 03:42:32 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now that people are really likely to start using separate remotes
(due to the default in git-clone changing) we should support ref
completion for these refs in as many commands as possible.

While we are working on this routine we should use for-each-ref
to obtain a list of local refs, as this should run faster than
peek-remote as it does not need to dereference tag objects in
order to produce the list of refs back to us.  It should also
be more friendly to users of StGIT as we won't generate a list
of the StGIT metadata refs.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b456a3b..df67f8e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -47,16 +47,26 @@ __git_refs ()
 {
 	local cmd i is_hash=y dir="${1:-$(__gitdir)}"
 	if [ -d "$dir" ]; then
-		cmd=git-peek-remote
-	else
-		cmd=git-ls-remote
+		if [ -e "$dir/HEAD" ]; then echo HEAD; fi
+		for i in $(git --git-dir="$dir" \
+			for-each-ref --format='%(refname)' \
+			refs/tags refs/heads refs/remotes); do
+			case "$i" in
+				refs/tags/*)    echo "${i#refs/tags/}" ;;
+				refs/heads/*)   echo "${i#refs/heads/}" ;;
+				refs/remotes/*) echo "${i#refs/remotes/}" ;;
+				*)              echo "$i" ;;
+			esac
+		done
+		return
 	fi
-	for i in $($cmd "$dir" 2>/dev/null); do
+	for i in $(git-ls-remote "$dir" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
 		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}" ;;
 		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}" ;;
+		n,refs/remotes/*) is_hash=y; echo "${i#refs/remotes/}" ;;
 		n,*) is_hash=y; echo "$i" ;;
 		esac
 	done
-- 
