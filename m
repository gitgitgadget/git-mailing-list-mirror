From: Martin Renold <martinxyz@gmx.ch>
Subject: [PATCH/v2] Remove filename from conflict markers
Date: Wed, 1 Jul 2009 22:18:04 +0200
Message-ID: <20090701201804.GA16876@old.homeip.net>
References: <20090628154559.GA29049@old.homeip.net> <7v63ed5pvi.fsf@alter.siamese.dyndns.org> <20090701123310.6117@nanako3.lavabit.com> <20090701075634.GA18326@old.homeip.net> <7vljn8ls0c.fsf@alter.siamese.dyndns.org> <20090701161651.GA29393@old.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:18:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM6Fz-0004k0-0o
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 22:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbZGAUSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 16:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbZGAUSD
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 16:18:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:34875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751428AbZGAUSC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 16:18:02 -0400
Received: (qmail invoked by alias); 01 Jul 2009 20:18:03 -0000
Received: from 84-74-83-103.dclient.hispeed.ch (EHLO bazaar) [84.74.83.103]
  by mail.gmx.net (mp064) with SMTP; 01 Jul 2009 22:18:03 +0200
X-Authenticated: #1936982
X-Provags-ID: V01U2FsdGVkX1/v3iMk1mbvQt+ywnb8O3ekgP09elVBetPPr2kcPG
	RYe2gJUBw4EZy7
Received: from martin by bazaar with local (Exim 4.69)
	(envelope-from <martinxyz@gmx.ch>)
	id 1MM6Fo-0007iV-Kc; Wed, 01 Jul 2009 22:18:04 +0200
Content-Disposition: inline
In-Reply-To: <20090701161651.GA29393@old.homeip.net>
X-Virus: Hi! I'm a header virus! Copy me into yours and join the fun!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122599>

Put filenames into the conflict markers only when they are different.
Otherwise they are redundant information clutter.

Print the filename explicitely when warning about a binary conflict.

Signed-off-by: Martin Renold <martinxyz@gmx.ch>
---

Thanks for your feedback. Here is the second attempt. It turned out that the
required function arguments were already there, just unused.

 ll-merge.c                    |    8 ++++----
 merge-recursive.c             |    9 +++++++--
 t/t3404-rebase-interactive.sh |    4 ++--
 t/t6024-recursive-merge.sh    |    9 ++++-----
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 9168958..a2c13c4 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -55,7 +55,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 
 static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmbuffer_t *result,
-			const char *path_unused,
+			const char *path,
 			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
@@ -67,10 +67,10 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	if (buffer_is_binary(orig->ptr, orig->size) ||
 	    buffer_is_binary(src1->ptr, src1->size) ||
 	    buffer_is_binary(src2->ptr, src2->size)) {
-		warning("Cannot merge binary files: %s vs. %s\n",
-			name1, name2);
+		warning("Cannot merge binary files: %s (%s vs. %s)\n",
+			path, name1, name2);
 		return ll_binary_merge(drv_unused, result,
-				       path_unused,
+				       path,
 				       orig, src1, name1,
 				       src2, name2,
 				       virtual_ancestor);
diff --git a/merge-recursive.c b/merge-recursive.c
index c703445..53cad96 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -622,8 +622,13 @@ static int merge_3way(struct merge_options *o,
 	char *name1, *name2;
 	int merge_status;
 
-	name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
-	name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
+	if (strcmp(a->path, b->path)) {
+		name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
+		name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
+	} else {
+		name1 = xstrdup(mkpath("%s", branch1));
+		name2 = xstrdup(mkpath("%s", branch2));
+	}
 
 	fill_mm(one->sha1, &orig);
 	fill_mm(a->sha1, &src1);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c32ff66..a973628 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -119,11 +119,11 @@ index e69de29..00750ed 100644
 EOF
 
 cat > expect2 << EOF
-<<<<<<< HEAD:file1
+<<<<<<< HEAD
 2
 =======
 3
->>>>>>> b7ca976... G:file1
+>>>>>>> b7ca976... G
 EOF
 
 test_expect_success 'stop on conflicting pick' '
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 129fa30..b3fbf65 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -65,18 +65,18 @@ test_expect_success "combined merge conflicts" "
 "
 
 cat > expect << EOF
-<<<<<<< HEAD:a1
+<<<<<<< HEAD
 F
 =======
 G
->>>>>>> G:a1
+>>>>>>> G
 EOF
 
 test_expect_success "result contains a conflict" "test_cmp expect a1"
 
 git ls-files --stage > out
 cat > expect << EOF
-100644 da056ce14a2241509897fa68bb2b3b6e6194ef9e 1	a1
+100644 439cc46de773d8a83c77799b7cc9191c128bfcff 1	a1
 100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
 100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
 EOF
@@ -93,8 +93,7 @@ test_expect_success 'refuse to merge binary files' '
 	git add binary-file &&
 	git commit -m binary2 &&
 	test_must_fail git merge F > merge.out 2> merge.err &&
-	grep "Cannot merge binary files: HEAD:binary-file vs. F:binary-file" \
-		merge.err
+	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
 '
 
 test_expect_success 'mark rename/delete as unmerged' '
-- 
1.6.3.1
