From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] use typechange as rename source
Date: Fri, 30 Nov 2007 22:35:08 -0800
Message-ID: <7vy7ce6hyb.fsf@gitster.siamese.dyndns.org>
References: <20071121171235.GA32233@sigill.intra.peff.net>
	<7vir3l2a1i.fsf@gitster.siamese.dyndns.org>
	<20071129141452.GA32670@coredump.intra.peff.net>
	<7vmyswsfl6.fsf@gitster.siamese.dyndns.org>
	<20071130015716.GA15224@coredump.intra.peff.net>
	<7vsl2n87jr.fsf@gitster.siamese.dyndns.org>
	<20071201043407.GD30725@coredump.intra.peff.net>
	<7vhcj36j6e.fsf@gitster.siamese.dyndns.org>
	<7v8x4f6iyu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 07:35:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyLwt-0006JP-PM
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 07:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbXLAGfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 01:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbXLAGfQ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 01:35:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48014 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbXLAGfO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 01:35:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CE7602EF;
	Sat,  1 Dec 2007 01:35:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E80EB99B08;
	Sat,  1 Dec 2007 01:35:31 -0500 (EST)
In-Reply-To: <7v8x4f6iyu.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 30 Nov 2007 22:13:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66702>

Sorry for the earlier broken one.  Here is the correct one I wanted to
send out.

By the way, this breaks some tests in t4008 (break-rewrite test) because
the test expects the behaviour you found counterintuitive (which was the
reason we have this thread).

-- >8 --
Subject: rename: Break filepairs with different types.

When we consider if a path has been totally rewritten, we did not
touch changes from symlinks to files or vice versa.  But a change
that modifies even the type of a blob surely should count as a
complete rewrite.

While we are at it, modernise diffcore-break to be aware of gitlinks (we
do not want to touch them).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                           |    7 +++
 diffcore-break.c                  |   12 +++--
 t/t4023-diff-rename-typechange.sh |   86 +++++++++++++++++++++++++++++++++++++
 tree-walk.h                       |    7 ---
 4 files changed, 101 insertions(+), 11 deletions(-)
 create mode 100755 t/t4023-diff-rename-typechange.sh

diff --git a/cache.h b/cache.h
index aaa135b..d0e7a71 100644
--- a/cache.h
+++ b/cache.h
@@ -192,6 +192,13 @@ enum object_type {
 	OBJ_MAX,
 };
 
+static inline enum object_type object_type(unsigned int mode)
+{
+	return S_ISDIR(mode) ? OBJ_TREE :
+		S_ISGITLINK(mode) ? OBJ_COMMIT :
+		OBJ_BLOB;
+}
+
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
diff --git a/diffcore-break.c b/diffcore-break.c
index c71a226..31cdcfe 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -52,8 +52,10 @@ static int should_break(struct diff_filespec *src,
 			     * is the default.
 			     */
 
-	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
-		return 0; /* leave symlink rename alone */
+	if (S_ISREG(src->mode) != S_ISREG(dst->mode)) {
+		*merge_score_p = (int)MAX_SCORE;
+		return 1; /* even their types are different */
+	}
 
 	if (src->sha1_valid && dst->sha1_valid &&
 	    !hashcmp(src->sha1, dst->sha1))
@@ -168,11 +170,13 @@ void diffcore_break(int break_score)
 		struct diff_filepair *p = q->queue[i];
 		int score;
 
-		/* We deal only with in-place edit of non directory.
+		/*
+		 * We deal only with in-place edit of blobs.
 		 * We do not break anything else.
 		 */
 		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two) &&
-		    !S_ISDIR(p->one->mode) && !S_ISDIR(p->two->mode) &&
+		    object_type(p->one->mode) == OBJ_BLOB &&
+		    object_type(p->two->mode) == OBJ_BLOB &&
 		    !strcmp(p->one->path, p->two->path)) {
 			if (should_break(p->one, p->two,
 					 break_score, &score)) {
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
new file mode 100755
index 0000000..255604e
--- /dev/null
+++ b/t/t4023-diff-rename-typechange.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description='typechange rename detection'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	rm -f foo bar &&
+	cat ../../COPYING >foo &&
+	ln -s linklink bar &&
+	git add foo bar &&
+	git commit -a -m Initial &&
+	git tag one &&
+
+	rm -f foo bar &&
+	cat ../../COPYING >bar &&
+	ln -s linklink foo &&
+	git add foo bar &&
+	git commit -a -m Second &&
+	git tag two &&
+
+	rm -f foo bar &&
+	cat ../../COPYING >foo &&
+	git add foo &&
+	git commit -a -m Third &&
+	git tag three &&
+
+	mv foo bar &&
+	ln -s linklink foo &&
+	git add foo bar &&
+	git commit -a -m Fourth &&
+	git tag four &&
+
+	# This is purely for sanity check
+
+	rm -f foo bar &&
+	cat ../../COPYING >foo &&
+	cat ../../Makefile >bar &&
+	git add foo bar &&
+	git commit -a -m Fifth &&
+	git tag five &&
+
+	rm -f foo bar &&
+	cat ../../Makefile >foo &&
+	cat ../../COPYING >bar &&
+	git add foo bar &&
+	git commit -a -m Sixth &&
+	git tag six
+
+'
+
+test_expect_success 'cross renames to be detected for regular files' '
+
+	git diff-tree five six -r --name-status -B -M | sort >actual &&
+	{
+		echo "R100	foo	bar"
+		echo "R100	bar	foo"
+	} | sort >expect &&
+	diff -u expect actual
+
+'
+
+test_expect_success 'cross renames to be detected for typechange' '
+
+	git diff-tree one two -r --name-status -B -M | sort >actual &&
+	{
+		echo "R100	foo	bar"
+		echo "R100	bar	foo"
+	} | sort >expect &&
+	diff -u expect actual
+
+'
+
+test_expect_success 'moves and renames' '
+
+	git diff-tree three four -r --name-status -B -M | sort >actual &&
+	{
+		echo "R100	foo	bar"
+		echo "T100	foo"
+	} | sort >expect &&
+	diff -u expect actual
+
+'
+
+test_done
diff --git a/tree-walk.h b/tree-walk.h
index 903a7b0..db0fbdc 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -7,13 +7,6 @@ struct name_entry {
 	unsigned int mode;
 };
 
-static inline enum object_type object_type(unsigned int mode)
-{
-	return S_ISDIR(mode) ? OBJ_TREE :
-		S_ISGITLINK(mode) ? OBJ_COMMIT :
-		OBJ_BLOB;
-}
-
 struct tree_desc {
 	const void *buffer;
 	struct name_entry entry;
-- 
1.5.3.6.2090.g4ece0
