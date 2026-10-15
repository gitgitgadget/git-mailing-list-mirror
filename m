Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531CC4A1DE0
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047483; cv=none; b=CnWRa+pswnM+SE7URU+Xu8SsZKGDcQLdcoXIBuVOBUBihSe5Snuigg+3JwKmzBuGlOZ6EjoVyBUuUmxWTShG6YPv5djSuw3cVZmU09KG7fZg8ljt7a/gWG3T2yAlBAI4h+f8502ltsg1QhnSw1dCnKkIUIEIp97SZeoFCURmj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047483; c=relaxed/simple;
	bh=MCqhjXW+fdgoePNs+SVEwyMWXPLn94ISutlshA2V/S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkAJpeXC3i28WX3fQD0YnTqY2EBe/M3mN+RC77hBk2iQJwVg5sfFu0JwTDxc9pu8yoBFQKZlkExJ9uxYL1AOTLsouDBpcEZRTcRobGItSsAuxBG4WRcxIOoajL7LpwD54ZJ/BnwdC6EQrVj/CV4mIFcQTPDEuer+Llwlr7J4RoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cBmtfULH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cBmtfULH"
Received: (qmail 75268 invoked by uid 106); 15 Oct 2026 06:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MCqhjXW+fdgoePNs+SVEwyMWXPLn94ISutlshA2V/S0=; b=cBmtfULHp/C9ZOG1KvlzcmElM/FiJ/iNRzofg7u/YoIsNwsTczPLXH0u1LYW199TU4lNq22VPL8Ye5rymWeOYvlB0dtzQyTiNU5XJjfrhxCcaouvvq0pnkDwr8mzdzehlgbiysry0q9l3MsqCaWlvqke9sibjVxicjcWG9BXkJapoP4vKBx/RpnXdA006g71gKlTxSCIdXJNiKu/VBAKI+BCxdNDuu8VtIFTpI4XJ4RO0ftqDdwR1yfbhCOTe94VjPAxfwup5CQXFX83+U9wTLHmW0RFgX8hf6T9JmYl+26CRahQIbb7VEJ9Wsh2H1LWRTx6o+W1wdym6C3zPa65sA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2026 06:57:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 48619 invoked by uid 111); 15 Oct 2026 06:57:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2026 02:57:58 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Oct 2026 02:57:54 -0400
From: Jeff King <peff@peff.net>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, jltobler@gmail.com
Subject: Re: [PATCH v2 2/2] odb: ignore refs of shallow and grafted alternates
Message-ID: <20261015065754.GB1979109@coredump.intra.peff.net>
References: <20261014103507.35317-1-iwiedler@gitlab.com>
 <20261014181134.56220-3-iwiedler@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014181134.56220-3-iwiedler@gitlab.com>

On Wed, Oct 14, 2026 at 08:11:34PM +0200, Igor Wiedler wrote:

> That assumption does not hold for a shallow repository, whose refs
> point at commits with no history behind them below its shallow
> boundary, nor for a grafted one. A repository borrowing objects from
> such an alternate does not see the alternate's shallow file, so the
> history that is missing there is missing here as well. The fetch then
> succeeds, the connectivity check stops at the alternate's refs, and
> a later "git log" fails with "Could not read <oid>".

In addition to grafts there are replace refs. I think we generally
insisted on having full connectivity of the original objects, though
(e.g., fsck will ignore replace refs). I thought that was true of
grafts, too, though (except for ones grafted by the shallow mechanism,
which is special).

> Partial clones have the same problem for the objects they lack, but
> detecting one requires reading the alternate's config, so this
> patch does not handle them.

Yeah, I'm sure there are some corner cases there. In theory you can grab
any of the missing partial-clone objects at will, though probably we
have no code to realize that it's the alternate which is partial and
through which the request should be routed. I guess you could argue the
same is true for shallow alternates (i.e., we _could_ get those objects
if we needed them, we just don't have a way to do so).

These are such weird setups that I think punting and saying "just ignore
their alternate refs" is totally fine. The use of the alternate refs is
an optimization, so falling back to the simpler behavior is good.

> --- a/odb.c
> +++ b/odb.c
> @@ -458,6 +458,17 @@ static int refs_from_alternate_cb(struct odb_source *alternate,
>  		goto out;
>  	strbuf_setlen(&path, base_len);
>  
> +	/* A shallow or grafted repository may lack the history behind its refs. */
> +	strbuf_addstr(&path, "/shallow");
> +	if (!access(path.buf, F_OK))
> +		goto out;
> +	strbuf_setlen(&path, base_len);
> +
> +	strbuf_addstr(&path, "/info/grafts");
> +	if (!access(path.buf, F_OK))
> +		goto out;
> +	strbuf_setlen(&path, base_len);

OK. It's a little gross that we have to check these magic paths, but
there's no real alternative here. We do not have a real repository
object or anything like it representing the alternate.

The thread has been talking about check_connected(), but the same
problem applies to advertising alternates for transfer. But your fix
here takes care of both, because it works at the lowest level. Good.

> diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
> index 4cc39af0f0..9c3862709a 100755
> --- a/t/t5618-alternate-refs.sh
> +++ b/t/t5618-alternate-refs.sh
> @@ -70,4 +70,17 @@ test_expect_success 'connectivity check of a deepening fetch excludes alternate
>  		--alternate-refs --quiet <deepen.trace
>  '
>  
> +test_expect_success 'refs of a shallow alternate are ignored' '
> +	git clone --depth=1 "file://$TRASH_DIRECTORY" "$TRASH_DIRECTORY/shallow" &&
> +	test_commit -C "$TRASH_DIRECTORY/shallow" shallow-only &&
> +	git -C "$TRASH_DIRECTORY/shallow" rev-parse HEAD >shallow-tip &&
> +	cp .git/objects/info/alternates alternates.bak &&
> +	test_when_finished "mv alternates.bak .git/objects/info/alternates" &&
> +	echo "$TRASH_DIRECTORY/shallow/.git/objects" >>.git/objects/info/alternates &&
> +	git cat-file -e $(cat shallow-tip) &&
> +	git rev-list --remotes=origin >expect &&
> +	git rev-list --alternate-refs >actual &&
> +	test_cmp expect actual
> +'

This is a direct test of --alternate-refs, which is probably reasonable
and the simplest way of doing it. I think you could also construct a
case where a fetch or push causes the recipient repo to be corrupted (it
claimed to have object X because of the alternate, so the other side
didn't send it, but since _we're_ not shallow, now fsck, etc, fails).
But I don't think there's a particular need to construct that full case
for the tests.

-Peff
