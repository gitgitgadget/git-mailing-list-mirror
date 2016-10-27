Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660A12022A
	for <e@80x24.org>; Thu, 27 Oct 2016 00:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935044AbcJ0AQq (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 20:16:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53871 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932332AbcJ0AQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 20:16:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41A184B262;
        Wed, 26 Oct 2016 20:16:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cp+pLpXpj53Ad6OjUXIwBnV/z6A=; b=oZt6Dk
        WY2SjUGpmF/qy7LSgsHq2dFXnONeVDt8XQkmDyt/4qO8LhCkYZYkVH/Teq3JWMfq
        kZt5SjdfnJqNzZqgcAyCyZMySxPX3CONlXO1KMlHNexO+oHcQCQN2tj+Xe+26W5L
        5cB6wVyVgwzEs3H4gtK0WAR6YGFJxHbtmtU7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZEBXRwkhsf+G7rfWZIwn40+o8ZLOgiyT
        cNk7JKjExu+W9q4gmUPOOBdMOf83zw0TWQxcfz+p4r1UFaETeeeuc/yryt4nHZvk
        Fv5quXCbqtYfZ75KA7WngkFrhvarUjnFObcZW44qi/teW0oGvIApxCfQbKfc7byW
        Z23L2z0oCWA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 390F04B261;
        Wed, 26 Oct 2016 20:16:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9AD14B260;
        Wed, 26 Oct 2016 20:16:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCHv2 1/2] attr: convert to new threadsafe API
References: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
        <20161026224104.31844-1-sbeller@google.com>
        <xmqqoa26aek6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaR4DddoHQNUUvRAY=_PK5qqS=ws_Wkfa-EXT2seN5b=A@mail.gmail.com>
Date:   Wed, 26 Oct 2016 17:16:41 -0700
In-Reply-To: <CAGZ79kaR4DddoHQNUUvRAY=_PK5qqS=ws_Wkfa-EXT2seN5b=A@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Oct 2016 17:08:14 -0700")
Message-ID: <xmqqfuniabo6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3FC02FE-9BDA-11E6-A92C-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +* Allocate an array of `struct git_attr_result` either on the stack
> +  or via `git_attr_result_alloc` on the heap when the result size
> +  is not known at compile time. The call to initialize
>    the result is not thread safe, because different threads need their
>    own thread local result anyway.

Do you want to keep the last sentence?  "The call to initialize the
result is not thread safe..."?  Is that true?

> @@ -103,7 +105,7 @@ To see how attributes "crlf" and "ident" are set
> for different paths.
>          const char *path;
>          struct git_attr_result result[2];
>
> -        git_check_attr(path, check, result);
> +        git_check_attr(path, &check, result);

What's the point of this change?  Isn't check typically a pointer
already?

