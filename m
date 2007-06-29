From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git add: respect core.filemode with unmerged entries
Date: Fri, 29 Jun 2007 18:32:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706291820200.4438@racer.site>
References: <20070625064017.GA2839@mellanox.co.il> <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
 <20070625071752.GB15343@mellanox.co.il> <Pine.LNX.4.64.0706250846200.4059@racer.site>
 <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>
 <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com>
 <Pine.LNX.4.64.0706281506390.4438@racer.site> <4683C5D2.FDF4ED02@eudaptics.com>
 <4683CA7A.7F8070D7@eudaptics.com> <Pine.LNX.4.64.0706281653260.4438@racer.site>
 <4684AD41.9868C32F@eudaptics.com> <Pine.LNX.4.64.0706291106190.4438@racer.site>
 <7v3b0bf4ea.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 19:38:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4KQm-0005WE-Dt
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 19:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbXF2Rin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 13:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbXF2Rin
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 13:38:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:46215 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751467AbXF2Rim (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 13:38:42 -0400
Received: (qmail invoked by alias); 29 Jun 2007 17:38:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 29 Jun 2007 19:38:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Gzolx/3cGZsSV3OFWohZFa0PZ0vJu92b4OXs8Iv
	HNYXPIBaY6CfRV
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3b0bf4ea.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51182>


When a merge left unmerged entries, git add failed to pick up the
file mode from the index, when core.filemode == 0. If more than one
unmerged entry is there, the order of stage preference is 2, 1, 3.

Noticed by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 29 Jun 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > On Fri, 29 Jun 2007, Johannes Sixt wrote:
	> >
	> >> However, if only two stages are present, the file mode is 
	> >> still taken from the file instead of from the index. As that 
	> >> easy to solve (at least for the unambiguous case)?
	> >
	> > It might be related to the bug Junio found, i.e. that I assumed stage 1 to 
	> > be "ours".
	> 
	> Actually it is because (-1-pos) and (1-pos) are two apart.

	I congratulate myself. My first off-by-two bug.

	> I am all for refactoring the funny "pick up an existing entry at
	> any stage, but favor 0 then 2 then 1 and finally 3" into a
	> separate function.  It makes sense, although I do not offhand
	> know of a place that we can immediately reuse it (logically,
	> diff-files ought to do that, but I haven't checked).

	Me neither. But at least I coded it (hopefully) correctly this 
	time, even accompied it by a test verifying that I got it right.

 read-cache.c   |   30 +++++++++++++++++++++++++++++-
 t/t3700-add.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4362b11..a363f31 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -350,6 +350,34 @@ int remove_file_from_index(struct index_state *istate, const char *path)
 	return 0;
 }
 
+static int compare_name(struct cache_entry *ce, const char *path, int namelen)
+{
+	return namelen != ce_namelen(ce) || memcmp(path, ce->name, namelen);
+}
+
+static int index_name_pos_also_unmerged(struct index_state *istate,
+	const char *path, int namelen)
+{
+	int pos = index_name_pos(istate, path, namelen);
+	struct cache_entry *ce;
+
+	if (pos >= 0)
+		return pos;
+
+	/* maybe unmerged? */
+	pos = -1 - pos;
+	if (pos >= istate->cache_nr ||
+			compare_name((ce = istate->cache[pos]), path, namelen))
+		return -1;
+
+	/* order of preference: stage 2, 1, 3 */
+	if (ce_stage(ce) == 1 && pos + 1 < istate->cache_nr &&
+			ce_stage((ce = istate->cache[pos + 1])) == 2 &&
+			!compare_name(ce, path, namelen))
+		pos++;
+	return pos;
+}
+
 int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 {
 	int size, namelen;
@@ -380,7 +408,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 		 * from it, otherwise assume unexecutable regular file.
 		 */
 		struct cache_entry *ent;
-		int pos = index_name_pos(istate, path, namelen);
+		int pos = index_name_pos_also_unmerged(istate, path, namelen);
 
 		ent = (0 <= pos) ? istate->cache[pos] : NULL;
 		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ad8cc7d..0d80c6a 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -110,4 +110,30 @@ test_expect_success 'check correct prefix detection' '
 	git add 1/2/a 1/3/b 1/2/c
 '
 
+test_expect_success 'git add and filemode=0 with unmerged entries' '
+	echo 1 > stage1 &&
+	echo 2 > stage2 &&
+	echo 3 > stage3 &&
+	for s in 1 2 3
+	do
+		echo "100755 $(git hash-object -w stage$s) $s	file"
+	done | git update-index --index-info &&
+	git config core.filemode 0 &&
+	echo new > file &&
+	git add file &&
+	git ls-files --stage | grep "^100755 .* 0	file$"
+'
+
+test_expect_success 'git add and filemode=0 prefers stage 2 over stage 1' '
+	git rm --cached -f file &&
+	(
+		echo "100644 $(git hash-object -w stage1) 1	file"
+		echo "100755 $(git hash-object -w stage2) 2	file"
+	) | git update-index --index-info &&
+	git config core.filemode 0 &&
+	echo new > file &&
+	git add file &&
+	git ls-files --stage | grep "^100755 .* 0	file$"
+'
+
 test_done
-- 
1.5.2.2.3228.g16a27
