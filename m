Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369F71F856
	for <e@80x24.org>; Thu,  8 Sep 2016 20:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbcIHUxh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 16:53:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52352 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753297AbcIHUxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 16:53:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A9983CCDA;
        Thu,  8 Sep 2016 16:53:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Li5aSe/76HsffGplzqLoiBgTb7o=; b=o166Nn
        OT//72el4XYT/mCbVq1FEDzm80hBZLQIDWLBQGrpBORiEnQrgMOstpL0SRx0qkMG
        i4OHSToGYIzYMQVWY5TjNPGncDmkPZl+lDV38L9R0Prv8jmUFpxJUMZB+ZlOpdVn
        HmXLH3L7P+R0g3bm+KNHwuaSztfseTojLHGu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K0vrydlNPHvFP7JVtvxBAKFpPVqY8lR/
        oK/xUoNLreKkvuAf9uF0dvkq9VuN8LLXIRxY8oRsZqYJsfHAKG/4KVCnbU4s7f3H
        +eRI3p/WEz4ePWYrqgawINNn1XHl+8TQT7QOOTxrE+JxuKXbMNMZynDT8B1iANmH
        Ll0lmTBTuE0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41A543CCD8;
        Thu,  8 Sep 2016 16:53:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B83523CCD7;
        Thu,  8 Sep 2016 16:53:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff: omit found pointer from emit_callback
References: <20160907233648.5162-1-sbeller@google.com>
        <20160907233648.5162-4-sbeller@google.com>
Date:   Thu, 08 Sep 2016 13:53:29 -0700
In-Reply-To: <20160907233648.5162-4-sbeller@google.com> (Stefan Beller's
        message of "Wed, 7 Sep 2016 16:36:46 -0700")
Message-ID: <xmqqpooef706.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D26E736-7606-11E6-A42E-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/diff.c b/diff.c
> index 4a6501c..79ad91d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -354,7 +354,6 @@ struct emit_callback {
>  	const char **label_path;
>  	struct diff_words_data *diff_words;
>  	struct diff_options *opt;
> -	int *found_changesp;
>  	struct strbuf *header;
>  };

I briefly wondered if we have some callsites that do not want
o->found_changes to be modified (hence pointing this field at
elsewhere), but the fact that you can _remove_ this field means that
there is no such use case, which is good.

> @@ -722,7 +721,6 @@ static void emit_rewrite_diff(const char *name_a,
>  
>  	memset(&ecbdata, 0, sizeof(ecbdata));
>  	ecbdata.color_diff = want_color(o->use_color);
> -	ecbdata.found_changesp = &o->found_changes;
>  	ecbdata.ws_rule = whitespace_rule(name_b);
>  	ecbdata.opt = o;
>  	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
> @@ -1215,13 +1213,13 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
>  	struct diff_options *o = ecbdata->opt;
>  	const char *line_prefix = diff_line_prefix(o);
> +	o->found_changes = 1;
>  
>  	if (ecbdata->header) {
>  		fprintf(o->file, "%s", ecbdata->header->buf);
>  		strbuf_reset(ecbdata->header);
>  		ecbdata->header = NULL;
>  	}
> -	*(ecbdata->found_changesp) = 1;

Is there a good reason to move the assignment up?  "The fact that
this function was called even once means we found some change" is
probably a good argument, but then I'd prefer to have a blank before
it to separate it (the first statement) from the block of decls.

No need to resend.  Thanks.
