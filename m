Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7081F461
	for <e@80x24.org>; Thu, 18 Jul 2019 19:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfGRTzR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 15:55:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61917 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfGRTzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 15:55:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F588172B1F;
        Thu, 18 Jul 2019 15:55:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FoaABoTwFLSA5QNYH8Ap7ZccOHE=; b=Kjrsb0
        Y4Qaw1mlQVdtXfAeuZrLXCvtm9b7Qzd3IYvItZIbTTjv/qhNWyVRyF4VC2Fb9X8v
        oUb739DOpSegnPgSzGhBw5t5woa7wywbEi6gNCwXNGEC4xuzhxqgtsc2x92qpPEA
        fiIP4eIoM8XnZvT+v0D+j1fT4a/tSCQFuPDJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w63SgevTL8n810reI2xerseSa4iY7pjL
        MfGvizEBNnlMva7ybDKd0NEOfHGgtHaoS0h+JR+7hg4a6fkZCr9eI5SFZlYklKJM
        a7RUN6NLrNLEB4CrnRJEOatn69xXiIBvDjr7+wZldvF37wsAEKN9C864Qs/7pdZo
        JU96NgQxX9k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87F46172B1E;
        Thu, 18 Jul 2019 15:55:14 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED3CC172B1D;
        Thu, 18 Jul 2019 15:55:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 4/9] sequencer: update `done_nr' when skipping commands in a todo list
References: <20190717143918.7406-1-alban.gruin@gmail.com>
        <20190717143918.7406-5-alban.gruin@gmail.com>
Date:   Thu, 18 Jul 2019 12:55:12 -0700
In-Reply-To: <20190717143918.7406-5-alban.gruin@gmail.com> (Alban Gruin's
        message of "Wed, 17 Jul 2019 16:39:13 +0200")
Message-ID: <xmqqo91rxgm7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F529749C-A995-11E9-9C88-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> In a todo list, `done_nr' is the amount of commands that were executed
> or skipped, but skip_unnecessary_picks() did not update it.

OK.  Together with 3/9 and this one, any increment of total_nr and
done_nr in the existing code is not removed; does it mean that
nobody actually cares what these fields contain?  IOW, there is no
code that says "if (list->total_nr <= i) { we are done; }" etc.?

Or are these fields used later, but somehow the lack of increment in
the places touched by 3/9 and 4/9 is compensated?

> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index e61ae75451..ec9c3d4dc5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4939,6 +4939,7 @@ static int skip_unnecessary_picks(struct repository *r,
>  		MOVE_ARRAY(todo_list->items, todo_list->items + i, todo_list->nr - i);
>  		todo_list->nr -= i;
>  		todo_list->current = 0;
> +		todo_list->done_nr += i;
>  
>  		if (is_fixup(peek_command(todo_list, 0)))
>  			record_in_rewritten(base_oid, peek_command(todo_list, 0));
