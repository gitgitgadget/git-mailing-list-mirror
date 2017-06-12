Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858F51F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 16:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbdFLQ4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 12:56:41 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58232 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753972AbdFLQ4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 12:56:40 -0400
Received: from a1i15.kph.uni-mainz.de (host2092.kph.uni-mainz.de [134.93.134.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ulm)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 5AAAE34169D;
        Mon, 12 Jun 2017 16:56:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <22846.51138.555606.729612@a1i15.kph.uni-mainz.de>
Date:   Mon, 12 Jun 2017 18:56:34 +0200
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
In-Reply-To: <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
References: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
        <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
        <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
        <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
        <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
        <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
        <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
        <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
        <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
        <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
        <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
        <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
        <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
X-Mailer: VM 8.2.0b under 24.3.1 (x86_64-pc-linux-gnu)
From:   Ulrich Mueller <ulm@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>>> On Mon, 12 Jun 2017, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Jun 12, 2017 at 5:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> René Scharfe <l.s.r@web.de> writes:
>>> Yes, or you could look up a time zone name somewhere else -- except we
>>> don't have a way to do that, at least for now.
>> 
>> Is that only "for now"?  I have a feeling that it is fundamentally
>> impossible with the data we record.  When GMTOFF 9:00 is the only
>> thing we have for a timestamp, can we tell if we should label it as
>> JST (aka Asia/Tokyo) or KST (aka Asia/Seoul)?

> It's obviously not perfect for all the reasons mentioned in this
> thread, but we already have a timezone->offset mapping in the
> timezone_names variable in date.c, a good enough solution might be to
> simply reverse that lookup when formatting %Z

That cannot work, because there is no unique mapping from offset to
timezone name. For a given offset there may be several timezone names,
or no name at all. (For example, if I decide to commit with my local
mean time which has an offset of +0033 then there won't be any
timezone name at all.)

> Of course we can never know if you were in Tokyo or Seul from the info
> in the commit object, but we don't need to, it's enough that we just
> emit JST for +0900 and anyone reading the output has at least some
> idea what +0900 maps to.

Please don't. Outputting invented information for something that
really isn't in the data is worse than outputting no information at
all.

> We could also simply replace "%Z" with the empty string, as the the
> POSIX strftime() documentation allows for:
> http://pubs.opengroup.org/onlinepubs/009695399/functions/strftime.html
> ("Replaced by the timezone name or abbreviation, or by no bytes if no
> timezone information exists.").

IMHO the two viable possibilities are the empty string, or the same
information as for %z. But this has been said before in this thread.

tzdata2017b has the following data in its "etcetera" file, the last
column being the timezone name:

   Zone	    Etc/GMT 	     0	-    GMT

   Zone	    Etc/GMT-14	    14	-    +14
   Zone	    Etc/GMT-13	    13	-    +13
   [...]
   Zone	    Etc/GMT+12	   -12	-    -12

This would be at least some rationale for converting %Z to [+-]hhmm,
i.e., the same as for %z. (One could even think about [+-]hh if the
minutes part is zero, but this already looks like over-engineering
to me.)

Ulrich
