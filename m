Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3471FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 22:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbcKRWBd (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 17:01:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753095AbcKRWBc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 17:01:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72A854E4FE;
        Fri, 18 Nov 2016 17:01:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BdU8Djg2T22hkho8ibqw1Kz0LWI=; b=NcA4nf
        ck7K9qfXWcR5nVAE1VQEPltqhGS1MszE2MfoOHz5JnCqzA3rbEx04YbpAXdUxGk+
        XxEXt7GSwWDRBDMpQrJN5tqh7w1jrLKCMbJJU4R6REycQGvgvP0jzPWNxe1MaWKm
        E79ZH1/40w9Fb4FuSC0Odpx3xgNuzOphPzaC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IIQdZ3+AMaJVsQ+m+Bz1gfv8tqhqJ4PB
        kO3oUFui3Fpzhurbt0sJ0FbH/Q748ZgeyS+Pi0WK487f7YIykYl/YsuPRKIWSVvJ
        A7A9+c0Wa0rfZnXjr+Tb/0lqgfFuTJDDpdgJbMQbVMEpjHFG8kTHVhIzQbjoOvAo
        3x9CQvqW7b0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 699724E4FD;
        Fri, 18 Nov 2016 17:01:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD1B94E4FB;
        Fri, 18 Nov 2016 17:01:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 4/6] grep: optionally recurse into submodules
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
        <1479499135-64269-1-git-send-email-bmwill@google.com>
        <1479499135-64269-5-git-send-email-bmwill@google.com>
Date:   Fri, 18 Nov 2016 14:01:29 -0800
In-Reply-To: <1479499135-64269-5-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 18 Nov 2016 11:58:53 -0800")
Message-ID: <xmqqshqola6e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FD8EEB0-ADDA-11E6-B2C2-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -300,6 +311,10 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
>  	if (opt->relative && opt->prefix_length) {
>  		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
>  		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
> +	} else if (super_prefix) {
> +		strbuf_add(&pathbuf, filename, tree_name_len);
> +		strbuf_addstr(&pathbuf, super_prefix);
> +		strbuf_addstr(&pathbuf, filename + tree_name_len);
>  	} else {
>  		strbuf_addstr(&pathbuf, filename);
>  	}
> @@ -328,10 +343,13 @@ static int grep_file(struct grep_opt *opt, const char *filename)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  
> -	if (opt->relative && opt->prefix_length)
> +	if (opt->relative && opt->prefix_length) {
>  		quote_path_relative(filename, opt->prefix, &buf);
> -	else
> +	} else {
> +		if (super_prefix)
> +			strbuf_addstr(&buf, super_prefix);
>  		strbuf_addstr(&buf, filename);
> +	}

The above two hunks both assume that the super_prefix option is
usable only from the top-level (i.e. opt->prefix_length == 0) and
also "--no-full-name" (which is the default) cannot be used.  The
only invoker that runs "grep" with "--super-prefix" is the "grep"
that runs in the superproject, and it will only run us from the
top-level of the working tree, so the former assumption is OK.  

It is a bit unclear to me how the "relative" and "--recurse-submodules"
would interact with each other, though.



