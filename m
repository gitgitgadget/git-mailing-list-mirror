Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC43C490
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059776; cv=none; b=bg5jqy6Qi+Mm4maXVuw8oRb0MeqJ0yXOF3PI4JDnctNW1QdvrUww/XnA49zt8f9VbQ0UteU6b9xdakmTmBHwPgEf/OkajVOxylflRa+Mzz1OpmMajFP/cwdDxWzaLepDtmd27efo47GPrn4meU46cbj9rqQZRuFRRm6kUp+nuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059776; c=relaxed/simple;
	bh=4VeMwDM8WnXcDtvRT7phI3/F4jBo+LMSIGkEI1FGQtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZfKusu1Vvr91LxUWP8askDp/LzMjw5oJRfBeiBmpBtk5pq9Wvr6HZ6y4iG6KH/JSgQVdPwc3pim7CnXwuAas8CSfAJP8yODRj6hsczPmFCQB9g9ebWTfeVoqnpcS/Ak7302ceA/xJYCZHznQaUHV0ipUWY/scrFXPFucun1Qu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QaYfLFQQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QaYfLFQQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C75D224468;
	Tue, 27 Feb 2024 13:49:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4VeMwDM8WnXcDtvRT7phI3/F4jBo+LMSIGkEI1
	FGQtI=; b=QaYfLFQQ07Qjz4FEvWfbHXxNg6FGmwn7gdX7cVzLfRaD+h+wchX8mu
	BQHR0eGfiRo42VClvxQcAs40sofO2EV8+C1JIolM3+N0zC84dVY6TDOgX1E3x0ms
	ZpF1/7Gx8NQ8LI7czrEZUeT/O22MVKGkc/2Nq7yUdE3c0mg0TjyD0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C005724467;
	Tue, 27 Feb 2024 13:49:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC40024466;
	Tue, 27 Feb 2024 13:49:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/3] builtin/repack.c: change xwrite to write_in_full
 and report errors.
In-Reply-To: <20240227150934.7950-2-randall.becker@nexbridge.ca> (Randall
	S. Becker's message of "Tue, 27 Feb 2024 10:09:32 -0500")
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>
	<20240227150934.7950-2-randall.becker@nexbridge.ca>
Date: Tue, 27 Feb 2024 10:49:29 -0800
Message-ID: <xmqq5xy9spxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F0FF594A-D5A0-11EE-8611-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Randall S. Becker" <the.n.e.key@gmail.com> writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This change is required because some platforms do not support file writes of
> arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
> maximum single I/O size possible for the destination device. The result of
> write_in_full() is also passed to the caller, which was previously ignored.

This misleads readers to think that maximum single I/O size is
smaller than a single write of oid_to_hex() string on some
platforms.  I somehow do not think that is why we want to make this
change.

Rather, the use of these xwrites() are simply wrong regardless of
maximum I/O size of the platforms, as this caller is not prepared to
see xwrite() result in a short write(2), and we do want to write all
bytes we have even in such a case.

You're right to also point out that we attempt to propagate the errors
to the caller (but see below).

> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  builtin/repack.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index ede36328a3..932d24c60b 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -307,6 +307,7 @@ static int write_oid(const struct object_id *oid,
>  		     struct packed_git *pack UNUSED,
>  		     uint32_t pos UNUSED, void *data)
>  {
> +	int err;
>  	struct child_process *cmd = data;
>  
>  	if (cmd->in == -1) {
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
>  }

I think this has already been brought up, but the caller of this
helper does not make such an error stand out enough and instead
makes the resulting repack silently produce wrong result, which
is not an improvement.  Perhaps

	if (write_in_full(...) ||
	    write_in_full(...))
		die(_("failed to list promisor objects to repack"));

or something?

Thanks.
