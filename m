Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59003F4AC
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZF17Bmd1"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82B2B8
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:54:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E9F933A8BA;
	Thu, 12 Oct 2023 17:54:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZETUpgdWwopPfUk0k5SY+8reexXReOC1KFmE6J
	UYoco=; b=ZF17Bmd1/Ie7McwcYsNGhL2/or81jA4ZF7KfyJ/7Ev6qkEQSw46y0i
	fx+rJMzY0oPkD3q05bc5mgVvEUNrxSJloNiN0tB887m3vGvdHrwZY/r/nOVadh91
	cPrw+kEaZz3SXBWgAfdQbftYmLInIjAWFtdB1jzJoVeLnSs4anwyw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E1C373A8B9;
	Thu, 12 Oct 2023 17:54:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7FA293A8B7;
	Thu, 12 Oct 2023 17:54:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Documentation/gitformat-pack.txt: fix incorrect
 MIDX documentation
In-Reply-To: <af2742e05dff48c4ba0a9f36d58bcbfc052dca40.1697144959.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 12 Oct 2023 17:09:31 -0400")
References: <cover.1697144959.git.me@ttaylorr.com>
	<af2742e05dff48c4ba0a9f36d58bcbfc052dca40.1697144959.git.me@ttaylorr.com>
Date: Thu, 12 Oct 2023 14:54:17 -0700
Message-ID: <xmqq5y3b4id2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4B070A2-6949-11EE-8DF9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
> index d7153962d4..54000c9412 100644
> --- a/Documentation/gitformat-pack.txt
> +++ b/Documentation/gitformat-pack.txt
> @@ -392,8 +392,9 @@ CHUNK DATA:
>  	Packfile Names (ID: {'P', 'N', 'A', 'M'})
>  	    Stores the packfile names as concatenated, NUL-terminated strings.

Not a problem this series (neither this or the previous step)
introduces, but I had to read the implementation of
write_midx_pack_names() to find out what "concatenated
NUL-terminated string" really means.  The code has a list of
strings, writes each of them as a NUL-terminated string in sequence,
and to align the beginning of the next chunk, NULs are added to make
the whole thing multiple of MIDX_CHUNK_ALIGNMENT bytes.

A naive reader code might implement a loop like so:

	while (ptr[0] != '\0') {
		endp = strlen(ptr);
		... ptr[0..endp] is one pathname ...
		ptr = endp + 1;
	}
		
expecting that the terminating NUL of the last entry would be
followed by a NUL, but that is buggy.  The sum of the pathname
strings (with one NUL after each) may happen to be multiple of
MIDX_CHUNK_ALIGNMENT bytes, in which case no extra padding NUL bytes
will be there.  So the reader also needs to pay attention to the
chunk size to notice when to stop reading.  It feels somewhat
suboptimal.

>  	    Packfiles must be listed in lexicographic order for fast lookups by
> -	    name. This is the only chunk not guaranteed to be a multiple of four
> -	    bytes in length, so should be the last chunk for alignment reasons.
> +	    name. Individual entries in this chunk are not guarenteed to be
> +	    aligned. The chunk is externally padded with zeros to align
> +	    remaining chunks.

I am not sure what "externally padded" means.

Before write_midx_pack_names() returns, there is a code to pad the
space after it writes those names, which does not look any external
than the bytes used to record the pathnames or NUL bytes used to
terminate these pathnames.

To me, "externally padded" is an appropriate phrase to use if this
function does not bother with the alignment after what it needs to
record, but the caller, i.e., write_chunkfile(), has code to notice
that the number of bytes written by cf->chunks[i].write_fn() it just
called is not a multiple of some required alignment and adds padding
bytes after .write_fn() returned.  I do not think that is what is
going on here.

My observations.

 * The packfile names chunk is used to record N pathnames; N is not
   recorded anywhere explicitly.  To record N pathnames, a single
   chunk with N names in it is used.  It is not like N chunks, each
   with one name is used.

 * Each of these pathname is recorded literally, followed by a NUL,
   in some order, without any extra padding.

 * To keep the size of the chunk multiple of alignment requirement,
   there may be extra NUL bytes after the names.

This data structure does not allow you to binary search or hash
lookup without an extra table of pointers into this table of strings
at runtime, and once you build such a table, the source being sorted
does not help all that much.  So I am not sure how strict the
"lexicographic" requirement needs to be, but of course, starting
strict and loosening later is much easier than starting loose, so
documenting "must be listed" and following that rule is fine.

Thanks.
