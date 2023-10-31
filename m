Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C9E36C
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VqhAFbSA"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37E693
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:42:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6A401CD7C2;
	Mon, 30 Oct 2023 20:42:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SKO32mJEDJQscfZO9A9H/9pMHkmWv08OQyFHRh
	gKptw=; b=VqhAFbSAepkF4FOzujO83S3JVdN1vqbNTCD3E7WyrSaIlPXvbsDQML
	yHEuDfxWumbsspeFrLvszeTIQYLhdqtuo96cdM6WyJa3JVO+rmbT/vhEdvXPFTUZ
	1cbPlsFLG70N7GYi+6eYqCwPkHfSZ6yETMtZ2AOuglsm6LuwbDU7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD6F51CD7C1;
	Mon, 30 Oct 2023 20:42:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 435191CD7C0;
	Mon, 30 Oct 2023 20:42:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Documentation/gitformat-pack.txt: fix incorrect
 MIDX documentation
In-Reply-To: <ZUAmWWh1WHujiN05@nand.local> (Taylor Blau's message of "Mon, 30
	Oct 2023 17:55:37 -0400")
References: <cover.1697144959.git.me@ttaylorr.com>
	<af2742e05dff48c4ba0a9f36d58bcbfc052dca40.1697144959.git.me@ttaylorr.com>
	<xmqq5y3b4id2.fsf@gitster.g> <ZUAmWWh1WHujiN05@nand.local>
Date: Tue, 31 Oct 2023 09:42:41 +0900
Message-ID: <xmqq8r7j7hby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 666E7A36-7786-11EE-B617-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>> >  	    Packfiles must be listed in lexicographic order for fast lookups by
>> > -	    name. This is the only chunk not guaranteed to be a multiple of four
>> > -	    bytes in length, so should be the last chunk for alignment reasons.
>> > +	    name. Individual entries in this chunk are not guarenteed to be
>> > +	    aligned. The chunk is externally padded with zeros to align
>> > +	    remaining chunks.
>>
>> I am not sure what "externally padded" means.
>
> How about something like this, instead?
>
> --- 8< ---
> diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
> index 0bc80f0d46..229490f82f 100644
> --- a/Documentation/gitformat-pack.txt
> +++ b/Documentation/gitformat-pack.txt
> @@ -392,9 +392,10 @@ CHUNK DATA:
>  	Packfile Names (ID: {'P', 'N', 'A', 'M'})
>  	    Stores the packfile names as concatenated, NUL-terminated strings.
>  	    Packfiles must be listed in lexicographic order for fast lookups by
> -	    name. Individual entries in this chunk are not guarenteed to be
> -	    aligned. The chunk is externally padded with zeros to align
> -	    remaining chunks.
> +	    name. Individual entries in this chunk are not guaranteed to be
> +	    aligned, since the packfile names can be of arbitrary length. The
> +	    chunk itself is padded at the end with NUL bytes in order to align
> +	    the remaining chunks.

There is no alignment requirement described, so "not guaranteed" and
"in order to align" sound hollow.  These are always byte-aligned ;-)

How about something along this line to simplify it a bit?

	Store the names of packfiles as a sequence of NUL-terminated
	strings.  There is no extra padding between the filenames,
	and they are listed in lexicographic order.  The chunk
	itself is padded at the end with NUL bytes to make the chunk
	size a multiple of 4 bytes.

I did not ccheck if the chunks need to be 4-byte aligned, so if the
number is wrong, please adjust accordingly.

