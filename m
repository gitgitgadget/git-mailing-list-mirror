Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B8DDA9
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377070; cv=none; b=hDcbOmz+XZncq34MGVVnxliF9F4pILRZw7p9MnmbPU1XNKFWD0qO6HToJleO96hsKdhO2NpQKKb8bA25JfGNvGaaqwLTM16B/cFY6DrTybLjE1OrjKcFe8oa8ZRPlUaqC5rIyXvigByBSAf2+DG8TISSRf03xhUbSt3Bjje+jqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377070; c=relaxed/simple;
	bh=Ku2nK3MAtRvhqpgCpcGjJHKn3f+rH5AuXUEC2gZJVrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoYc46HDJsGLmqCElxDd7umSXK1E59tU3WL5FIFgRmPN9+DgGuL6hWhxoItD43KzNkuGV7f7KHygRdRHiVdG+SngQlnVOAfvZysJsTjSWYjNt8i3YGOE+n49gSf6tbtqb8NBOtOi3kvqBz9OwhulrvjbO//a9QfXz/GP8/m9HPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GbHpGgiV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GbHpGgiV"
Received: (qmail 19591 invoked by uid 109); 7 Mar 2025 19:51:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ku2nK3MAtRvhqpgCpcGjJHKn3f+rH5AuXUEC2gZJVrw=; b=GbHpGgiVSXIqN2cdNyqphmom+qhBpFt8Msnt4+TrtxhK8aLDmemUaqXfjB9U8rLtDaabMaQCG1VHZr7ZGtvcvQE5YCW0/ML2HL592qRPC2hSyJ9IkmMBI6Jng9Cifqz3CV3EAKtUM5DXZtd7Dun3EYDw9mbScYX1EKbxUKKIxPTM/wyjMPp12rtBDvDz+0L2jJL5nk18AyXZ6u9goo+ZYbhgjid7KvxGrLfF2ZOmXoYErLW5JPXKq45gNDrupC/lp/ek2ZHdqJSPK/QBAVymsWUnUaGHBxCk7oaKwXC/0i7Yya4hqe6Tf5YPvoxGBFKqlW3JV7y2tDhjwzV8vvVLSA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Mar 2025 19:51:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17132 invoked by uid 111); 7 Mar 2025 19:50:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Mar 2025 14:50:57 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 7 Mar 2025 14:50:57 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH v3 6/8] refs: implement partial reference transaction
 support
Message-ID: <20250307195057.GA3675279@coredump.intra.peff.net>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>

On Wed, Mar 05, 2025 at 06:39:01PM +0100, Karthik Nayak wrote:

> @@ -1456,6 +1471,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>  					    update->refname,
>  					    oid_to_hex(&update->old_oid));
>  				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
> +
> +				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
> +					strbuf_setlen(err, 0);
> +					ret = 0;
> +					continue;
> +				}
> +
>  				goto error;
>  			}
>  		}

This new code isn't reachable, since we return in the lines shown in the
diff context.

Should it have been "ret = REF_TRANSACTION_ERROR"... in the first place?
I think the "goto error" was already unreachable, so possibly the error
is in an earlier patch. (I didn't look; Coverity flagged this in the
final state in 'jch').

-Peff
