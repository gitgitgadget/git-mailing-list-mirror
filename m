Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47B39843
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tGrWQV4t"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D804114
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:10:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E5291C2EED;
	Wed, 18 Oct 2023 19:10:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=19hnlbDcAdg1WBJMQDZ/MiQpzmzhEnBpCi4x6B
	nx78Q=; b=tGrWQV4te/UrzU3nfGH9mrtzs4qgT6zDAitDtEtRdouO5zmcPOdiO/
	avRnwZZAQg7FWhCNbtGv6FsqVKGahMctRge65xfoYjXfLbDNLDJ+HffxLLVpMVYF
	7n3/ndA0LcDpm36JGYudLrvBWIbk+9WiZEj/XOy+Bh16uJTG+AyC4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5662F1C2EEC;
	Wed, 18 Oct 2023 19:10:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1D5B1C2EEB;
	Wed, 18 Oct 2023 19:10:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "Eric W.
 Biederman" <ebiederm@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 05/10] bulk-checkin: extract abstract
 `bulk_checkin_source`
In-Reply-To: <da52ec838025a59a3f4f4ffaf2e6f9098a37547e.1697648864.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 18 Oct 2023 13:08:02 -0400")
References: <cover.1696629697.git.me@ttaylorr.com>
	<cover.1697648864.git.me@ttaylorr.com>
	<da52ec838025a59a3f4f4ffaf2e6f9098a37547e.1697648864.git.me@ttaylorr.com>
Date: Wed, 18 Oct 2023 16:10:43 -0700
Message-ID: <xmqqa5sfplvw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 90CCBE66-6E0B-11EE-B891-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> A future commit will want to implement a very similar routine as in
> `stream_blob_to_pack()` with two notable changes:
>
>   - Instead of streaming just OBJ_BLOBs, this new function may want to
>     stream objects of arbitrary type.
>
>   - Instead of streaming the object's contents from an open
>     file-descriptor, this new function may want to "stream" its contents
>     from memory.
>
> To avoid duplicating a significant chunk of code between the existing
> `stream_blob_to_pack()`, extract an abstract `bulk_checkin_source`. This
> concept currently is a thin layer of `lseek()` and `read_in_full()`, but
> will grow to understand how to perform analogous operations when writing
> out an object's contents from memory.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  bulk-checkin.c | 61 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 53 insertions(+), 8 deletions(-)

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index f4914fb6d1..fc1d902018 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -140,8 +140,41 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
>  	return 0;
>  }
>  
> +struct bulk_checkin_source {
> +	enum { SOURCE_FILE } type;
> +
> +	/* SOURCE_FILE fields */
> +	int fd;
> +
> +	/* common fields */
> +	size_t size;
> +	const char *path;
> +};

Looks OK, even though I expected to see a bit more involved object
orientation with something like

	struct bulk_checkin_source {
		off_t (*read)(struct bulk_checkin_source *, void *, size_t);
		off_t (*seek)(struct bulk_checkin_source *, off_t);
		union {
			struct {
				int fd;
				size_t size;
				const char *path;
			} from_fd;
			struct {
				...
			} incore;
		} data;
	};

As there will only be two subclasses of this thing, it may not
matter all that much right now, but it would be much nicer as your
methods do not have to care about "switch (enum) { case FILE: ... }".

