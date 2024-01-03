Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1B1BDD1
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MqKwd9rR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC4371CB135;
	Wed,  3 Jan 2024 11:38:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HHL1Z6z5wUFI
	apRhxBOQUqHL+sMZQNi4oOkW0HAtOgo=; b=MqKwd9rR/ElnrznZxOpT1TyA2ZpI
	z0PEoye4RtSN0xV6zjNRyN2dYsl8xAY3Of5kJNsRkd2kDocpeQbc1HxZyebDTO4t
	DnMG13g03uEGO82XcW5L3RACzuaYCIH54pptIt5aXbKqL8kGrnSfEQauXNJnB01z
	wjJuIyy3acsMPjY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A32D81CB133;
	Wed,  3 Jan 2024 11:38:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA1391CB130;
	Wed,  3 Jan 2024 11:38:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
In-Reply-To: <20240103090152.GB1866508@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 3 Jan 2024 04:01:52 -0500")
References: <xmqq5y0bcjpw.fsf@gitster.g>
	<20240103090152.GB1866508@coredump.intra.peff.net>
Date: Wed, 03 Jan 2024 08:37:59 -0800
Message-ID: <xmqq8r56bcew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 75501282-AA56-11EE-A708-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> It looks like this is the original version. I posted a v2 that took
> Ren=C3=A9's suggestion to swap out the awk for shell, but it got overlo=
oked.
> I'm happy enough either way, but if we want to salvage that effort,
> here's a patch which could go on top:

Thanks.  I was happy enough with the old one and placed the updated
one on backburner.

A commit message that explains why this incremental update (i.e.,
rewrite from awk to a shell loop) is a good idea below does make it
worthwhile ;-)

> -- >8 --
> From: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Subject: [PATCH] t1006: prefer shell loop to awk for packed object size=
s
>
> To compute the expected on-disk size of packed objects, we sort the
> output of show-index by pack offset and then compute the difference
> between adjacent entries using awk. This works but has a few readabilit=
y
> problems:
>
>   1. Reading the index in pack order means don't find out the size of a=
n
>      oid's entry until we see the _next_ entry. So we have to save it t=
o
>      print later.
>
>      We can instead iterate in reverse order, so we compute each oid's
>      size as we see it.

If you go forward, you need "the end of the previous round" (which
is "the beginning of the current round") to be subtracted from "the
end of the current round".  If you go forward, you have to have "the
beginning of the previous round" (which is "the end of the current
round") from which you subtract "the beginning of the current round".

So from that point of view, the only difference is that you would
not be ready to emit in the first round, and you would need to emit
for the last entry after the loop.  Because we happen to have the
end of the last entry outside the loop, we can omit the awkwardness.

OK.  But iterating over a list backwards is a bit awkward ;-).

>   2. Since the awk invocation is inside a text_expect block, we can't
>      easily use single-quotes to hold the script. So we use
>      double-quotes, but then have to escape the dollar signs in the awk
>      script.

Yup.  The joy of shell quoting rules ;-)

> I gave Ren=C3=A9 authorship since this was his cleverness, but obviousl=
y I
> wrote the commit message. Giving an explicit signoff would be nice,
> though.

Indeed.

>  t/t1006-cat-file.sh | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 0c2eafae65..5ea3326128 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -1117,14 +1117,16 @@ test_expect_success 'cat-file %(objectsize:disk=
) with --batch-all-objects' '
>  		while read idx
>  		do
>  			git show-index <"$idx" >idx.raw &&
> -			sort -n <idx.raw >idx.sorted &&
> +			sort -nr <idx.raw >idx.sorted &&
>  			packsz=3D$(test_file_size "${idx%.idx}.pack") &&
>  			end=3D$((packsz - rawsz)) &&
> -			awk -v end=3D"$end" "
> -			  NR > 1 { print oid, \$1 - start }
> -			  { start =3D \$1; oid =3D \$2 }
> -			  END { print oid, end - start }
> -			" idx.sorted ||
> +			while read start oid rest
> +			do
> +				size=3D$((end - start)) &&
> +				end=3D$start &&
> +				echo "$oid $size" ||
> +				return 1
> +			done <idx.sorted ||
>  			return 1
>  		done
>  	} >expect.raw &&

This is totally unrelated tangent, but the way "show-index" gets
invoked in the above loop makes readers wonder how the caller found
out which $idx file to read.

Of course, the above loop sits downstream of a pipe

    find .git/objects/pack -type f -name \*.idx

which means that any user of "git show-index" must be intimately
familiar with how the object database is structured.  I wonder if we
want an extra layer of abstraction, similar to how the reference
database can have different backend implementation.

Anyway, will queue.  Thanks.
