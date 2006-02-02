From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] combine-diff: reuse diff from the same blob.
Date: Wed, 01 Feb 2006 23:40:51 -0800
Message-ID: <7v1wymus1o.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 08:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Z5N-0006Vj-8R
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 08:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423356AbWBBHky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 02:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423357AbWBBHky
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 02:40:54 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62188 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1423356AbWBBHkx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 02:40:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202073938.FUGB20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 02:39:38 -0500
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 01 Feb 2006 23:05:46 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15490>

When dealing with an insanely large Octopus, it is possible to
optimize by noticing that more than one parents have the same
blob and avoid running diff between a parent and the merge
result by reusing an earlier result.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Junio C Hamano <junkio@cox.net> writes:

 > One trivial thing I should be able to do to speed things up is
 > to reuse previous diff with other parents.  For example, that
 > commit does this to kernel/sys.c from its 12 parents.
 >
 > :100644 100644 d09cac2... 0929c69... M  kernel/sys.c
 > :100644 100644 eecf845... 0929c69... M  kernel/sys.c
 > :100644 100644 c3b1874... 0929c69... M  kernel/sys.c
 > :100644 100644 bce933e... 0929c69... M  kernel/sys.c
 > :100644 100644 eecf845... 0929c69... M  kernel/sys.c
 > :100644 100644 bce933e... 0929c69... M  kernel/sys.c
 > :100644 100644 bce933e... 0929c69... M  kernel/sys.c
 > :100644 100644 bce933e... 0929c69... M  kernel/sys.c
 > :100644 100644 eecf845... 0929c69... M  kernel/sys.c
 > :100644 100644 eecf845... 0929c69... M  kernel/sys.c
 > :100644 100644 eecf845... 0929c69... M  kernel/sys.c
 > :100644 100644 eecf845... 0929c69... M  kernel/sys.c
 >
 > Running "sort -u" on these would leave only 4 lines.
 >
 > I did not expect anybody to be _that_ sick (eh, pardon my
 > language) to do a 12-way octpus, so I did not consider this
 > optimization possibility, but I should be doing only 4 diffs to
 > format -c for this commit.  Currently I do 12.

 On my Duron 750 w/ 770MB RAM here is the results.

 Without this optimization:
 real	0m11.117s	user	0m9.230s	sys	0m1.860s
 With this optimization:
 real	0m7.339s	user	0m6.730s	sys	0m0.610s

 combine-diff.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)

7bf761b73cfb74917454e179d95f0dab1cab8f0b
diff --git a/combine-diff.c b/combine-diff.c
index 243f967..0cc18fe 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -523,6 +523,30 @@ static void dump_sline(struct sline *sli
 	}
 }
 
+static void reuse_combine_diff(struct sline *sline, unsigned long cnt,
+			       int i, int j)
+{
+	/* We have already examined parent j and we know parent i
+	 * and parent j are the same, so reuse the combined result
+	 * of parent j for parent i.
+	 */
+	unsigned long lno, imask, jmask;
+	imask = (1UL<<i);
+	jmask = (1UL<<j);
+
+	for (lno = 0; lno < cnt; lno++) {
+		struct lline *ll = sline->lost_head;
+		while (ll) {
+			if (ll->parent_map & jmask)
+				ll->parent_map |= imask;
+			ll = ll->next;
+		}
+		if (!(sline->flag & jmask))
+			sline->flag &= ~imask;
+		sline++;
+	}
+}
+
 int show_combined_diff(struct combine_diff_path *elem, int num_parent,
 		       int dense, const char *header, int show_empty)
 {
@@ -596,8 +620,19 @@ int show_combined_diff(struct combine_di
 		sline[cnt-1].flag = (1UL<<num_parent) - 1;
 	}
 
-	for (i = 0; i < num_parent; i++)
-		combine_diff(elem->parent_sha1[i], ourtmp, sline, cnt, i);
+	for (i = 0; i < num_parent; i++) {
+		int j;
+		for (j = 0; j < i; j++) {
+			if (!memcmp(elem->parent_sha1[i],
+				    elem->parent_sha1[j], 20)) {
+				reuse_combine_diff(sline, cnt, i, j);
+				break;
+			}
+		}
+		if (i <= j)
+			combine_diff(elem->parent_sha1[i], ourtmp, sline,
+				     cnt, i);
+	}
 
 	show_hunks = make_hunks(sline, cnt, num_parent, dense);
 
-- 
1.1.6.g2672
