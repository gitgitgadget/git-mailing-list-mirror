From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Wed, 13 Feb 2008 01:10:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802130108060.3870@racer.site>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 13 02:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP68z-0003MF-FH
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbYBMBKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 20:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbYBMBKA
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 20:10:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:59338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753467AbYBMBJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 20:09:59 -0500
Received: (qmail invoked by alias); 13 Feb 2008 01:09:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 13 Feb 2008 02:09:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fLXcskz1fKcVHRio2YStgWMEnziTzRU+zH8ABfb
	vUCE/5Va1OL9br
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802130003370.3870@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73728>


When a merge conflicts, there are often common lines that are not really
common, such as empty lines or lines containing a single curly bracket.

With XDL_MERGE_ZEALOUS_ALNUM, we use the following heuristics: when a
hunk does not contain any letters or digits, it is treated as conflicting.

In other words, a conflict which used to look like this:

	<<<<<<<
	if (a == 1)
	=======
	if (a == 2)
	>>>>>>>
	{
	<<<<<<<
		b = 2;
	=======
		b = 1;
	>>>>>>>

will look like this with ZEALOUS_ALNUM:

	<<<<<<<
	if (a == 1)
	{
		b = 2;
	=======
	if (a == 2)
	{
		b = 1;
	>>>>>>>

To demonstrate this, git-merge-file has been switched from
XDL_MERGE_ZEALOUS to XDL_MERGE_ZEALOUS_ALNUM.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 13 Feb 2008, Johannes Schindelin wrote:

	> On Tue, 12 Feb 2008, Linus Torvalds wrote:
	> 
	> > On Tue, 12 Feb 2008, Voltage Spike wrote:
	> > > 
	> > > First, git is overly zealous at merging differences and two 
	> > > functions added at the same point in a file become 
	> > > intertwined during the merge.  A trivial example of this 
	> > > behavior:
	> > 
	> > Hmm. Have you tested what happens if you use XDL_MERGE_EAGER 
	> > instead of XDL_MERGE_ZEALOUS in the "level" argument to 
	> > xdl_merge() in merge-recursive.c?
	> > 
	> > (No, I didn't test it myself, but it may get you the behaviour 
	> > you want, and we could make it a config option for people who 
	> > want a less aggressive merge)
	> 
	> Actually, I have this in my ever-growing TODO:
	> 
	> XDL_MERGE_ZEALOUS_ALNUM: require an alnum in the common code; 
	> otherwise do not de-conflict it.
	> 
	> In other words, if there is a hunk consisting of conflicting 
	> lines, which are identical, but have no letter and no number in 
	> it, then keep them as conflicts.
	> 
	> But I never got around to try it.

	I just could not resist.  But now I HEAD for bed.

 builtin-merge-file.c  |    2 +-
 t/t6023-merge-file.sh |   40 ++++++++++++++++++++++++++++++++++
 xdiff/xdiff.h         |    1 +
 xdiff/xmerge.c        |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 1 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 58deb62..adce6d4 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -46,7 +46,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xpp, XDL_MERGE_ZEALOUS, &result);
+			&xpp, XDL_MERGE_ZEALOUS_ALNUM, &result);
 
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 8641996..7e72b8d 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -139,4 +139,44 @@ test_expect_success 'binary files cannot be merged' '
 	grep "Cannot merge binary files" merge.err
 '
 
+cat > a1.c << EOF
+int main()
+{
+	return 1;
+}
+EOF
+
+cat > a2.c << EOF
+int main2()
+{
+	return 0;
+}
+EOF
+
+cat > a3.c << EOF
+int main3()
+{
+	return 2;
+}
+EOF
+
+cat > expect << EOF
+<<<<<<< a2.c
+int main2()
+{
+	return 0;
+}
+=======
+int main3()
+{
+	return 2;
+}
+>>>>>>> a3.c
+EOF
+
+test_expect_success 'ZEALOUS_ALNUM' '
+	! git merge-file -p a2.c a1.c a3.c > merge.out &&
+	git diff expect merge.out
+'
+
 test_done
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c00ddaa..413082e 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -53,6 +53,7 @@ extern "C" {
 #define XDL_MERGE_MINIMAL 0
 #define XDL_MERGE_EAGER 1
 #define XDL_MERGE_ZEALOUS 2
+#define XDL_MERGE_ZEALOUS_ALNUM 3
 
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index b83b334..330121b 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -248,10 +248,63 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 	return 0;
 }
 
+static int line_contains_alnum(const char *ptr, long size)
+{
+	while (size--)
+		if (isalnum(*(ptr++)))
+			return 1;
+	return 0;
+}
+
+static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
+{
+	for (; chg; chg--, i++)
+		if (line_contains_alnum(xe->xdf2.recs[i]->ptr,
+				xe->xdf2.recs[i]->size))
+			return 1;
+	return 0;
+}
+
+/*
+ * This function merges m and m->next, marking everything between those hunks
+ * as conflicting, too.
+ */
+static void xdl_merge_two_conflicts(xdmerge_t *m)
+{
+	xdmerge_t *next_m = m->next;
+	m->chg1 += next_m->i1 + next_m->chg1 - m->i1;
+	m->chg2 += next_m->i2 + next_m->chg2 - m->i2;
+	m->next = next_m->next;
+	free(next_m);
+}
+
+static int xdl_non_alnum_conflicts(xdfenv_t *xe1, xdmerge_t *m)
+{
+	int result = 0;
+
+	for (;;) {
+		xdmerge_t *next_m = m->next;
+
+		if (!next_m)
+			return result;
+
+		if (lines_contain_alnum(xe1, m->i1 + m->chg1,
+				next_m->i1 + next_m->chg1 - 1
+				- m->i1 - m->chg1))
+			m = next_m;
+		else {
+			result++;
+			xdl_merge_two_conflicts(m);
+		}
+	}
+}
+
 /*
  * level == 0: mark all overlapping changes as conflict
  * level == 1: mark overlapping changes as conflict only if not identical
  * level == 2: analyze non-identical changes for minimal conflict set
+ * level == 3: analyze non-identical changes for minimal conflict set, but
+ *             treat hunks not containing any letter or number as conflicting
  *
  * returns < 0 on error, == 0 for no conflicts, else number of conflicts
  */
@@ -359,6 +412,10 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 		xdl_cleanup_merge(changes);
 		return -1;
 	}
+	if (level > 2 && xdl_non_alnum_conflicts(xe1, changes) < 0) {
+		xdl_cleanup_merge(changes);
+		return -1;
+	}
 	/* output */
 	if (result) {
 		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
-- 
1.5.4.1.1321.g633fc8
