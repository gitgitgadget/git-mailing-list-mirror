Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1D370
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566888; cv=none; b=mTzxes3ru1GZHhNvddr2PKgjoKcAdQjp19QFT9kosSZ4KL8qL5hlKWo9PoYTXOfGx9AiTpcLP1b5zosxziL29pRTa5fnftPhfIsEzEywL/4qSdj57n93WOcJ2EXt/HizQIqyjiXolAt8yZ6634fRyNUgUGZuMVvAtWG03wESZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566888; c=relaxed/simple;
	bh=s10jKeWh87keR/opMjenRwz5M6Y690u88mp6gUjJIp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZAdAFoEhYl1FtI+byB/JZEbQbxnwmoH7csbjoAiOPANN4M3tW4KaWJI0Zq/Pe7qH/hCiyo08J8A45BHRJsDOnYUTLQMvySwFmKHotb9NJr0Z6Lr46pYmSFeZu7NXKikhtvXGBW9E+bskI7zsllb+jAh0wkY9JpTlbu9PBYxeYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YzYsRBEy; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YzYsRBEy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E4CE1EDFE;
	Tue, 13 Aug 2024 12:34:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s10jKeWh87keR/opMjenRwz5M6Y690u88mp6gU
	jJIp0=; b=YzYsRBEyOWD9KsikkQsqIDcFkJN2sPAgjGI1KTJduvPsBMbBMIkMZ0
	RHJwpsXrCP7ycaEFBM6M4YX6qyshHAK4rN4MT6AZmmEz4ZRIvfeBekwJYBLr6Igf
	E8ujz2nYi70aXAcTSnOLpoM/+8UcUXkG4flO9kyPSyLluAnpK+FU8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 772E01EDFD;
	Tue, 13 Aug 2024 12:34:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E38031EDFC;
	Tue, 13 Aug 2024 12:34:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>,  karthik nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 12/22] builtin/fast-export: fix leaking diff options
In-Reply-To: <9591fb7b5e1dac2f989bd10ef2c13a191571a060.1723540931.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 13 Aug 2024 11:31:42 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723540931.git.ps@pks.im>
	<9591fb7b5e1dac2f989bd10ef2c13a191571a060.1723540931.git.ps@pks.im>
Date: Tue, 13 Aug 2024 09:34:40 -0700
Message-ID: <xmqqplqc755r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F0F4E9FE-5991-11EF-AD0E-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Before calling `handle_commit()` in a loop, we set `diffopt.no_free`
> such that its contents aren't getting freed inside of `handle_commit()`.
> We never unset that flag though, which means that it'll ultimately leak
> when calling `release_revisions()`.
>
> Fix this by unsetting the flag after the loop.

If I grep for 

    $ git grep -nH -E -e '(\.|->)no_free' \*.c

I notice that in a lot of places there is a pattern of doing

    set .no_free to 1
    cause a bunch of diff using the same set of options
    set .no_free to 0
    call diff_free().

I am curious why we do not need any diff_free() here?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fast-export.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 4b6e8c6832..fe92d2436c 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -1278,9 +1278,11 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  	revs.diffopt.format_callback = show_filemodify;
>  	revs.diffopt.format_callback_data = &paths_of_changed_objects;
>  	revs.diffopt.flags.recursive = 1;
> +
>  	revs.diffopt.no_free = 1;
>  	while ((commit = get_revision(&revs)))
>  		handle_commit(commit, &revs, &paths_of_changed_objects);
> +	revs.diffopt.no_free = 0;
>  
>  	handle_tags_and_duplicates(&extra_refs);
>  	handle_tags_and_duplicates(&tag_refs);
