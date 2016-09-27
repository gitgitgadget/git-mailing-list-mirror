Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6760220986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934732AbcI0UB3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:01:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62812 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934274AbcI0UB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:01:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C11F3E9CC;
        Tue, 27 Sep 2016 16:01:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W8mnO8FB/FN6X72eACjxE1hy+0k=; b=AkJJ7S
        nA2OhvL/liqv5UBhUmITd1afYYnEjvuk5MNaPrQje0qmpe+0lIjmbb3QbqkFyugn
        RxvrfBrSUU2kHR1GdoHt7rFst4uvVumTezad38sGfjqRyKXHCQg6j0sA9VQiBfvF
        ZFjc3i+aVSZfeI09YlsSWRLdZ95BBw8KKajjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cdohQT4DR4s69tYrUjLnmU/dypfMWyeT
        iboUCbB8ABeA1WSf+X5REVHd1Bfc4hW/cX5QMCzV2B98tvCUFkisKMp/Mj+c2cOo
        5CbZXcufHiI20j69MTFHeoLZ3IPAK3hQcdE6cxSXpriVDsFb6977IYtbSWko6pBs
        ppnlANIw49M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 531623E9CB;
        Tue, 27 Sep 2016 16:01:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7A313E9CA;
        Tue, 27 Sep 2016 16:01:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4 v4] ls-files: add pathspec matching for submodules
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-5-git-send-email-bmwill@google.com>
Date:   Tue, 27 Sep 2016 13:01:23 -0700
In-Reply-To: <1474930003-83750-5-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 26 Sep 2016 15:46:43 -0700")
Message-ID: <xmqq1t05nmcs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BCC58C8-84ED-11E6-B58B-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> -	/* Find common prefix for all pathspec's */
> -	max_prefix = common_prefix(&pathspec);
> +	/*
> +	 * Find common prefix for all pathspec's
> +	 * This is used as a performance optimization which unfortunately cannot
> +	 * be done when recursing into submodules
> +	 */
> +	if (recurse_submodules)
> +		max_prefix = NULL;
> +	else
> +		max_prefix = common_prefix(&pathspec);
>  	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;

I still wonder if we can do better than this, as this would be a big
cycle-saver especially in recurse-submodules case.

When you get max_prefix that is "a/b/c", there are three cases:

 * a/b/c is a path prefix for an entry in the index, e.g. a/b/c/d;
   you then can safely use it and you do not have to do any
   recursive invocation of ls-files outside "a/b/c".  You may match
   a/b/c/d in the toplevel, or you may recurse a/b/c/e that is a
   submodule, but you won't have to pay attention to submodules
   outside.

 * a leading path of a/b/c, e.g. a/b, is a gitlink or a blob in the
   index; you can use a/b and you only have to recurse into a/b if
   that is a submodule; if a/b is a blob, you'd show nothing.

 * a/b/c itself and no leading path of it appears in the index; you
   know that nothing will match once you know that you are in this
   situation.

Because a gitlink "a/b" sorts at the same location in the index as a
regular blob "a/b" would, by feeding the max_prefix common_prefix()
gives you (i.e. "a/b/c") to index_name_pos() to see which one of the
three situations you are in can be done fairly cheaply, I would
think.  The index_name_pos() call may find "a/b/c" exactly (case 1),
or return a location where "a/b/c" would be inserted in the list of
existing entries.  If there were "a/b" (or "a") in the index, there
wouldn't be any "a/b/x" (or "a/x") at the same time, so a query for
"a/b/c" would land you next to (just after) an existing entry that
is a leading path of it, if such an entry exists, no?  That would
allow you to tell case 2 above fairly cheaply, I would expect.

It is a separate issue if adding that support to 4/4 is a good idea;
I personally think doing it as a separate follow-up patch would make
more sense, so all of the above is tangent.

