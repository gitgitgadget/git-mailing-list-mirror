Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C58620954
	for <e@80x24.org>; Mon,  4 Dec 2017 18:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdLDSat (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 13:30:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56392 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751208AbdLDSar (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 13:30:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A00D8CBFF6;
        Mon,  4 Dec 2017 13:30:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZaxyY1hsvTvmBqRY+yWBv0WlJ0s=; b=tLfkwV
        zOr34eTf+hx+eIEVmce73S22AgRt8mx0AKBItmlQZLQmtrxRDxQrJmHnGCUimSpV
        JbKss+LBd6L8gU8qDsiXPHG8w/Lmbm3lZPtrieL85xyGAJh6VutCgxKEsbdaLS4O
        l9LPJoeu0GER9zahMKHpYBJPh23dXsCixlT0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=leK7c0DtUiKNpdOSdJDV5jX/m+a80Vjl
        j5lfhPyTpbwYpaOo41ziqN6oeWx09igj8gVAQVcPFIh/uk2EMlIjMDRF/KPpqvlj
        UWT8EYb3/xqmWGJXnMFVXDiHNoGwrHMJUXCP8BQ+8/xBtsjh8kbibTnn7VqIYN+U
        8TF9aScclWE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F51BCBFF5;
        Mon,  4 Dec 2017 13:30:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5CB9CBFF4;
        Mon,  4 Dec 2017 13:30:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 7/9] sequencer: load commit related config
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171124110758.9406-1-phillip.wood@talktalk.net>
        <20171124110758.9406-8-phillip.wood@talktalk.net>
Date:   Mon, 04 Dec 2017 10:30:44 -0800
In-Reply-To: <20171124110758.9406-8-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Fri, 24 Nov 2017 11:07:56 +0000")
Message-ID: <xmqqd13umjl7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E4959B8-D921-11E7-8192-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -9,6 +9,17 @@ static const char * const builtin_rebase_helper_usage[] = {
>  	NULL
>  };
>  
> +static int git_rebase_helper_config(const char *k, const char *v, void *cb)
> +{
> +	int status;
> +
> +	status = git_sequencer_config(k, v, NULL);
> +	if (status)
> +		return status;
> +
> +	return git_default_config(k, v, NULL);
> +}
> +

Sorry for spotting the problem this late, but this code is
unfortunate and we will need to revisit it later; we may want to do
so sooner rather than later.

When k,v is a valid configuration that is handled by
sequencer_config() successfully, this code still needs to call into
default_config() with the same k,v, only to get it ignored.

The problem lies in the (mis)design of git_sequencer_config().  The
function should either allow the caller to notice that (k,v) has
already been handled, or be the last one in the callback by making a
call to default_config() itself.

For the former, because this helper does not have to be called
directly as a git_config() callback, but instead it is always meant
to be called indirectly from another git_config() callback (like
git_rebase_helper_config() here, and common_config() in
builtin/revert.c like we see below), it does *not* have to be
constrained by the function signature required for it to be a config
callback.  It could take a pointer to an int that stores if 'k' was
handled inside the function,

    int git_sequencer_config_helper(char *k, char *v, int *handled);

for example.
