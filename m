Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8CE1DEFE2
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466513; cv=none; b=DCo3/nOe84idjJMHGaTokngvnXCVF40k6GOoZRZQRHwoIkjpOTUafqGPN5PjXavyHrQRiEwaGxhBgQIMw35XRnw36GcBi69NazdDi6VKYOAEtZNyOqE9STevKPe+FBLLAO187AnvWptkfmam9YFTVOvgdHZbU3MeaRV8xmx7VDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466513; c=relaxed/simple;
	bh=gAjWzltGUnt/yZDfeiECJIJ9k09gTNsVx6YBvESKX5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GyyUnrK3yQtA2IbRWmJeyL/K7u2Swow3MV3orCfW21brnVE7cby8/UtKUSHqGPNqQhfCSPcXBvNUsN8SBdNVVuLlr96ga02ToxV8i2eoSQDty89uNo78q3o+IEwl2/tE/FxlIq5sWD7vXZhknCeOszE9Vfsl9i0aQIHzT8RAwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=F9IPXN+q; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F9IPXN+q"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16EC035EE3;
	Wed,  4 Sep 2024 12:15:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gAjWzltGUnt/yZDfeiECJIJ9k09gTNsVx6YBvE
	SKX5E=; b=F9IPXN+qAHpUO9HCrFtmmneUHk0Y57R/J45NERUpQhg69u5UwycP/v
	9uVpyOjoc38Ytt+XQzM8SU0N5fWn5prBBw01j5+ITxF0oisTyucVZer9Q2w4+1Lt
	NW01KcfsGSrXJGhpqOStK9Eyy4skJPx16esWJ/elJPYAljsjxyZmA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4D6735EE0;
	Wed,  4 Sep 2024 12:15:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E41AE35EDF;
	Wed,  4 Sep 2024 12:15:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: karthik nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] refs/files: use heuristic to decide whether to
 repack with `--auto`
In-Reply-To: <ZtgPSGMD0ZV3S0Nn@pks.im> (Patrick Steinhardt's message of "Wed,
	4 Sep 2024 09:42:06 +0200")
References: <cover.1725280479.git.ps@pks.im>
	<9a63abfe3b812a32d69c7393004bea4f88971559.1725280479.git.ps@pks.im>
	<CAOLa=ZRGvU4LvX9kjvF3dJCTvKR6CC1CwPTp515c3Wt5M8a5vA@mail.gmail.com>
	<ZtbVbn5rxrmLFuNa@pks.im> <xmqq4j6wlhpr.fsf@gitster.g>
	<ZtgPSGMD0ZV3S0Nn@pks.im>
Date: Wed, 04 Sep 2024 09:15:01 -0700
Message-ID: <xmqqzfonbdkq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D7F4BE4A-6AD8-11EF-BA67-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In any case, GCC is clever enough to notice what we're doing:
>
>     fastlog2(unsigned long):
>             xor     eax, eax
>             test    rdi, rdi
>             je      .L5
>             bsr     rax, rdi
>     .L5:
>             ret

Nice.  Aiming to compile to "bsr" is very good.

> So with the following definition we're optimizing both with GCC and
> Clang:
>
>     size_t fastlog2(size_t sz)
>     {
>         size_t l = 0;
>         if (!sz)
>             return 0;
>         for (; sz; sz >>= 1)
>             l++;
>         return l;
>     }
>
> I'd thus say we can just pick that function instead of caring about
> platform endianess with `ffs()`.

The above loop that compilers seem to know to reduce to "bsr" is
good.

FWIW, because the definition of "first bit" in ffs() is "least
significant bit", you do not need to worry about endianness at all,
but what we want is most significant, so it is not directly usable.
