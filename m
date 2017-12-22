Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2BF51F406
	for <e@80x24.org>; Fri, 22 Dec 2017 20:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756257AbdLVUtq (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 15:49:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63670 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755941AbdLVUtq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 15:49:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C1BDBEBA8;
        Fri, 22 Dec 2017 15:49:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AeZfhIg47T4Le2sZ8Xif5QOdLjs=; b=eMkgmp
        V44udc3DATRcixkdp4ivOMN9v2kr/fm36PMgdI2RoStq5HZK9lgF5eVMPpGFkeIl
        ERkuLiwIsuDaxGd5iVCBDih/BB6KxtcKvBaOMMklZ08XMuqWBQTLkz3WWP4OsJxa
        X/Ff8hc8tTkof8oZbIn6fNEuQumoGNZBf242E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iqvTm9cGbbKKnXRZDck6UKM3bxYGxaZ3
        nWI5ENGF7/IhDMLa2a3XH7rVYI1ENV/gY/PXhzAWBuY9f0jwAYuAFsN1meJiC8wN
        cR0qXpvyJsLNcgezVm8udKP1eq/VpjWg/oaDluzTw7mwvPWPfvsNioAWpYF42GHo
        94aEjfmds24=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74E1FBEBA1;
        Fri, 22 Dec 2017 15:49:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E975CBEBA0;
        Fri, 22 Dec 2017 15:49:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dave Borowitz <dborowitz@google.com>
Cc:     git@vger.kernel.org, jrn@google.com
Subject: Re: [PATCH] config.txt: Document behavior of backslashes in subsections
References: <20171221131042.91107-1-dborowitz@google.com>
Date:   Fri, 22 Dec 2017 12:49:43 -0800
In-Reply-To: <20171221131042.91107-1-dborowitz@google.com> (Dave Borowitz's
        message of "Thu, 21 Dec 2017 08:10:42 -0500")
Message-ID: <xmqq8tduqyhk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A41F305A-E759-11E7-815D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Borowitz <dborowitz@google.com> writes:

> Unrecognized escape sequences are invalid in values:
>
>   $ git config -f - --list <<EOF
>   [foo]
>     bar = "\t\\\y\"\u"
>   EOF
>   fatal: bad config line 2 in standard input
>
> But in subsection names, the backslash is simply dropped if the
> following character does not produce a recognized escape sequence:
>
>   $ git config -f - --list <<EOF
>   [foo "\t\\\y\"\u"]
>     bar = baz
>   EOF
>   foo.t\y"u.bar=baz
>
> Although it would be nice for subsection names and values to have
> consistent behavior, changing the behavior for subsection names is a
> nonstarter since it would cause existing, valid config files to
> suddenly be interpreted differently.
>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---
>  Documentation/config.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Thanks.

>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b18c0f97fe..f772186c44 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -41,11 +41,13 @@ in the section header, like in the example below:
>  --------
>  
>  Subsection names are case sensitive and can contain any characters except
> -newline (doublequote `"` and backslash can be included by escaping them
> -as `\"` and `\\`, respectively).  Section headers cannot span multiple
> -lines.  Variables may belong directly to a section or to a given subsection.
> -You can have `[section]` if you have `[section "subsection"]`, but you
> -don't need to.
> +newline and the null byte. Doublequote `"` and backslash can be included
> +by escaping them as `\"` and `\\`, respectively. Backslashes preceding
> +other characters are dropped when reading; for example, `\t` is read as
> +`t` and `\0` is read as `0` Section headers cannot span multiple lines.
> +Variables may belong directly to a section or to a given subsection. You
> +can have `[section]` if you have `[section "subsection"]`, but you don't
> +need to.
>  
>  There is also a deprecated `[section.subsection]` syntax. With this
>  syntax, the subsection name is converted to lower-case and is also
