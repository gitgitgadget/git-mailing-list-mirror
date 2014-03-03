From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] cache_tree_find(): remove redundant check in while condition
Date: Mon, 03 Mar 2014 17:32:37 +0100
Message-ID: <87a9d7kztm.fsf@fencepost.gnu.org>
References: <1393862885-23271-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 03 17:32:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKVnG-0005qW-OV
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 17:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbaCCQcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 11:32:39 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:55436 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbaCCQci (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 11:32:38 -0500
Received: from localhost ([127.0.0.1]:54477 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKVnB-0000Ge-Hm; Mon, 03 Mar 2014 11:32:37 -0500
Received: by lola (Postfix, from userid 1000)
	id 23B9CE077A; Mon,  3 Mar 2014 17:32:37 +0100 (CET)
In-Reply-To: <1393862885-23271-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 3 Mar 2014 17:08:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243233>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> A trivial little cleanup.
>
>  cache-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 0bbec43..7f63c23 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -565,7 +565,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
>  			return NULL;
>  		it = sub->cache_tree;
>  		if (slash)
> -			while (*slash && *slash == '/')
> +			while (*slash == '/')
>  				slash++;
>  		if (!slash || !*slash)
>  			return it; /* prefix ended with slashes */

That seems dragging around a NULL slash a lot.  How about not checking
for it multiple times?

		if (!slash)
                	return it;
		while (*slash == '/')
			slash++;
		if (!*slash)
			return it; /* prefix ended with slashes */

As a bonus, the comment appears to be actually correct.  Attempting to
verify its correctness by seeing whether a non-NULL slash is guaranteed
to really end with slashes, we find the following code above for
defining slash:

                slash = strchr(path, '/');
                if (!slash)
                        slash = path + strlen(path);

So it is literally impossible for slash to ever be NULL and all the
checking is nonsensical.  In addition, "prefix ended with slashes" does
not seem overly convincing when this code path is reached whether or not
there is a slash at all (I am not sure about it: it depends on the
preceding find_subtree to some degree).

So perhaps all of that should just be

		while (*slash == '/')
			slash++;
		if (!*slash)
			return it;

-- 
David Kastrup
