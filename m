From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH(RFC) 2/2] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Sun, 17 Feb 2008 19:07:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802171907310.30505@racer.site>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site> <alpine.LSU.1.00.0802130108060.3870@racer.site> <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802131113360.30505@racer.site> <7vlk5mgm5y.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802151012380.3066@woody.linux-foundation.org> <alpine.LSU.1.00.0802171816150.30505@racer.site> <alpine.LSU.1.00.0802171906590.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQosF-00064f-Ju
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbYBQTHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbYBQTHw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:07:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:33534 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752074AbYBQTHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:07:51 -0500
Received: (qmail invoked by alias); 17 Feb 2008 19:07:49 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.76]) [86.138.198.40]
  by mail.gmx.net (mp041) with SMTP; 17 Feb 2008 20:07:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XU0F0aJVXz4fcbXmR33qnF+0CEAMA9HsoLPLbNb
	6/pc7Kddf2Vkng
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802171906590.30505@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74168>


When a merge conflicts, there are often common lines that are not really
common, such as empty lines or lines containing a single curly bracket.

With XDL_MERGE_ZEALOUS_ALNUM, we use the following heuristics: when a
hunk does not contain any letters or digits, it is treated as conflicting.

In other words, a conflict which used to look like this:

	<<<<<<<
					a = 1;
	=======
					output();
	>>>>>>>
				}
			}
		}

	<<<<<<<
		output();
	=======
		b = 1;
	>>>>>>>

will look like this with ZEALOUS_ALNUM:

	<<<<<<<
					a = 1;
				}
			}
		}

		output();
	=======
					output();
				}
			}
		}

		b = 1;
	>>>>>>>

To demonstrate this, git-merge-file has been switched from
XDL_MERGE_ZEALOUS to XDL_MERGE_ZEALOUS_ALNUM.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Conflicts:

	t/t6023-merge-file.sh
---
 builtin-merge-file.c  |    2 +-
 t/t6023-merge-file.sh |   10 ++++++++++
 xdiff/xdiff.h         |    1 +
 xdiff/xmerge.c        |   31 ++++++++++++++++++++++++++++---
 4 files changed, 40 insertions(+), 4 deletions(-)

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
index 869e8d5..79dc58b 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -149,4 +149,14 @@ test_expect_success 'MERGE_ZEALOUS simplifies non-conflicts' '
 
 '
 
+sed -e 's/deerit./&\n\n\n\n/' -e "s/locavit,/locavit;/" < new6.txt > new8.txt
+sed -e 's/deerit./&\n\n\n\n/' -e "s/locavit,/locavit --/" < new7.txt > new9.txt
+
+test_expect_success 'ZEALOUS_ALNUM' '
+
+	! git merge-file -p new8.txt new5.txt new9.txt > merge.out &&
+	test 1 = $(grep ======= < merge.out | wc -l)
+
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
index 9cd448c..2128eaf 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -248,6 +248,23 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
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
 /*
  * This function merges m and m->next, marking everything between those hunks
  * as conflicting, too.
@@ -266,7 +283,8 @@ static void xdl_merge_two_conflicts(xdmerge_t *m)
  * it appears simpler -- because it takes up less (or as many) lines --
  * if the lines are moved into the conflicts.
  */
-static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m)
+static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
+		int simplify_if_no_alnum)
 {
 	int result = 0;
 
@@ -282,7 +300,11 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m)
 		begin = m->i1 + m->chg1;
 		end = next_m->i1;
 
-		if (m->mode != 0 || next_m->mode != 0 || end - begin > 3)
+		if (m->mode != 0 || next_m->mode != 0 ||
+				(end - begin > 3 &&
+				 (!simplify_if_no_alnum ||
+				  lines_contain_alnum(xe1, begin,
+					  end - begin))))
 			m = next_m;
 		else {
 			result++;
@@ -295,6 +317,8 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m)
  * level == 0: mark all overlapping changes as conflict
  * level == 1: mark overlapping changes as conflict only if not identical
  * level == 2: analyze non-identical changes for minimal conflict set
+ * level == 3: analyze non-identical changes for minimal conflict set, but
+ *             treat hunks not containing any letter or number as conflicting
  *
  * returns < 0 on error, == 0 for no conflicts, else number of conflicts
  */
@@ -400,7 +424,8 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	/* refine conflicts */
 	if (level > 1 &&
 			(xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
-			 xdl_simplify_non_conflicts(xe1, changes) < 0)) {
+			 xdl_simplify_non_conflicts(xe1, changes,
+				level > 2) < 0)) {
 		xdl_cleanup_merge(changes);
 		return -1;
 	}
-- 
1.5.4.1.1396.g177d-dirty
