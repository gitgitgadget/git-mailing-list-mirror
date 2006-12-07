X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Optionally check for uncommitted changes before switching branches.
Date: Thu, 7 Dec 2006 05:02:24 -0500
Message-ID: <20061207100224.GB12966@spearce.org>
References: <6ed9774cb95e873e76a4ac406dd740caf954bd3b.1165485618.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 10:02:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <6ed9774cb95e873e76a4ac406dd740caf954bd3b.1165485618.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33565>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsG5H-0003dD-Rn for gcvg-git@gmane.org; Thu, 07 Dec
 2006 11:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031939AbWLGKC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 05:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031944AbWLGKC3
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 05:02:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33462 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031939AbWLGKC2 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 05:02:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsG5A-00005y-FJ; Thu, 07 Dec 2006 05:02:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 C913D20FB6E; Thu,  7 Dec 2006 05:02:24 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Lately I have noticed a number of users are forgetting that they
have uncommitted changes in their working directory when they switch
to another branch.  This causes the user to accidentally carry those
changes into the new branch, which is usually not where they wanted
to commit them.  A correlation does appear to exist between the user
being interrupted in the middle of their task and the branch switch,
indicating they simply got distracted and forgot what was going on.

Git shouldn't cause the user to make mistakes when it can help to
prevent them.  So now users may set checkout.requireCleanDirectory
to true in their config file to have git-checkout verify the working
directory is clean before switching branches.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |    8 ++++++++
 git-checkout.sh          |   10 ++++++++++
 t/t3200-branch.sh        |   11 +++++++++++
 3 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9d754c8..f10e8ac 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -136,6 +136,14 @@ checkout.requireSourceBranch::
 	be the source version if only one argument is supplied.
 	Default is false, to stay compatible with prior behavior.
 
+checkout.requireCleanDirectory::
+	If true tells git-checkout to verify there are no uncommitted
+	changes still in the index or working directory before
+	switching branches.  If uncommitted changes exist the -m
+	flag can be used to skip the check if the user really wanted
+	to carry those onto the new branch.  Default is false,
+	to stay compatible with prior behavior.
+
 pager.color::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-checkout.sh b/git-checkout.sh
index 5f9fb6e..c04b8c1 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -171,6 +171,16 @@ then
     git-read-tree --reset -u $new
 else
     git-update-index --refresh >/dev/null
+	if [ -n "$old" ] &&
+	   [ -z "$merge" ] &&
+	   [ Xtrue = "X`git-repo-config --bool checkout.requireCleanDirectory`" ]
+	then
+		if [ `git-diff-index --cached $old | wc -l` -gt 0 ] ||
+		   [ `git-diff-files | wc -l` -gt 0 ]
+		then
+			die "Working directory has uncommitted changes; commit, reset or use -m"
+		fi
+	fi
     merge_error=$(git-read-tree -m -u $old $new 2>&1) || (
 	case "$merge" in
 	'')
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7e0c48b..9429827 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -84,4 +84,15 @@ test_expect_success \
 	'git-repo-config checkout.requireSourceBranch false
 	 git-checkout -b N'
 
+test_expect_failure \
+	'git checkout -b O works only if tree is clean' \
+	'git-repo-config checkout.requireCleanDirectory true
+	 echo atest >atest
+	 git add atest
+	 git-checkout -b O'
+
+test_expect_success \
+	'git checkout -m -b O works' \
+	'git-checkout -m -b O'
+
 test_done
-- 
