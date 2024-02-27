Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274BC56469
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022031; cv=none; b=A84JJp808/M4NdmtKkb5088eANj158H3DLReWidV2dmGIj+QpWDlmH2h93YozKyJUURw9xA2Vd7wMcZrBQshKjCz4nnnaHzmjUuSohVA/AvfbhYHMjAZOwekBm7EFcMxZSQj2PJoV5i8Cq9BvAvFsrN8DEwRjcmOtZkYxxo3deI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022031; c=relaxed/simple;
	bh=KHh4Gh8IcN4t80Qkz15TPE5TIs6dxyVgS0OCB72su3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3zTJ2MCLO2qdqbjpTAOauByt6JK0nObp87IszKSzeYL4XGtPvSB8YWsrotxcp04TacWa2GsYZGOWORfogKz0TYALcFWgbis5ERWby5h6UR5rS87Gqnphc16oNi+zg0Obtw+tC9yOwl5eOZ/+3ef0cs159nCMUiIJpmd3EwJQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11516 invoked by uid 109); 27 Feb 2024 08:20:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Feb 2024 08:20:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7427 invoked by uid 111); 27 Feb 2024 08:20:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Feb 2024 03:20:32 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Feb 2024 03:20:27 -0500
From: Jeff King <peff@peff.net>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v1 3/4] builtin/repack.c: change xwrite to write_in_full
 to allow large sizes.
Message-ID: <20240227082027.GH3263678@coredump.intra.peff.net>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
 <20240226220539.3494-4-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226220539.3494-4-randall.becker@nexbridge.ca>

On Mon, Feb 26, 2024 at 05:05:37PM -0500, Randall S. Becker wrote:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> This change is required because some platforms do not support file writes of
> arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
> maximum single I/O size possible for the destination device. The result of
> write_in_full() is also passed to the caller, which was previously ignored.

These are going to be tiny compared to single-write() I/O limits, I'd
think, but in general we should be on guard for the OS returning short
reads (this is a pipe and so for most systems PIPE_BUF would guarantee
atomicity, I think, but IMHO it is simpler to just make things
obviously-correct by looping with write_in_full). So I'd be surprised if
this spot was the cause of a visible bug, but I think it's worth
changing regardless.

The error detection is a separate question, though. I think it is good
to check the result of the write here, as an error here means that the
child pack-objects misses some objects we wanted it to pack, which could
lead to a corrupt repository. But I don't think what you have here is
quite enough:

> @@ -314,8 +315,12 @@ static int write_oid(const struct object_id *oid,
>  			die(_("could not start pack-objects to repack promisor objects"));
>  	}
>  
> -	xwrite(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
> -	xwrite(cmd->in, "\n", 1);
> +	err = write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
> +	if (err <= 0)
> +		return err;
> +	err = write_in_full(cmd->in, "\n", 1);
> +	if (err <= 0)
> +		return err;
>  	return 0;

OK, so we detect the error and return it to the caller. Who is the
caller? The only use of this function is in repack_promisor_objects(),
which calls:

        for_each_packed_object(write_oid, &cmd,
                               FOR_EACH_OBJECT_PROMISOR_ONLY);

So when we return the error, now for_each_packed_object() will stop
traversing, and propagate that error up to the caller. But as we can see
above, the caller ignores it!

So I think you'd either want to die directly (perhaps using
write_or_die). Or you'd need to additionally check the return from
for_each_packed_object(). That would also catch cases where that
function failed to open a pack (I'm not sure how important that is to
this code).

But as it is, your patch just causes a write error to truncate the list
of oids send to the child process (though that is probably not
materially different from the current behavior, as the subsequent calls
would presumably fail, too).

-Peff
