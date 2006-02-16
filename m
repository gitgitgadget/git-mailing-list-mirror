From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list --date-order ?
Date: Wed, 15 Feb 2006 19:11:21 -0800
Message-ID: <7vpsloknfq.fsf@assigned-by-dhcp.cox.net>
References: <17395.58926.26670.23572@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 04:11:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9ZYJ-0002nc-Kj
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 04:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWBPDL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 22:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBPDL2
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 22:11:28 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32406 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751378AbWBPDL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 22:11:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216030823.ZXDU17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 22:08:23 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17395.58926.26670.23572@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Thu, 16 Feb 2006 13:40:46 +1100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16263>

Paul Mackerras <paulus@samba.org> writes:

> Junio,
>
> Gitk has a -d option that tells it to reorder the commits in
> decreasing order of their commit time, subject to the constraint that
> parents come after all of their children.  Currently it uses
> git-rev-list --header --topo-order --parents and then reorders the
> commits internally.
>
> How hard would it be to add a --date-order flag to git-rev-list to
> make it order the commits in decreasing commit time order, subject to
> the constraint that parents come after their children?
>
> If we had that then I could remove another chunk of code from gitk and
> make it a bit faster.

It's been a while that I read the topo-order code, but I suspect
something like this?  I may be completely off the mark here.

--
diff --git a/commit.c b/commit.c
index 67e11d7..0d94e4d 100644
--- a/commit.c
+++ b/commit.c
@@ -630,7 +630,9 @@ void sort_in_topological_order(struct co
 		}
 		next=next->next;
 	}
+
 	/* process the list in topological order */
+	sort_by_date(&work);
 	while (work) {
 		struct commit * work_item = pop_commit(&work);
 		struct sort_node * work_node = (struct sort_node *)work_item->object.util;
@@ -648,7 +650,7 @@ void sort_in_topological_order(struct co
                                  */
 				pn->indegree--;
 				if (!pn->indegree) 
-					commit_list_insert(parent, &work);
+					insert_by_date(parent, &work);
 			}
 			parents=parents->next;
 		}
