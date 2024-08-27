Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A91BC9FE
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773433; cv=none; b=WrsY4pqnwQ5W2LoxRUMk4nMXzMvyNRWTHzJvD+cdPNi4LOjdabb3VaczF2Oj/9/5Brge4j9KX3Tq7ca8rmkSZR5KquhAN+QthkbdAVui9vcbGCZNgYc6C8vauzskl4K795VwRxly5FVN4lrORNf6w8iC/FpyJ5VUA3F5R+ClRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773433; c=relaxed/simple;
	bh=tLf0VlDoGsqo0hdd6aTnSDoYzynRZQdR2OhBYsde2Mk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3vfU2Mtjgrpn0oNYp+sLmOt0RZTOooi+oss/SgId6eNFHRo5+tLRnFU5oJOPILPr9KxCd8W3bKXBh6J6CfWOWGQ8azGiSjNmBfoeV6n/2WFyq+7FjTECLFbCqRiB6xg76F+hy7VJDXB6TnVYerHi7PLv81rSTiK8ZSmzW6qv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NEfwbwJW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NEfwbwJW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 63EDF1B125;
	Tue, 27 Aug 2024 11:43:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tLf0VlDoGsqo0hdd6aTnSDoYzynRZQdR2OhBYs
	de2Mk=; b=NEfwbwJWvPy7jMAI1qCR3JcbY3OSbqEtKYHmOWMVg/4s/zXwZfxcx/
	9VUasMstvNGlP9o0SFL3W0zXdf/OWAhoi40U4LVCn865fkGrzDO4Vnu72hMakHB7
	6MAVV7OJ5rrvogY+gNvJiPpjAJt32oojVaYifKCcehmE5lu2YW0p4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AF7C1B124;
	Tue, 27 Aug 2024 11:43:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D6301B123;
	Tue, 27 Aug 2024 11:43:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 10/10] cat-file: use writev(2) if available
In-Reply-To: <xmqq1q2acyjo.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	26 Aug 2024 22:41:47 -0700")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-11-e@80x24.org> <xmqq1q2acyjo.fsf@gitster.g>
Date: Tue, 27 Aug 2024 08:43:47 -0700
Message-ID: <xmqqwmk2as3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26D6C304-648B-11EF-9B07-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +static void batch_writev(struct batch_options *opt, struct expand_data *data,
>> +			const struct strbuf *hdr, size_t size)
>> +{
>> ...
>> +}
>
> ... the above made me read it twice, wondering "where does
> iov[1].iov_base comes from???"  The location of the git_iovec
> structure in the expand_data forces this rather unnatural calling
> convention where the iovec is passed by address (as part of the
> expand_data structure), with only one of six slots filled, and the
> other five slots are filled by this function from the parameters
> passed to it.
>
> I wonder if we can rework the data structure to
>
>  - Not embed git_iovec iov[] in expand_data;
>
>  - Keep "void *content" instead there;
>
>  - Define an on-stack "struct git_iovec iov[3]" local to this function;
>
>  - Pass "void *content" from the caller to this function;
>
>  - Populate iov[] fully from hdr->{buf,len}, content, size, and
>    opt->output_delim and consume it in this function by either
>    calling fwritev_or_die() or writev_or_die().
>
> That way, the caller does not have to use data->iov[1].iov_base in
> place of data->content, which is the source of "Huh?  Why is the 2nd
> element of the 3-element array so special?" puzzlement readers would
> feel while reading the caller---after all, the fact that we are
> using writev with three chunks is an implementation detail that the
> caller does not have to know to correctly use this helper function.
>
> Or am I missing something?

Additional thought.  Perhaps we can introduce

    static void batch_write(struct batch_options *opt,
			    const void *data, ...);

that is a vararg function that takes <data, len> pairs repeated at
the end, with data==NULL as sentinel.  It may technically need to be
called batch_writel(), but that is a backward compatible interface
for existing batch_write() callers.

Then the use of writev() can be encapsulated inside the updated
batch_write() function.  If you get only a single <data, len> pair,
you would do a single write_or_die() or fwrite_or_die().  Otherwise
you'd do the writev() thing, and the function can stay oblivious to
the meaning of what it is writing out.  There is no need for the
function to know that the payload is "header followed by body
followed by delimiter byte", as that is what the callers express at
the call sites of the function.

Hmm?

			    

