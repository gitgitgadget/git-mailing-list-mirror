From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 1/1] Add a topological sort procedure to commit.c
Date: Thu, 30 Jun 2005 17:00:40 +1000
Message-ID: <2cfc403205063000009d149f5@mail.gmail.com>
References: <20050630055821.1329.qmail@blackcubes.dyndns.org>
	 <7v1x6k5oau.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 08:54:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnsvn-0002fj-3R
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 08:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVF3HBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 03:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVF3HBE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 03:01:04 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:33501 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262878AbVF3HAl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 03:00:41 -0400
Received: by rproxy.gmail.com with SMTP id i8so60602rne
        for <git@vger.kernel.org>; Thu, 30 Jun 2005 00:00:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F0G7zzOHnQYCXhx+gW03BXIkXbI7Esv919naWzHKpHNJXEpa1r/4czEQ4JKa9iMatPbavTBqnO3ZlKSCjH/PoePtHJL21gHYJqpB0aX8JPSj1rWh1xosCh5xUwvrCnjLfVlSOsosSRTFLF8HZTv1zagOm5APzj2lL0ctHi3/qKQ=
Received: by 10.38.65.12 with SMTP id n12mr382513rna;
        Thu, 30 Jun 2005 00:00:41 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 30 Jun 2005 00:00:40 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x6k5oau.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/30/05, Junio C Hamano <junkio@cox.net> wrote:
> Interesting idea.  Help me understand the code.
> 
> @@ -346,3 +352,79 @@ int count_parents(struct commit * commit
>          return count;
>  }
> 
> +/*
> + * Performs an in-place topological sort on the list supplied
> + */
> +void sort_in_topological_order(struct commit_list ** list)
> +{
> +       ...
> +       /* allocate an array to help sort the list */
> +       nodes = xmalloc(sizeof(*nodes) * count);
> +       /* link the list to the array */
> +       next_nodes = nodes;
> +       next=*list;
> +       while (next) {
> +               next_nodes->list_item = next;
> +               next->item->object.util = next_nodes;
> +               next_nodes++;
> +               next = next->next;
> +       }
> +       /* update the indegree */
> 
> Don't you want to initialize before update?  Either in the above
> while(next) loop or just after xmalloc() with a single
> memset(0), or xcalloc()?

Oops, yes I do.

> 
> +       next=*list;
> +       while (next) {
> +               struct commit_list * parents = next->item->parents;
> +               while (parents) {
> +                       struct commit * parent=parents->item;
> +                       struct sort_node * pn = (struct sort_node *)parent->object.util;
> +
> +                       if (pn)
> +                               pn->indegree++;
> 
> I take this to mean that not all commits are on *list and such
> commits not on *list have object.util set to NULL.  Who
> initializes object.util (this is not a nitpick but a question as
> a user)?   commit.c::lookup_commit() uses memset(0) and when
> sort_in_topological_order() function is called everybody (not
> limited to the ones on *list but all commits reachable from
> them) are supposed to have object.util set to NULL?
> 

Yes, that is the current assumption. Alternatively, I could save the current
version of object.util in the temporary structure and restore it when done.
Perhaps I'll do that.

> So sort_node->indegree means how many children of it are on the
> *list.  Am I reading you correctly so far?

Correct.

> 
> +                       parents=parents->next;
> +               }
> +               next=next->next;
> +       }
> +       /* find the roots */
> +       next=*list;
> +       while (next) {
> +               struct sort_node * node = (struct sort_node *)next->item->object.util;
> +
> +               if (node->indegree == 0) {
> +                       commit_list_insert(next->item, &work);
> +               }
> +               next=next->next;
> +       }
> 
> You say "find the roots", but this sounds more like finding the
> tips of forests.  You are finding people without children,
> right (again, not a nitpick but trying to understand the code)?

True. Should reword the comment to find the tips.

> 
> +       /* process the list in topological order */
> +       while (work) {
> +               struct commit * work_item = pop_commit(&work);
> +               struct sort_node * work_node = (struct sort_node *)work_item->object.util;
> +               struct commit_list * parents = work_item->parents;
> +
> +               while (parents) {
> +                       struct commit * parent=parents->item;
> +                       struct sort_node * pn = (struct sort_node *)parent->object.util;
> +
> +                       if (pn) {
> +                               pn->indegree--;
> +                               if (!pn->indegree)
> +                                       commit_list_insert(parent, &work);
> 
> And when you look at each parent, and push the parent into work
> queue when you have seen all its children.

Correct.

> 
> +                       }
> +                       parents=parents->next;
> +               }
> 
> And at this point work_item, popped from your work queue, is
> guaranteed to be a commit all of whose children have been
> processed (i.e. pushed into the original *list).

Yep.

> 
> +               *pptr = work_node->list_item;
> +               work_node->list_item->next = NULL;
> +               pptr = &(*pptr)->next;
> +               work_item->object.util = NULL;
> 
> +       }
> +       free(nodes);
> +}
> 
> By the way, you seem to be using "git format-patch".  Do you
> want to help me pushing it upstream ;-)?

Yep, but can you fix the PATCH 1/1 thing first :-)

I'll rework the patch, incorporating answers to your questions into the comment.

Regards,

jon.
