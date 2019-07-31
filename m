Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CFAA1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 17:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfGaR7Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 13:59:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65025 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaR7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 13:59:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB394159D2D;
        Wed, 31 Jul 2019 13:59:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IkX0OCEB80gEG7hBWJU3/OkKtSw=; b=VS6fal
        Yi6AWR/Ly9gZBRmvOxInX5UdANL/PdT7A2BeJUMN6Tx8+K1sPOPj8jwWlMbrpbdc
        qKf4MaEgMdHFifDUQhtZP7AruGLqkZxxwKkbpEkt5fIH0GsFcM0oChCVaCkCDo/P
        zBvU1uKoUfIrVBSTVsXWulOcaVf2l9o4oDY3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aE5iAlr+XVKZujuYH5Zu6Ue5ZZAk55YN
        kDBvWxnHbbaDyT47DHaorYvpCsHe0N+XaScdIdsdW1bV1M1ITefe77Aq957dYSa0
        TzHiVVMxa1ChllpVxpMiJYWTU/fXubdlPuLiUyLYZHJbhGqVvbaNuyalmtEw0dZo
        3WzHB5yzCuQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFF3C159D2A;
        Wed, 31 Jul 2019 13:59:18 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3448B159D29;
        Wed, 31 Jul 2019 13:59:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Daniel Ferreira <bnmvco@gmail.com>
Subject: Re: [PATCH v3 02/11] diff: export diffstat interface
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
        <c7a377890d84849ea2f63099cfc081420a4de15d.1563289115.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Jul 2019 10:59:17 -0700
In-Reply-To: <c7a377890d84849ea2f63099cfc081420a4de15d.1563289115.git.gitgitgadget@gmail.com>
        (Daniel Ferreira via GitGitGadget's message of "Tue, 16 Jul 2019
        07:58:38 -0700 (PDT)")
Message-ID: <xmqqwofyozka.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA93D87A-B3BC-11E9-90FF-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -6273,12 +6257,7 @@ void diff_flush(struct diff_options *options)
>  	    dirstat_by_line) {
>  		struct diffstat_t diffstat;
>  
> -		memset(&diffstat, 0, sizeof(struct diffstat_t));
> -		for (i = 0; i < q->nr; i++) {
> -			struct diff_filepair *p = q->queue[i];
> -			if (check_pair_status(p))
> -				diff_flush_stat(p, options, &diffstat);
> -		}
> +		compute_diffstat(options, &diffstat, q);
>  		if (output_format & DIFF_FORMAT_NUMSTAT)
>  			show_numstat(&diffstat, options);
>  		if (output_format & DIFF_FORMAT_DIFFSTAT)
> @@ -6611,6 +6590,20 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
>  	return ignored;
>  }
>  
> +void compute_diffstat(struct diff_options *options,
> +		      struct diffstat_t *diffstat,
> +		      struct diff_queue_struct *q)
> +{
> +	int i;
> +
> +	memset(diffstat, 0, sizeof(struct diffstat_t));
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		if (check_pair_status(p))
> +			diff_flush_stat(p, options, diffstat);
> +	}
> +}

Hmm, (1) clearing diffstat struct to initialize, (2) looping over
diff_queue to compute stat for each path, (3) using diffstat
information and then (4) finally freeing the diffstat info is the
bog-standard sequence of the user of this API.  Merging step (1) and
(2) may probably be OK (iow, I do not think of a use pattern for
future users where being able to do some custom things between steps
(1) and (2) would be useful), which is this function is about.  (3)
is what the user of this API would do, but shouldn't (4) be exported
at the same time, if we are making (1+2) as an external API?

>  void diff_addremove(struct diff_options *options,
>  		    int addremove, unsigned mode,
>  		    const struct object_id *oid,
> diff --git a/diff.h b/diff.h
> index b680b377b2..34fc658946 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -244,6 +244,22 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
>  void diff_emit_submodule_pipethrough(struct diff_options *o,
>  				     const char *line, int len);
>  
> +struct diffstat_t {
> +	int nr;
> +	int alloc;
> +	struct diffstat_file {
> +		char *from_name;
> +		char *name;
> +		char *print_name;
> +		const char *comments;
> +		unsigned is_unmerged:1;
> +		unsigned is_binary:1;
> +		unsigned is_renamed:1;
> +		unsigned is_interesting:1;
> +		uintmax_t added, deleted;
> +	} **files;
> +};
> +
>  enum color_diff {
>  	DIFF_RESET = 0,
>  	DIFF_CONTEXT = 1,
> @@ -333,6 +349,9 @@ void diff_change(struct diff_options *,
>  
>  struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
>  
> +void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat,
> +		      struct diff_queue_struct *q);
> +
>  #define DIFF_SETUP_REVERSE      	1
>  #define DIFF_SETUP_USE_SIZE_CACHE	4
