Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7DE1F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 06:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbcJLGXV (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 02:23:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51731 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752738AbcJLGXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 02:23:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EAFF3C755;
        Wed, 12 Oct 2016 02:23:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E4tuqPJzeRkPBTTDKDX/Ug/DNkA=; b=NUirw9
        I4qSMH2ohOApUzyakfFqZJhyr3RrNb06rn4aQo1NoNLOv2vIwCFKIuwux1qP1Uz7
        FjApfDBPngYhcE4FQXvJRSrT7wl2abSPE1t1jsT1f/QXKgKV7PVL4UZ5fqNhiHWf
        2IuSxmq+hApNFgX1OCllzBsLmbRB/bZa/1JI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U5rc23yIEua3IKUVJ4T6QpUORnThVlic
        szZxz4K4b1IQxgJ62YzNtZPfWKN9STLuQ3+dQ7iG3l5MpXKxqEvCf5g9kGVM4pK2
        AGm5CvRZ4JtKvlks/SFGEApVDCHJ+sBg/8oKzws5/+lUu8LBPFX/ylOLg5AsSoF5
        OEP8ckiupfo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 769D13C754;
        Wed, 12 Oct 2016 02:23:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6F8D3C753;
        Wed, 12 Oct 2016 02:23:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 5/5] trailer: support values folded to multiple lines
References: <cover.1476232683.git.jonathantanmy@google.com>
        <cover.1476232683.git.jonathantanmy@google.com>
        <4b8616732b719ede04b90c87ab240c29b4e3a0bb.1476232683.git.jonathantanmy@google.com>
Date:   Tue, 11 Oct 2016 23:23:16 -0700
In-Reply-To: <4b8616732b719ede04b90c87ab240c29b4e3a0bb.1476232683.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 11 Oct 2016 18:23:29 -0700")
Message-ID: <xmqqr37m5bmz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D57B6F0-9044-11E6-9FD2-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently, interpret-trailers requires that a trailer be only on 1 line.
> For example:
>
>   a: first line
>      second line
>
> would be interpreted as one trailer line followed by one non-trailer line.
>
> Make interpret-trailers support RFC 822-style folding, treating those
> lines as one logical trailer.

Let's see how the code handles one minor detail when we see 822
folding, namely, "what happens to the leading whitespace that signals
the beginning of the second and subsequent lines?".

> diff --git a/trailer.c b/trailer.c
> index 97e96a9..907baa0 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -31,7 +31,7 @@ struct trailer_item {
>  	 * (excluding the terminating newline) and token is NULL.
>  	 */
>  	char *token;
> -	char *value;
> +	struct strbuf value;
>  };

Is the length of value very frequently used once the list of trailer
lines are fully parsed?  If not, I'd rather not to have "struct
strbuf" in a long-living structure like this one and instead prefer
keeping it a simple and stupid "char *value".

Yes, I know the existing code in trailers overuses strbuf when there
is no need, primarily because it uses the lazy "split into an array
of strbufs" function.  We shouldn't make it worse.

> @@ -767,16 +773,24 @@ static int process_input_file(FILE *outfile,
>  
>  	/* Parse trailer lines */
>  	for (i = trailer_start; i < trailer_end; i++) {
> +		if (last && isspace(lines[i]->buf[0])) {

It is convenient if "value" is a strbuf to do this,

> +			/* continuation line of the last trailer item */
> +			strbuf_addch(&last->value, '\n');
> +			strbuf_addbuf(&last->value, lines[i]);
> +			strbuf_strip_suffix(&last->value, "\n");

but it is easy to introduce a temporary strbuf in this scope and use
it only to create the final value and detach it to last->value, i.e.

		if (last && isspace(*lines[i]->buf)) {
			struct strbuf buf = STRBUF_INIT;
			strbuf_addf(&buf, "%s\n%s", last->value, lines[i]->buf);
			strbuf_strip_suffix(&buf, "\n");
			free(last->value);
			last->value = strbuf_detach(&buf, NULL);

By the way, I now see that the code handles the "minor detail" to
keep the leading whitespace, which is good.

Thanks.
