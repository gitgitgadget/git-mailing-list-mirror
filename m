Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564F21F454
	for <e@80x24.org>; Mon, 11 Nov 2019 02:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfKKCee (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 21:34:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52072 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfKKCee (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 21:34:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1935182AD3;
        Sun, 10 Nov 2019 21:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1YxlkHnToEYEshDHh+1wvUvTUS8=; b=s9yoPS
        X881hYwJPzmeyQEH35OlH7AfqW4agJq679S3PbzfNNNBYoiIVF7rxoggATX3Lbnl
        ZGyCETAVJ82xXlXY9YTj35Uw3RVfPMLpLKf4KWc/gqJ8dQ7Usmqc9w6b3Jng6n1Y
        MFS4LxoBUBANOrG1varAZOeKGJqByznXmlE+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JmQpb4/584WFZGlUxatrrco3TmS+/aFZ
        VbnEdgMidd3/eviKlegWFC0dLLUipqnIKhqKaiCOXHLxdWtMoRjpR8hjxOcLilOa
        VkPK9Msk0mQ1pGq71szOUNxZdHgYnp4oP0JMWK7cqMIerf9+hQShBh+SFt52tGqi
        07Uk9luuT+s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1238B82AD2;
        Sun, 10 Nov 2019 21:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4050082ACE;
        Sun, 10 Nov 2019 21:34:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] bundle: framework for options before bundle file
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
        <20191110204126.30553-1-robbat2@gentoo.org>
Date:   Mon, 11 Nov 2019 11:34:26 +0900
In-Reply-To: <20191110204126.30553-1-robbat2@gentoo.org> (Robin H. Johnson's
        message of "Sun, 10 Nov 2019 12:41:24 -0800")
Message-ID: <xmqqlfsni1jh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9222E34-042B-11EA-B21A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> +static int verbose;
> +
> +static int parse_options_cmd_bundle(int argc,
> +		const char **argv,
> +		const char* prefix,
> +		const char * const usagestr[],
> +		const struct option options[],
> +		const char **bundle_file) {
> +	int newargc;
> +	newargc = parse_options(argc, argv, NULL, options, usagestr,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (argc < 1)
> +		usage_with_options(usagestr, options);
> +	*bundle_file = prefix_filename(prefix, argv[0]);
> +	return newargc;
> +}

Looks like a useful helper to be shared among subcommands.

> +static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	const char* bundle_file;
> ...
> +int cmd_bundle(int argc, const char **argv, const char *prefix)
> +{
> +	struct option options[] = {
> +		OPT__VERBOSE(&verbose, N_("be verbose; must be placed before a subcommand")),
> +		OPT_END()
> +	};
> +	int result;
> +
> +	argc = parse_options(argc, argv, prefix, options, builtin_bundle_usage,
> +		PARSE_OPT_STOP_AT_NON_OPTION);

Looks like a reasonable arrangement for two-level option parser.
