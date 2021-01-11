Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC0FC433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 20:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41EA2054F
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 20:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404070AbhAKUMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 15:12:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50155 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390366AbhAKUMs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 15:12:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEF3B931F4;
        Mon, 11 Jan 2021 15:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BLPg+tjwPM/eBqO3EeIdJCyYnrw=; b=Yz5QA5
        0ESl+joqRwBCkIwEeWpzBgxABUzIKGKVSmCG55g9nSLpbS1G+B/7J4F45udb2EZF
        q81/n0CbA3FaO9ZLUGioZaOGIb/7+yNdz+KRjcWEURsqE/igdpR29NmqCmF10rxw
        SF/yqNzOndff36f+9mib7ngBHvnCRuNO/kJIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CA8X1HB70EOM1nuUkTPstI1Zbe9o/Af8
        GZmdt8+WqC72eakWQRr+58jGTF4QhMXedQbhDcrpIU46IF5z/FQY7Ea4OqMKWWYs
        4H7qm0W+emhENrXgW7VoGMgbeslkxpOOA7Lgs/5FBsCMjlziYGk3OWYK8ZOyvt2e
        u9ofKxiL5xE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7D0E931F3;
        Mon, 11 Jan 2021 15:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13895931F1;
        Mon, 11 Jan 2021 15:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v5 2/3] bundle: lost objects when removing duplicate
 pendings
References: <xmqqbldxg466.fsf@gitster.c.googlers.com>
        <20210110143019.5625-3-worldhello.net@gmail.com>
Date:   Mon, 11 Jan 2021 12:12:05 -0800
In-Reply-To: <20210110143019.5625-3-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 10 Jan 2021 09:30:18 -0500")
Message-ID: <xmqqwnwj6xnu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46BBE39E-5449-11EB-8184-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>  /*
> - * Return true iff array already contains an entry with name.
> + * Return true if array already contains an entry.
>   */

I think the original deliberately spells "if and only if", but a
natural reading of "return true if X" would be "this would never
return true if not X", so perhaps the above change is OK.

> -static int contains_name(struct object_array *array, const char *name)
> +static int contains_object(struct object_array *array,
> +			   const struct object *item, const char *name)
>  {
>  	unsigned nr = array->nr, i;
>  	struct object_array_entry *object = array->objects;
>  
>  	for (i = 0; i < nr; i++, object++)
> -		if (!strcmp(object->name, name))
> +		if (item == object->item && !strcmp(object->name, name))
>  			return 1;
>  	return 0;
>  }
> @@ -432,7 +433,8 @@ void object_array_remove_duplicates(struct object_array *array)
>  
>  	array->nr = 0;
>  	for (src = 0; src < nr; src++) {
> -		if (!contains_name(array, objects[src].name)) {
> +		if (!contains_object(array, objects[src].item,
> +				     objects[src].name)) {
>  			if (src != array->nr)
>  				objects[array->nr] = objects[src];
>  			array->nr++;
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index 637cdb5a8e..5c9d5ed94d 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -169,7 +169,7 @@ test_expect_success 'setup' '
>  	test_commit_setvar P "Commit P" main.txt
>  '
>  
> -test_expect_failure 'create bundle from special rev: main^!' '
> +test_expect_success 'create bundle from special rev: main^!' '
>  	git bundle create special-rev.bdl "main^!" &&
>  
>  	git bundle list-heads special-rev.bdl |
n
