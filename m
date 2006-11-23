X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] git-fetch: reuse ls-remote result.
Date: Wed, 22 Nov 2006 23:24:04 -0800
Message-ID: <7vbqmylj6z.fsf@assigned-by-dhcp.cox.net>
References: <200611222213.44336.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 07:24:25 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32118>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn8wU-0002LW-LN for gcvg-git@gmane.org; Thu, 23 Nov
 2006 08:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757284AbWKWHYH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 02:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757287AbWKWHYG
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 02:24:06 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:26515 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1757284AbWKWHYF
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 02:24:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123072404.FNKP5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 02:24:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id q7QC1V00D1kojtg0000000; Thu, 23 Nov 2006
 02:24:12 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This will become necessary to update the dumb protocol
transports to fetch from a repository with packed and then
pruned tags.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * I am doing this to allow dumb protocol transports to work
   with a repository with packed and then pruned refs, but it
   should be reusable for other purposes, such as wildcarding the
   refspecs Andy is interested in.

 git-fetch.sh |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index eb32476..170c2cb 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -88,6 +88,10 @@ then
 	: >"$GIT_DIR/FETCH_HEAD"
 fi
 
+# Global that is reused later
+ls_remote_result=$(git ls-remote $upload_pack "$remote") ||
+	die "Cannot find the reflist at $remote"
+
 append_fetch_head () {
     head_="$1"
     remote_="$2"
@@ -233,10 +237,7 @@ reflist=$(get_remote_refs_for_fetch "$@"
 if test "$tags"
 then
 	taglist=`IFS="	" &&
-		  (
-			git-ls-remote $upload_pack --tags "$remote" ||
-			echo fail ouch
-		  ) |
+		  echo "$ls_remote_result" |
 	          while read sha1 name
 		  do
 			case "$sha1" in
@@ -245,6 +246,8 @@ then
 			esac
 			case "$name" in
 			*^*) continue ;;
+			refs/tags/*) ;;
+			*) continue ;;
 			esac
 		  	if git-check-ref-format "$name"
 			then
@@ -431,7 +434,7 @@ case "$no_tags$tags" in
 		# effective only when we are following remote branch
 		# using local tracking branch.
 		taglist=$(IFS=" " &&
-		git-ls-remote $upload_pack --tags "$remote" |
+		echo "$ls_remote_result" |
 		sed -n	-e 's|^\('"$_x40"'\)	\(refs/tags/.*\)^{}$|\1 \2|p' \
 			-e 's|^\('"$_x40"'\)	\(refs/tags/.*\)$|\1 \2|p' |
 		while read sha1 name
-- 
1.4.4.1.g77614

