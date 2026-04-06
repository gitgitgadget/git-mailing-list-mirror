Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25992641FC
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506748; cv=none; b=TQK0vxeVN2eyvTwX20ltsJBcRywZPjtALrzyOj6x+F2+44aibqwSH5EPxrJ6W5zmeyPrUJi3QUDFHNRztO2T1Gir2pemNHA1gLB0aZf6F/30Z1gNDSYzqYhsQdyBGYXEVRORvfMLgXm1jFM3tyWUfB+fcBaVCweFdnNR+WfBWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506748; c=relaxed/simple;
	bh=PIYfJjdGHpzex5OU6nPzAeYzn4ikHY6+9aBpM6oqlZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq3zNrzcT9ekNymOSnQ0iKNW4EFVSO6HpKcki7NI3xHy9gkXSjWt/5xuVIdfREbeS2ggWxgROg/kZPLZp03ZSDBwmagpMCr/520f+aKTLwY08HIxw9kxSbGnWpty4J3xJn89nTbaMPRlbosKPE05vfTbtNQWY8Vk+HYgldrkTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FO6ZIjk/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FO6ZIjk/"
Received: (qmail 265453 invoked by uid 106); 6 Apr 2026 20:19:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PIYfJjdGHpzex5OU6nPzAeYzn4ikHY6+9aBpM6oqlZE=; b=FO6ZIjk/X6XSV1cb77MmdvEnxQa4dwyL/Ya2RTtcCcAuvejYWnyuTXL3oO3Hyr9QS0FRi7DEGIz3KE3oUwZZOrt7X4OwSAtwMIYnRG0v+4oYQF8df2AslRM60oJNyeSs5sNtABTUEv9T0Js+NVG4KCN6S/fdDTXjao1TD5Ka5vOkq5RRBWtAs6ceum8/F3UwH0kUHeK0D/nGsL+LElGcVn6MQmVGx5JT0nYR7FIq3IwZa7xDN7uexeY9+3GjbOqmoeIW1ZVZJlTkoQ8pYmuWjzw5wpi4YHh91Bc9YM3EDE895BWY8uNKZUAMHIqlH/1tpxOv9/eDaWeo3yaJxnd17w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Apr 2026 20:19:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 434727 invoked by uid 111); 6 Apr 2026 20:19:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2026 16:19:05 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Apr 2026 16:19:04 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v3 4/7] object-file: remove flags from transaction
 packfile writes
Message-ID: <20260406201904.GA26632@coredump.intra.peff.net>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
 <20260402213220.2651523-5-jltobler@gmail.com>
 <20260406201627.GA26312@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260406201627.GA26312@coredump.intra.peff.net>

On Mon, Apr 06, 2026 at 04:16:28PM -0400, Jeff King wrote:

> On Thu, Apr 02, 2026 at 04:32:17PM -0500, Justin Tobler wrote:
> 
> > @@ -1667,18 +1685,28 @@ int index_fd(struct index_state *istate, struct object_id *oid,
> > [...]
> > +		struct odb_write_stream stream;
> > +		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));
> > +
> > +		if (flags & INDEX_WRITE_OBJECT) {
> > +			struct object_database *odb = the_repository->objects;
> > +			struct odb_transaction_files *files_transaction;
> > +			struct odb_transaction *transaction;
> > +
> > +			transaction = odb_transaction_begin(odb);
> > +			files_transaction = container_of(odb->transaction,
> > +							 struct odb_transaction_files,
> > +							 base);
> > +			ret = index_blob_packfile_transaction(files_transaction, oid, fd,
> > +						      xsize_t(st->st_size), path);
> > +			odb_transaction_commit(transaction);
> > +		} else {
> > +			ret = hash_blob_stream(&stream,
> > +					       the_repository->hash_algo, oid,
> > +					       xsize_t(st->st_size));
> > +		}
> > +
> > +		odb_write_stream_release(&stream);
> 
> Probably not a big deal, but I notice that "stream" is not used in half
> of the conditional. Should its initialization and cleanup be pushed down
> into the else clause?

Ah, never mind. I was looking at this patch in isolation as a solution
to the segfault problem. But later in the series, you end up converting
index_blob_packfile_transaction() to use stream, too, which seems like a
good direction.

So it is a little funny at this step, but it reduces the diff later.

-Peff
