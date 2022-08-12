Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C88C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiHLRlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbiHLRlR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 13:41:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC9764C
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 10:41:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41EC51B66EE;
        Fri, 12 Aug 2022 13:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FpP/HaRVJaavnQFLUrOiu4XA0M2F90XXVv9y91
        C5bRA=; b=ujFN+hA267IBBWv5NoEFUF5jNmGigkTTTKOeEKI1Z4UeG4rBATq1lb
        /zvGTT+m5CEMKZAzxptwRZ3P5FbidqyC1cNdmep87ncx+MY7NZoNiYMapVP+8kxT
        1x55qXMr8byL2kYK+akfzDndbdQOofnfkCqAmZ7toDApG9QaOTcIs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3AA4B1B66ED;
        Fri, 12 Aug 2022 13:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D3F301B66EA;
        Fri, 12 Aug 2022 13:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Delannoy <anthony.2lannoy@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] pathspec: fix memleak
References: <20220812081744.456280-1-anthony.2lannoy@gmail.com>
        <20220812081744.456280-2-anthony.2lannoy@gmail.com>
Date:   Fri, 12 Aug 2022 10:41:08 -0700
In-Reply-To: <20220812081744.456280-2-anthony.2lannoy@gmail.com> (Anthony
        Delannoy's message of "Fri, 12 Aug 2022 10:17:44 +0200")
Message-ID: <xmqqsfm1bbrf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3923C7E-1A65-11ED-B135-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Delannoy <anthony.2lannoy@gmail.com> writes:

> diff --git a/preload-index.c b/preload-index.c
> index e5529a5863..a05f4d1390 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -148,6 +148,9 @@ void preload_index(struct index_state *index,
>  		if (pthread_join(p->pthread, NULL))
>  			die("unable to join threaded lstat");
>  		t2_sum_lstat += p->t2_nr_lstat;
> +
> +		if (pathspec)
> +			free(p->pathspec.items);
>  	}
>  	stop_progress(&pd.progress);

Given the way how copy_pathspec() makes a deep copy of a pathspec, I
suspect that this is still leaking all the resources held by the
array that is freed here.  Let's take a look:

        void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
        {
                int i, j;

                *dst = *src;
                ALLOC_ARRAY(dst->items, dst->nr);
                COPY_ARRAY(dst->items, src->items, dst->nr);

Here, we copy the array of "struct pathspec_item".  But that is not
enough because ...

                for (i = 0; i < dst->nr; i++) {
                        struct pathspec_item *d = &dst->items[i];
                        struct pathspec_item *s = &src->items[i];

                        d->match = xstrdup(s->match);
                        d->original = xstrdup(s->original);

... each "struct pathspec_item" instance has pointer members like
these, and the copying of the array made these strings shared
between the src and dst arrays.  Here we make a copy of the string
owned by the element in the src array and give the copy to the
element in the dst array.

                        ALLOC_ARRAY(d->attr_match, d->attr_match_nr);
                        COPY_ARRAY(d->attr_match, s->attr_match, d->attr_match_nr);

Likewise for a separate array pointed by a member in "struct
pathspec_item" ...

                        for (j = 0; j < d->attr_match_nr; j++) {
                                const char *value = s->attr_match[j].value;
                                d->attr_match[j].value = xstrdup_or_null(value);

... which has a pointer member here ...

                        }

                        d->attr_check = attr_check_dup(s->attr_check);

... and here.  Both are deep-copied.

                }
        }

There is pathspec.c::clear_pathspec() API function, which looks as
if it was made for this exact use case.

I wonder if this is a good place to use it, perhaps like the
attached patch.

 preload-index.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/preload-index.c w/preload-index.c
index e5529a5863..100f7a374d 100644
--- c/preload-index.c
+++ w/preload-index.c
@@ -151,6 +151,12 @@ void preload_index(struct index_state *index,
 	}
 	stop_progress(&pd.progress);
 
+	if (pathspec) {
+		/* earlier we made deep copies for each thread to work with */
+		for (i = 0; i < threads; i++)
+			clear_pathspec(&data[i].pathspec);
+	}
+
 	trace_performance_leave("preload index");
 
 	trace2_data_intmax("index", NULL, "preload/sum_lstat", t2_sum_lstat);
