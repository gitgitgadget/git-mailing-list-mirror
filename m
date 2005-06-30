From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Add a topological sort procedure to commit.c
Date: Wed, 29 Jun 2005 23:52:41 -0700
Message-ID: <7v1x6k5oau.fsf@assigned-by-dhcp.cox.net>
References: <20050630055821.1329.qmail@blackcubes.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 08:46:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnsoY-0001sf-KQ
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 08:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVF3Gxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 02:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVF3Gxj
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 02:53:39 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:2435 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262881AbVF3Gwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 02:52:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050630065241.GFXK18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 02:52:41 -0400
To: Jon Seymour <jon.seymour@gmail.com>
In-Reply-To: <20050630055821.1329.qmail@blackcubes.dyndns.org> (Jon Seymour's message of "Thu, 30 Jun 2005 15:58:21 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Interesting idea.  Help me understand the code.

@@ -346,3 +352,79 @@ int count_parents(struct commit * commit
         return count;
 }
 
+/*
+ * Performs an in-place topological sort on the list supplied
+ */
+void sort_in_topological_order(struct commit_list ** list)
+{
+	...
+	/* allocate an array to help sort the list */
+	nodes = xmalloc(sizeof(*nodes) * count);
+	/* link the list to the array */
+	next_nodes = nodes;
+	next=*list;
+	while (next) {
+		next_nodes->list_item = next;
+		next->item->object.util = next_nodes;
+		next_nodes++;
+		next = next->next;
+	}
+	/* update the indegree */

Don't you want to initialize before update?  Either in the above
while(next) loop or just after xmalloc() with a single
memset(0), or xcalloc()?

+	next=*list;
+	while (next) {
+		struct commit_list * parents = next->item->parents;
+		while (parents) {
+			struct commit * parent=parents->item;
+			struct sort_node * pn = (struct sort_node *)parent->object.util;
+			
+			if (pn)
+				pn->indegree++;

I take this to mean that not all commits are on *list and such
commits not on *list have object.util set to NULL.  Who
initializes object.util (this is not a nitpick but a question as
a user)?   commit.c::lookup_commit() uses memset(0) and when
sort_in_topological_order() function is called everybody (not
limited to the ones on *list but all commits reachable from
them) are supposed to have object.util set to NULL?

So sort_node->indegree means how many children of it are on the
*list.  Am I reading you correctly so far?

+			parents=parents->next;
+		}
+		next=next->next;
+	}
+	/* find the roots */
+	next=*list;
+	while (next) {
+		struct sort_node * node = (struct sort_node *)next->item->object.util;
+
+		if (node->indegree == 0) {
+			commit_list_insert(next->item, &work);
+		}
+		next=next->next;
+	}

You say "find the roots", but this sounds more like finding the
tips of forests.  You are finding people without children,
right (again, not a nitpick but trying to understand the code)?

+	/* process the list in topological order */
+	while (work) {
+		struct commit * work_item = pop_commit(&work);
+		struct sort_node * work_node = (struct sort_node *)work_item->object.util;
+		struct commit_list * parents = work_item->parents;
+
+		while (parents) {
+			struct commit * parent=parents->item;
+			struct sort_node * pn = (struct sort_node *)parent->object.util;
+			
+			if (pn) {
+				pn->indegree--;
+				if (!pn->indegree) 
+					commit_list_insert(parent, &work);

And when you look at each parent, and push the parent into work
queue when you have seen all its children.

+			}
+			parents=parents->next;
+		}

And at this point work_item, popped from your work queue, is
guaranteed to be a commit all of whose children have been
processed (i.e. pushed into the original *list).

+		*pptr = work_node->list_item;
+		work_node->list_item->next = NULL;
+		pptr = &(*pptr)->next;
+		work_item->object.util = NULL;

+	}
+	free(nodes);
+}

By the way, you seem to be using "git format-patch".  Do you
want to help me pushing it upstream ;-)?
