Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC5C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 21:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiEWVTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 17:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiEWVTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 17:19:19 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443988D696
        for <git@vger.kernel.org>; Mon, 23 May 2022 14:19:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B13711E29D;
        Mon, 23 May 2022 17:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6wBPHlTTwGGu4ItFRuN9jfowlW24UUefJ0Xrsh
        ATdXo=; b=qnVGmSglUTCaQjSsu4//ZKnm9E+DyDXItc2Cjf5383EE4DEJdYIddd
        3iOBstt7t45TVLKTcc6WNJzOke2ayDCFfQiCwFv+vPSsPBplweluv607FN5DtO6M
        JdA/ZrevUV99WtP1rdSbQkIPaGsGa0wYjJOVV0V7hGja+3QPZe66g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 213EA11E29C;
        Mon, 23 May 2022 17:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8178711E29B;
        Mon, 23 May 2022 17:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v7 26/30] t/helper/hexdump: add helper to print hexdump
 of stdin
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <6f2e935f148e826609153378751c04807858e76c.1653336765.git.gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 14:19:15 -0700
In-Reply-To: <6f2e935f148e826609153378751c04807858e76c.1653336765.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Mon, 23 May 2022
        20:12:41 +0000")
Message-ID: <xmqqk0acosks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 005FF594-DADE-11EC-B2D6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +int cmd__hexdump(int argc, const char **argv)
> +{
> +	char buf[1024];
> +	ssize_t i, len;
> +
> +	for (;;) {
> +		len = xread(0, buf, sizeof(buf));
> +		if (len < 0)
> +			die_errno("failure reading stdin");
> +		if (!len)
> +			break;
> +
> +		for (i = 0; i < len; i++)
> +			printf("%02x ", (unsigned char)buf[i]);
> +	}
> +
> +	return 0;
> +}

It is meant to be consumed by machine, so I do not think we would
mind too much about a single long line, but given that consumers
include "grep", it would probably be better to avoid emitting an
incomplete line, especially since addition of this tool is all about
portability across platforms.

An extra putchar('\n'); after the loop would fix it easily.

Thanks.

> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 0424f7adf5d..88c4b28cdfa 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -38,6 +38,7 @@ static struct test_cmd cmds[] = {
>  	{ "getcwd", cmd__getcwd },
>  	{ "hashmap", cmd__hashmap },
>  	{ "hash-speed", cmd__hash_speed },
> +	{ "hexdump", cmd__hexdump },
>  	{ "index-version", cmd__index_version },
>  	{ "json-writer", cmd__json_writer },
>  	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index c876e8246fb..511f6251bf5 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -29,6 +29,7 @@ int cmd__genzeros(int argc, const char **argv);
>  int cmd__getcwd(int argc, const char **argv);
>  int cmd__hashmap(int argc, const char **argv);
>  int cmd__hash_speed(int argc, const char **argv);
> +int cmd__hexdump(int argc, const char **argv);
>  int cmd__index_version(int argc, const char **argv);
>  int cmd__json_writer(int argc, const char **argv);
>  int cmd__lazy_init_name_hash(int argc, const char **argv);
