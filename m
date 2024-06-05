Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAC1527B5
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604606; cv=none; b=lgYpW3Tzl30ZB6qBqZS1EuunskQC2nLaucVrLiRnIsGIBKSkNvRZcgK8dSvazi7k28aGfM1Tp2efaSFcGvoCvYv54zMXnZ/vE/yh6keQ5SeKV08LubIe47nXHqyi655T4vOj3h9PL2+JsPhi7D2hcEcfW7FBemMnIwFKdNHXA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604606; c=relaxed/simple;
	bh=OucLmG/AhfyM3oFvqzEiDRAE/eW8U+aE6/SRfOScfAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDw9esntCejSHMwC/R4T2FqzcvpQ5gijJf9dIc88A7I4W0EpgmKlCbC+hhW71oQ43Yyxni4IBAWmW7Zyd/vIB/g+1ICAG69QVnFEVzpG3nLhUgsCS5DXYFMIAEXeyg2DyztUJMqHayg22l7pfmrxrEZMQSlXaOoxNp5GKmCxwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dSlyQEii; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dSlyQEii"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E1161E0EA;
	Wed,  5 Jun 2024 12:23:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OucLmG/AhfyM3oFvqzEiDRAE/eW8U+aE6/SRfO
	ScfAc=; b=dSlyQEiiVhiC5C+I3EZfLa4LpAuW7dqOfHSTd2X5UuRYKHoxHIIrsp
	qvTzABi+mLy1DrsQC5faXTeSotycZRGsYMziKV0cJ3Dat97rW1Wj4aUdwRcT1/xD
	Z1UoP6fkWp+MghyUEeiHYK2+E10K2Eqoz1NM+EVTDwz98lGTHDOgQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8655D1E0E9;
	Wed,  5 Jun 2024 12:23:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E18B71E0E8;
	Wed,  5 Jun 2024 12:23:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] dir.c: skip .gitignore, etc larger than INT_MAX
In-Reply-To: <20240605080308.GA2345232@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 5 Jun 2024 04:03:08 -0400")
References: <20240531120034.GA442032@coredump.intra.peff.net>
	<xmqqh6eehvj4.fsf@gitster.g>
	<20240604103947.GC1781455@coredump.intra.peff.net>
	<xmqqikyowqjj.fsf@gitster.g>
	<20240605080308.GA2345232@coredump.intra.peff.net>
Date: Wed, 05 Jun 2024 09:23:21 -0700
Message-ID: <xmqqplsvuznq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EDBBC71E-2357-11EF-BF75-6488940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> I do not mind if consolidation waits for later, but I guess the
> immediate question is whether we'd prefer to reduce the limit set by my
> patch to a more security-conservative value. It would be easy to swap
> out INT_MAX for a 100MB #define on top.
>
> Maybe this?

Sounds sensible.  Thanks.

> -- >8 --
> Subject: [PATCH] dir.c: reduce max pattern file size to 100MB
>
> In a2bc523e1e (dir.c: skip .gitignore, etc larger than INT_MAX,
> 2024-05-31) we put capped the size of some files whose parsing code and
> data structures used ints. Setting the limit to INT_MAX was a natural
> spot, since we know the parsing code would misbehave above that.
>
> But it also leaves the possibility of overflow errors when we multiply
> that limit to allocate memory. For instance, a file consisting only of
> "a\na\n..." could have INT_MAX/2 entries. Allocating an array of
> pointers for each would need INT_MAX*4 bytes on a 64-bit system, enough
> to overflow a 32-bit int.
>
> So let's give ourselves a bit more safety margin by giving a much
> smaller limit. The size 100MB is somewhat arbitrary, but is based on the
> similar value for attribute files added by 3c50032ff5 (attr: ignore
> overly large gitattributes files, 2022-12-01).
>
> There's no particular reason these have to be the same, but the idea is
> that they are in the ballpark of "so huge that nobody would care, but
> small enough to avoid malicious overflow". So lacking a better guess, it
> makes sense to use the same value. The implementation here doesn't share
> the same constant, but we could change that later (or even give it a
> runtime config knob, though nobody has complained yet about the
> attribute limit).
>
> And likewise, let's add a few tests that exercise the limits, based on
> the attr ones. In this case, though, we never read .gitignore from the
> index; the blob code is exercised only for sparse filters. So we'll
> trigger it that way.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  dir.c                               | 10 ++++++++--
>  t/t0008-ignores.sh                  |  8 ++++++++
>  t/t6112-rev-list-filters-objects.sh | 12 ++++++++++++
>  3 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 914060edfd..ad2b7ebe2d 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -32,6 +32,12 @@
>  #include "tree.h"
>  #include "hex.h"
>  
> + /*
> +  * The maximum size of a pattern/exclude file. If the file exceeds this size
> +  * we will ignore it.
> +  */
> +#define PATTERN_MAX_FILE_SIZE (100 * 1024 * 1024)
> +
>  /*
>   * Tells read_directory_recursive how a file or directory should be treated.
>   * Values are ordered by significance, e.g. if a directory contains both
> @@ -1149,7 +1155,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
>  		}
>  	}
>  
> -	if (size > INT_MAX) {
> +	if (size > PATTERN_MAX_FILE_SIZE) {
>  		warning("ignoring excessively large pattern file: %s", fname);
>  		free(buf);
>  		return -1;
> @@ -1211,7 +1217,7 @@ int add_patterns_from_blob_to_list(
>  	if (r != 1)
>  		return r;
>  
> -	if (size > INT_MAX) {
> +	if (size > PATTERN_MAX_FILE_SIZE) {
>  		warning("ignoring excessively large pattern blob: %s",
>  			oid_to_hex(oid));
>  		free(buf);
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 361446b2f4..02a18d4fdb 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -945,4 +945,12 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
>  	test_grep "unable to access.*gitignore" err
>  '
>  
> +test_expect_success EXPENSIVE 'large exclude file ignored in tree' '
> +	test_when_finished "rm .gitignore" &&
> +	dd if=/dev/zero of=.gitignore bs=101M count=1 &&
> +	git ls-files -o --exclude-standard 2>err &&
> +	echo "warning: ignoring excessively large pattern file: .gitignore" >expect &&
> +	test_cmp expect err
> +'
> +
>  test_done
> diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
> index 43e1afd44c..0387f35a32 100755
> --- a/t/t6112-rev-list-filters-objects.sh
> +++ b/t/t6112-rev-list-filters-objects.sh
> @@ -701,4 +701,16 @@ test_expect_success 'expand blob limit in protocol' '
>  	grep "blob:limit=1024" trace
>  '
>  
> +test_expect_success EXPENSIVE 'large sparse filter file ignored' '
> +	blob=$(dd if=/dev/zero bs=101M count=1 |
> +	       git hash-object -w --stdin) &&
> +	test_must_fail \
> +		git rev-list --all --objects --filter=sparse:oid=$blob 2>err &&
> +	cat >expect <<-EOF &&
> +	warning: ignoring excessively large pattern blob: $blob
> +	fatal: unable to parse sparse filter data in $blob
> +	EOF
> +	test_cmp expect err
> +'
> +
>  test_done
