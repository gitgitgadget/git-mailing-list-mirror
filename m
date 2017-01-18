Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C324920756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbdARAT1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:19:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64714 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751418AbdARAT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:19:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA4A2611D7;
        Tue, 17 Jan 2017 19:19:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZZ+81irJNo3FTed5n3LZcvW9tpA=; b=O6u6BX
        xOV0jWufc2wBv5jSREM3TqqmtGu8tLaUzUVjuwMUFRzeWbB9vlq+Z5DOnxiYtOq3
        9pLAYv7RZd/3WGy/ZfcXLRkXp4SnHbtWdQ9+OiOvWKHDGi9Apuo0X/bWm59RbFLB
        N+FuYgCFfQ+x0Ej/vJzHs3OwGTRCi2jfbjVUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I5MP8Y9esbOwP0AVyRPJMQuKPy2MfzhW
        vN0kAdY16n9O8sTGeqNUzo6KYqLDipWVwePcwuup2egPMNFTh8Q1V7Ec+i6EbrEe
        j6rNzi+7QcnWMZtkk/5qcZTiQZ3JCSKbsFgS0y90nA7+KsHv2CzI1Xzl6HF0NWfB
        quRQoXN+DcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D19B8611D6;
        Tue, 17 Jan 2017 19:19:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F454611D2;
        Tue, 17 Jan 2017 19:19:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
References: <20170117233723.23897-1-santiago@nyu.edu>
        <20170117233723.23897-5-santiago@nyu.edu>
Date:   Tue, 17 Jan 2017 16:19:24 -0800
In-Reply-To: <20170117233723.23897-5-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Tue, 17 Jan 2017 18:37:21 -0500")
Message-ID: <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C487E84C-DD13-11E6-BC38-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> @@ -428,9 +443,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (filter.merge_commit)
>  		die(_("--merged and --no-merged option are only allowed with -l"));
>  	if (cmdmode == 'd')
> -		return for_each_tag_name(argv, delete_tag);
> -	if (cmdmode == 'v')
> -		return for_each_tag_name(argv, verify_tag);
> +		return for_each_tag_name(argv, delete_tag, NULL);
> +	if (cmdmode == 'v') {
> +		if (format)
> +			verify_ref_format(format);
> +		return for_each_tag_name(argv, verify_tag, format);
> +	}

This triggers:

    builtin/tag.c: In function 'cmd_tag':
    builtin/tag.c:451:3: error: passing argument 3 of
    'for_each_tag_name' discards 'const' qualifier from pointer target type [-Werror]
       return for_each_tag_name(argv, verify_tag, format);

Either for-each-tag-name's new parameter needs to be typed
correctly, or the type of the "format" variable needs to be updated.
