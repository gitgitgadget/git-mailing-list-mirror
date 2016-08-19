Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81DC1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 21:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754873AbcHSVwd (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 17:52:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55703 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754043AbcHSVwc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 17:52:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 813D337AEC;
        Fri, 19 Aug 2016 17:52:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ivL8is7+TVUoRIk0YM/MQzgZojc=; b=RDJMPy
        x5Z+7gIhWRZ1TPoSOZz2cAL/DTqTEH7kHrDh+KS0KYsDH4CDai3zby5ThpGt5Dap
        7uVXeaAcLzvuOyww7N/voMHovkbwhHK1ZzdO3f/eecgWzeftD3wHDc0+PjYoaKoG
        BF62pLP0gFM4d3YGRuG2BX2dpu/NRPb4/ki9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vk4ej5ptu7fb41ClHUn8hlZLrWtCqcmm
        Y4552ufZZHTUIfrrWJ8MoGQrXkTWrGGpYvkTcCWvflg2fIRQaYtQyMs0fn4ti69v
        ztHEvVdKgmrzfac3deaw8hS6GmYt4Z5yDegDh05eWq2ggD/RM/5yfAvXTB1807M3
        qzBnP1KD3sk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7998F37AEB;
        Fri, 19 Aug 2016 17:52:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04CDB37AEA;
        Fri, 19 Aug 2016 17:52:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 8/8] diff: teach diff to display submodule difference with an inline diff
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-9-jacob.e.keller@intel.com>
Date:   Fri, 19 Aug 2016 14:52:29 -0700
In-Reply-To: <20160819000031.24854-9-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 18 Aug 2016 17:00:31 -0700")
Message-ID: <xmqqmvk8zasi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A7E8904-6657-11E6-9FE0-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/diff.h b/diff.h
> index ea5aba668eaa..192c0eedd0ff 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -112,6 +112,7 @@ enum diff_words_type {
>  enum diff_submodule_format {
>  	DIFF_SUBMODULE_SHORT = 0,
>  	DIFF_SUBMODULE_LOG,
> +	DIFF_SUBMODULE_INLINE_DIFF,

Same trailing comma.

>  };
>  
>  struct diff_options {
> diff --git a/submodule.c b/submodule.c
> index 7108b4786bc1..cecd3cd98de4 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -435,6 +435,68 @@ void show_submodule_summary(FILE *f, const char *path,
>  	clear_commit_marks(right, ~0);
>  }
>  
> +void show_submodule_inline_diff(FILE *f, const char *path,
> +		const char *line_prefix,
> +		struct object_id *one, struct object_id *two,
> +		unsigned dirty_submodule, const char *meta,
> +		const char *del, const char *add, const char *reset,
> +		const struct diff_options *o)
> +{
> +	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
> +	struct commit *left = NULL, *right = NULL;
> +	struct strbuf submodule_dir = STRBUF_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
> +			      meta, reset, &left, &right);
> +
> +	/* We need a valid left and right commit to display a difference */
> +	if (!(left || is_null_oid(one)) ||
> +	    !(right || is_null_oid(two)))
> +		goto done;
> +
> +	if (left)
> +		old = one;
> +	if (right)
> +		new = two;
> +
> +	fflush(f);
> +	cp.git_cmd = 1;
> +	cp.dir = path;
> +	cp.out = dup(fileno(f));
> +	cp.no_stdin = 1;
> +
> +	/* TODO: other options may need to be passed here. */
> +	argv_array_pushl(&cp.args, "diff");

I think you meant argv_array_push() here.  Or ", NULL" at the end if
you anticipate you would grow more args after "diff" later and keep
using pushl().
