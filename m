Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138616426
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224781; cv=none; b=SxA3VAwxquOpu9SKNasA4Di56awVjBIHkkUAQDnuhoYY6j9sMSYExOnoQ7Rb/N1RaxuoffhtZqrwuyHmhF1RUwh1NRsFOnBOV0tRUty6PLeyEqHri9qFMEYkA7lpkfJ+0w76aO+pnUFTLJAwXTV0A4epdbgzWY9xID8PBCS+KVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224781; c=relaxed/simple;
	bh=1YrXbivZ4mdHuxIOTKttM7+rivJWilTS1U6qEwpc+M4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O/4lw6QovOz0VurpeptwzeXCuAB7aMewDqLpV0oRQTRB3lkREP6QTaY+/qOEmRMelfet2irjzSLIEw4ERvxtEBPIKtDo98WilHoiDfy9K4XT5yCN/4ltk+LzqAD8ad0H8HmFrsActqvKCl0zo3Uf2IY7FCoWzkUQKYvIKjii83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=X2lJGFX3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X2lJGFX3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 953E52E336;
	Fri,  9 Aug 2024 13:32:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1YrXbivZ4mdHuxIOTKttM7+rivJWilTS1U6qEw
	pc+M4=; b=X2lJGFX3i1woB0528abcv5G77uF/32x3873dcao+3uqwVuy/mfrdO4
	H18d1HSoKpypOWkBfTuHw5k7F/rdnDJGMY7rDPh+S9SWsN1z1Q+QJacq1NtAsRgH
	6RUslkXDsBygE32P0CR8CA1vCn360iFfjpSdTce3CM+yBMv8VcFGo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DDE22E334;
	Fri,  9 Aug 2024 13:32:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1683D2E333;
	Fri,  9 Aug 2024 13:32:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 02/20] path: expose `do_git_common_path()` as
 `strbuf_git_common_pathv()`
In-Reply-To: <ytv7y3jlbaru5o3ehotanqoqvjnwaomzsyj746k3hbb3htymts@m4qct6cvebiz>
	(Justin Tobler's message of "Fri, 9 Aug 2024 12:18:12 -0500")
References: <cover.1723013714.git.ps@pks.im>
	<e7a143c30dd95d8192eacc35c876e7926cb7c6a4.1723013714.git.ps@pks.im>
	<ytv7y3jlbaru5o3ehotanqoqvjnwaomzsyj746k3hbb3htymts@m4qct6cvebiz>
Date: Fri, 09 Aug 2024 10:32:54 -0700
Message-ID: <xmqq5xs9eh4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 69FC4C9A-5675-11EF-A3EC-BF444491E1BC-77302942!pb-smtp20.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

>> -static void do_git_common_path(const struct repository *repo,
>> -			       struct strbuf *buf,
>> -			       const char *fmt,
>> -			       va_list args)
>> +void strbuf_git_common_pathv(struct strbuf *sb,
>> +			     const struct repository *repo,
>> +			     const char *fmt,
>> +			     va_list args)
>
> Here we reorder the arguments to make `strbuf` first. I assume we are do
> this to align with the preexisting `strbuf_git_common_path()` and use
> the "strbuf_" prefix in the function name.

I thought that we already established as a general guideline that
"strbuf_" should be cleaned up so that functions that happen to use
strbuf merely as a way to carry parameters into or results out of
them but are not primarily about string manipulation are renamed out
of the "strbuf_" namespace.

  https://lore.kernel.org/git/ZqiLA0bGYZfH1OWD@tanuki/

And this is about getting a path, which is communicated via a
"struct strbuf", and not the standard "char *".  That is a prime
example of a function that we do *not* want to stress strbuf-ness
of the function.

> In the previous commit we used the "repo_" prefix for
> `repo_git_pathv()`. Would it make sense to be consistent here? All these
> functions are operating on the provided buffer, but for a given
> repository. Not sure what would be most appropriate here.

Yes, if the function is about obtaining the path for a file in a
given repository's metadata directory, and its association with
"strbuf" is that it merely happens to use it instead of "char *",
it should not be named as if "strbuf_" ness is the primary
characteristics of the function.

strbuf_cleanup_path() should also be renamed for the same reason.

>>  {
>> -	strbuf_addstr(buf, repo->commondir);
>> -	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
>> -		strbuf_addch(buf, '/');
>> -	strbuf_vaddf(buf, fmt, args);
>> -	strbuf_cleanup_path(buf);
>> +	strbuf_addstr(sb, repo->commondir);
>> +	if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
>> +		strbuf_addch(sb, '/');
>> +	strbuf_vaddf(sb, fmt, args);
>> +	strbuf_cleanup_path(sb);
>>  }
