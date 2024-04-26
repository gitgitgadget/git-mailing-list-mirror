Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879941DA58
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166133; cv=none; b=TaNyNb9sFTOUBRvY8VVk1BdBXrWJBl/SyxveMihVG3BIfsTUuIokaJ9e29jgZCR7468G45R3iuJZsQF5wbczwWcx3hO7YRtkixtuGT1rdTgC/c/R8Enq/gkpqceFQZ3YQ5miKH40Z0uEGqbJm5v3V/RV5GHXwXdBgmUQHKNRVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166133; c=relaxed/simple;
	bh=B8HfSdmQSr9lmYgTdJ40JYxqYURhgtm164XMGWEI2YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCmjXljSwW+XMu0J4z2YatoLp9VAuiwchs6Iul5uwT2EWuMoYUbL7zAWJHYlmbjouz9Ok7oZchLoOv2mMmkqBr5rlwFTNQo7ETmWfLLcUmqsKkFur62zyf2OtuJqgFFGII4By6YavVOvlxeFYzq0z68fbIZFJ/csLsNDKzjD2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13776 invoked by uid 109); 26 Apr 2024 21:15:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Apr 2024 21:15:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3705 invoked by uid 111); 26 Apr 2024 21:15:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Apr 2024 17:15:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Apr 2024 17:15:29 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Karthik Nayak <karthik.188@gmail.com>, christian.couder@gmail.com,
	git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
Message-ID: <20240426211529.GD13703@coredump.intra.peff.net>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com>
 <xmqq1q6rc44n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q6rc44n.fsf@gitster.g>

On Fri, Apr 26, 2024 at 12:31:36PM -0700, Junio C Hamano wrote:

> This is an unrelated #leftoverbits tangent, but while trying to find
> out the reason why "[_add]" in the title looked irritating to me, I
> noticed that builtin/show-ref.c includes <refs/refs-internal.h>.  I
> do not know what it uses from the "internal" implementation detail,
> but the API may have to be cleaned up so that a random "client"
> caller do not have to do so.

There are two issues. One is the use of refs_read_raw_ref(), added by
Patrick's 9080a7f178 (builtin/show-ref: add new mode to check for
reference existence, 2023-10-31). And it argues there why the regular
API is unsufficient (mostly because it does not protect errno).

But the more interesting one is a call to refname_is_safe(), added
recently by Phillip's 1dbe401563 (show-ref --verify: accept pseudorefs,
2024-02-07). Looking at that commit, the intent was to allow pseudo-refs
by loosening the conditional that checked "HEAD" to allow "FOO_BAR" but
not "foobar" outside of "refs/". We enforce the all-caps pseudoref
syntax in is_refname_safe().

The proper API there is I think check_ref_format() with ALLOW_ONELEVEL.
But you shouldn't need to do that, because the refs code should be
checking the names itself (using check_ref_format() usually, but falling
back to refname_is_safe() if the ALLOW_BAD_NAME flag is passed).

And I think there _is_ a bug there. The idea of those two functions is
that check_ref_format() would allow a subset of what refname_is_safe()
does. We'd fall back to the latter when deleting, but not otherwise
allow creation or updates.

However, it looks like check_ref_format() doesn't enforce the pseudo-ref
syntax. It will happily resolve this:

  git rev-parse HEAD >.git/foo
  git rev-parse foo

and even update it:

  git update-ref foo HEAD

though curiously we will refuse to delete it:

  $ git update-ref -d foo
  error: refusing to update ref with bad name 'foo'

since that sets the ALLOW_BAD_NAME flag!

IMHO these should _all_ be forbidden, because we only want to allow the
more limited pseudoref names everywhere (and never mischievous ones like
"config" or whatever). And once we are doing that, then show-ref has no
need to check the format. It can just call read_ref() and it either gets
an answer or doesn't.

I don't know if that is a #leftoverbit though. It perhaps more
complicated than that.

-Peff
