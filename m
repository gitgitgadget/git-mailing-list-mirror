Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DEE3D76
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345087; cv=none; b=G8cDCHXQzmo1IgPLx60fmgPLhjSlWRAFnHXGWs9jYY8QE7cB9Hz5CPpbUXHPT0rfV7oRYpWmdfGkCgJfDrRG7UKAb3yqrLgym8e4Ry8gdd/pIoOgNzgRYBfA3Ywp4/hhA++HnPnNACL7Zj4sqp3xGrliYLaqgccdsNFxeM0tIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345087; c=relaxed/simple;
	bh=1gWysid0PVUypSvI2NIdSBjkFxDvFleWyFDeJSxtU6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8TE8FSW09R02uuVHnkr9lFhs0xU18SQnkPfAitWqL04Z4i3C90P2BlCmeMl3mwi+DRLS+TPw8cXgzwVDJqigLEH6jzGAdrcECg6ibTL6xHk1H1ZKSwOixGhxPENnNUx0v8qDW9+OHszWDXzU6LeB+rTg/P89dVcjQJ6YDkiqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11701 invoked by uid 109); 7 Feb 2024 22:31:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Feb 2024 22:31:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24032 invoked by uid 111); 7 Feb 2024 22:31:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Feb 2024 17:31:21 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 7 Feb 2024 17:31:20 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/2] refs: introduce reftable backend
Message-ID: <20240207223120.GA537741@coredump.intra.peff.net>
References: <cover.1706601199.git.ps@pks.im>
 <cover.1707288261.git.ps@pks.im>
 <5de60d46bdccbfbf0a923abc2f45eda07f30c110.1707288261.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5de60d46bdccbfbf0a923abc2f45eda07f30c110.1707288261.git.ps@pks.im>

On Wed, Feb 07, 2024 at 08:20:31AM +0100, Patrick Steinhardt wrote:

> +static int write_copy_table(struct reftable_writer *writer, void *cb_data)
> +{
> [...]
> +	/*
> +	 * Create the reflog entry for the newly created branch.
> +	 */
> +	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
> +	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
> +	fill_reftable_log_record(&logs[logs_nr]);
> +	logs[logs_nr].refname = (char *)arg->newname;
> +	logs[logs_nr].update_index = creation_ts;
> +	logs[logs_nr].value.update.message =
> +		xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
> +	logs[logs_nr].value.update.new_hash = old_ref.value.val1;
> +	logs_nr++;
> +
> +	/*
> +	 * In addition to writing the reflog entry for the new branch, we also
> +	 * copy over all log entries from the old reflog. Last but not least,
> +	 * when renaming we also have to delete all the old reflog entries.
> +	 */
> +	ret = reftable_merged_table_seek_log(mt, &it, arg->oldname);
> +	if (ret < 0)
> +		return ret;

Should this last line be "goto done" as is used elsewhere in the
function? Otherwise we are at least leaking the "logs" array (and
possibly some of the other cleanup is important, too).

> +	while (1) {
> +		ret = reftable_iterator_next_log(&it, &old_log);
> +		if (ret < 0)
> +			goto done;
> +		if (ret > 0 || strcmp(old_log.refname, arg->oldname)) {
> +			ret = 0;
> +			break;
> +		}

This "ret = 0" doesn't have any effect. We break out of the loop, and
then...

> +	}
> +
> +	ret = reftable_writer_add_logs(writer, logs, logs_nr);
> +	if (ret < 0)
> +		goto done;

...the first thing we do is write over it. I dunno if it's worth keeping
as a maintenance precaution, though (if the code after the loop changed
to omit that assignment, then setting "ret" would become important).

Both were noticed by Coverity (along with several other false
positives).

-Peff
