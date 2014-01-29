From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 3/4] combine-diff: Optimize combine_diff_path sets
 intersection
Date: Wed, 29 Jan 2014 15:21:06 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140129112106.GA3144@tugrik.mns.mnsspb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
 <b97e63128093f6c5f5cab854b9b9487c4e6b955a.1390234183.git.kirr@mns.spb.ru>
 <xmqqbnyvlqki.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 29 12:19:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8TAw-000383-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 12:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbaA2LTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 06:19:19 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:52085 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbaA2LTS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 06:19:18 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1W8TAm-0008PX-JJ; Wed, 29 Jan 2014 15:19:12 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1W8TCc-0001Im-CR; Wed, 29 Jan 2014 15:21:06 +0400
Content-Disposition: inline
In-Reply-To: <xmqqbnyvlqki.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241205>

On Tue, Jan 28, 2014 at 01:55:09PM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > diff --git a/combine-diff.c b/combine-diff.c
> > index 3b92c448..98c2562 100644
> > --- a/combine-diff.c
> > +++ b/combine-diff.c
> > @@ -15,8 +15,8 @@
> > ...
> > +	while (1) {
> > ...
> > +		if (cmp < 0) {
> > +			if (pprev)
> > +				pprev->next = p->next;
> > +			ptmp = p;
> > +			p = p->next;
> > +			free(ptmp);
> > +			if (curr == ptmp)
> > +				curr = p;
> >  			continue;
> > ...
> > +		if (cmp > 0) {
> > +			i++;
> > +			continue;
> >  		}
> > ...
> > +
> > +		pprev = p;
> > +		p = p->next;
> > +		i++;
> >  	}
> >  	return curr;
> >  }
> 
> Thanks. I very much like the approach.
> 
> I was staring at the above part of the code, but couldn't help
> recalling this gem (look for "understand pointers" in the article):
> 
>   http://meta.slashdot.org/story/12/10/11/0030249/linus-torvalds-answers-your-questions
> 
> How about doing it this way (on top of your patch)?  It reduces 7
> lines even though it adds two comment lines ;-)
> 
>  combine-diff.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)

Thanks, this is sound approach and adding guiding comments is good, and
also now some of us with self-taught heritage understand (or at least
they think so) pointers a bit better :)

Now some nitpicks:

> diff --git a/combine-diff.c b/combine-diff.c
> index 2d79312..0809e79 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -15,11 +15,10 @@
>  static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
>  {
>  	struct diff_queue_struct *q = &diff_queued_diff;
> -	struct combine_diff_path *p, *pprev, *ptmp;
> +	struct combine_diff_path *p, **tail = &curr;
>  	int i, cmp;
>  
>  	if (!n) {
> -		struct combine_diff_path *list = NULL, **tail = &list;
>  		for (i = 0; i < q->nr; i++) {
>  			int len;
>  			const char *path;
> @@ -43,35 +42,30 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
>  			*tail = p;
>  			tail = &p->next;
>  		}
> -		return list;
> +		return curr;
>  	}
>  
>  	/*
> -	 * NOTE paths are coming sorted here (= in tree order)
> +	 * paths in curr (linked list) and q->queue[] (array) are
> +	 * both sorted in the tree order.
>  	 */
> -
> -	pprev = NULL;
> -	p = curr;
>  	i = 0;
> +	while ((p = *tail) != NULL) {
> +		cmp = ((i >= q->nr)
> +		       ? -1 : strcmp(p->path, q->queue[i]->two->path));

I liked cmp assignment being the original way - when "-1" is on one line
and strcmp is on another - to me it reads better. I'm not insisting on
it though.


> -	while (1) {
> -		if (!p)
> -			break;
> -
> -		cmp = (i >= q->nr) ? -1
> -				   : strcmp(p->path, q->queue[i]->two->path);
>  		if (cmp < 0) {
> -			if (pprev)
> -				pprev->next = p->next;
> -			ptmp = p;
> -			p = p->next;
> -			free(ptmp);
> -			if (curr == ptmp)
> -				curr = p;
> +			/* p->path not in q->queue[]; drop it */
> +			struct combine_diff_path *next = p->next;
> +
> +			if ((*tail = next) != NULL)
> +				tail = &next->next;
> +			free(p);
>  			continue;
>  		}

A bug crept in here - if we are removing the first element, i.e. when
p=curr, we have to advance curr as well - as we are returning curr back
as new intersected paths set list start. That's why there was curr
change.

Now curr stays the same, and if we'll remove the first element, curr
will be pointing to freed memory -> oops. A possible fixup could be:

---- 8< ----
diff --git a/combine-diff.c b/combine-diff.c
index 0809e79..6a61a25 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -60,6 +60,8 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 
                        if ((*tail = next) != NULL)
                                tail = &next->next;
+                       if (curr == p)
+                               curr = next;
                        free(p);
                        continue;
                }
---- 8< ----

but this is blind code, as I had not tested it.


>  
>  		if (cmp > 0) {
> +			/* q->queue[i] not in p->path; skip it */
>  			i++;
>  			continue;
>  		}
> @@ -80,8 +74,7 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
>  		p->parent[n].mode = q->queue[i]->one->mode;
>  		p->parent[n].status = q->queue[i]->status;
>  
> -		pprev = p;
> -		p = p->next;
> +		tail = &p->next;
>  		i++;
>  	}
>  	return curr;


P.S. I'm slowly working on to speedup combine-diff further - the same
way as diff_tree() skips path for two trees, for combine-diff we could
traverse a merge tree and n parents simultaneously, even not delving
into generating (usually huge) diff(merge,parent_i) for a path, if we
know such diff for parent_j will be empty.

I have no numbers yet, but this should give significant speedup, as my
tracing showed for e.g. linux.git a lot of diffing is done for
combine-diff for merges to e.g. second parents (mean value of diff to
HEAD^2 is ~ 1500 paths) and almost all of them annulate when intersected
to diff(HEAD, HEAD^1).

Only this can't work (or at least I don't know how) if rename/copy
detection is on, so there will be two codepaths - fast, if we run
without -M/-C, and generic, but slower, where combine-diff paths are
computed as intersections:

    D(A,P1,P2,...Pn) = D(A,P1) ^ D(A,P2) ^ ... ^ D(A,Pn)

i.e. the current way.

Does this approach sound reasonable? My draft not-working-yet code is here:

http://repo.or.cz/w/git/kirr.git/shortlog/refs/heads/x/combinediff-sorted
(look for diff_tree_combined_X)


Thanks,
Kirill
