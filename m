Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5973112BF
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561137; cv=none; b=Lfnuy+CJx1m0+vtxResfDY5p2gaWPqFzn+6iQ1ukqqCY3frVyXqV0LyOQ0hgxDOxAgPGUL0v6TAHd8zX/IkSPeG2VzSyhtemaYF1dtnbccjLsrhuEqqV6oyJWyY5rpe7Dbzs/XxJ8b8ZtY628JMUQ+RicFt3nIQVa6iZZmoElQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561137; c=relaxed/simple;
	bh=zdPW8OkuAO9EtOuBMHYa1tg4A3pnH66dKnbM4MEDMbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4s1l7/dV0EviFCXR0qAcmAjyzw/SqWn8hyEawYj+YQ6jFUzkGjo7c8tvHqnY1JIGxRXlulZ5BPG85HcX+bhFVadiGwgepRk+Bhly7gy69GQz/RfadqvBOW5wl7CADVSK+49V5Mko8JtvJRkxNCeEk4PMgZOlWQckzk8Vf5TtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YD/s4bg3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YD/s4bg3"
Received: (qmail 161277 invoked by uid 109); 22 Sep 2025 17:12:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zdPW8OkuAO9EtOuBMHYa1tg4A3pnH66dKnbM4MEDMbM=; b=YD/s4bg3b7K8Z1FE9l+3qyUXAx2xBI6S6+lUcH4NolbO5uXOlFpYOnL961hwlvpwfiHLR+6Q+kfflDoAksIT2FziWJOBM9We2XvQQmxKbruCmxX7Lkq8C41IbH/2iWINlb5lwaLvy+B7lBiaAbxxEk4VZpm1OdeV7Te6OzOkwOnmZJvPhdGvYP8ZmAvRmY/ZV4GFfhuBlyFUS6gJyJ/MhIhV5F3NkPTDuVVXwZq/usjmlnCSeZKJyIazYsMxLRPLI6JdEl7uVgsrdJgSV2z5Puw7yRDzcH3WNOY3rVXkyqTE1ZCAmXHwqnmUyMbSuHUUgQObYq6PitSczTiPF150MQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Sep 2025 17:12:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 252478 invoked by uid 111); 22 Sep 2025 17:12:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 13:12:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 13:12:03 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] refs: do not clobber dangling symrefs
Message-ID: <20250922171203.GA2202085@coredump.intra.peff.net>
References: <20250819192934.GD1059295@coredump.intra.peff.net>
 <20250922122332.584428-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922122332.584428-1-toon@iotcl.com>

On Mon, Sep 22, 2025 at 02:23:32PM +0200, Toon Claes wrote:

> At $DAYJOB we hit into an edge-case where this patch breaks our expectancies.
> 
> We use `update FOO_HEAD 000...000 000..000` to delete a symref, if that symref
> is dangling (otherwise the old oid would have resolved to something). I've
> attached a patch that would allow this (on top of your patches). Do you think it
> makes sense to allow this scenario?

Hmm. That's a funny command. You are providing _two_ null oids. The
first one says "this should be a deletion" and the second one says "the
previous state is that this should be deleted". So it should always be a
noop, if we are checking both sides.

I think the "right" way to say that is just:

  update FOO_HEAD 000...000

with no old-oid field at all. Or just:

  delete FOO_HEAD

but the two are internally the same thing.

So I think allowing this is working against what the patch is trying to
do, which is to consistently enforce the old-oid match that the user
asked for. The only thing that makes it an oddball is that it is
inherently a broken thing to ask for in the first place (at least under
the new, enforced regime). So we could perhaps allow it as a special
case for historical reasons without hurting anybody too badly.

I'd prefer not to do that, just because the refs code is already
complicated enough. But whether that's practical would depend on how
widespread this pattern is. Presumably it would not be that big a deal
to fix what you're sending (and assuming this is Gitaly, I'd guess that
it is bundled along with Git, so you are not that worried about people
using new Git with old Gitaly). But I'm not sure how we'd find out if
other people are doing the same thing in the wild.

So I dunno. My inclination is to say that the double-null-oid invocation
is weird and wrong, and callers should update if they need to. But I
could be convinced otherwise.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 1b3bf26add..5e46d3a110 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2537,7 +2537,7 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
>  		 * that case to preserve the dangling symref.
>  		 */
>  		if ((update->flags & REF_NO_DEREF) && referent->len &&
> -		    is_null_oid(oid)) {
> +		    is_null_oid(oid) && !is_null_oid(&update->new_oid)) {
>  			strbuf_addf(err, "cannot lock ref '%s': "
>  				    "dangling symref already exists",
>  				    ref_update_original_update_refname(update));

I think the implementation here (and the matching one in the reftable
code) is correct for what you want to do. We should probably note the
special case in the comment above, too.

-Peff
