Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99839EF02
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506591; cv=none; b=i1s0Wlum53tY+QGULr2oHNvkOwqjZ+gl+y8ulYYeSb7FpghUjtLdQUIjVQhjoytVA4JFA52wnL6v4wLxmxJKeyu3lSwbcxHxn4FqZAPdVKbDed0dxRx7JW2xCxfk7DqOEPL1RCbgbe5pUc9q0+Uu2k8oWwEjkP3hO258xUqzwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506591; c=relaxed/simple;
	bh=LZyyKrPiVox9S7G0cakel5etzhhmaZdmMhr2EnNRHAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDsOOLxQclMVdYdHBJ/N15GQVMvFUD85l36H5sQiyeO10MFFi8ZkXKD8tKV7FTSeIRUaLbPBrOiAdpYyA04wOaMhGm6liOz+s08yqXpCEi4OxypXGtk90KfYtwpylU/caWPuqMOmO4UNZwG8D9kvPWJs59G32Z9U4eVR8nhUWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Xhucpkz/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Xhucpkz/"
Received: (qmail 265428 invoked by uid 106); 6 Apr 2026 20:16:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LZyyKrPiVox9S7G0cakel5etzhhmaZdmMhr2EnNRHAU=; b=Xhucpkz/nyLRio6bsCKrxt35dMvac9/0x0x1Iv3rOGfrgoZXqF2ydqPt+tUUL1S9sgFhcHlUfJe6+4zxc4kFgrQC7K0tILKGJgcjBreSISmfHxbo1p2een8T0Lr9K/Jw+VzuNsXMWK7DsHYK3vtBUA4G/vFhMrkOEdoC8pBYtKNi/zvBF+gEN4Bnakd0+6oKttQnJaDVL4eDp4pcnAArW0I5KIBlFx2MGZ1U/wJHhifYzGtMj6ql01okP/kunPg4MR9VZ1B+x9JKYFK+IxWhFqUVip4IIP9bW5n61lYwTRJ+IV6Xf6oUGSFMGFVKk1x1Jcuh9gJHePGSoC+iXkzx3Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Apr 2026 20:16:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 434647 invoked by uid 111); 6 Apr 2026 20:16:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2026 16:16:28 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Apr 2026 16:16:27 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v3 4/7] object-file: remove flags from transaction
 packfile writes
Message-ID: <20260406201627.GA26312@coredump.intra.peff.net>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
 <20260402213220.2651523-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402213220.2651523-5-jltobler@gmail.com>

On Thu, Apr 02, 2026 at 04:32:17PM -0500, Justin Tobler wrote:

> @@ -1667,18 +1685,28 @@ int index_fd(struct index_state *istate, struct object_id *oid,
> [...]
> +		struct odb_write_stream stream;
> +		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));
> +
> +		if (flags & INDEX_WRITE_OBJECT) {
> +			struct object_database *odb = the_repository->objects;
> +			struct odb_transaction_files *files_transaction;
> +			struct odb_transaction *transaction;
> +
> +			transaction = odb_transaction_begin(odb);
> +			files_transaction = container_of(odb->transaction,
> +							 struct odb_transaction_files,
> +							 base);
> +			ret = index_blob_packfile_transaction(files_transaction, oid, fd,
> +						      xsize_t(st->st_size), path);
> +			odb_transaction_commit(transaction);
> +		} else {
> +			ret = hash_blob_stream(&stream,
> +					       the_repository->hash_algo, oid,
> +					       xsize_t(st->st_size));
> +		}
> +
> +		odb_write_stream_release(&stream);

Probably not a big deal, but I notice that "stream" is not used in half
of the conditional. Should its initialization and cleanup be pushed down
into the else clause?

-Peff
