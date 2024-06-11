Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4D17556B
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095862; cv=none; b=mhmNMuTvsDEVVIwhh8MM4aKlPJu2flWm3EHAHkOeHct0nvI0nBc1DF8rlhN0+iRuWO9xEzPehrQuiUudMUVnLLZtRDYN0O6Mt44gvI4Va0aYsuaWe3y2rTs7xBi4X8PMpPZujIYEXA3Hpx2PA+TdO+iI4rCsUmrSx48KPxcQdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095862; c=relaxed/simple;
	bh=MCh/XWM3dlyFl9k4Kvie+Iv4qPCDgDEvv62A8qLhAiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJn81ftw91T7Sbo8mGDoixIBEsSfCrFyWZLiygglLjsS7XAbB2OYkarmdLegpioVKUzwmtUSwgN8IfQEAxQQ1+5UGXlEOi/X36yRzENPMJGwoTj8cUJVu3LVIvyOyB2axeH//2Rqzw9yEh4tQZVDaOndHLg0grH2kyEHDfN365Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18667 invoked by uid 109); 11 Jun 2024 08:50:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 08:50:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24907 invoked by uid 111); 11 Jun 2024 08:50:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 04:50:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 04:50:58 -0400
From: Jeff King <peff@peff.net>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
Message-ID: <20240611085058.GJ3248245@coredump.intra.peff.net>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>

On Thu, Jun 06, 2024 at 05:26:37PM +0000, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
> 
> refs_resolve_ref_unsafe retrieves the referent, the unresolved value of
> a reference. Add a parameter to allow refs_resolve_ref_unsafe to pass up
> the value of referent to the caller so it can save this value in ref
> iterators for more efficient access.

This commit message left me with a lot of questions.

For one, it wasn't immediately obvious to me what a "referent" is. ;) I
think an example could help. If I understand, you mean that if you have
a situation like:

  - refs/heads/one is a symref pointing to refs/heads/two
  - refs/heads/two is a regular ref

and we resolve "one", then "two" is the referent? And the caller might
want to know that?

But I think we already pass that out as the return value from
refs_resolve_ref_unsafe(). That is how something like "rev-parse
--symbolic-full-name" works now.

But there are some subtleties. In a chain of symbolic refs (say, "two"
is a symbolic ref to "three"), we return only the final name ("three").
And you might want to know about "two".

You can pass RESOLVE_REF_NO_RECURSE to inhibit this, and get back just
"two". You can see that now with "git symbolic-ref --no-recurse". The
downside is that we never look at the referent at all, so you get only
the symref value (and no information about the actual oid, or if the
referent even exists). You would still get an oid for any non-symrefs
you examine.

So reading between the lines, you have a caller in mind which wants to
know the immediate referent in addition to the final recursive oid?

Looking at the rest of your series, I guess that caller is the one in
loose_fill_ref_dir_regular_file(), so that it can get passed to the
for-each-ref callback. But why is it right thing for it to record and
pass along the immediate referent there, and not the final one? For that
matter, would a caller ever want to see the whole chain of
one/two/three?

> @@ -1761,6 +1761,7 @@ int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
>  
>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  				    const char *refname,
> +				    const char *referent,
>  				    int resolve_flags,
>  				    struct object_id *oid,
>  				    int *flags)

Unless I am misunderstanding the purpose of your patch completely, this
"referent" is meant to be an out-parameter, right? In which case,
shouldn't it be "const char **referent"?

As the code is now:

> @@ -1822,6 +1823,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  		}
>  
>  		*flags |= read_flags;
> +		if (referent && (read_flags & REF_ISSYMREF) &&
> +		    sb_refname.len > 0)
> +			referent = sb_refname.buf;
>  
>  		if (!(read_flags & REF_ISSYMREF)) {
>  			if (*flags & REF_BAD_NAME) {

...we'd assign the local "referent" pointer to our refname buf, but
the caller would never see that. Plus doing so would not help you
anyway, since sb_refname will be used again as we recurse. So at best,
you end up with the final name in the chain anyway. Or at worst,
sb_refname gets reallocated and "referent" is left as a dangling
pointer.

-Peff
