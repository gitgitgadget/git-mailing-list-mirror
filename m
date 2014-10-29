From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] cache-tree: avoid infinite loop on zero-entry tree
Date: Wed, 29 Oct 2014 11:50:12 -0700
Message-ID: <xmqqppdayal7.fsf@gitster.dls.corp.google.com>
References: <20141029171158.GA32188@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 19:50:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjYK5-0002tb-TK
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 19:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104AbaJ2SuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 14:50:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752071AbaJ2SuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 14:50:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD708199C0;
	Wed, 29 Oct 2014 14:50:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O7sk+zEE5HiWPTMOQJO4xVteFbI=; b=GeaTCr
	k/goELuham3/AIkgr4WBZ8sPZEeFt8s0LnpJC8+Zaor5Qe2y9h2bQW1YeUd6sKE0
	p3NMVE4J42cRG6e297ip9jbpADzy1vROlEcaz2+zZnsWM5mcGY+PFNYNB2Iajyh6
	Z+J+NgMIjI5y1iQh4rVnY1hvjNUGmAoSIpgSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=obg296M9gy3pmGcnpZjM0LSnOUS93q1d
	2cdckZHpKvXzl8JzMYcE/embgnbARwqd8JV2c/Z4XCtlSrBkpYz1Hj4CCYBAYmG2
	YKFpLb8rddMFvYM85gEs2Hyjql/wC8P8LAS+U/fM1vYTg3LT+ymz/lXSFTDgPuyE
	qccC2Zp/2qk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3CEE199BF;
	Wed, 29 Oct 2014 14:50:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AA7D199BE;
	Wed, 29 Oct 2014 14:50:13 -0400 (EDT)
In-Reply-To: <20141029171158.GA32188@peff.net> (Jeff King's message of "Wed,
	29 Oct 2014 13:11:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A6F3578-5F9C-11E4-A62D-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm a little iffy on this just because it is fixing one particular bug,
> and I am sure there are probably a bunch of other ways to have a bogus
> index. Fundamentally, I think we pretty much trust that the index was
> not maliciously generated (unlike packfiles, for instance, which can
> come from elsewhere).  Still, this is one step closer to safe, and the
> bug was seen in the wild, so maybe it is worth doing.

Is it cheap to sanity-check the input when we map in the cache-tree
upon read_cache()?  Then we can just invalidate the cache-tree,
either in its entirety (easy) or just the bogus subpart (maybe not
worth doing).

> We could alternatively (or in addition) reject 0-entry cache trees when
> reading them from disk. The trick, though, is that it is not just
> records with 0 entries, but ones where the sum of the entries and
> subtree entries is 0. Given that it is not something we expect to
> happen, it is easier to catch it here. And we know there can be no
> regressions for missed corner cases, because the case we are catching
> here would _always_ have gone into an infinite loop before this patch.

OK.  I wonder if we can instead die here but propagate the error
back up the callchain and have the ultimate caller rebuild the cache
tree without paying attention to the existing data that we now know
is bogus.

>  cache-tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 215202c..32772b9 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -303,6 +303,8 @@ static int update_one(struct cache_tree *it,
>  				    flags);
>  		if (subcnt < 0)
>  			return subcnt;
> +		if (!subcnt)
> +			die("index cache-tree records empty sub-tree");
>  		i += subcnt;
>  		sub->count = subcnt; /* to be used in the next loop */
>  		*skip_count += subskip;
