Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EF91F461
	for <e@80x24.org>; Mon, 13 May 2019 22:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfEMWct (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:32:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53174 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMWct (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:32:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EB0F6C863;
        Mon, 13 May 2019 18:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rnvTcEP/p1HRZQDkFvr9dDtSysM=; b=mBHp8M
        nmGE6Y2FODGhEbt5az2Ll9sotU5V5BbNFl/7KDKUs+g/wKTigZJaAsm4RJPJ6tDi
        8KwTQK53iEmcarm5URb64t2rv1QBw2oBb5YCd+Zhgylq54JUuKWEqU4FboVtPvrb
        o28S8rFHthuITL1m1arHpPfnVnYDF83LWcuLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jm4/onQGfRbQaVmLUekldyPawdyGGYpT
        JSNGcscmTqu6qXgqwsuBWKgOBcgsXgrHOYaLHi+VM1B7do3xR1gk6o17tXveEP9F
        m4pfZPvc60hCGQkZrUzlkrZfE38o3AQ53vZGdw8kTQ2qNPpJOBSUl2DbeiPgxmRk
        IVuy2oMHuqg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 456E76C862;
        Mon, 13 May 2019 18:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 741076C861;
        Mon, 13 May 2019 18:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 5/5] fast-export: do automatic reencoding of commit messages only if requested
References: <20190510205335.19968-1-newren@gmail.com>
        <20190513164722.31534-1-newren@gmail.com>
        <20190513164722.31534-6-newren@gmail.com>
Date:   Tue, 14 May 2019 07:32:42 +0900
In-Reply-To: <20190513164722.31534-6-newren@gmail.com> (Elijah Newren's
        message of "Mon, 13 May 2019 09:47:22 -0700")
Message-ID: <xmqq5zqeastx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06D68BBC-75CF-11E9-B359-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +static int parse_opt_reencode_mode(const struct option *opt,
> +				   const char *arg, int unset)
> +{
> +	if (unset || !strcmp(arg, "abort"))
> +		reencode_mode = REENCODE_ABORT;
> +	else if (!strcmp(arg, "yes") || !strcmp(arg, "true") || !strcmp(arg, "on"))
> +		reencode_mode = REENCODE_YES;
> +	else if (!strcmp(arg, "no") || !strcmp(arg, "false") || !strcmp(arg, "off"))
> +		reencode_mode = REENCODE_NO;

Don't duplicate the logic; find existing callers of git_parse_maybe_bool(),
learn what they are using the helper for and mimic them, perhaps?
