X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge: allow merging into a yet-to-be-born branch.
Date: Tue, 21 Nov 2006 21:24:05 -0800
Message-ID: <7vlkm4vytm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 05:24:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32066>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmkaj-0003n7-IO for gcvg-git@gmane.org; Wed, 22 Nov
 2006 06:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161764AbWKVFYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 00:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756795AbWKVFYJ
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 00:24:09 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64190 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1756775AbWKVFYI
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 00:24:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122052405.DRPC5575.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Wed, 22
 Nov 2006 00:24:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id phPc1V00B1kojtg0000000; Wed, 22 Nov 2006
 00:23:36 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is not useful in a freshly initialized repository, since
   it would not have any commits that you can use with the
   command.  But you can push into the repository and then later
   use the updated branch to merge into your 'master' branch
   that still does not exist yet.

 git-merge.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 25deb1e..dd4e83d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -159,6 +159,24 @@ then
 	shift
 	head_arg="$1"
 	shift
+elif ! git-rev-parse --verify HEAD 2>/dev/null
+then
+	# If the merged head is a valid one there is no reason to
+	# forbid "git merge" into a branch yet to be born.  We do
+	# the same for "git pull".
+	if test 1 -ne $#
+	then
+		echo >&2 "Can merge only exactly one commit into empty head"
+		exit 1
+	fi
+
+	rh=$(git rev-parse --verify "$1^0") ||
+		die "$1 - not something we can merge"
+
+	git-update-ref -m "initial pull" HEAD "$rh" "" &&
+	git-read-tree --reset -u HEAD
+	exit
+
 else
 	# We are invoked directly as the first-class UI.
 	head_arg=HEAD
-- 
1.4.4.g26805

