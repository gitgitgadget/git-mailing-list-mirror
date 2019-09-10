Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7401F463
	for <e@80x24.org>; Tue, 10 Sep 2019 06:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390749AbfIJGOl (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 02:14:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51286 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732405AbfIJGOl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 02:14:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E488C9748B;
        Tue, 10 Sep 2019 02:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S9V2EHKoewOzZ6ti06QR/yyepmg=; b=q5JfYq
        kCe17+OYPQoRnvksk0PzUFOeUxdCPggynHIPZ6B9HpwDxDdPSHntjhtgx0BCoJMM
        RUeRgbnIVSp+FYfVnOePzvHDzKKESKrv8UwM7AXEx3NK7x5MzhQX/+h+pxxpWHHt
        ilXaUzujwAOTHRY5fDX1e5p0C++s+FO1WC6n8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H5ExvI6Wg3mohWPuTSah9q8TsPgSGQ71
        0toS5SeAftBJXYZBaTaGCc/k7tjpqyq3QrEBnaLQvyz/+Q9IjGxQjpRfERhL80Gy
        sQFo5ilCiRikuQCtruDRwVrcpam9mMdMynFBewSdbLcVAgj3KMdmN0PDn4I75f/k
        BKjwYz2qaSc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9D1E9748A;
        Tue, 10 Sep 2019 02:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05E4797480;
        Tue, 10 Sep 2019 02:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Freese <ericdfreese@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: do not output empty lines
References: <20190910051705.2765-1-ericdfreese@gmail.com>
        <20190910051705.2765-2-ericdfreese@gmail.com>
        <xmqqpnk8heow.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 09 Sep 2019 23:14:33 -0700
In-Reply-To: <xmqqpnk8heow.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 09 Sep 2019 23:02:07 -0700")
Message-ID: <xmqqlfuwhe46.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 435D7598-D392-11E9-BD12-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  	fwrite(final_buf.buf, 1, final_buf.len, stdout);
>> +	if (final_buf.len)
>> +		putchar('\n');
>
> While we are introducing a conditional, let's drop the useless
> fwrite of 0-byte while we are at it [*1*], i.e.
>
> 	if (final_buf.len && !omit_empty_lines) {

Of course, that's a typo for "||"; if it is not empty, we'd emit no
matter what, and if omit_empty is not given, we'd emit whether it is
empty or not.

> 		fwrite(final_buf.buf, 1, final_buf.len, stdout);
> 		putchar('\n');
> 	}



>
> Thanks.
>
>
> [Footnote]
>
> *1* "While we are at it", the existing code tempts me to drop fwrite
>     and replace it with something along the lines of...
>
> 	printf("%*s\n", count, buf)
>
>     but I refrained from doing so.  An enhancement patch like this
>     is not a place to "improve" existing code (which should be done
>     as a separate patch).
