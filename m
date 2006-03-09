From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Teach git-blame about renames
Date: Wed, 08 Mar 2006 16:27:02 -0800
Message-ID: <7v4q28h38p.fsf@assigned-by-dhcp.cox.net>
References: <20060308225412.GA461@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 01:27:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH8zl-0002GG-2O
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 01:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbWCIA1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 19:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWCIA1F
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 19:27:05 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:7303 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932648AbWCIA1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 19:27:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309002508.HKFJ20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Mar 2006 19:25:08 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17392>

Fredrik Kuivinen <freku045@student.liu.se> writes:

(from part 1/3)

> +void default_setter(struct commit* c, void* data)
> +{
> +	c->object.util = data;
> +}
> +
> +void* default_getter(struct commit* c)
> +{
> +	return c->object.util;
> +}
> +

These names are too generic to be used as a global.

The rest of the git code tends to say "void *default_getter()".

(from part 2/3)

> @@ -224,7 +224,7 @@ static struct commit_list *find_bisectio
>  	nr = 0;
>  	p = list;
>  	while (p) {
> -		if (!revs.paths || (p->item->object.flags & TREECHANGE))
> +		if (!revs.prune_data || (p->item->object.flags & TREECHANGE))
>  			nr++;
>  		p = p->next;
>  	}

Here you test with revs.prune_data, but the rest you test with
revs.prune_fn.  It is conceivable that some prune_fn could be
written without using prune_data, so I'd suggest to check
consistently with prune_fn.

> -static int compare_tree(struct tree *t1, struct tree *t2)
> +int compare_tree(struct tree *t1, struct tree *t2)
> ...
> -static int same_tree_as_empty(struct tree *t1)
> +int same_tree_as_empty(struct tree *t1)

Maybe the names are a bit too generic to be used as a global?

> -	if (revs->paths)
> +	/* if (revs->paths)
>  		try_to_simplify_commit(revs, commit);
> +	*/

Leftover commenting.


(from part 3/3)

> -	struct util_info *util;
> -	if (commit->object.util)
> -		return 0;
> +	struct util_info *util = commit->object.util;
> +
> +	if(util)
> +		return util;

The rest of the git code tends to say "if (util)".
