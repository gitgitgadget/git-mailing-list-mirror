Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2BE55B
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754133092; cv=none; b=XMd6/V9LRpbkGAhd7kOQX2LFOFy60zBuiDZV++Oe8pYhgjyHXeaC/bOWy5AQpBhfU5mDM/c88LKzvTAFTjFC4TJndf0HwmNLZQUQp9kjOYT+aoOrHOKyW7DE262/PGD/j7k4vW1Vz9ffLtzmQeGSMPX8IOaKGBqnypIXSAR+bVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754133092; c=relaxed/simple;
	bh=SmpH6TBTCruRb2Ya6d45tx3eDVjopveCnHvOlv99+gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i75rHCdJ7MvHuvIUFQef84XYZRVSnfTixXVLt+h7DM4g9zn+TmHqsl6oQGuIThuzbxCDFKlS+6AlU3JICQtHdNp8jMszcYACWPqG9ylfRta66XILfqg8oNZiN7b5oB/rLqOSTCgsdtF1AOUK3nHJCtkIEWs3r1Oz+mM4sRTNkJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K64vcdhW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K64vcdhW"
Received: (qmail 9719 invoked by uid 109); 2 Aug 2025 11:11:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SmpH6TBTCruRb2Ya6d45tx3eDVjopveCnHvOlv99+gA=; b=K64vcdhWEIX8zXZkrV4EhI9nMqWzuQyFpHy7xpXCBwdrSDo1zKVgXyngJRqzoyQ9TMa5COO1A2OSufKqKl2NN6aH1J3ChFOAn1jkH72MH4aTTkdHkm91vHsJr0tpT2ofrvPDBAxWfG2cJWXKYnsHpd/vY8zyhjxQsby3aTnjTZmOKEO/iSDtrWevp3kYxu/RcDLMpuXz+pOlfVEEZVd+xcTiDlbubZ0pVTI4shlNsCU73z+C6AnrG8+usrbJWjLPFJxgWXBUfvyDaK7xYLkfvnBmpcKiCpNv2CoFsTEjQsx6ImjReBGwu6gODDbOsN/Cf7fbuPoYCrW8EyPx0r0xTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 11:11:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13101 invoked by uid 111); 2 Aug 2025 11:11:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 07:11:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 07:11:28 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 7/9] refs/files: detect race when generating reflog
 entry for HEAD
Message-ID: <20250802111128.GC1180347@coredump.intra.peff.net>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
 <20250729-pks-reflog-append-v3-7-9614d310f073@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729-pks-reflog-append-v3-7-9614d310f073@pks.im>

On Tue, Jul 29, 2025 at 10:55:25AM +0200, Patrick Steinhardt wrote:

> Unfortunately, this change only helps with the second race. We cannot
> reliably plug the first race without locking the HEAD reference at the
> start of the transaction. Locking HEAD unconditionally would effectively
> serialize all writes though, and that doesn't seem like an option. Also,
> double checking its value at the end of the transaction is not an option
> either, as its target may have flip-flopped during the transaction.

I agree we should not always take a lock on HEAD, since most refs would
not need it. But I wonder if we could do better by examining HEAD, then
taking a lock when we think we'll need it, and then re-checking the
value of HEAD. That is still racy, though (somebody could have pointed
HEAD at us between the two checks). Fundamentally the files backend is
not atomic across the whole namespace, and we are trying to update two
refs. So I think there will always be some race.

It does make me wonder if this race-fix is even worth it, then. We are
catching the case where somebody moves HEAD away from the ref we are
updating while we are updating it. But without atomicity, do we even
know which happened first? That is, would it be incorrect to update
HEAD anyway? I guess the outcome is observable because their movement of
HEAD generated a reflog entry, and thus the entries would be out of
order. So maybe that is worth it.

Anyway, I had two questions about the code:

> @@ -2600,7 +2607,36 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
>  
>  	update->backend_data = lock;
>  
> -	if (update->type & REF_ISSYMREF) {
> +	if (update->flags & REF_LOG_VIA_SPLIT) {
> +		struct ref_lock *parent_lock;
> +
> +		if (!update->parent_update)
> +			BUG("split update without a parent");
> +
> +		parent_lock = update->parent_update->backend_data;
> +
> +		/*
> +		 * Check that "HEAD" didn't racily change since we have looked
> +		 * it up. If it did we must refuse to write the reflog entry.
> +		 *
> +		 * Note that this does not catch all races: if "HEAD" was
> +		 * racily changed to point to one of the refs part of the
> +		 * transaction then we would miss writing the split reflog
> +		 * entry for "HEAD".
> +		 */
> +		if (!(update->type & REF_ISSYMREF) ||
> +		    strcmp(update->parent_update->refname, referent.buf)) {
> +			strbuf_addstr(err, "HEAD has been racily updated");
> +			ret = REF_TRANSACTION_ERROR_GENERIC;
> +			goto out;
> +		}

One, what happens with a multi-level ref (e.g., HEAD points to
refs/heads/foo which points to refs/heads/bar)?

We've resolved HEAD to get referent.buf. Do we get "foo" or "bar" here?
If "bar", then a write through "foo" will complain. But if we get "foo",
then theoretically a write through "bar" will complain.

I _think_ we are OK, though. Constructing it like this:

  git init
  git commit --allow-empty -m whatever

  git symbolic-ref refs/heads/foo refs/heads/bar
  git symbolic-ref HEAD refs/heads/foo
  git update-ref refs/heads/foo main

triggers the check and shows that our referent from lock_raw_ref() is
the first level (i.e., "foo"). Which is good.

If we swap out "foo" for "bar" in the update-ref call, then we'd get a
mismatch. But in that case we do not figure out that HEAD needs be
written at all! That is, we only do a single level of look-back to
decide whether to write HEAD at all. So as long as we keep doing so, we
are OK.

> +		if (!(update->type & REF_ISSYMREF) ||
> +		    strcmp(update->parent_update->refname, referent.buf)) {
> +			strbuf_addstr(err, "HEAD has been racily updated");
> +			ret = REF_TRANSACTION_ERROR_GENERIC;
> +			goto out;
> +		}

And two, is an error the right thing here? The user asked us to update
"foo", and we saw that HEAD pointed to it. So we decided to update
HEAD's reflog, too. And when it came time to do so under lock, we found
that HEAD did not point to "foo" any more.

Shouldn't we quietly drop the HEAD reflog update, rather than forcing
the whole transaction to fail? The user never asked us to update HEAD at
all. It was something we opportunistically decided to do, and now we
find out that it is not appropriate to do so.

-Peff
