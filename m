Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265121A0A
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k+AMpn0r"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF83CA
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 14:04:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AF752DAF8;
	Fri, 13 Oct 2023 17:04:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hayh9g5Xf3OBRZv13b35+dbf1Uj7HDh4UGtAtY
	tkUCo=; b=k+AMpn0r4VH2TuGLTFRC1KS2E1Bm3So+0Doa8UzqexHICVIoxA7oQ5
	VbJfKwFPOh9mx5bbNM9fFwGnWORs/qPq2wMm9+EW6Tn/0j7jEGZh3E00Vyky61ih
	v3Ra+/LXetX+B/dlcI9Qf6LCl/SSlo7h3cBix3ZlsuqPfLIaPmk0g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 33CD62DAF7;
	Fri, 13 Oct 2023 17:04:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 601612DAF5;
	Fri, 13 Oct 2023 17:04:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] midx: read `OIDF` chunk with `pair_chunk_expect()`
In-Reply-To: <b39203b32c24772d5d8a257c4f647b7d9bd92d53.1697225110.git.me@ttaylorr.com>
	(Taylor Blau's message of "Fri, 13 Oct 2023 15:25:32 -0400")
References: <20231009205544.GA3281950@coredump.intra.peff.net>
	<cover.1697225110.git.me@ttaylorr.com>
	<b39203b32c24772d5d8a257c4f647b7d9bd92d53.1697225110.git.me@ttaylorr.com>
Date: Fri, 13 Oct 2023 14:04:34 -0700
Message-ID: <xmqqmswmxmhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1D9DDFB8-6A0C-11EE-ADA0-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Taylor Blau <me@ttaylorr.com> writes:

> +	if (pair_chunk_expect(cf, MIDX_CHUNKID_OIDFANOUT,
> +			      (const unsigned char **)&m->chunk_oid_fanout,
> +			      256 * sizeof(uint32_t))) {
> +		error(_("multi-pack-index OID fanout is of the wrong size"));
>  		die(_("multi-pack-index required OID fanout chunk missing or corrupted"));
> +	}

This is not a new problem, but when laid out this way, the doubled
messages look a bit suboptimal.

Together with reporting the actual and expected byte counts and
doing so consistenly I alluded to in a separate message, cleaning
these up should probably be left outside of the topic, I suspect.

> +	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
>  	if (read_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, midx_read_oid_lookup, m))
>  		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
>  	if (read_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_object_offsets, m))
