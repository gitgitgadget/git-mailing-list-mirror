Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFB31FAEF
	for <e@80x24.org>; Tue,  9 Jan 2018 20:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbeAIU54 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 15:57:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55319 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758151AbeAIU5p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 15:57:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA76EC02AE;
        Tue,  9 Jan 2018 15:57:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Aw+TDh301Hs6MW0PnVogDmcGsM=; b=qZxdW0
        ysaEWjbTedu2AWZfsKu50MWRfGp8kNIc3myZ+xUHUfUYIUVicP0D1fapHztzkjk8
        pJ7Gk8dfVXZkdkFE3SRWSUGlpOlckyagXcZADKDqyPaNB8gdpfWsjoSfuKDmF1K6
        HAodBkrfUgAtdRu+8Jcy8cxkNquCuD1RIXyxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xjhlSHzuXnbTNFal/cr3URbRNZ0gfr+3
        w6gt4nYkzNYlHv1O3lNWOn4MzR9Z+WJSNbnxfg8jwkr84uvuTTiN2D3LPaK2BBYH
        8kiqy9r/HIln6CNgTymL+Z/8Up4XfukU62+x/wL1fHY7+GkkXgtqQ4pJCj4IsfJg
        OSXMlBCE1bw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0F86C02AD;
        Tue,  9 Jan 2018 15:57:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35CBEC02AB;
        Tue,  9 Jan 2018 15:57:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [PATCH v1 1/2] submodule: port submodule subcommand 'sync' from shell to C
References: <20180109175703.4793-1-pc44800@gmail.com>
        <20180109175703.4793-2-pc44800@gmail.com>
Date:   Tue, 09 Jan 2018 12:57:43 -0800
In-Reply-To: <20180109175703.4793-2-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Tue, 9 Jan 2018 23:27:02 +0530")
Message-ID: <xmqqpo6i4uns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD38CF2C-F57F-11E7-B32F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> +static int print_default_remote(int argc, const char **argv, const char *prefix)
> +{
> +	const char *remote;
> +
> +	if (argc != 1)
> +		die(_("submodule--helper print-default-remote takes no arguments"));
> +
> +	remote = get_default_remote();
> +	if (remote)
> +		printf("%s\n", remote);
> +
> +	return 0;
> +}

This is called directly from main and return immediately after
printing, so a small leak of remote does not matter, I guess.

> +static void sync_submodule(const char *path, const char *prefix,
> +			   unsigned int flags)
> +{
> +	const struct submodule *sub;
> +	char *remote_key = NULL;
> +	char *sub_origin_url, *super_config_url, *displaypath;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	char *sub_config_path = NULL;
> +
> +	if (!is_submodule_active(the_repository, path))
> +		return;
> +
> +	sub = submodule_from_path(&null_oid, path);
> +
> +	if (sub && sub->url) {
> +		if (starts_with_dot_dot_slash(sub->url) || starts_with_dot_slash(sub->url)) {

Not a big deal, but other codepaths seem to fold this pattern into
two lines, i.e.

		if (starts_with_dot_dot_slash(sub->url) ||
		    starts_with_dot_slash(sub->url)) {

> +			sub_origin_url = relative_url(remote_url, sub->url, up_path);
> +			super_config_url = relative_url(remote_url, sub->url, NULL);

On this side, these two are allocated memory that need to be freed.

> +		} else {
> +			sub_origin_url = xstrdup(sub->url);
> +			super_config_url = xstrdup(sub->url);

This side as well.

> +		}
> +	} else {
> +		sub_origin_url = "";
> +		super_config_url = "";

But not these.  You have free() of these two at the end of this
function, which will break things.

