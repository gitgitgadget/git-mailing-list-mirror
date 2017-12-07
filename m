Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB7920C33
	for <e@80x24.org>; Thu,  7 Dec 2017 23:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbdLGXmE (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 18:42:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58780 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751741AbdLGXmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 18:42:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19AF7C6718;
        Thu,  7 Dec 2017 18:42:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vMu10t14mVJvW6kisxV/fO4UiU8=; b=L1pNOO
        fGivMrg81cSlv/idRUFXz1v0Ncul8PQgfYUg+ZN3K+diO6Ot/nTngjFmJMdk5uvN
        NpU81Nb0adhYMz3iZtu/1IoTIcgqm4OIWSYlOwRf27qSc31Y0n6umCRaFlQDCqcQ
        u/KaBBPTnvj3ZPjkXX/biQsLzkp9c2lcLfRI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AqQRYPa8mWO0u6bYLsd6F1vr2Lf6dt/C
        WVWhJQHUIBOGXj9Pi14MyZqMeXksjmYfqmzq9fUiWqHNnOEL/DvGzzELXLSG+bG3
        CUmqo/LnF2wFtWyYvSfmPh9OnTdnuXj1Fl20scQDqCbn16rDDvjPg2AdL1NAQbyf
        ukBOW7VfMOA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11DC0C6717;
        Thu,  7 Dec 2017 18:42:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CEC7C6716;
        Thu,  7 Dec 2017 18:42:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 11/15] serve: introduce git-serve
References: <20171020171839.4188-1-bmwill@google.com>
        <20171204235823.63299-1-bmwill@google.com>
        <20171204235823.63299-12-bmwill@google.com>
Date:   Thu, 07 Dec 2017 15:42:01 -0800
In-Reply-To: <20171204235823.63299-12-bmwill@google.com> (Brandon Williams's
        message of "Mon, 4 Dec 2017 15:58:19 -0800")
Message-ID: <xmqq8teeaywm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39968A74-DBA8-11E7-B19B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +static struct protocol_capability *get_capability(const char *key)
> +{
> +	int i;
> +
> +	if (!key)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
> +		struct protocol_capability *c = &capabilities[i];
> +		const char *out;
> +		if (skip_prefix(key, c->name, &out) && (!*out || *out == '='))
> +			return c;

Looks familiar and resembles what was recently discussed on list ;-)

> +int cmd_serve(int argc, const char **argv, const char *prefix)
> +{
> +
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	/* ignore all unknown cmdline switches for now */
> +	argc = parse_options(argc, argv, prefix, options, grep_usage,
> +			     PARSE_OPT_KEEP_DASHDASH |
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +	serve();
> +
> +	return 0;
> +}
> ...
> +/* Main serve loop for protocol version 2 */
> +void serve(void)
> +{
> +	/* serve by default supports v2 */
> +	packet_write_fmt(1, "version 2\n");
> +
> +	advertise_capabilities();
> +
> +	for (;;)
> +		if (process_request())
> +			break;
> +}

I am guessing that this would be run just like upload-pack,
i.e. invoked via ssh or via git-daemon, and that is why it can just
assume that fd#0/fd#1 are already connected to the other end.  It
may be helpful to document somewhere how we envision to invoke this
program.

