X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/6] Bash completion support for remotes in .git/config.
Date: Sun, 5 Nov 2006 06:21:03 -0500
Message-ID: <20061105112103.GC20495@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 11:21:43 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30967>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggg4E-000758-Qy for gcvg-git@gmane.org; Sun, 05 Nov
 2006 12:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932645AbWKELVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 06:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWKELVJ
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 06:21:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45440 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932645AbWKELVG
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 06:21:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggg3h-0008NE-R2; Sun, 05 Nov 2006 06:21:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E030120E491; Sun,  5 Nov 2006 06:21:03 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now that Git natively supports remote specifications within the
config file such as:

	[remote "origin"]
		url = ...

we should provide bash completion support "out of the box" for
these remotes, just like we do for the .git/remotes directory.

Also cleaned up the __git_aliases expansion to use the same form
of querying and filtering repo-config as this saves two fork/execs
in the middle of a user prompted completion.  Finally also forced
the variable 'word' to be local within __git_aliased_command.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 926638d..5f1be46 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -59,12 +59,21 @@ __git_refs2 ()
 
 __git_remotes ()
 {
-	local i REVERTGLOB=$(shopt -p nullglob)
+	local i ngoff IFS=$'\n'
+	shopt -q nullglob || ngoff=1
 	shopt -s nullglob
 	for i in .git/remotes/*; do
 		echo ${i#.git/remotes/}
 	done
-	$REVERTGLOB
+	[ "$ngoff" ] && shopt -u nullglob
+	for i in $(git repo-config --list); do
+		case "$i" in
+		remote.*.url=*)
+			i="${i#remote.}"
+			echo "${i/.url=*/}"
+			;;
+		esac
+	done
 }
 
 __git_complete_file ()
@@ -103,13 +112,20 @@ __git_complete_file ()
 
 __git_aliases ()
 {
-	git repo-config --list | grep '^alias\.' \
-		| sed -e 's/^alias\.//' -e 's/=.*$//'
+	local i IFS=$'\n'
+	for i in $(git repo-config --list); do
+		case "$i" in
+		alias.*)
+			i="${i#alias.}"
+			echo "${i/=*/}"
+			;;
+		esac
+	done
 }
 
 __git_aliased_command ()
 {
-	local cmdline=$(git repo-config alias.$1)
+	local word cmdline=$(git repo-config --get "alias.$1")
 	for word in $cmdline; do
 		if [ "${word##-*}" ]; then
 			echo $word
-- 
1.4.3.3.g9621
