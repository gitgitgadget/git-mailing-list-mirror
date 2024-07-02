Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D067EEE7
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956009; cv=none; b=jKEepOiU0JZyFKcVV6MB3Cgxo15Lvmey3ovmqek+FkbKeMR0ZRJTUt0SwvFPYWNouRKnozWe926rlAZFkSA54xa0NXqwqVy2O7juNzVMmRYs345AKm3OwH7hu248iEYBwNtTr2WgPMPbSgRJZJPUGJ89rhQyJ6tb9gvHe+8H0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956009; c=relaxed/simple;
	bh=5Ofb2/GGLZWpJiK5bv17DtT69wQ8IitHiG91GYe/Ei8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzMVVRyxOd+3j9VQJ+mZO78fqTivTRTpe1qgVXzq/hru5zWON1xDOw1bg2vd4BTzPzT9hzSd7AQs0u4V66TrV7rn2ByO2h3EPaBjVxdfd9sMFqDeIGCtROMjiyQ2PDaFnlAc6YQPwYomN00abJM6ErSxzO+gL1Qu0SD63xYm2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8807 invoked by uid 109); 2 Jul 2024 21:33:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jul 2024 21:33:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29148 invoked by uid 111); 2 Jul 2024 21:33:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jul 2024 17:33:25 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jul 2024 17:33:26 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 7/7] merge-ort: convert more error() cases to
 path_msg()
Message-ID: <20240702213326.GA591768@coredump.intra.peff.net>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
 <500433edf49a4df448b330e4ed9201cfac83cecf.1718766019.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <500433edf49a4df448b330e4ed9201cfac83cecf.1718766019.git.gitgitgadget@gmail.com>

On Wed, Jun 19, 2024 at 03:00:19AM +0000, Elijah Newren via GitGitGadget wrote:

> +static int read_oid_strbuf(struct merge_options *opt,
> +			   const struct object_id *oid,
> +			   struct strbuf *dst,
> +			   const char *path)
>  {
>  	void *buf;
>  	enum object_type type;
>  	unsigned long size;
>  	buf = repo_read_object_file(the_repository, oid, &type, &size);
> -	if (!buf)
> -		return error(_("cannot read object %s"), oid_to_hex(oid));
> +	if (!buf) {
> +		path_msg(opt, ERROR_OBJECT_READ_FAILED, 0,
> +			 path, NULL, NULL, NULL,
> +			 _("error: cannot read object %s"), oid_to_hex(oid));
> +		return -1;
> +	}
>  	if (type != OBJ_BLOB) {
>  		free(buf);
> -		return error(_("object %s is not a blob"), oid_to_hex(oid));
> +		path_msg(opt, ERROR_OBJECT_NOT_A_BLOB, 0,
> +			 path, NULL, NULL, NULL,
> +			 _("error: object %s is not a blob"), oid_to_hex(oid));
>  	}
>  	strbuf_attach(dst, buf, size, size + 1);
>  	return 0;

This loses the early return in the "type != OBJ_BLOB" code path. So we
free(buf), but then continue on to the strbuf_attach() call on the
dangling pointer. Should it "return -1" like the earlier conditional?

-Peff
