X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Thu, 7 Dec 2006 05:01:52 -0500
Message-ID: <20061207100152.GA12966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 10:02:06 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33564>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsG4p-0003Yz-A2 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 11:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031942AbWLGKCA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 05:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031944AbWLGKCA
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 05:02:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33441 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031942AbWLGKB7 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 05:01:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsG4h-0008Vu-QM; Thu, 07 Dec 2006 05:01:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B580D20FB6E; Thu,  7 Dec 2006 05:01:52 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

I have recently observed a rather large number of users who forget
to specify the base revision when they start a new branch with
git-checkout -b.  Many of these users are shocked many hours and
commits later when their prior branch is now also part of the new
branch.  Nasty words about Git usually follow the discovery.

This introduces a new config option: checkout.requireSourceBranch,
which the user can set to make git-checkout -b require them to supply
not only the new branch name but also the initial version for that
branch.  This prevents the command from assuming the user meant HEAD
when they omitted an argument by accident.

To keep behavior backwards compatible with any existing scripts
this option is currently disabled by default, but it would be more
friendly to new users if the option was enabled by default.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |    6 ++++++
 git-checkout.sh          |   12 +++++++++++-
 t/t3200-branch.sh        |   14 ++++++++++++++
 3 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9090762..9d754c8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -130,6 +130,12 @@ branch.<name>.merge::
 	When in branch <name>, it tells `git fetch` the default remote branch
 	to be merged.
 
+checkout.requireSourceBranch::
+	If true tells git-checkout -b to require the user to
+	supply two arguments, rather than assuming HEAD should
+	be the source version if only one argument is supplied.
+	Default is false, to stay compatible with prior behavior.
+
 pager.color::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-checkout.sh b/git-checkout.sh
index 737abd0..5f9fb6e 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -137,7 +137,17 @@ then
 	cd "$cdup"
 fi
 
-[ -z "$new" ] && new=$old && new_name="$old_name"
+# If we have no new name default to 'HEAD', unless we are
+# making a new branch and the user told us not to assume.
+if [ -z "$new" ]; then
+	if [ "$newbranch" ] &&
+	   [ Xtrue = "X`git-repo-config --bool checkout.requireSourceBranch`" ]
+	then
+		die "A source branch is required when creating a branch."
+	fi
+	new=$old
+	new_name="$old_name"
+fi
 
 # If we don't have an old branch that we're switching to,
 # and we don't have a new branch name for the target we
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index acb54b6..7e0c48b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -70,4 +70,18 @@ test_expect_success \
         git-branch -d l/m &&
         git-branch l'
 
+test_expect_success \
+	'git checkout -b M works if checkout.requireSourceBranch not set' \
+	'git-checkout -b M'
+
+test_expect_failure \
+	'git checkout -b N fails if checkout.requireSourceBranch is set' \
+	'git-repo-config checkout.requireSourceBranch true
+	 git-checkout -b N'
+
+test_expect_success \
+	'git checkout -b N works if checkout.requireSourceBranch is false' \
+	'git-repo-config checkout.requireSourceBranch false
+	 git-checkout -b N'
+
 test_done
-- 
1.4.4.2.gb772
