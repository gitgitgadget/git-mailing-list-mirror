From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/17] get_revision_internal(): make check less mysterious
Date: Tue, 21 May 2013 10:38:48 -0700
Message-ID: <7vsj1gnsgn.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<1368995232-11042-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 21 19:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeqWV-0008CJ-Rv
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab3EURiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:38:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab3EURiu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:38:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 716311E9E3;
	Tue, 21 May 2013 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DpfAipq1zkoLAzErqIzGB28rmvY=; b=G89oyY
	WNyCbZT1uCnt2ayeUUSC+pZds8pckPkR8J4mGBPyJckculaW1/NNrkSW3kiJVIHq
	1cWrNPQyiX9kxk9fDqOInjlTTEFg7C/497cDkknluClpOi51J//NV+Plk9rzz5NE
	yWZAn8tHYIUp2qUtEgiArxttVfkYIe2ar+kz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y/QPHmuVt6BTuGGoLl9B3gi6TCPxzTLV
	ziBQFlF4Wg7pJqcqXfX6dTQDrCGSTDdWryTgpWB0bLxSagKius4OnUpPhhopip5H
	0TCu7kz2wlQBYwtVTfrXgm3RScVQPJY7wzO18Ovdf6iBZHSrIFaFioMBusrouYn4
	HVvaf1CuglE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6872E1E9E1;
	Tue, 21 May 2013 17:38:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EFF51E9D5;
	Tue, 21 May 2013 17:38:49 +0000 (UTC)
In-Reply-To: <1368995232-11042-11-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sun, 19 May 2013 22:27:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BDB2890-C23D-11E2-99EC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225049>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The condition under which gc_boundary() is called was previously
>
>     if (alloc <= nr)
>
> .  But by construction, nr can never exceed alloc, so the check looks
> unnecessarily mysterious.  In fact, the purpose of the check is to try
> to avoid a realloc() call by shrinking the array if possible if it is
> at its allocation limit when a new element is about to be added.  So
> change the check to
>
>     if (nr == alloc)
>
> and add a comment to explain what's going on.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> Please check that I have properly described the purpose of this check.
>
> The way the code is written, it looks like a bad pattern of growth and
> shrinkage of the array (namely, just under the resize limit) could
> cause gc_boundary() to be called over and over again with (most of)
> the same data.  I hope that the author had some reason to believe that
> such a pattern is unlikely.

That is about comparing with "alloc", not having high and low
watermarks, right?

I do not see "alloc <= nr" is mysterious at all; it is merely being
defensive.

>
>  revision.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 2e0992b..19c59f4 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2573,8 +2573,10 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>  		if (p->flags & (CHILD_SHOWN | SHOWN))
>  			continue;
>  		p->flags |= CHILD_SHOWN;
> -		if (revs->boundary_commits.alloc <= revs->boundary_commits.nr)
> +		if (revs->boundary_commits.nr == revs->boundary_commits.alloc) {
> +			/* Try to make space and thereby avoid a realloc(): */
>  			gc_boundary(&revs->boundary_commits);
> +		}
>  		add_object_array(p, NULL, &revs->boundary_commits);
>  	}
