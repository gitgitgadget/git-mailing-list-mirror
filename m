From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] t1200: fix a timing dependent error
Date: Wed, 25 Nov 2009 08:08:08 +0900
Message-ID: <20091125080808.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 00:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND4Uj-0007sP-Pi
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 00:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934372AbZKXXIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 18:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934308AbZKXXIJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 18:08:09 -0500
Received: from karen.lavabit.com ([72.249.41.33]:34802 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934253AbZKXXIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 18:08:07 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 61A9C11B849;
	Tue, 24 Nov 2009 17:08:13 -0600 (CST)
Received: from 3584.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id I5AVXFYU2M2R; Tue, 24 Nov 2009 17:08:13 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=UPpdx10+Hf+EmY2za+J34rrZm+K/jFA7ChWPo1l/LJ1VUYXFsjD4ZwLEtBZei07uG+tKaaeHd27F320g3iNb7+SgS66qrvu4upbIQ+UwClMVB33OhnLiWwMnuuHZp3ewZzUP/HCsykoRfDEP8Q5O7oKfIkKmk04tFYGz4XFU71c=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133597>

The fourth test of show-branch in t1200 test was failing but only 
sometimes. It only failed when two commits created in an earlier
test had different timestamps. When they were created within the
same second, the actual output matched the expected output.

Fix this by using test_tick to force reliable timestamps and update
the expected output so it does not to depend on the commits made in
the same sacond.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index b7380b0..e237394 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1186,9 +1186,9 @@ $ git show-branch
 * [master] Some fun.
  ! [mybranch] Some work.
 --
- + [mybranch] Some work.
 *  [master] Some fun.
-*+ [mybranch^] Initial commit
+ + [mybranch] Some work.
+*+ [master^] Initial commit
 ------------
 
 Now we are ready to experiment with the merge by hand.
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 6bf8475..238c2f1 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -47,7 +47,8 @@ test_expect_success 'tree' '
 '
 
 test_expect_success 'git diff-index -p HEAD' '
-	tree=$(git write-tree)
+	test_tick &&
+	tree=$(git write-tree) &&
 	commit=$(echo "Initial commit" | git commit-tree $tree) &&
 	git update-ref HEAD $commit &&
 	git diff-index -p HEAD > diff.output &&
@@ -113,12 +114,14 @@ test_expect_success 'git branch' '
 test_expect_success 'git resolve now fails' '
 	git checkout mybranch &&
 	echo "Work, work, work" >>hello &&
+	test_tick &&
 	git commit -m "Some work." -i hello &&
 
 	git checkout master &&
 
 	echo "Play, play, play" >>hello &&
 	echo "Lots of fun" >>example &&
+	test_tick &&
 	git commit -m "Some fun." -i hello example &&
 
 	test_must_fail git merge -m "Merge work in mybranch" mybranch
@@ -141,6 +144,7 @@ cat > show-branch.expect << EOF
 EOF
 
 test_expect_success 'git show-branch' '
+	test_tick &&
 	git commit -m "Merge work in mybranch" -i hello &&
 	git show-branch --topo-order --more=1 master mybranch \
 		> show-branch.output &&
@@ -201,9 +205,9 @@ cat > show-branch4.expect << EOF
 * [master] Some fun.
  ! [mybranch] Some work.
 --
- + [mybranch] Some work.
 *  [master] Some fun.
-*+ [mybranch^] Initial commit
+ + [mybranch] Some work.
+*+ [master^] Initial commit
 EOF
 
 test_expect_success 'git show-branch (part 4)' '


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
