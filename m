Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0211F461
	for <e@80x24.org>; Thu, 18 Jul 2019 19:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390915AbfGRTwT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 15:52:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63370 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfGRTwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 15:52:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9489815A669;
        Thu, 18 Jul 2019 15:52:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OlsYBfcNevqAFB1YyxJM5rkdVi0=; b=ivi6ne
        ZjVL9+PjQQCYfdDERUNO5v8wRUPE4PUmCu/KhppSekYZUNr8skaLBhzjVsh+4vZe
        DT1fe9Q+oubmY0IMcIC2Zy9qzGUF+bCw+3+JxcAp0qOWi+dSyTU1qGdH0rcqdZ0R
        cQ178HOwwdcUtSIrnSuW06H6x6RPKRx6K48T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bugHb0Ftp8hM/+eCL39NISLctu8LwTct
        k4Tlj0qlg9lfMZnmcPvTOnVwTpjsc70AOd2pfN4bcEszuFHniEe7wv7TTl+3GBiy
        1o7rLrIqvX2Nawqmt7Y7XWtC+eZEEfVkCQJzJ2Km6S4KF5XD8r1iaoExOYXkUpvr
        8Z/bDQLhDPI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A50715A668;
        Thu, 18 Jul 2019 15:52:14 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02DF215A667;
        Thu, 18 Jul 2019 15:52:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 3/9] sequencer: update `total_nr' when adding an item to a todo list
References: <20190717143918.7406-1-alban.gruin@gmail.com>
        <20190717143918.7406-4-alban.gruin@gmail.com>
Date:   Thu, 18 Jul 2019 12:52:13 -0700
In-Reply-To: <20190717143918.7406-4-alban.gruin@gmail.com> (Alban Gruin's
        message of "Wed, 17 Jul 2019 16:39:12 +0200")
Message-ID: <xmqqsgr3xgr6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89E5DBF8-A995-11E9-8D1C-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> `total_nr' is the total amount of items, done and toto, that are in a

"amount" -> "number" perhaps.  Also s/toto/todo/ perhaps but I am
not sure what you wanted to say here, so...

> todo list.  But unlike `nr', it was not updated when an item was
> appended to the list.

Good finding.

>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index cf262701e8..e61ae75451 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo_list)
>  static struct todo_item *append_new_todo(struct todo_list *todo_list)
>  {
>  	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
> +	++todo_list->total_nr;

When we do not use the value in an expression, we prefer post
increment, not pre increment.

>  	return todo_list->items + todo_list->nr++;
>  }
