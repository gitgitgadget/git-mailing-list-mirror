Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F56C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0C420756
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 21:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l2ELzOML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgIMV4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 17:56:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51602 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIMV4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 17:56:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC9E1FB73B;
        Sun, 13 Sep 2020 17:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Dcsf37wv5hO8ggXa4F3C9Ru/Sc=; b=l2ELzO
        MLC2wndh3o9Kybgh+MLWv80/8I/fpnDKpkHudiTkPXOwUTzCfxwKoHDdZcHCYj4H
        V/ZF51Zc+Rx97faTJMxxkpBQoohGMzbcp6cxvfkJ4Nug3it61HHX0eWZ+uwrKpzY
        9aW50pCGqatG9uDqzb0vGhJ1b4BGxsMGgwfIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VDhwh8wyCdMU3m1LrRwXeEXbz301K9n+
        2y60S7ofkF0Hk01riwuQQ9W9lyUfiIrAn8FvscuvVBUNpM3ALB7NXp2wWiqfHP21
        qXRnd0aTDKTiOKbkUXgmW4tZhGar8xJcyQzKexjWq1km8LptuLkec7Q7lL+Mbzb+
        egKHgk4ZkW8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5784FB73A;
        Sun, 13 Sep 2020 17:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C471FB739;
        Sun, 13 Sep 2020 17:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Aaron Lipman <alipman88@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] ref-filter: allow merged and no-merged filters
References: <20200911185754.64173-3-alipman88@gmail.com>
        <20200913193140.66906-1-alipman88@gmail.com>
        <20200913193140.66906-4-alipman88@gmail.com>
        <CAPig+cTNp84Dm=0n-Bb9o=1nZNDFRE20XDWUPJT8yjdefv15rA@mail.gmail.com>
Date:   Sun, 13 Sep 2020 14:56:36 -0700
In-Reply-To: <CAPig+cTNp84Dm=0n-Bb9o=1nZNDFRE20XDWUPJT8yjdefv15rA@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 13 Sep 2020 17:36:39 -0400")
Message-ID: <xmqqo8m9mjcb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF9FAA36-F60B-11EA-B110-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       struct commit_list *check_reachable_list = reachable ?
>> +               ref_cbdata->filter->reachable_from :
>> +               ref_cbdata->filter->unreachable_from;
>> +
>> +       if (!check_reachable_list)
>> +               return;
>
> Rather than adding a boolean 'reachable' parameter to the function
> signature, you could instead directly pass in the `struct commit_list
> *` upon which to operate, which would allow you to drop the ternary
> operator here, and...
>
>> @@ -2322,8 +2337,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>> -       if (filter->merge_commit)
>> -               do_merge_filter(&ref_cbdata);
>> +       do_merge_filter(&ref_cbdata, 1);
>> +       do_merge_filter(&ref_cbdata, 0);
>
> ... make the callers a bit less opaque by eliminating the
> less-than-meaningful 0-or-1, and making it obvious which list is being
> consulted:
>
>     do_merge_filter(&ref_cbdata, ref_cbdata->filter->reachable_from);
>     do_merge_filter(&ref_cbdata, ref_cbdata->filter->unreachable_from);


There is this code in do_merge_filter(), though.

		if (is_merged == reachable)
 			array->items[array->nr++] = array->items[i];
 		else
 			free_array_item(item);

This is a body of the loop that runs over (surviving) tips of ref,
after painting the commits from the tips of refs (interesting) and
the [un]reachable_from commits (uninteresting).  The temporary
variable is_merged signals if the tip after revision walk is painted
uninteresting, i.e. some of the [un]reachable_from commits reach the
tip.

If 'reachable' and 'is_merged' are the same, that means either

 (1) the tip is reachable from some commit given as --merged
     <commit>; or

 (2) the tip is NOT reachable from any commit given as --no-merged
     <commit>

which means it survives this round of filtering.

By losing the 'reachable' bit, you make this switch impossible.

I do not mind making the 0/1 a symbolic constant between
do_emreg_filter() and filter_refs() for enhanced readability,
though.

Thanks.
