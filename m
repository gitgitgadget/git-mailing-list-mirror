Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB64201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 18:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdCNSGi (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 14:06:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56127 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750744AbdCNSGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 14:06:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DD4869CE1;
        Tue, 14 Mar 2017 14:06:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/ZREt83021MkuG+5Y6oUb7bDNWQ=; b=dirnAO
        4fkrFTfTtR/56qZZQYYsX2UGfoBLLZZ64nCsqRTNqeXMlBCVuKTSt/pkvDiwBhv4
        9bKA4juq2lVbO02HrWdEdk37cZ1B6fpLDtsqIByOFiN7OUSdXTnzulihDtWAYOrV
        2/uFA5npnmqifGUMbkJApvqtj9CZ6xkhN1CdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HHMwhLH+gKCZ/0xwGW+C2QVOyV+fcuYG
        NfL7rP02qYzXb1fsDt8aHAFTo3A8sxOct+vwHfa4Mr2+lQCqMsInbAD0T36Y4FU7
        H0+7GD2HXVopt8l1M1tB8d2l5ukJZPReBZ5iyJJqkzkLQ0hl3sbkGR5azm0e6ULz
        Y21HP6HLjbE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55D1069CE0;
        Tue, 14 Mar 2017 14:06:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABDB669CDF;
        Tue, 14 Mar 2017 14:06:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 04/10] submodule--helper clone: check for configured submodules using helper
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-5-bmwill@google.com>
Date:   Tue, 14 Mar 2017 11:06:33 -0700
In-Reply-To: <20170313214341.172676-5-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:35 -0700")
Message-ID: <xmqq4lyvka1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5C6094A-08E0-11E7-AC00-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> -	/*
> -	 * Looking up the url in .git/config.
> -	 * We must not fall back to .gitmodules as we only want
> -	 * to process configured submodules.
> -	 */
> -	strbuf_reset(&sb);
> -	strbuf_addf(&sb, "submodule.%s.url", sub->name);
> -	git_config_get_string(sb.buf, &url);
> -	if (!url) {
> +	/* Check if the submodule has been initialized. */
> +	if (!is_submodule_initialized(ce->name)) {
>  		next_submodule_warn_missing(suc, out, displaypath);
>  		goto cleanup;
>  	}
> @@ -835,7 +827,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  		argv_array_push(&child->args, "--depth=1");
>  	argv_array_pushl(&child->args, "--path", sub->path, NULL);
>  	argv_array_pushl(&child->args, "--name", sub->name, NULL);
> -	argv_array_pushl(&child->args, "--url", url, NULL);
> +	argv_array_pushl(&child->args, "--url", sub->url, NULL);

Even without this patch, we already had an instance of struct submodule
available in this function, so the query to .git/config this patch removed
was unnecessary?

I am wondering what was meant by the comment "We must not fall back to..."
that is being removed---is that because sub->url can come from .gitmodules
that is in-tree, not from .git/config?  If that is the case, doesn't the
change in this hunk change behaviour from using the URL the user prefers
to using the URL the upstream suggests, overriding user's configuration?

> @@ -845,7 +837,6 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  		argv_array_push(&child->args, suc->depth);
>  
>  cleanup:
> -	free(url);
>  	strbuf_reset(&displaypath_sb);
>  	strbuf_reset(&sb);
