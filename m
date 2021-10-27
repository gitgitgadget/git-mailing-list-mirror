Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A2C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD7F610A6
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJ0Vqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 17:46:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51402 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0Vqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 17:46:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5C4AF133B;
        Wed, 27 Oct 2021 17:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k55YVCMKZIV8w+lHuHWhxJl06e0xcl/L7WIlHJ
        5JQq8=; b=jygiauS9MkClxyd7z91GxxScq5dtGtb8Y8/nhBZiNGwaDrzxfNWWWI
        kPkKmY20TJK2eQKwI9Ypjd0oQqKS5LLk0YnZOOb0jAMQbm/okMCK8p3ydMbyVwE8
        sul+umIHh0Rfvi2BjoOUqo8fHrA9P9C7lrjqqUR2ICF+GREGBr5dE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD9F0F133A;
        Wed, 27 Oct 2021 17:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D5EEF1339;
        Wed, 27 Oct 2021 17:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, Ivan Frade <ifrade@google.com>
Subject: Re: [RFC PATCH 1/1] protocol-v2.txt: align delim-pkt spec with usage
References: <20211027193501.556540-1-calvinwan@google.com>
        <20211027193501.556540-2-calvinwan@google.com>
Date:   Wed, 27 Oct 2021 14:44:01 -0700
In-Reply-To: <20211027193501.556540-2-calvinwan@google.com> (Calvin Wan's
        message of "Wed, 27 Oct 2021 19:35:01 +0000")
Message-ID: <xmqq7ddyuori.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0086EDA6-376F-11EC-8B4E-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> move delim-pkt from command-args to command-request

That is something we can read from the patch text.  Can we explain
what it means to the human readers?  Let's read on the patch.

> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Reported-by: Ivan Frade <ifrade@google.com>

These are reversed, aren't they?  Chronologically what happened?
Ivan reported, you wrote a patch, and then you signed it off before
sending, no?  Please align the order of the events with the order of
the trailer lines.

> ---
>  Documentation/technical/protocol-v2.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 21e8258ccf..1e75863680 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -125,11 +125,11 @@
>      empty-request = flush-pkt
>      command-request = command
>  		      capability-list
> -		      [command-args]
> +			  delim-pkt
> +		      command-args

Are these meant to be unaligned like this?  In this project, a HT
always jumps to the next multiple-of-8 column.

>  		      flush-pkt
>      command = PKT-LINE("command=" key LF)
> -    command-args = delim-pkt
> -		   *command-specific-arg
> +    command-args = *command-specific-arg

OK, so we used to say, after the capability list, there may be
a command-args, or no command-args.  And a command-args begins
with a delim-pkt followed by zero or more command specific args.

We now say after the capability list, there always is a delim-pkt
and zero or more command specific args will follow.

So, the difference (fix) is that the original production allowed a
command-request that ends with capability list (without a final
delim-pkt), but we require delim-pkt after capability-list, whether
there is any command-specific-args?

If so, perhaps the human-readable rewrite of the proposed log
message would be

    The current protocol EBNF allows command-request to end with the
    capability list, if no command specific arguments follow, but
    the protocol requires that after the capability list, there must
    be a delim-pkt regardless of the number of command speficic
    arguments.  Fix the EBNF to match.

By the way, what are we matching this document to with this change?
Our over-the-wire protocol implementation?  I am asking because it
would mean that we may be retroactigvely changing the rules under
other implementations, making what used to be allowed now invalid.

