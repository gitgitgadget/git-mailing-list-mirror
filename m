From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 18:28:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508231823420.3317@g5.osdl.org>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
 <7vhddgnw9q.fsf@assigned-by-dhcp.cox.net> <1124836282.14730.4.camel@toshiba>
 <7vzmr8mci2.fsf@assigned-by-dhcp.cox.net> <7vek8kmb2a.fsf@assigned-by-dhcp.cox.net>
 <7v3bp0m9ax.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Len Brown <len.brown@intel.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 03:29:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7k4Q-0001r5-Bh
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 03:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVHXB2m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 21:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVHXB2m
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 21:28:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751331AbVHXB2m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 21:28:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7O1SZjA018060
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Aug 2005 18:28:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7O1SXW6019401;
	Tue, 23 Aug 2005 18:28:34 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bp0m9ax.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7696>



On Tue, 23 Aug 2005, Junio C Hamano wrote:
> 
> Only lightly tested, in the sense that I did only this one case
> and nothing else.  For a large repository and with complex
> merges, "merge-base -a" _might_ end up reporting many
> candidates, in which case the pre-merge step to figure out the
> best merge base may turn out to be disastrously slow.  I dunno.

Ok, I think your approach is the correct one. Just list all the commits, 
and let the merge logic figure out which one is the best one.

Here, in case anybody cares, is an alternate approach, which sucks. It 
_happens_ to pick the right parent in this case, but when I look at why it 
picks it, it's pretty much just pure luck again. The distance function is 
not good.

Just returning several entries is the correct thing to do, because then
you can make the distance function be based on the tree diffs, like you
do. That's _much_ better than trying to make the distance be based on some
topology.

So I append this patch just as a historical curiosity. Junio's patch is 
clearly superior.

		Linus

---
diff --git a/merge-base.c b/merge-base.c
--- a/merge-base.c
+++ b/merge-base.c
@@ -82,10 +82,84 @@ static struct commit *interesting(struct
  * commit B.
  */
 
+/*
+ * Count the distance from one commit to the base, using a very
+ * stupid recursive algorithm. We only avoid recursion when seeing
+ * a single parent.
+ */
+static unsigned long count_distance(struct commit *head, struct commit *base)
+{
+	struct commit_list *parents;
+	unsigned long distance = ULONG_MAX;
+	unsigned long chain = 1;
+
+	/* Walk the chain of direct parents */
+	for (;;) {
+		parents = head->parents;
+		if (!parents)
+			goto no_parent;
+		/* Multiple parents? */
+		if (parents->next)
+			break;
+		head = parents->item;
+		if (head == base)
+			return chain;
+		chain++;
+	}
+
+	while (parents) {
+		struct commit *c = parents->item;
+		unsigned long d;
+
+		parents = parents->next;
+		if (c == base)
+			return chain;
+		if (c->object.flags & UNINTERESTING)
+			continue;
+		d = count_distance(c, base);
+		if (d < distance)
+			distance = d;
+	}
+	if (distance != ULONG_MAX)
+		return distance + chain;
+no_parent:
+	return ULONG_MAX;
+}
+
+/*
+ * There are some really nasty cases where we get multiple apparently
+ * equally valid parents, and we need to disambiguate them.
+ *
+ * We aim for the one whose total distance to the two revisions is the
+ * smallest, where distance is "x**2 + y**2" (we _much_ prefer a nice
+ * balanced equidistant one over one that is near to one but far from
+ * the other)
+ */
+static struct commit *pick_best_commit(struct commit_list *list, struct commit *rev1, struct commit *rev2)
+{
+	unsigned long distance = ULONG_MAX;
+	struct commit *best = NULL;
+
+	do {
+		struct commit *base = list->item;
+		unsigned long d1 = count_distance(rev1, base);
+		unsigned long d2 = count_distance(rev2, base);
+		unsigned long d = d1*d1 + d2*d2;
+
+fprintf(stderr, "distance analysis: %s: %lu %lu %lu\n", sha1_to_hex(base->object.sha1), d1, d2, d);
+		if (d < distance) {
+			distance = d;
+			best = base;
+		}
+	} while ((list = list->next) != NULL);
+	return best;
+}
+
 static struct commit *common_ancestor(struct commit *rev1, struct commit *rev2)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
+	struct commit_list *final = NULL;
 
 	if (rev1 == rev2)
 		return rev1;
@@ -122,7 +196,32 @@ static struct commit *common_ancestor(st
 			insert_by_date(p, &list);
 		}
 	}
-	return interesting(result);
+
+	/*
+	 * Go through the result list, and pick out unique
+	 * members to put on the final list.
+	 */
+	while (result) {
+		struct commit_list *entry = result;
+		struct commit *c = result->item;
+		result = result->next;
+		if (c->object.flags & UNINTERESTING)
+			continue;
+		if (c == rev1 || c == rev2)
+			return c;
+		entry->next = final;
+		final = entry;
+		c->object.flags |= UNINTERESTING;
+	}
+
+	if (!final)
+		return NULL;
+
+	/* Just one entry? */
+	if (!final->next)
+		return final->item;
+
+	return pick_best_commit(final, rev1, rev2);
 }
 
 int main(int argc, char **argv)
