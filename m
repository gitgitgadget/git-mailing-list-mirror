Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29FC1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 20:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfHTUcJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 16:32:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64903 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfHTUcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 16:32:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20251164BE7;
        Tue, 20 Aug 2019 16:32:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qkqbenAuiNgx+N8Ho5AP77HfHPE=; b=MrYKdC
        fXBsY844eDcyDztsqB81hhKXPfpOvPI4ortyPPHNs8uAjqJylNbsKIWgIFGAlWDm
        DrWtSy1YF+1wcrqor2GulOPi1swVJJkp/DiMpLN4K1meOYLjSgAlkYpXkErvsaaP
        sxyxtkNQF0p+USHTH2qTtFSSwU/FLQbDAutvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=npnXzmYya4f7+m544NuAiRDXejQ2iN+S
        /c127xSqDaZvz00A+QH9K7ePXHq5DUHSD1kll3JJzaU/MQF0wul3VCWwRDOhBndV
        SlRpaO3yyxOT2wMtPL6obkO6FddbtI1d5tFfkvcyEzSuuvKb/2tdeoM9YOL7OnJy
        51MowGNrrzU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1730C164BE6;
        Tue, 20 Aug 2019 16:32:07 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74921164BE5;
        Tue, 20 Aug 2019 16:32:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, garimasigit@gmail.com, jeffhost@microsoft.com,
        stolee@gmail.com, Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 1/1] quote: handle null and empty strings in sq_quote_buf_pretty()
References: <pull.314.git.gitgitgadget@gmail.com>
        <9d2685bdb2e193986bec8cad88795963977d41fe.1566329700.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Aug 2019 13:32:05 -0700
In-Reply-To: <9d2685bdb2e193986bec8cad88795963977d41fe.1566329700.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Tue, 20 Aug 2019 12:35:01
        -0700 (PDT)")
Message-ID: <xmqqpnkztw6y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 938C965C-C389-11E9-B84B-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/*
> +	 * In case of null or empty tokens, add a '' to ensure we 
> +	 * don't inadvertently drop those tokens
> +	 */

A good comment.

> +	if (!src || !*src) {

I think a caller that passes src==NULL deserves a BUG, or just a
normal segfault.  The condition here should just be "if (!*src)"
instead.

> +		strbuf_addstr(dst, "''");
> +		return;
> +	}

Otherwise, the fix itself is good.

Thanks.


>  	for (p = src; *p; p++) {
>  		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
>  			sq_quote_buf(dst, src);
