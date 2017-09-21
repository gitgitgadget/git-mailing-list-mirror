Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9E1520A29
	for <e@80x24.org>; Thu, 21 Sep 2017 05:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdIUFKK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 01:10:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61978 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751068AbdIUFKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 01:10:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3E63A8B5F;
        Thu, 21 Sep 2017 01:10:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UrPyKA2PzJtWc0PfgWW3rHrjjik=; b=Dgcgc4
        qjqoCyGSBcn5qkwgdoYhbRVjznTDiRkg5n7+mFElqTiDSomKHCEyF7X/Vi24EaA3
        43xx0nQev6XGJjcqGn7yN90gp7RkhXY7aL5ifbeeiAWN6LYEagfYbTlkOougzmJC
        AiUqE1GyOHEzqa7G/z44E+0NDvm+E6JZKE0Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q4n8DIg/rRgpz9P2PtdQKUvaDe/IjtSe
        FViwHpPk6Sq0U7ZiIHk0iLwA8b9vMI0KGgq0curjO3SXWiYsYwbKtnHTG3Ku7FZf
        9PayxLPsXNbY6r7exT/fw/cH3areeS+hI4qNqY1vCnq913EpI5N7qc5NjnDwZePZ
        OBVuvY++prU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB046A8B5E;
        Thu, 21 Sep 2017 01:10:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 442CAA8B5D;
        Thu, 21 Sep 2017 01:10:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] revision: replace "struct cmdline_pathspec" with argv_array
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
        <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
        <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
        <20170920224826.GH27425@aiede.mtv.corp.google.com>
        <20170921030424.akqaou7tqj2updgr@sigill.intra.peff.net>
        <20170921044112.GB91069@aiede.mtv.corp.google.com>
Date:   Thu, 21 Sep 2017 14:10:06 +0900
In-Reply-To: <20170921044112.GB91069@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 20 Sep 2017 21:41:12 -0700")
Message-ID: <xmqq7ewsljrl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2300697E-9E8B-11E7-8ED0-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/pathspec.c b/pathspec.c
> index e2a23ebc96..cdefdc7cc0 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -526,10 +526,6 @@ static void NORETURN unsupported_magic(const char *pattern,
>  	    pattern, sb.buf);
>  }
>  
> -/*
> - * Given command line arguments and a prefix, convert the input to
> - * pathspec. die() if any magic in magic_mask is used.
> - */
>  void parse_pathspec(struct pathspec *pathspec,
>  		    unsigned magic_mask, unsigned flags,
>  		    const char *prefix, const char **argv)
> diff --git a/pathspec.h b/pathspec.h
> index 60e6500401..6420d1080a 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -70,6 +70,13 @@ struct pathspec {
>   */
>  #define PATHSPEC_LITERAL_PATH (1<<6)
>  
> +/*
> + * Given command line arguments and a prefix, convert the input to
> + * pathspec. die() if any magic in magic_mask is used.
> + *
> + * Any arguments used are copied. It is safe for the caller to modify
> + * or free 'prefix' and 'args' after calling this function.
> + */
>  extern void parse_pathspec(struct pathspec *pathspec,
>  			   unsigned magic_mask,
>  			   unsigned flags,

Obviously the extra text is better than not having any, but I
somehow found "Any arguments used" a bit unsatisfactory.  magic_mask
and flags are probably also copied ;-) but I wonder if *pathspec is
also copied?  The second sentence that singles out 'prefix' and 'args'
helps to remove such a confusion from a clueless reader like me, and
makes me wonder if can take advantage of the existence of them in a
more direct way.

	It is safe for the caller to modify or free 'prefix' and
	'args' after calling this function, as copies of them are
	stored in the pathspec structure.

or something like that, perhaps.  Adding "(which is freed by calling
clear_pathspec())" at the end might even better, as that function
does not currently have any docstring.

