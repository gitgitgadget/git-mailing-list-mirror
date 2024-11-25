Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235419D09F
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534079; cv=none; b=cQfyswEI+9fhlU06jalVHqoD2vJ/MP7SPZC6OLOr+pjST1FuaHr+W6ARD/OAGiFyR0vBU/9W5UFKvzsgh6B1Sbgt8gSx3XUskfh84QaafKPdz+gBvq0jXaRBR0aju14PE+PLKp9BgYqlj6jLJiAZnnhQgyLX9yN80zCN1CuKmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534079; c=relaxed/simple;
	bh=beEu8+mrR8IBEPFNhtWO8zouLMPd2PD51dEbW5uPOAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqq1qfc0DIQS6yAYr61D1dgo+N2T5AlvWzLay2ZIScivOZEWyrpaPRJRR+/gJeWyp0RjeVxoaxlRotjlMsJzDmKQUcjWfD0OY4ioIEoPMfhZ9aHud3K9ACHsqBaXgYiHYp2Urcg3ymWQNqhwML6d3s8OKcXJu9UoGoC6K6oeiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CM1VDiHR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CM1VDiHR"
Received: (qmail 10867 invoked by uid 109); 25 Nov 2024 11:27:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=beEu8+mrR8IBEPFNhtWO8zouLMPd2PD51dEbW5uPOAg=; b=CM1VDiHRf7cNQH+nZJt+89cPm6Bo9ichw+oyRpIgm1dYsagcxDmCVuJ4zRj7fJacRosPL69kR6we9rHWFtkcqbk9vxkp9+3c7JmKTTUdtT4SutvRoMnytW16zQjTiJP6weoHrQfgrIsqCrHHn+HczvgcPZYUqA3SRT+88RHhEjgN2GhdcfDejM9+bftxeeS6i0/vJDYB92zhMl4hYmJe+5B2VLhNhi9LNidF1TtP7/I8VXkHLLr7P2+9LJUd0dxyXY9wvSqp6+QfITjqsSpvdsV0uw26qQ2DtEy80BMkhrDNjK3H+q5j1xBQaJc1ABV9Z67B2rw8A7wMxk96Uv24PA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Nov 2024 11:27:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8953 invoked by uid 111); 25 Nov 2024 11:27:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2024 06:27:49 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Nov 2024 06:27:46 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 07/27] bisect: fix various cases where we leak commit
 list items
Message-ID: <20241125112746.GA1069812@coredump.intra.peff.net>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
 <20241120-b4-pks-leak-fixes-pt10-v3-7-d67f08f45c74@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-7-d67f08f45c74@pks.im>

On Wed, Nov 20, 2024 at 02:39:36PM +0100, Patrick Steinhardt wrote:

> diff --git a/bisect.c b/bisect.c
> index 12efcff2e3c1836ab6e63d36e4d42269fbcaeaab..f6fa5c235ffb351011ed5e81771fbcdad9ca0917 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -442,9 +442,12 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
>  			best->next = NULL;
>  		}
>  		*reaches = weight(best);
> +	} else {
> +		free_commit_list(*commit_list);
>  	}

Coverity complains about this hunk being a potential double-free, and
I'm not sure it's wrong.

Looking at the parts of the function related to commit_list:

  void find_bisection(struct commit_list **commit_list, ...)
  {
  ...
          /*
           * Count the number of total and tree-changing items on the
           * list, while reversing the list.
           */
          for (nr = on_list = 0, last = NULL, p = *commit_list;
               p;
               p = next) {
                  unsigned commit_flags = p->item->object.flags;

                  next = p->next;
                  if (commit_flags & UNINTERESTING) {
                          free(p);
                          continue;
                  }
                  p->next = last;
                  last = p;
                  if (!(commit_flags & TREESAME))
                          nr++;
                  on_list++;
          }
  ...

          best = do_find_bisection(list, nr, weights, bisect_flags);
          if (best) {
                  if (!(bisect_flags & FIND_BISECTION_ALL)) {
                          list->item = best->item;
                          free_commit_list(list->next);
                          best = list;
                          best->next = NULL;
                  }
                  *reaches = weight(best);
          } else {
                  free_commit_list(*commit_list);
          }
  ...
  }

We iterate over commit_list using "p". If the entry is UNINTERESTING, we
free that node immediately and skip it. That's OK for a node in the
middle of the list, since after we reverse the list by modifying the
next pointers, nobody will refer to it anymore.

But we never updated commit_list. What if the first entry in the list is
UNINTERESTING? We'll have freed it, but *commit_list will still point to
it, and your free_commit_list() will be a double-free.

And for that matter, I am confused about what should be in commit_list
after the reverse anyway. Even if we didn't free that first entry, it
will now be the final entry in the reversed list. So wouldn't
*commit_list always be pointing to a single node?

Should the code be freeing "list" and not "*commit_list"? Should the
reversal be assigning "*commit_list = last" (in which case do we still
need "list" at all)?

-Peff
