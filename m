From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] Allow specifying specialized merge-backend per path.
Date: Tue, 17 Apr 2007 01:08:37 -0700
Message-ID: <11767973191314-git-send-email-junkio@cox.net>
References: <11767973183627-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 10:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdik3-0001Yq-FI
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 10:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbXDQIIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 04:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbXDQIIp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 04:08:45 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44604 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbXDQIIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 04:08:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417080839.TZNX1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Tue, 17 Apr 2007 04:08:39 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o88e1W01q1kojtg0000200; Tue, 17 Apr 2007 04:08:39 -0400
X-Mailer: git-send-email 1.5.1.1.125.g402f-dirty
In-Reply-To: <11767973183627-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44739>

This allows 'merge' attribute to control how the file-level
three-way merge is done per path.

 - If you set 'merge' to true or leave unspecified, we use the
   built-in 3-way xdl-merge.

 - If you set 'merge' to false, the merge result is 'ours'.  But
   this still leaves the path conflicted, so that the mess can
   be sorted out by the user.  This is probably useful for
   binary files.

 - 'merge=union' (this is the first example of a string valued
   attribute, introduced in the previous one) uses the "union"
   merge.  The "union" merge takes lines in conflicted hunks
   from both sides, which is useful for line-oriented files such
   as .gitignore.

Currently there is no way to specify random programs but it
should be trivial for motivated contributors to add later.

There is one caveat, though.  ll_merge() is called for both
internal ancestor merge and the outer "final" merge.  I think an
interactive custom per-path merge backend should refrain from
going interactive when performing an internal merge (you can
tell it by checking call_depth) and instead just call either
ll_xdl_merge() if the content is text, or call ll_ours_merge()
otherwise.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-recursive.c |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 126 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4eb62cf..a6c08a1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -15,6 +15,7 @@
 #include "unpack-trees.h"
 #include "path-list.h"
 #include "xdiff-interface.h"
+#include "attr.h"
 
 static int subtree_merge;
 
@@ -659,6 +660,124 @@ static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 	mm->size = size;
 }
 
+/* Low-level merge functions */
+typedef int (*ll_merge_fn)(mmfile_t *orig,
+			   mmfile_t *src1, const char *name1,
+			   mmfile_t *src2, const char *name2,
+			   mmbuffer_t *result);
+
+static int ll_xdl_merge(mmfile_t *orig,
+			mmfile_t *src1, const char *name1,
+			mmfile_t *src2, const char *name2,
+			mmbuffer_t *result)
+{
+	xpparam_t xpp;
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xpp, 0, sizeof(xpp));
+	return xdl_merge(orig,
+			 src1, name1,
+			 src2, name2,
+			 &xpp, XDL_MERGE_ZEALOUS,
+			 result);
+}
+
+static int ll_union_merge(mmfile_t *orig,
+			  mmfile_t *src1, const char *name1,
+			  mmfile_t *src2, const char *name2,
+			  mmbuffer_t *result)
+{
+	char *src, *dst;
+	long size;
+	const int marker_size = 7;
+
+	int status = ll_xdl_merge(orig, src1, NULL, src2, NULL, result);
+	if (status <= 0)
+		return status;
+	size = result->size;
+	src = dst = result->ptr;
+	while (size) {
+		char ch;
+		if ((marker_size < size) &&
+		    (*src == '<' || *src == '=' || *src == '>')) {
+			int i;
+			ch = *src;
+			for (i = 0; i < marker_size; i++)
+				if (src[i] != ch)
+					goto not_a_marker;
+			if (src[marker_size] != '\n')
+				goto not_a_marker;
+			src += marker_size + 1;
+			size -= marker_size + 1;
+			continue;
+		}
+	not_a_marker:
+		do {
+			ch = *src++;
+			*dst++ = ch;
+			size--;
+		} while (ch != '\n' && size);
+	}
+	result->size = dst - result->ptr;
+	return 0;
+}
+
+static int ll_ours_merge(mmfile_t *orig,
+			 mmfile_t *src1, const char *name1,
+			 mmfile_t *src2, const char *name2,
+			 mmbuffer_t *result)
+{
+	/*
+	 * Pretend the tentative merge result is "ours",
+	 * but still return "conflicted merge" status.
+	 */
+	result->ptr = src1->ptr;
+	result->size = src1->size;
+	src1->ptr = NULL;
+	return 1;
+}
+
+static struct {
+	const char *name;
+	ll_merge_fn fn;
+} ll_merge_fns[] = {
+	{ "3way", ll_xdl_merge },
+	{ "ours", ll_ours_merge },
+	{ "union", ll_union_merge },
+	{ NULL, NULL },
+};
+
+static ll_merge_fn find_ll_merge_fn(void *merge_attr)
+{
+	const char *name;
+	int i;
+
+	if (ATTR_TRUE(merge_attr) || ATTR_UNSET(merge_attr))
+		return ll_xdl_merge;
+	else if (ATTR_FALSE(merge_attr))
+		return ll_ours_merge;
+
+	/* Otherwise merge_attr may name the merge function */
+	name = merge_attr;
+	for (i = 0; ll_merge_fns[i].name; i++)
+		if (!strcmp(ll_merge_fns[i].name, name))
+			return ll_merge_fns[i].fn;
+
+	/* default to the 3-way */
+	return ll_xdl_merge;
+}
+
+static void *git_path_check_merge(const char *path)
+{
+	static struct git_attr_check attr_merge_check;
+
+	if (!attr_merge_check.attr)
+		attr_merge_check.attr = git_attr("merge", 5);
+
+	if (git_checkattr(path, 1, &attr_merge_check))
+		return ATTR__UNSET;
+	return attr_merge_check.value;
+}
+
 static int ll_merge(mmbuffer_t *result_buf,
 		    struct diff_filespec *o,
 		    struct diff_filespec *a,
@@ -667,9 +786,10 @@ static int ll_merge(mmbuffer_t *result_buf,
 		    const char *branch2)
 {
 	mmfile_t orig, src1, src2;
-	xpparam_t xpp;
 	char *name1, *name2;
 	int merge_status;
+	void *merge_attr;
+	ll_merge_fn fn;
 
 	name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
 	name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
@@ -678,12 +798,11 @@ static int ll_merge(mmbuffer_t *result_buf,
 	fill_mm(a->sha1, &src1);
 	fill_mm(b->sha1, &src2);
 
-	memset(&xpp, 0, sizeof(xpp));
-	merge_status = xdl_merge(&orig,
-				 &src1, name1,
-				 &src2, name2,
-				 &xpp, XDL_MERGE_ZEALOUS,
-				 result_buf);
+	merge_attr = git_path_check_merge(a->path);
+	fn = find_ll_merge_fn(merge_attr);
+
+	merge_status = fn(&orig, &src1, name1, &src2, name2, result_buf);
+
 	free(name1);
 	free(name2);
 	free(orig.ptr);
-- 
1.5.1.1.821.g88bdb
