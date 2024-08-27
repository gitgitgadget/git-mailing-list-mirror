Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB22E414
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735171; cv=none; b=KEHJrwP8k07gMRxVG66DG3qVXaoTEn2sz6CTNBce335c5eof8nindnHWIYN4v9wfQpGZ2kOG4iOBlnjQ4MnxivPAzKZzV6nfOmDlr64RRnhVC6ebot8ioQ/B0Zwk9NFZaZU7Utt67KuJLW+dq2fK9kZD5wiQn7vUG6LLLb9mo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735171; c=relaxed/simple;
	bh=P/h3jSf/ayqR0Sb7+zOLZA08hCq1B1Ns+3XXOMwaCPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQGqgax8fLw8oVd1eMBk83PjoIgnDX3RiA598U+QLg9LkHM7EigLEVRpG0Ox0SCG2gK2eR8JWwKGzsoBAUFb5VkLbCujX1pNoPTF45ErXWGkV0ZI18dmh2UpffKA4qpUMlDrCax6bp6iY/+OFMDT+EVLchF5ATk2WMF1UHwi6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SjhgICMe; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SjhgICMe"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2709C2BFCB;
	Tue, 27 Aug 2024 01:06:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P/h3jSf/ayqR0Sb7+zOLZA08hCq1B1Ns+3XXOM
	waCPE=; b=SjhgICMe30j4qspsT7S1BCAdmyu1Uj7OdNHRaZlNhhOfka+rcCpH2e
	PDgVnQysahIaaAZ5ns3L4WLn8uEqJuBCL5dXnSnfHPADySPDaaiURfB1DbSWi1aV
	ZVdaUX2RYmH/TFiPpLllu/tFGLVegGCdENP+jnKrwJmn6KyONi8vI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F44B2BFCA;
	Tue, 27 Aug 2024 01:06:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F3212BFC9;
	Tue, 27 Aug 2024 01:06:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 09/10] cat-file: batch_write: use size_t for length
In-Reply-To: <20240823224630.1180772-10-e@80x24.org> (Eric Wong's message of
	"Fri, 23 Aug 2024 22:46:29 +0000")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-10-e@80x24.org>
Date: Mon, 26 Aug 2024 22:06:03 -0700
Message-ID: <xmqqr0aad078.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 10475670-6432-11EF-BDF8-BF444491E1BC-77302942!pb-smtp20.pobox.com

Eric Wong <e@80x24.org> writes:

> fwrite(3) and write(2), and all of our wrappers for them use
> size_t while object size is `unsigned long', so there's no
> excuse to use a potentially smaller representation.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  builtin/cat-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Obviously correct.  Thanks.

>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 067cdbdbf9..bf81054662 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -369,7 +369,7 @@ static void expand_format(struct strbuf *sb, const char *start,
>  	}
>  }
>  
> -static void batch_write(struct batch_options *opt, const void *data, int len)
> +static void batch_write(struct batch_options *opt, const void *data, size_t len)
>  {
>  	if (opt->buffer_output) {
>  		if (fwrite(data, 1, len, stdout) != len)
