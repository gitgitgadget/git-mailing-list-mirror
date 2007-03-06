From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Tue, 6 Mar 2007 02:12:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060137210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
 <7vejo3xuq9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 02:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOOEB-0001NO-DT
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 02:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933736AbXCFBMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 20:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933727AbXCFBMT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 20:12:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:42229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933736AbXCFBMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 20:12:17 -0500
Received: (qmail invoked by alias); 06 Mar 2007 01:12:16 -0000
X-Provags-ID: V01U2FsdGVkX1+MNJ0+jxyMrB4c9WV6GVTMpgv6oZMgPqy8AM4UCv
	9s7FirCV85onYo
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vejo3xuq9.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41519>

Hi,

On Mon, 5 Mar 2007, Junio C Hamano wrote:

>  - rip out the boundary logic from the commit walker. Placing
>    "negative" commits in the revs->commits list was Ok if all we
>    cared about "boundary" was the UNINTERESTING limiting case,
>    but conceptually it was wrong.

I agree.

> It loses more code than it adds, even when the new gc_boundary()
> function, which is purely for early optimization, is counted.

I have the slight suspicion that it might be faster if gc_boundary() was 
not called at all... But that's probably a subject for later.

> Note that this patch is purely for eyeballing and discussion
> only.  It breaks git-bundle's verify logic because the logic
> does not use BOUNDARY_SHOW flag for its internal computation
> anymore.  After we correct it not to attempt to affect the
> boundary processing by setting the BOUNDARY_SHOW flag, we can
> remove BOUNDARY_SHOW from revision.h and use that bit assignment
> for the new CHILD_SHOWN flag.

Yes, git-bundle should be easy enough to fix.

> +	struct commit_list *l;
> +
> +	if (revs->boundary == 2) {
> +		unsigned i;
> +		struct object_array *array = &revs->boundary_commits;
> +		struct object_array_entry *objects = array->objects;
> +		for (i = 0; i < array->nr; i++) {

An easy optimisation would be iterate in the other direction, resetting 
array->nr after the loop. Of course, this does not preserve the order...

> +	if (revs->reverse) {
> +		l = NULL;
> +		while ((c = get_revision_1(revs)))
> +			commit_list_insert(c, &l);
> +		revs->commits = l;
> +		revs->reverse = 0;
>  	}

Clever!

>  
> -	/* Check the max_count ... */
> +	/*
> +	 * Now pick up what they want to give us
> +	 */
> +	c = get_revision_1(revs);
> +	while (0 < revs->skip_count) {
> +		revs->skip_count--;
> +		c = get_revision_1(revs);
> +		if (!c)
> +			break;
> +	}
> +
> +	/*
> +	 * Check the max_count.
> +	 */
>  	switch (revs->max_count) {
>  	case -1:
>  		break;
>  	case 0:
> -		if (revs->boundary) {
> -			struct commit_list *list = revs->commits;
> -			while (list) {
> -				list->item->object.flags |=
> -					BOUNDARY_SHOW | BOUNDARY;
> -				list = list->next;
> -			}
> -			/* all remaining commits are boundary commits */
> -			revs->max_count = -1;
> -			revs->limited = 1;
> -		} else
> -			return NULL;
> +		c = NULL;
> +		break;

I guess that you want to do this instead:

	case 0:
		c = NULL;
		/* fall through */
>  	default:
>  		revs->max_count--;

so that --reverse actually works (otherwise, the while() loop would 
deplete max_count, and then max_count would be 0, and nothing would be 
returned).

> +	/*
> +	 * boundary commits are the commits that are parents of the
> +	 * ones we got from get_revision_1() but they themselves are
> +	 * not returned from get_revision_1().  Before returning
> +	 * 'c', we need to mark its parents that they could be boundaries.
> +	 */
> +
> +	for (l = c->parents; l; l = l->next) {

AFAICT this changes behaviour: c->parents were possibly rewritten. But I 
guess it makes sense showing the rewritten parents as boundary commits, 
not the real parents.

> +		struct object *p;
> +		p = &(l->item->object);
> +		if (p->flags & CHILD_SHOWN)

... or
		if (p->flags & (CHILD_SHOWN | SHOWN))

?

Ciao,
Dscho
