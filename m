From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Allow git-checkout when on a non-existant branch.
Date: Mon, 25 Sep 2006 01:24:38 -0400
Message-ID: <20060925052438.GA16023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 07:25:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRixp-0006cu-Aw
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 07:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWIYFYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 01:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWIYFYo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 01:24:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:24245 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751392AbWIYFYn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 01:24:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GRixM-0007dv-TG
	for git@vger.kernel.org; Mon, 25 Sep 2006 01:24:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 10D8320FB16; Mon, 25 Sep 2006 01:24:38 -0400 (EDT)
To: git@vger.kernel.org
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
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27727>

I've seen some users get into situtations where their HEAD
symbolic-ref is pointing at a non-existant ref.  (Sometimes this
happens during clone when the remote repository lacks a 'master'
branch.)  If this happens the user is unable to use git-checkout
to switch branches as there is no prior commit to merge from.

So instead of giving the user low-level errors about how HEAD
can't be resolved and how not a single revision was given change
the type of checkout to be a force and go through with the user's
request anyway.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-checkout.sh |    9 ++++++++-
 t/t7201-co.sh   |    9 +++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index f03620b..119bca1 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -4,8 +4,8 @@ USAGE='[-f] [-b <new_branch>] [-m] [<bra
 SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 
-old=$(git-rev-parse HEAD)
 old_name=HEAD
+old=$(git-rev-parse --verify $old_name 2>/dev/null)
 new=
 new_name=
 force=
@@ -140,6 +140,13 @@ # what we already had
 	die "git checkout: to checkout the requested commit you need to specify 
               a name for a new branch which is created and switched to"
 
+if [ "X$old" = X ]
+then
+	echo "warning: You do not appear to currently be on a branch." >&2
+	echo "warning: Forcing checkout of $new_name." >&2
+	force=1
+fi
+
 if [ "$force" ]
 then
     git-read-tree --reset -u $new
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b64e8b7..085d4a0 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -31,6 +31,15 @@ test_expect_success setup '
 	git checkout master
 '
 
+test_expect_success "checkout from non-existing branch" '
+
+	git checkout -b delete-me master &&
+	rm .git/refs/heads/delete-me &&
+	test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
+	git checkout master &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)"
+'
+
 test_expect_success "checkout with dirty tree without -m" '
 
 	fill 0 1 2 3 4 5 >one &&
-- 
1.4.2.1.g7a39b
