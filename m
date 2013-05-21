From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/17] gc_boundary(): move the check "alloc <= nr" to caller
Date: Tue, 21 May 2013 10:49:15 -0700
Message-ID: <7vobc4nrz8.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<1368995232-11042-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 21 19:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueqgj-00051P-Mv
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab3EURtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:49:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755418Ab3EURtS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:49:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8F0E202AD;
	Tue, 21 May 2013 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Q2V5DaWupcnXz5qODT7uBCUz/s=; b=mMcpBT
	wX7NTp3LUAJ+jhn2yhEhdhg0wpj1RmsZxincLGC53F7ANnpjuxgkEXwpjWrf6JpI
	mrapbq1jphOF37vPRUKja92KUGTPToiihUvZYpCt4hNq7Gmxc10bOzYBKqv/Ryh6
	Tf+cENVbLQoHre4k4hlTj93HlIZIiGBqUq2/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qMbQ2ZJZGFn68eaCVD2jL2+tEgMDELYU
	MSK4r2rXen21hT4DCMh4mWaDCK3cY5V7wGZeV+t6UtIfIlMkeLX5FRQHEU8TAZmG
	vXJ46YaQg2lbT83XtO/N7CImGnysffU7R28yOGfKIUePNGXUhR813FsuTH52vns9
	SfY8gZkVAE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFC59202AC;
	Tue, 21 May 2013 17:49:17 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AA5A202A9;
	Tue, 21 May 2013 17:49:16 +0000 (UTC)
In-Reply-To: <1368995232-11042-10-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sun, 19 May 2013 22:27:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1D8F6F2-C23E-11E2-A073-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225050>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> There is no logical reason for this test to be here.  At the caller we
> might be able to figure out its meaning.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

I do not think this change is justified, *unless* the caller later
in the series gains a better heuristics than what can be done with
information in the object_array (namely, alloc and nr) to decide
when to trigger gc.

And I was hoping to see such a cleverness added to the caller, but I
do not think I saw any.

I would have to say gc_boundary() knows better when it needs to gc
with the code at this point in the series, and that is true also in
the final code after all the patches in this series.

If we keep the "when to gc" logic inside "gc", in 11/17 this caller
can no longer call directly to object_array_filter().  It should
call gc_boundary(), but I see it as a merit, not a downside.  The
"gc function can later be taught the high/low watermark logic you
alluded to in 10/17, and the growth/shrinkage characteristic you
would take advantage of while doing "gc" is specific to this
codepath.  And the logic still does not have to have access to
anything only the caller has access to; "gc" can work on what can be
read from the object_array->{alloc,nr} that is given to it.

  revision.c | 27 ++++++++++++---------------

>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 8ac88d6..2e0992b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2437,23 +2437,19 @@ static struct commit *get_revision_1(struct rev_info *revs)
>  
>  static void gc_boundary(struct object_array *array)
>  {
> -	unsigned nr = array->nr;
> -	unsigned alloc = array->alloc;
> +	unsigned nr = array->nr, i, j;
>  	struct object_array_entry *objects = array->objects;
>  
> -	if (alloc <= nr) {
> -		unsigned i, j;
> -		for (i = j = 0; i < nr; i++) {
> -			if (objects[i].item->flags & SHOWN)
> -				continue;
> -			if (i != j)
> -				objects[j] = objects[i];
> -			j++;
> -		}
> -		for (i = j; i < nr; i++)
> -			objects[i].item = NULL;
> -		array->nr = j;
> +	for (i = j = 0; i < nr; i++) {
> +		if (objects[i].item->flags & SHOWN)
> +			continue;
> +		if (i != j)
> +			objects[j] = objects[i];
> +		j++;
>  	}
> +	for (i = j; i < nr; i++)
> +		objects[i].item = NULL;
> +	array->nr = j;
>  }
>  
>  static void create_boundary_commit_list(struct rev_info *revs)
> @@ -2577,7 +2573,8 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>  		if (p->flags & (CHILD_SHOWN | SHOWN))
>  			continue;
>  		p->flags |= CHILD_SHOWN;
> -		gc_boundary(&revs->boundary_commits);
> +		if (revs->boundary_commits.alloc <= revs->boundary_commits.nr)
> +			gc_boundary(&revs->boundary_commits);
>  		add_object_array(p, NULL, &revs->boundary_commits);
>  	}
