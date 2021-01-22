Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60AFC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E0123A5C
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbhAVTws (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:52:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56805 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbhAVTTf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 14:19:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B74FAA76C3;
        Fri, 22 Jan 2021 14:18:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TGusI+EEZHWTy30RmgEVy/AtJH8=; b=CRxm5C
        8VoXOdfP14f+4d6eh3d7GiuIaX78AhNd+goCZFE2IGYeyt0g48VYdmVmL+bTPYp+
        M6Lv/c8EpC5VN83Vj6WqISsl5FlmHNvEpxUuuzoYqZW5m005i1hm5v9T3ohZyPQE
        3oJsSgLWz7t5E3yOHdnF9hBWbywqEyQ1wIIng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F9WNTFSQEg07HgmrX6o6K6T+WJ5ji1+F
        +v0aoShJ7UzIGWqhCFeUaxDDCc0XA42KBv0g5A58THGeXpvbVgUNAvg6olGs4uIF
        qW5Bn9LH4E5v0BTgykW/FWtodcofY6F2ZhdPn2Nu2cewJvpEqI5yHnZepz0NIcON
        QB82LvXGKhc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE7FCA76C2;
        Fri, 22 Jan 2021 14:18:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 356E0A76C0;
        Fri, 22 Jan 2021 14:18:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/8] fsmonitor: de-duplicate BUG()s around dirty bits
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <31095f9aa0ecd29193cc4d612d1953653c04b8ae.1611320639.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 11:18:42 -0800
In-Reply-To: <31095f9aa0ecd29193cc4d612d1953653c04b8ae.1611320639.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 22 Jan 2021
        13:03:54 +0000")
Message-ID: <xmqqh7n893vx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A438BB3C-5CE6-11EB-A060-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The index has an fsmonitor_dirty bitmap that records which index entries
> are "dirty" based on the response from the FSMonitor. If this bitmap
> ever grows larger than the index, then there was an error in how it was
> constructed, and it was probably a developer's bug.
>
> There are several BUG() statements that are very similar, so replace
> these uses with a simpler assert_index_minimum(). Since there is one
> caller that uses a custom 'pos' value instead of the bit_size member, we
> cannot simplify it too much. However, the error string is identical in
> each, so this simplifies things.

Also that single caller with a custom 'pos' used to allow 'pos' to
point one beyond the end of istate->cache[] array, but now it is
forbidden.  If this is a strict bugfix, it probably deserves a
mention here.

> The end result is that the code is simpler to read while also preserving
> these assertions for developers in the FSMonitor space.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  fsmonitor.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index ca031c3abb8..52a50a9545a 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -13,14 +13,19 @@
>  
>  struct trace_key trace_fsmonitor = TRACE_KEY_INIT(FSMONITOR);
>  
> +static void assert_index_minimum(struct index_state *istate, size_t pos)
> +{
> +	if (pos > istate->cache_nr)
> +		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> +		    (uintmax_t)pos, istate->cache_nr);
> +}
> +
>  static void fsmonitor_ewah_callback(size_t pos, void *is)
>  {
>  	struct index_state *istate = (struct index_state *)is;
>  	struct cache_entry *ce;
>  
> -	if (pos >= istate->cache_nr)
> -		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
> -		    (uintmax_t)pos, istate->cache_nr);
> +	assert_index_minimum(istate, pos);
>  
>  	ce = istate->cache[pos];
>  	ce->ce_flags &= ~CE_FSMONITOR_VALID;
> @@ -82,10 +87,8 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
>  	}
>  	istate->fsmonitor_dirty = fsmonitor_dirty;
>  
> -	if (!istate->split_index &&
> -	    istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> -		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> -		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> +	if (!istate->split_index)
> +		assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>  
>  	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
>  	return 0;
> @@ -110,10 +113,8 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
>  	uint32_t ewah_size = 0;
>  	int fixup = 0;
>  
> -	if (!istate->split_index &&
> -	    istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> -		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> -		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> +	if (!istate->split_index)
> +		assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>  
>  	put_be32(&hdr_version, INDEX_EXTENSION_VERSION2);
>  	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
> @@ -335,9 +336,7 @@ void tweak_fsmonitor(struct index_state *istate)
>  			}
>  
>  			/* Mark all previously saved entries as dirty */
> -			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> -				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> -				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> +			assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>  			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
>  
>  			refresh_fsmonitor(istate);
