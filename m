Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF5B1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbfFMQih (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:38:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52736 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392734AbfFMQif (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 12:38:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EEAC7FFBE;
        Thu, 13 Jun 2019 12:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YnRmxjeAJLFA
        qKqfwa1efXKo21E=; b=il7rsOqM3CWo3j2IlHVBPR6NHYxZ8VbOmra2PQ3bBeFW
        6N7QobW1/Ab8tVqkGE3fd/rx+JYJxUziaVR0Tf5lyksvwtgy6OFRlP34iM207itP
        7HLRvSQ2cVeMk+yLN568p4cZVilNTaJJ916FR1F9SSpkUXNLDHRBgO0LeDOCHvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M5aA04
        +wbCZopx1WF/lKPUCRIbfvtkwj3pAxOk55kYEGD4Iwp+oAKYNxHe0s6OUjNpg+f4
        pMXblqFSCunlpnj7XmZesfDHJ/J14xOwu7e9rvgd92xNGTwHbcALimywNX1MDAKa
        NJSOIb40kWlXGkPheH6UffQmwBm1I6ztFxiP4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 666D57FFBD;
        Thu, 13 Jun 2019 12:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C3A67FFBC;
        Thu, 13 Jun 2019 12:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Barret Rhoden <brho@google.com>, git@vger.kernel.org,
        Michael Platings <michael@platin.gs>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v8 7/9] blame: add a fingerprint heuristic to match ignored lines
References: <20190610153014.42055-1-brho@google.com>
        <20190610153014.42055-8-brho@google.com>
        <20190613151756.GA31952@szeder.dev>
Date:   Thu, 13 Jun 2019 09:38:28 -0700
In-Reply-To: <20190613151756.GA31952@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 13 Jun 2019 17:17:56 +0200")
Message-ID: <xmqqef3xwid7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD5E7E6C-8DF9-11E9-888D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file | sed -e "$pi=
ck_author" >actual &&
>
> Please use an intermediate file between 'git blame' and the downstream
> 'sed' command, here and in other tests as well.
>
> This test script focuses specifically on 'git blame', but that pipe
> hides its exit code.

Good point on "this matters even more for 'blame' as the whole point
of t8014 _is_ about 'blame' running corretly".

Thanks.
