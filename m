From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Disconnect stash from its base commit
Date: Wed, 02 Jul 2008 19:59:47 +0900
Message-ID: <20080702195947.6117@nanako3.lavabit.com>
References: <7vskuuoygp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Olivier Marin <dkr+ml.git@free.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 13:01:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE05U-0002wu-PM
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 13:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYGBLA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 07:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbYGBLA1
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 07:00:27 -0400
Received: from karen.lavabit.com ([72.249.41.33]:45784 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbYGBLA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 07:00:26 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 65CEAC8412;
	Wed,  2 Jul 2008 06:00:17 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id N7S3SG8O72X9; Wed, 02 Jul 2008 06:00:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=rbYCiNTD22rRM0RryxiVQLzpHcvy3n4OU9ZE0qbMBmTH77hd5x2NQpN2/ieCOPY5i5Y7mb5LNSkLh1QH3PFRk90dAy1Vn4BE8LeQzmZ3RiktY7XjLCaBKhHUddpf9Hep/DOkktk2RyLpC2NJCa/TC71p30AKVjnl2KFMUTYwWJk=;
  h=From:Subject:To:Cc:Date:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vskuuoygp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87128>

A stash records the state of the files in the working tree as a merge
between the HEAD and another commit that records the state of the index,
that in turn is a child commit of the HEAD commit.  In order to later
apply (or pop) the stash, however, only the tree objects of these three
commits are necessary.

This patch changes the structure of a stash to use a parentless new commit
that has the same tree as the HEAD commit, in place of the HEAD commit.
This way, a stash does not keep the history that leads to the HEAD commit
reachable, even if the stash is kept forever.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

 The patch in the message Olivier quoted alone will be insufficient.  This
 is an update to that patch.

 Documentation/git-stash.txt |   14 +++++++-------
 git-stash.sh                |    3 +++
 t/t3903-stash.sh            |    2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 23ac331..17c65e9 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -101,18 +101,18 @@ DISCUSSION
 ----------
 
 A stash is represented as a commit whose tree records the state of the
-working directory, and its first parent is the commit at `HEAD` when
-the stash was created.  The tree of the second parent records the
+working directory, and its first parent is the commit that has the same
+tree as the `HEAD`.  The tree of the second parent records the
 state of the index when the stash is made, and it is made a child of
-the `HEAD` commit.  The ancestry graph looks like this:
+the first commit.  The ancestry graph looks like this:
 
             .----W
            /    /
-     -----H----I
+	  H*---I
 
-where `H` is the `HEAD` commit, `I` is a commit that records the state
-of the index, and `W` is a commit that records the state of the working
-tree.
+where `H{asterisk}` is a commit with the same tree as the `HEAD`, `I` is
+a commit that records the state of the index, and `W` is a commit that
+records the state of the working tree.
 
 
 EXAMPLES
diff --git a/git-stash.sh b/git-stash.sh
index 4938ade..8f374b3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -54,6 +54,9 @@ create_stash () {
 	fi
 	msg=$(printf '%s: %s' "$branch" "$head")
 
+	# create the base commit that is parentless
+	b_commit=$(printf 'base of %s\n' "$msg" | git commit-tree "HEAD:")
+
 	# state of the index
 	i_tree=$(git write-tree) &&
 	i_commit=$(printf 'index on %s\n' "$msg" |
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 54d99ed..b083c04 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -32,7 +32,7 @@ index 0cfbf08..00750ed 100644
 EOF
 
 test_expect_success 'parents of stash' '
-	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
+	test $(git rev-parse stash^^{tree}) = $(git rev-parse HEAD^{tree}) &&
 	git diff stash^2..stash > output &&
 	test_cmp output expect
 '
-- 
1.5.6

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
