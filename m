Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35D251F461
	for <e@80x24.org>; Tue, 23 Jul 2019 21:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392013AbfGWVVU (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 17:21:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63913 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfGWVVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 17:21:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 984017707F;
        Tue, 23 Jul 2019 17:21:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4DsdkhCGRme9
        lI0FMMptFVfgBo4=; b=LjoWJvAtagxOa4YWTBc3qFQ3KjyT2efIV1HTW9EVkp8F
        3tmlFAbzV8YuIAmYaWAZpKleEDrwZfMYhAx7Ajq7HVdoqrqgZaZlk5fbydDP3jyP
        Le7UJhVnTZI4edj8/syW8wF9t5Ns9PJl3hlpYfV/tkgPIpRUvQwAfVewhOSGDXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JyoupK
        UuY4eitEa+lyb6RHITwl855KKU1UVENVUS+A7t31Q300MZj6jwzB8eLT6VGU1HjH
        y20kSrGtrcx4dOnaWSVZv01NY2HzEbMLjGBD4Z5fudL6+YUotvjNfIHo+3bZl2aD
        k7Yz0+qxzStqFulmRmxhoT1jN9e3EFLquqbzs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F24E7707E;
        Tue, 23 Jul 2019 17:21:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C034C7707B;
        Tue, 23 Jul 2019 17:21:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Matt Turner <mattst88@gmail.com>, git@vger.kernel.org,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH] archive: Store checksum correctly
References: <20190723025736.23036-1-mattst88@gmail.com>
        <xmqqd0i0u253.fsf@gitster-ct.c.googlers.com>
        <14410e00-4701-40d0-6960-e481fea50ed0@web.de>
Date:   Tue, 23 Jul 2019 14:21:12 -0700
In-Reply-To: <14410e00-4701-40d0-6960-e481fea50ed0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 23 Jul 2019 21:38:47 +0200")
Message-ID: <xmqqef2gsb07.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CD50053C-AD8F-11E9-B6AB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> Wow.  The choice of %07o is as old as the very original of tar-tree
>> implementation in our codebase, starting at ae64bbc1 ("tar-tree:
>> Introduce write_entry()", 2006-03-25).
>
> Actually it's already in 731ab9ccf2 ("[PATCH] create tar archives of
> tree on the fly", 2005-04-28).

Yup, after viewing "git show ae64bbc1" I found out the commit added
a new helper to do %07o without touching the existing one that did
the same.  Problem with relying on "git blame" too much X-<.

>> I think the updated behaviour matches Wikipedia [*1*] where it
>> spells out that 6 octal is followed by a NUL and a SP; it also says
>> various implementations do not adhere to this format---perhaps they
>> meant us ;-)
>
> OpenBSD's pax(1) does the same if I read
> https://github.com/openbsd/src/blob/master/bin/pax/tar.c correctly.

What's more interesting is that their verifier in tar_id() compares
the ulong value read from textual checksum with the ulong value
computed.  I agree with you that it would be the more robust way
than what is done by squshfs tools (ng).
