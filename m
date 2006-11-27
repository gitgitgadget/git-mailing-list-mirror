X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 9/10] Allow completion of --committer and --author arguments to git log.
Date: Mon, 27 Nov 2006 03:42:28 -0500
Message-ID: <20061127084228.GI19745@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:42:47 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32400>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc4R-0007ky-3E for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757425AbWK0Imc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757441AbWK0Imc
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:42:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:12684 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757425AbWK0Imb
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:42:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc4J-0004Vy-QW; Mon, 27 Nov 2006 03:42:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 569B920FB7F; Mon, 27 Nov 2006 03:42:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This is just a cute hack, but we can (easily) complete the parameter
to --author or --committer in bash by asking for all possible authors
or committers in this project from git log and offering them up as
valid choices.

We replace spaces with dots as this prevents names with spaces from
appearing as two parameters rather than one, yet it still matches the
space in the field.

Currently my Mac OS X system takes ~5 seconds to compute the completions
for --author on git.git and ~4 seconds to compute the completions for
--committer on same.  I imagine it would take longer on more active
projects, but its a good way to see if the name you are entering is
going to be unique or not.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8acfb09..b456a3b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -360,6 +360,26 @@ _git_log ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
+	--committer=*)
+		COMPREPLY=($(compgen -W "$(git log --pretty=raw --all \
+			| sed -n -e "/^committer /{
+				s/^committer //
+				s/ <.*//
+				s/ /./g
+				p
+			}")" -- "${cur##--committer=}"))
+		return
+		;;
+	--author=*)
+		COMPREPLY=($(compgen -W "$(git log --pretty=raw --all \
+			| sed -n -e "/^author /{
+				s/^author //
+				s/ <.*//
+				s/ /./g
+				p
+			}")" -- "${cur##--author=}"))
+		return
+		;;
 	--pretty=*)
 		COMPREPLY=($(compgen -W "
 			oneline short medium full fuller email raw
-- 
1.4.4.1.ge3fb
