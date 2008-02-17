From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] xdl_merge(): make XDL_MERGE_ZEALOUS output simpler
Date: Sun, 17 Feb 2008 19:07:19 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802171906590.30505@racer.site>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site> <alpine.LSU.1.00.0802130108060.3870@racer.site> <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802131113360.30505@racer.site> <7vlk5mgm5y.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802151012380.3066@woody.linux-foundation.org> <alpine.LSU.1.00.0802171816150.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQorw-0005yy-Ah
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbYBQTHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbYBQTHc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:07:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:33099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752050AbYBQTHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:07:31 -0500
Received: (qmail invoked by alias); 17 Feb 2008 19:07:28 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.76]) [86.138.198.40]
  by mail.gmx.net (mp018) with SMTP; 17 Feb 2008 20:07:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18H9QMgjxoHReXvLohkTNO3y5WGfsguN14mYazOKI
	eFK7eSF/Sq+GDb
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802171816150.30505@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74167>


When a merge conflicts, there are often less than three common lines
between two conflicting regions.

Since a conflict takes up as many lines as are conflicting, plus three
lines for the commit markers,  the output will be shorter (and thus,
simpler) in this case, if the common lines will be merged into the
conflicting regions.

This patch merges up to three common lines into the conflicts.

For example, what looked like this before this patch:

	<<<<<<<
	if (a == 1)
	=======
	if (a != 0)
	>>>>>>>
	{
		int i;
	<<<<<<<
		a = 0;
	=======
		a = !a;
	>>>>>>>

will now look like this:

	<<<<<<<
	if (a == 1)
	{
		int i;
		a = 0;
	=======
	if (a != 0)
	{
		int i;
		a = !a;
	>>>>>>>

Suggested Linus (based on ideas by "Voltage Spike" -- if that name is
real, it is mighty cool).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6023-merge-file.sh |   10 ++++++++++
 xdiff/xmerge.c        |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 8641996..869e8d5 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -139,4 +139,14 @@ test_expect_success 'binary files cannot be merged' '
 	grep "Cannot merge binary files" merge.err
 '
 
+sed -e "s/deerit.$/deerit;/" -e "s/me;$/me./" < new5.txt > new6.txt
+sed -e "s/deerit.$/deerit,/" -e "s/me;$/me,/" < new5.txt > new7.txt
+
+test_expect_success 'MERGE_ZEALOUS simplifies non-conflicts' '
+
+	! git merge-file -p new6.txt new5.txt new7.txt > output &&
+	test 1 = $(grep ======= < output | wc -l)
+
+'
+
 test_done
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index b83b334..9cd448c 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -249,6 +249,49 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 }
 
 /*
+ * This function merges m and m->next, marking everything between those hunks
+ * as conflicting, too.
+ */
+static void xdl_merge_two_conflicts(xdmerge_t *m)
+{
+	xdmerge_t *next_m = m->next;
+	m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
+	m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
+	m->next = next_m->next;
+	free(next_m);
+}
+
+/*
+ * If there are less than 3 non-conflicting lines between conflicts,
+ * it appears simpler -- because it takes up less (or as many) lines --
+ * if the lines are moved into the conflicts.
+ */
+static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m)
+{
+	int result = 0;
+
+	if (!m)
+		return result;
+	for (;;) {
+		xdmerge_t *next_m = m->next;
+		int begin, end;
+
+		if (!next_m)
+			return result;
+
+		begin = m->i1 + m->chg1;
+		end = next_m->i1;
+
+		if (m->mode != 0 || next_m->mode != 0 || end - begin > 3)
+			m = next_m;
+		else {
+			result++;
+			xdl_merge_two_conflicts(m);
+		}
+	}
+}
+
+/*
  * level == 0: mark all overlapping changes as conflict
  * level == 1: mark overlapping changes as conflict only if not identical
  * level == 2: analyze non-identical changes for minimal conflict set
@@ -355,7 +398,9 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	if (!changes)
 		changes = c;
 	/* refine conflicts */
-	if (level > 1 && xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0) {
+	if (level > 1 &&
+			(xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
+			 xdl_simplify_non_conflicts(xe1, changes) < 0)) {
 		xdl_cleanup_merge(changes);
 		return -1;
 	}
-- 
1.5.4.1.1396.g177d-dirty
