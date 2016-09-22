Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4479D207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 21:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935827AbcIVVXm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 17:23:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54475 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934534AbcIVVXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 17:23:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB78F3F934;
        Thu, 22 Sep 2016 17:23:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wo8HR8kIaxGYNQQhzQg4UVh5JXM=; b=ZZR/8o
        xjgShAt+XZQ+vBrk6OohWKxXv9/N8m60fIF1xKCYk3MUzc9zaDnbp6UTlOEtv0Io
        qPJkJ9e7QrEbzJOWBWDcTqpEQSUecYZaUR2GVPNH5vFEPhO5llnKF6SilpHo3yB7
        LjE60ux8IiNJwG0TsBge83i7OZ2e5nxGv7X+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U8yCIxAjpfJgORApmyOZNwDw9eo8TbUY
        ArkVQFFyW1vKaNnEbujoqe6NDeddOt2P2tTd/DbQKeNGfbmwYDq3QkKbldjhmp0p
        QdwqoHgf7w5rFtH5aAVU9WkpdsjWCIPTYWtocPNR79gxXXXFSoBu7G8scX9XWpt/
        rKsP28JY6Ew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B42983F933;
        Thu, 22 Sep 2016 17:23:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 379663F932;
        Thu, 22 Sep 2016 17:23:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: Re: [PATCH 6/6] builtin/tag: add --format argument for tag -v
References: <20160922185317.349-1-santiago@nyu.edu>
        <20160922185317.349-7-santiago@nyu.edu>
Date:   Thu, 22 Sep 2016 14:23:37 -0700
In-Reply-To: <20160922185317.349-7-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Thu, 22 Sep 2016 14:53:17 -0400")
Message-ID: <xmqqeg4b39ye.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D44FFA4A-810A-11E6-905B-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> @@ -425,8 +431,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		die(_("--merged and --no-merged option are only allowed with -l"));
>  	if (cmdmode == 'd')
>  		return for_each_tag_name(argv, delete_tag);
> -	if (cmdmode == 'v')
> +	if (cmdmode == 'v') {
> +		if (fmt_pretty)
> +			verify_ref_format(fmt_pretty);
>  		return for_each_tag_name(argv, verify_tag);
> +	}

OK, you said something about for_each_ref() in an earlier commit,
but what you meant was this one, which takes each_tag_name_fn.

The function for_each_tag_name(), the type each_tag_name_fn, and the
function of that type verify_tag(), are ALL file-scope static in
this single file, builtin/tag.c.  It seems to me that it is not
necessary to make the format string global at all.

> @@ -425,8 +431,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		die(_("--merged and --no-merged option are only allowed with -l"));
>  	if (cmdmode == 'd')
>  		return for_each_tag_name(argv, delete_tag);
> -	if (cmdmode == 'v')
> +	if (cmdmode == 'v') {
> +		if (fmt_pretty)
> +			verify_ref_format(fmt_pretty);
>  		return for_each_tag_name(argv, verify_tag);
> +	}

There are minor implementation and design issues I spotted, but
overall I think the feature the series attempts to add may be a good
thing to have.

Thanks.
