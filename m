From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Add merge-base
Date: Sun, 17 Apr 2005 18:01:06 +0200
Message-ID: <20050417160106.GI1487@pasky.ji.cz>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org> <Pine.LNX.4.21.0504171124340.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:58:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNC9U-0006ee-8z
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDQQB1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVDQQB1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:01:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31890 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261338AbVDQQBJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:01:09 -0400
Received: (qmail 26912 invoked by uid 2001); 17 Apr 2005 16:01:06 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504171124340.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 05:27:13PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> merge-base finds one of the best common ancestors of a pair of commits. In
> particular, it finds one of the ones which is fewest commits away from the
> further of the heads.

What does it return when I have

  A -- C
    \/   \
    /\   /
  B -- D

? >:)

I assume just either A or B, randomly?

I think it would be best if it could list all the "first-class" matches
(both A and B in this case), each on a separate line; this way the
overlay tools could choose an algorithm to evaluate those further as
they see fit - e.g. sort them by time (you might aid that by listing the
commit time in front of them), then take the first n and try to diff
them all and take the one with least changes (as suggested by Linus).

And if someone doesn't care, he just does | head -n 1 | cut -f 2.

> Index: merge-base.c
> ===================================================================
> --- /dev/null  (tree:37a0b01b85c2999243674d48bfc71cdba0e5518e)
> +++ d662b707e11391f6cfe597fd4d0bf9c41d34d01a/merge-base.c  (mode:100644 sha1:0f85e7d9e9a896d1142a54170ddf1159f11f9cdd)
> @@ -0,0 +1,108 @@
> +#include <stdlib.h>
> +#include "cache.h"
> +#include "revision.h"
> +
> +struct revision *common_ancestor(struct revision *rev1, struct revision *rev2)
> +{
> +	struct parent *parent;
> +
> +	struct parent *rev1list = malloc(sizeof(struct parent));
> +	struct parent *rev2list = malloc(sizeof(struct parent));

Did I overlook anything or you could have just a single revlist?

> +        

I smell trailing whitespaces!

> +	struct parent *posn, *temp;
> +
> +	rev1list->parent = rev1;
> +	rev1list->next = NULL;
> +
> +	rev2list->parent = rev2;
> +	rev2list->next = NULL;
> +
> +	while (rev1list || rev2list) {
> +		posn = rev1list;
> +		rev1list = NULL;
> +		while (posn) {
> +			parse_commit_object(posn->parent);
> +			if (posn->parent->flags & 0x0001) {
> +				/*
> +				printf("1 already seen %s %x\n",
> +				       sha1_to_hex(posn->parent->sha1),
> +				       posn->parent->flags);
> +				*/
> +                                // do nothing

Mostly for consistency, I'd prefer you to use /* */ comments in general.

I think a terrified squeak at stderr in this situation (possibly
suggesting fsck-cache) might be appropriate.

> +			} else if (posn->parent->flags & 0x0002) {
> +                                // XXXX free lists

Hmm, so, why not free the lists?

> +				return posn->parent;
> +			} else {
> +				/*
> +				printf("1 based on %s\n",
> +				       sha1_to_hex(posn->parent->sha1));
> +				*/
> +				posn->parent->flags |= 0x0001;
> +
> +				parent = posn->parent->parent;
> +				while (parent) {
> +					temp = malloc(sizeof(struct parent));
> +					temp->next = rev1list;
> +					temp->parent = parent->parent;
> +					rev1list = temp;
> +					parent = parent->next;
> +				}
> +			}
> +			posn = posn->next;
> +		}
> +		posn = rev2list;
> +		rev2list = NULL;
> +		while (posn) {
> +			parse_commit_object(posn->parent);
> +			if (posn->parent->flags & 0x0002) {
> +				/*
> +				printf("2 already seen %s\n",
> +				       sha1_to_hex(posn->parent->sha1));
> +				*/
> +                                // do nothing
> +			} else if (posn->parent->flags & 0x0001) {
> +                                // XXXX free lists
> +				return posn->parent;
> +			} else {
> +				/*
> +				printf("2 based on %s\n",
> +				       sha1_to_hex(posn->parent->sha1));
> +				*/
> +				posn->parent->flags |= 0x0002;
> +
> +				parent = posn->parent->parent;
> +				while (parent) {
> +					temp = malloc(sizeof(struct parent));
> +					temp->next = rev2list;
> +					temp->parent = parent->parent;
> +					rev2list = temp;
> +					parent = parent->next;
> +				}
> +			}
> +			posn = posn->next;
> +		}

Symmetrical notes apply to this half. Actually, they are too similar.
What about factoring them to a common function?

> +	}
> +	return NULL;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct revision *rev1, *rev2, *ret;
> +	unsigned char rev1key[20], rev2key[20];

A newline here please.

> +	if (argc != 3 ||
> +	    get_sha1_hex(argv[1], rev1key) ||
> +	    get_sha1_hex(argv[2], rev2key)) {
> +		usage("mergebase <commit-id> <commit-id>");
> +	}
> +	rev1 = lookup_rev(rev1key);
> +	rev2 = lookup_rev(rev2key);
> +	ret = common_ancestor(rev1, rev2);
> +	if (ret) {
> +		printf("%s\n", sha1_to_hex(ret->sha1));
> +		return 0;
> +	} else {
> +		printf("Sorry.\n");
> +		return 1;

Please stay silent if you don't have anything useful to say.

> +	}
> +	
> +}

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
