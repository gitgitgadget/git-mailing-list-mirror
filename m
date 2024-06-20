Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F01BE244
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906259; cv=none; b=Jjdt3Y/yGxY75kG4fxBwTF/XKeyt6GyRqvMgZxDXgU/Y0bzvoNt+q9uuhm6tumHR7MtO/sgi+DzvQm2pBGneJyn5T0jo0rk6qCjjI5T7C8I4ocfsOx0Z7ippk4KbKpBZ5945/Ib6pb5MrY0DuT3eOU5O1WHEOSoEbDIpSNzVL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906259; c=relaxed/simple;
	bh=I9uDLnnyyk/rg2vHyrEqaF8Z41bGtQJWonAkTowMVww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bjgpG5dopOL9XSVwrQMYhGG2tbFLBLZh/yqV1mBQwrgfmP5R1HgGtmqZSqj+elDQLSEWwnN58xUHLtu18y/LoSi6mu1nYQlNJa1BA1yONgFgCZfa1rc1hKcIENma/An3jjfNYke/Xn2U/V7PYeIPi1XnLS6jXI8JxhQX44/QkD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UQM6zW/C; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UQM6zW/C"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E92A2EC55;
	Thu, 20 Jun 2024 13:57:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=I9uDLnnyyk/rg2vHyrEqaF8Z41bGtQJWonAkTo
	wMVww=; b=UQM6zW/CFT4MDc5MkyMoVyRltCHxUN4dy4PpLzU1v9LuaOrTMlHdkB
	aSiperC26Kj+jKoKQWKRuEQHMJE279bNmdiTuARHK7zyEGfLtgtrSU3iWe+JL0xd
	q5McZLUElS5Yg5Nwx1UrpZ/dqvU40AFDp6kY9lrkcN9XN6X8IIWb0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 063A32EC54;
	Thu, 20 Jun 2024 13:57:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9C7102EC53;
	Thu, 20 Jun 2024 13:57:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kirill Smelkov <kirr@nexedi.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@google.com>,  Alain Takoudjou <alain.takoudjou@nexedi.com>,
  =?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>
Subject: Re: [PATCH] fetch-pack: fix segfault when fscking without --lock-pack
In-Reply-To: <20240619130256.GA228005@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 19 Jun 2024 09:02:56 -0400")
References: <20240606133605.602276-1-kirr@nexedi.com>
	<ZnJpJyLPAKlu82s8@deca.navytux.spb.ru>
	<20240619130256.GA228005@coredump.intra.peff.net>
Date: Thu, 20 Jun 2024 10:57:33 -0700
Message-ID: <xmqq4j9nwl82.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 929D35F6-2F2E-11EF-8606-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Before that commit, if pack_lockfiles was NULL, we wouldn't bother
> reading the output from index-pack at all. But since that commit,
> index-pack may produce extra output if we asked it to fsck. So even if
> nobody cares about the lockfile path, we still need to read it to skip
> to the output we do care about.

True.  Looking at that problematic commit, I wonder how it passed
the review process.  As a design, adding a list of bare object IDs
without marking what they are for is way too inextensible by our
standard practice.

It is probably not too late to fix it, as this is purely an internal
implementation detail between fetch-pack and index-pack that is not
even documented ("git index-pack --help" does talk about the
"(pack|keep)\t<pack-name>" output, but never the output after that).

> We correctly check that we didn't get a NULL lockfile path (which can
> happen if we did not ask it to create a .keep file at all), but we
> missed the case where the lockfile path is not NULL (due to "-k -k") but
> the pack_lockfiles string_list is NULL (because nobody passed
> "--lock-pack"), and segfault trying to add to the NULL string-list.
>
> We can fix this by skipping the append to the string list when either
> the value or the list is NULL. In that case we must also free the
> lockfile path to avoid leaking it when it's non-NULL.

OK.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index eba9e420ea..42f48fbc31 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1038,8 +1038,10 @@ static int get_pack(struct fetch_pack_args *args,
>  
>  		if (!is_well_formed)
>  			die(_("fetch-pack: invalid index-pack output"));
> -		if (pack_lockfile)
> +		if (pack_lockfiles && pack_lockfile)
>  			string_list_append_nodup(pack_lockfiles, pack_lockfile);
> +		else
> +			free(pack_lockfile);
>  		parse_gitmodules_oids(cmd.out, gitmodules_oids);
>  		close(cmd.out);
>  	}

That looks like a very safe thing to do.

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index b26f367620..585ea0ee16 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -993,6 +993,16 @@ test_expect_success 'ensure bogus fetch.negotiationAlgorithm yields error' '
>  		       fetch origin server_has both_have_2
>  '
>  
> +test_expect_success 'fetch-pack with fsckObjects and keep-file does not segfault' '
> +	rm -rf server client &&
> +	test_create_repo server &&
> +	test_commit -C server one &&
> +
> +	test_create_repo client &&
> +	git -c fetch.fsckObjects=true \
> +	    -C client fetch-pack -k -k ../server HEAD
> +'
> +

And the test is quite straight-forward.

Will queue.  Thanks.
