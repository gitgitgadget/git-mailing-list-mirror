Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1147C433DF
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 06:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E482073E
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 06:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FbInPk9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGFGj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 02:39:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53964 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgGFGj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 02:39:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 751575F386;
        Mon,  6 Jul 2020 02:39:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y/pnMVerm/m5
        G3OANE2rxj8bOcc=; b=FbInPk9SNIhyV242QNyOvuBPQx371mjCgbAh7SITZJub
        iSeAhdZHg4f2X4PcUaRyPsChy71uXvBKJI848M3eRWKW3vZNtjKUPFfpNowpo2BU
        IKRJ4HyofwccKWDcfpENPuY+P+ZpcPTzRu3yTj3xxUm8NdsRNJPnF+JyFDFAYWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YbRDNE
        t6Ms9EXWkggNd1TWTzow8Ziuyvh6QObdroK7a+1GLI8D9C5rovBRwDGWo4NueMCF
        pI4RIhKZMG5BVMsVinWNMrnUPlTK3M9J+sW5mNNFwRxyJeRyalOm5f5+13qEM4gN
        q2ktK+7Wu75G/RI9tKeIK5qFtmlcglBe1BTNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BD0A5F385;
        Mon,  6 Jul 2020 02:39:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFF745F383;
        Mon,  6 Jul 2020 02:39:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Brandon Williams <bwilliamseng@gmail.com>
Subject: Re: [PATCH v12 5/5] read-cache: speed up has_dir_name (part 2)
References: <20170419170618.16535-1-git@jeffhostetler.com>
        <20170419170618.16535-6-git@jeffhostetler.com>
        <20200704172708.GC11341@szeder.dev>
Date:   Sun, 05 Jul 2020 23:39:55 -0700
In-Reply-To: <20200704172708.GC11341@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Sat, 4 Jul 2020 19:27:08 +0200")
Message-ID: <xmqqr1tp9mf8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8142BB22-BF53-11EA-AE04-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +				 * last: xxx/yy-file (because '-' sorts before '/')
>> +				 * this: xxx/yy/abc
>
> This is problematic, because the index can already contain 'xxx/yy' as
> a file, when adding 'xxx/yy/abc', but since 'xxx/yy' as a file sorts
> before 'xxx/yy-file', the short-circuiting here doesn't see it and
> thus leaves the d-f collision undetected.  Consequently, even Git
> porcelain commands can create tree objects with duplicate entries, as
> demonstrated in the tests below.

Yeah, the "optimization" is quite bogus.  Thanks for catching it.
