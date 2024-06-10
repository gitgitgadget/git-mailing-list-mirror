Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907B1BF2A
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049908; cv=none; b=Z8RIyugAQ7Bq/Ftp8EqKXDqa+9QeHnsqbjGuYslI/xx/7Bj5N7pEkEuAkhDvLs5KFuw7A6mXfc+Y/p50i6PtQwQigeOEReyE3U6nXDenMrjeJlslduMDCViVsHLZqID6MdVpvfeuwFUKY1ZAUl4rK8PG8JFPzHc/Pm/dbDGS3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049908; c=relaxed/simple;
	bh=522FPaeZXuy+/0FpYanzM0Np45u1jBAr1Aq4BS5afTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hhJybiSyuHstlm49+7NbzDgC47MlClW6Le0ts2vhCFsra+26tzGyE83cale/EQk/hVZnzvxIBEGRlilAsb+3RDjBZX3ThGuDb6/B3CWSrtuvnDeGRnc5s07OOljaygtn8Y45NZtmHy2fSBbknlGJTP2WZFhRcT2fQHgd8gVuut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=whuvFxLO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="whuvFxLO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F41A01F70F;
	Mon, 10 Jun 2024 16:05:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=522FPaeZXuy+/0FpYanzM0Np45u1jBAr1Aq4BS
	5afTU=; b=whuvFxLO5Yux+oHyYdl3spETMgjyZZ0NmebwyC0UuEAlAZ5cEnRdP9
	hYkmH4ukSNCWTWArSptSpniKPQ6CpUxLjaHs7vLpBeB2dRmplv4TiXnCyYSNbt/s
	TCo/do1fchUSpDG8cefrX++ZRnFLzOD6sVcJHqfI97IGZA/B1eK+I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EC2CB1F70E;
	Mon, 10 Jun 2024 16:05:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9163B1F708;
	Mon, 10 Jun 2024 16:05:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] DONTAPPLY: -Og fallout workaround
In-Reply-To: <xmqqjziw3arr.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	10 Jun 2024 11:36:40 -0700")
References: <cover.1717655210.git.ps@pks.im> <cover.1718001244.git.ps@pks.im>
	<03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
	<xmqqed946auc.fsf@gitster.g> <xmqqjziw3arr.fsf@gitster.g>
Date: Mon, 10 Jun 2024 13:05:00 -0700
Message-ID: <xmqqsexk1s43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B904ADCC-2764-11EF-BB6C-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> These "workarounds" are to mark variables that are used after
> initialized, but some compilers with lower optimization levels
> cannot see and report "used uninitialized".
>
> This set targets "gcc-12 -Og".  For the reason why this is a wrong
> thing to do for longer-term code health, see
>
>   https://lore.kernel.org/git/xmqqed946auc.fsf@gitster.g/
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Even though I said I won't do the actual patch, since I had to
>    gauge the extent of damage, I ended up doing so anyways.
>
>    As I explained already, the size of this patch, i.e. number of
>    places that need the workaround, does not really matter.  What
>    is horrible is how each of these workaround will hide real bugs
>    we may introduce in the future from the compilers.
>
>  builtin/branch.c          | 2 +-
>  builtin/fast-import.c     | 4 ++--
>  builtin/repack.c          | 2 +-
>  fetch-pack.c              | 2 +-
>  http-backend.c            | 2 +-
>  http.c                    | 2 +-
>  pack-mtimes.c             | 2 +-
>  pack-revindex.c           | 2 +-
>  refs/packed-backend.c     | 2 +-
>  reftable/stack.c          | 2 +-
>  remote-curl.c             | 4 ++--
>  t/helper/test-ref-store.c | 2 +-
>  trailer.c                 | 4 ++--
>  13 files changed, 16 insertions(+), 16 deletions(-)

And depending on the version of compilers, apparently even this is
not enough.  I do not offhand know what GitHub CI is running for
linux-gcc-default (ubuntu-latest), but this gets flagged for using
(try to guess which one without looking at the answer below) ...

        static int parse_count(const char *arg)
        {
                int count;

                if (strtol_i(arg, 10, &count) < 0)
                        die("'%s': not an integer", arg);
                return count;
        }

... count uninitilaized, since the compiler does not realize that
strtol_i() always touches "count" unless the function returns
negative, and die() never returns.  Exactly the same pattern
continues.

So, unless we disable -Werror, let's not continue this experiment
with -Og or -Os as the damage seems to be far greater than the
benefit (which I haven't seen any, but that is largely due to
timezone differences---I asked "what's the real bug you found with
this" a few hours ago that is past EOB in Europe).

