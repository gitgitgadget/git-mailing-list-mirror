Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73A32FA2C
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413643; cv=none; b=ijOjfGimizdbkjhElReAl3eWo9YVwPwVXVP+L+6nxQymeu4rUkEBBnuRUpBJVXVyajZ2x3soC+AaF4C7Bx2rqwC1wV2rctmMJY6ezVwqtG80Iw6OY1e5bu6PINTED1X9mpsM00j7nTv41lftJuvD5y7dr6Jv7jor7tyUWeQ8aNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413643; c=relaxed/simple;
	bh=eFQa9ZNUmO+8Ff1kzB2GhMduw+wKnQ5uCd6XdVKxqZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBLpk2KdFy1/dNe211G9RlH+j5OX9xWgJdxdVg4ufaqwbhidzCSizqOFxJyruFvhsrYt9i6cB98hoIyiHfZJDFPq3RWzktphvC/DP9XU3OkxMpsYPCrfdTr4TrVh5Iu09XTNeE8aVOhDeSlJti7+oEIiBH1w8hjo8sfpXWowIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ckuJxQ9t; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ckuJxQ9t"
Received: (qmail 40869 invoked by uid 109); 14 Jan 2026 18:00:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eFQa9ZNUmO+8Ff1kzB2GhMduw+wKnQ5uCd6XdVKxqZI=; b=ckuJxQ9tzz2EoagJkTjFG+glvL12JeeSavDYX/MW/yOA8NGvwBoDpkY6iLfzjRaf57cgbw0E6Lo723sheRtT1pVDEmO2BZW2mEUw2hYtsZiyh4LCvODQcyXPqalB8tDfuLt9/onncQ5y+qt+32m1aLe8ZPy3D0tf974dch/n8SNg3zCKRtUUKXseRlHG/Wb5enBVXOMFkLCCsiKPhGkTXhF7wawJUgH4hn/tLhuQ2FG2fYitz22QURIfvC7mmSLamGaubBgswYh0L/JThadUGVctQHcSaqjS0uIYY6L25DeTGF3UopSKn5b0KqJc7pDP8WFHPwG2PSpuzU8naJ4FHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 18:00:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67562 invoked by uid 111); 14 Jan 2026 18:00:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 13:00:42 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 13:00:40 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 5/6] fetch: utilize rejected ref error details
Message-ID: <20260114180040.GH885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-5-f5f8b173c501@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-5-f5f8b173c501@gmail.com>

On Wed, Jan 14, 2026 at 04:40:46PM +0100, Karthik Nayak wrote:

> @@ -1674,9 +1674,11 @@ static void ref_transaction_rejection_handler(const char *refname,
>  			"branches"), data->remote_name);
>  		data->conflict_msg_shown = true;
>  	} else {
> -		const char *reason = ref_transaction_error_msg(err);
> -
> -		error(_("fetching ref %s failed: %s"), refname, reason);
> +		if (details)
> +			error("%s", details);
> +		else
> +			error(_("fetching ref %s failed: %s"),
> +			      refname, ref_transaction_error_msg(err));
>  	}

OK, so here we're writing to stderr anyway, and now we'll just give the
more detailed data. Makes sense (though like Junio, I do wonder if the
existing message might provide more details in some cases).

BTW, I think there is still a related fallout for git-fetch. Even with
your patch, doing this:

  $ git fetch . v1.0.0:refs/heads/foo
  From .
   * [new tag]               v1.0.0     -> foo
  error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'

will not put anything in the status table. Whereas in v2.50.0 and
earlier, we get:

  $ git.v2.50.0 fetch . v1.0.0:refs/heads/foo
  error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
  From .
   ! [new tag]               v1.0.0     -> foo  (unable to update local ref)

Note the "!" and the "unable to update local ref" message in the status
table.

-Peff
