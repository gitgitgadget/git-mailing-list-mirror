Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E4820D09
	for <e@80x24.org>; Mon, 17 Apr 2017 06:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbdDQGA3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 02:00:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57124 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932581AbdDQGA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 02:00:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EEBB8CC24;
        Mon, 17 Apr 2017 02:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EO88GkYcCzPy82UQ4bhThHmOst4=; b=K/nAnd
        B8+XvCmi9RaYuuXSgp7KSj9dwU5Vg4TQ23aGoVLzmTJ38TVweVE4Qn5B2b1uAr0Q
        YEvGUUArQq/pVI/6OTO0A+WpNCYc+4npQXSgTSh1P+Zxclufb0oUytvUwKNRbMU7
        ak4hXcM1yNaGasevVSZXSkxMLlAcnbeJAVQs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uQ4U7eWBKj/7iaXDTV+5bp3Tb7XUKTlk
        1YxcagENSchuT5x/rLXpNqXjN/HbAu1m3LBJpGC/7rCtWqD1BhUmIEUaHKIJwigi
        d4mtmWGArNOGxgl0X+aMJJ/M41pUvHSmoS2Qx3zPJXBP40q91hL0g/SB36sgh96V
        L/X4w8LAc38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76B828CC23;
        Mon, 17 Apr 2017 02:00:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA1BF8CC22;
        Mon, 17 Apr 2017 02:00:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/18] avoid using fixed PATH_MAX buffers for refs
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
        <20170328194629.5ddehsxizajitn3q@sigill.intra.peff.net>
Date:   Sun, 16 Apr 2017 23:00:25 -0700
In-Reply-To: <20170328194629.5ddehsxizajitn3q@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Mar 2017 15:46:30 -0400")
Message-ID: <xmqq1ssrk1za.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2761093E-2333-11E7-9BCE-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/replace.c b/builtin/replace.c
> index f83e7b8fc..065515bab 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -93,26 +93,31 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
>  static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
>  {
>  	const char **p, *full_hex;
> -	char ref[PATH_MAX];
> +	struct strbuf ref = STRBUF_INIT;
> +	size_t base_len;
>  	int had_error = 0;
>  	struct object_id oid;
>  
> +	strbuf_addstr(&ref, git_replace_ref_base);
> +	base_len = ref.len;
> +
>  	for (p = argv; *p; p++) {
>  		if (get_oid(*p, &oid)) {
>  			error("Failed to resolve '%s' as a valid ref.", *p);
>  			had_error = 1;
>  			continue;
>  		}
> -		full_hex = oid_to_hex(&oid);
> -		snprintf(ref, sizeof(ref), "%s%s", git_replace_ref_base, full_hex);
> -		/* read_ref() may reuse the buffer */
> -		full_hex = ref + strlen(git_replace_ref_base);
> -		if (read_ref(ref, oid.hash)) {
> +
> +		strbuf_setlen(&ref, base_len);
> +		strbuf_addstr(&ref, oid_to_hex(&oid));
> +		full_hex = ref.buf + base_len;
> +
> +		if (read_ref(ref.buf, oid.hash)) {
>  			error("replace ref '%s' not found.", full_hex);
>  			had_error = 1;
>  			continue;
>  		}
> -		if (fn(full_hex, ref, &oid))
> +		if (fn(full_hex, ref.buf, &oid))
>  			had_error = 1;
>  	}
>  	return had_error;

Don't we need to strbuf_release(&ref) before leaving this function?
