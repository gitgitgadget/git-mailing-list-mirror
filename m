From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] combine-diff: use textconv for combined diff format
Date: Fri, 15 Apr 2011 17:29:05 +0200
Message-ID: <36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net>
References: <20110414213006.GA7709@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 17:29:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkxO-0008KT-BY
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 17:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab1DOP3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 11:29:10 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54329 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752911Ab1DOP3I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 11:29:08 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CCC5421394;
	Fri, 15 Apr 2011 11:29:07 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 15 Apr 2011 11:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=02de1iB1vDH5AruskLpCCWtI8lI=; b=BNFEJ3YOSy2b2gU456w5dUxQAyCzPHVfb2F4MEhymWqKIgyejC727w/G0Tc2kfg0ff3X0f4gxIS37mjG6lelLyy+9BXGnelLAlP2192MBeZnPkyVYxyjU5K8Hr+A9C3yQzmPXph/eHwqg2Aln5xxTXr8+wEl2xpK5+pL4tVBn7s=
X-Sasl-enc: fK8vnsTney59fOXwFs33v4MBEk1oqrQskcxZ7uYKVCeo 1302881347
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 17409406A5A;
	Fri, 15 Apr 2011 11:29:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1.312.g1936c
In-Reply-To: <20110414213006.GA7709@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171613>

Currently, we ignore textconv and binary status for the combined diff
formats (-c, -cc) which was never intended.

Change this so that combined diff uses the same helpers.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
So, just so that I don't get the vapor patch award, here's a WIP passing
Jeff's test.

Before looking at free()ing what I've introduced and the binary issue I'll
check whether the whole blob/file read hunk in show_patch_diff() can't be
simply subsumed in the fill_textconv() call. It is almost a copy of
diff_populate_filespec() but not quite.

Also, the situation with worktree is even worse than I thought:

git diff -m produces a combined diff!

Also, my patch does not cure "diff -c" against worktree so far, I'm not
textconv'ing the worktree file yet. But then again, "diff -m" sucks here also.

I'll probably pick this up later today.
---
 combine-diff.c                 |   30 +++++++++---
 diff.h                         |    2 +
 t/t4046-diff-textconv-merge.sh |   97 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 8 deletions(-)
 create mode 100755 t/t4046-diff-textconv-merge.sh

diff --git a/combine-diff.c b/combine-diff.c
index 655fa89..8056fc3 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -8,7 +8,7 @@
 #include "log-tree.h"
 #include "refs.h"
 
-static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
+static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent, int textconv)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct combine_diff_path *p;
@@ -34,9 +34,13 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 
 			hashcpy(p->sha1, q->queue[i]->two->sha1);
 			p->mode = q->queue[i]->two->mode;
+			if (textconv)
+				p->textconv = get_textconv(q->queue[i]->two);
 			hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
+			if (textconv)
+				p->parent[n].textconv = get_textconv(q->queue[i]->one);
 			*tail = p;
 			tail = &p->next;
 		}
@@ -60,6 +64,8 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 				hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
 				p->parent[n].mode = q->queue[i]->one->mode;
 				p->parent[n].status = q->queue[i]->status;
+				if (textconv)
+					p->parent[n].textconv = get_textconv(q->queue[i]->one);
 				break;
 			}
 		}
@@ -201,8 +207,8 @@ static void consume_line(void *state_, char *line, unsigned long len)
 	}
 }
 
-static void combine_diff(const unsigned char *parent, unsigned int mode,
-			 mmfile_t *result_file,
+static void combine_diff(const char *path, const unsigned char *parent, unsigned int mode,
+			 struct userdiff_driver *textconv, mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent, int result_deleted)
 {
@@ -212,13 +218,13 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 	xdemitconf_t xecfg;
 	mmfile_t parent_file;
 	struct combine_diff_state state;
-	unsigned long sz;
+	struct diff_filespec *df = alloc_filespec(path);
 
 	if (result_deleted)
 		return; /* result deleted */
 
-	parent_file.ptr = grab_blob(parent, mode, &sz);
-	parent_file.size = sz;
+	fill_filespec(df, parent, mode);
+	parent_file.size = fill_textconv(textconv, df, &parent_file.ptr);
 	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
@@ -777,6 +783,12 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			close(fd);
 	}
 
+	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) && elem->textconv) {
+		struct diff_filespec *df = alloc_filespec(elem->path);
+		fill_filespec(df, elem->sha1, elem->mode);
+		result_size = fill_textconv(elem->textconv, df, &result);
+	}
+
 	for (cnt = 0, cp = result; cp < result + result_size; cp++) {
 		if (*cp == '\n')
 			cnt++;
@@ -821,8 +833,10 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			}
 		}
 		if (i <= j)
-			combine_diff(elem->parent[i].sha1,
+			combine_diff(elem->path,
+				     elem->parent[i].sha1,
 				     elem->parent[i].mode,
+				     elem->parent[i].textconv,
 				     &result_file, sline,
 				     cnt, i, num_parent, result_deleted);
 		if (elem->parent[i].mode != elem->mode)
@@ -1001,7 +1015,7 @@ void diff_tree_combined(const unsigned char *sha1,
 			diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 		diff_tree_sha1(parent[i], sha1, "", &diffopts);
 		diffcore_std(&diffopts);
-		paths = intersect_paths(paths, i, num_parent);
+		paths = intersect_paths(paths, i, num_parent, DIFF_OPT_TST(opt, ALLOW_TEXTCONV));
 
 		if (show_log_first && i == 0) {
 			show_log(rev);
diff --git a/diff.h b/diff.h
index 007a055..4ca6b84 100644
--- a/diff.h
+++ b/diff.h
@@ -176,10 +176,12 @@ struct combine_diff_path {
 	char *path;
 	unsigned int mode;
 	unsigned char sha1[20];
+	struct userdiff_driver *textconv;
 	struct combine_diff_parent {
 		char status;
 		unsigned int mode;
 		unsigned char sha1[20];
+		struct userdiff_driver *textconv;
 	} parent[FLEX_ARRAY];
 };
 #define combine_diff_path_size(n, l) \
diff --git a/t/t4046-diff-textconv-merge.sh b/t/t4046-diff-textconv-merge.sh
new file mode 100755
index 0000000..8420bb6
--- /dev/null
+++ b/t/t4046-diff-textconv-merge.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+
+test_description='combined and merge diff uses textconv'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one file &&
+	test_commit two file &&
+	git checkout -b other HEAD^ &&
+	test_commit three file &&
+	test_must_fail git merge master &&
+	echo resolved >file &&
+	echo "file diff=upcase" >.gitattributes &&
+	git config diff.upcase.textconv "tr a-z A-Z <"
+'
+
+cat >expect <<'EOF'
+diff --combined file
+index 2bdf67a,f719efd..0000000
+--- a/file
++++ b/file
+@@@ -1,1 -1,1 +1,1 @@@
+- THREE
+ -TWO
+++RESOLVED
+EOF
+test_expect_success 'diff -c uses textconv' '
+	git diff -c >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+diff --git a/file b/file
+index 2bdf67a..0000000 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-THREE
++RESOLVED
+
+diff --git a/file b/file
+index f719efd..0000000 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-TWO
++RESOLVED
+EOF
+test_expect_success 'diff -m uses textconv' '
+	git diff -m >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Merge branch 'master' into other
+
+diff --combined file
+index 2bdf67a,f719efd..2ab19ae
+--- a/file
++++ b/file
+@@@ -1,1 -1,1 +1,1 @@@
+- THREE
+ -TWO
+++RESOLVED
+EOF
+test_expect_success 'show -c uses textconv' '
+	git commit -a &&
+	git show --format=%s -c >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Merge branch 'master' into other
+
+diff --git a/file b/file
+index 2bdf67a..2ab19ae 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-THREE
++RESOLVED
+Merge branch 'master' into other
+
+diff --git a/file b/file
+index f719efd..2ab19ae 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-TWO
++RESOLVED
+EOF
+test_expect_success 'show -m uses textconv' '
+	git show --format=%s -m >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.5.rc1.312.g1936c
