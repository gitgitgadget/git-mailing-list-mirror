From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3-wip] revision traversal: show full history with merge
 simplification
Date: Thu, 31 Jul 2008 15:09:18 -0700
Message-ID: <7vabfxyacx.fsf_-_@gitster.siamese.dyndns.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
 <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org>
 <7vej5b3ozz.fsf@gitster.siamese.dyndns.org>
 <7vhca6zcuy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 00:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgLw-0001NF-Bv
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 00:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbYGaWJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 18:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756197AbYGaWJ3
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 18:09:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbYGaWJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 18:09:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DD0F547343;
	Thu, 31 Jul 2008 18:09:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6D2A447340; Thu, 31 Jul 2008 18:09:20 -0400 (EDT)
In-Reply-To: <7vhca6zcuy.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 31 Jul 2008 01:17:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5711CF50-5F4D-11DD-A8DE-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91005>

This one makes it incremental.  It is not relative to v2 but on top of
'master'.

The idea and the logic to find what parents to rewrite is the same as the
previous one, but this one works incrementally as much as possible.  When
you have this topology, where commits with capital letters are the ones
that change the paths you are interested in:


        A---M---o---C---D---o
       /   /
   ---o---B

(1) we can tell that the rightmost one 'o' is not we want to show, without
    digging any further than D;

(2) we can show D after inspecting C without digging any further.  C is
    the sole parent of D, and C itself is an interesting one, so D's
    parent will stay to be C and not its ancestor.

(3) before showing C, we need to know what the rewritten parent of it
    would be; we need to dig down to M and notice that it has two parents
    that simplify to a different commit (both A and B touch the path we
    are interested in), so M simplifies to itself and it becomes the
    parent of C.  IOW, we need to dig no further than A and B in order to
    show C.

$ time sh -c 'git log --pretty=oneline --abbrev-commit \
	--simplify-merges --parents \
	-- kernel/printk.c | head -n 1'
5dfb66b... 1d9b9f6... c9272c4... Merge branch 'for-linus' of git://git.o-hand.com/linux-mfd

real    0m0.344s
user    0m0.324s
sys     0m0.020s

The same query with 's/| head -n 1/>/dev/null' is more expensive.  In fact
it is much more expensive than the non-incremental one (v2), and about
three times more expensive than non-limiting --full-history for explaining
the history of kernel/printk.c.  There must be opportunity to further
optimize this, but I'd stop here for now, as you keep saying this is hard,
and if I continue thinking about this any longer my head would explode ;-)

---
 revision.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 revision.h |    1 +
 2 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 3897fec..9554a70 100644
--- a/revision.c
+++ b/revision.c
@@ -1045,6 +1045,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--topo-order")) {
 		revs->lifo = 1;
 		revs->topo_order = 1;
+	} else if (!strcmp(arg, "--simplify-merges")) {
+		revs->simplify_merges = 1;
+		revs->rewrite_parents = 1;
+		revs->simplify_history = 0;
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->lifo = 0;
 		revs->topo_order = 1;
@@ -1450,9 +1454,10 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	}
 }
 
-static void remove_duplicate_parents(struct commit *commit)
+static int remove_duplicate_parents(struct commit *commit)
 {
 	struct commit_list **pp, *p;
+	int surviving_parents;
 
 	/* Examine existing parents while marking ones we have seen... */
 	pp = &commit->parents;
@@ -1465,9 +1470,13 @@ static void remove_duplicate_parents(struct commit *commit)
 		parent->object.flags |= TMP_MARK;
 		pp = &p->next;
 	}
-	/* ... and clear the temporary mark */
-	for (p = commit->parents; p; p = p->next)
+	/* count them while clearing the temporary mark */
+	surviving_parents = 0;
+	for (p = commit->parents; p; p = p->next) {
 		p->item->object.flags &= ~TMP_MARK;
+		surviving_parents++;
+	}
+	return surviving_parents;
 }
 
 static int rewrite_parents(struct rev_info *revs, struct commit *commit)
@@ -1536,6 +1545,89 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 	return commit_show;
 }
 
+static void simplify_merges(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list *work = NULL;
+
+	commit_list_insert(commit, &work);
+	while (!commit->util && work) {
+		struct commit *c;
+		struct commit_list *p;
+		int cnt;
+
+		c = pop_commit(&work);
+		if (c->util)
+			continue;
+		if ((c->object.flags & UNINTERESTING) || !c->parents) {
+			c->util = c;
+			continue;
+		}
+
+		/*
+		 * Do we know what commit all of the parents of this
+		 * should be rewritten to?  Otherwise we are not ready
+		 * to rewrite this one yet.
+		 */
+		for (cnt = 0, p = c->parents; p; p = p->next) {
+			if (!p->item->util) {
+				if (!cnt)
+					commit_list_insert(c, &work);
+				commit_list_insert(p->item, &work);
+				cnt++;
+			}
+		}
+		if (cnt)
+			continue;
+
+		/*
+		 * Rewrite the list of parents.
+		 */
+		for (p = c->parents; p; p = p->next)
+			p->item = p->item->util;
+		cnt = remove_duplicate_parents(c);
+
+		/*
+		 * It is possible that this is a merge and one side
+		 * branch does not have any commit that touches the
+		 * given paths; in such a case, the immediate parents
+		 * will be rewritten to different commits if we do not
+		 * reduce such a false merge of fast-forward parents.
+		 *
+		 *      o----X		X: the commit we are looking at;
+		 *     /    /		o: a commit that touches the paths;
+		 * ---o----'
+		 *
+		 * Further reduce the parents by removing redundant
+		 * parents.
+		 */
+		if (1 < cnt) {
+			struct commit_list *h = reduce_heads(c->parents);
+			cnt = commit_list_count(h);
+			free_commit_list(c->parents);
+			c->parents = h;
+		}
+
+		/*
+		 * A commit simplifies to itself if it is a root, if
+		 * it is UNINTERESTING, if it touches the given paths,
+		 * or if it is a merge and its parents simplifies to
+		 * more than one commits (the first two cases are
+		 * already handled at the beginning of this function).
+		 *
+		 * Otherwise, it simplifies to what its sole parent
+		 * simplifies to.
+		 */
+		if (!cnt ||
+		    (c->object.flags & UNINTERESTING) ||
+		    !(c->object.flags & TREESAME) ||
+		    (1 < cnt))
+			c->util = c;
+		else
+			c->util = c->parents->item->util;
+	}
+	free_commit_list(work);
+}
+
 static struct commit *get_revision_1(struct rev_info *revs)
 {
 	if (!revs->commits)
@@ -1570,8 +1662,14 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		case commit_error:
 			return NULL;
 		default:
-			return commit;
+			break;
+		}
+		if (revs->simplify_merges && !commit->util) {
+			simplify_merges(revs, commit);
+			if (commit->util != commit)
+				continue;
 		}
+		return commit;
 	} while (revs->commits);
 	return NULL;
 }
diff --git a/revision.h b/revision.h
index f64e8ce..dfa06b5 100644
--- a/revision.h
+++ b/revision.h
@@ -41,6 +41,7 @@ struct rev_info {
 			simplify_history:1,
 			lifo:1,
 			topo_order:1,
+			simplify_merges:1,
 			tag_objects:1,
 			tree_objects:1,
 			blob_objects:1,
