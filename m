Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960D01F462
	for <e@80x24.org>; Tue, 30 Jul 2019 20:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfG3U0N convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 30 Jul 2019 16:26:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:63580 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfG3U0N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:26:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x6UKQ2Pp031135
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 16:26:02 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com> <20190730194515.GA1088@sigill.intra.peff.net>
In-Reply-To: <20190730194515.GA1088@sigill.intra.peff.net>
Subject: RE: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Date:   Tue, 30 Jul 2019 16:25:56 -0400
Message-ID: <04b201d54715$0180a0f0$0481e2d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIOLVcRtBsBNXlmTtIvSwfiR5E4KQJZZ+eIpl8BNWA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 30, 2019 3:45 PM, Jeff King wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org; git-
> packagers@googlegroups.com
> Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
> 
> On Tue, Jul 30, 2019 at 01:08:37PM -0400, Randall S. Becker wrote:
> 
> > t0016: oidmap
> >
> > Subtest 6 had an ordering issue. We do not know whether the problem is
> the code or the test result not keeping up with the code changes.
> > --- expect      2019-07-30 16:56:36 +0000
> > +++ actual      2019-07-30 16:56:36 +0000
> > @@ -1,6 +1,6 @@
> >  NULL
> >  NULL
> >  NULL
> > +7c7cd714e262561f73f3079dfca4e8724682ac21 3
> >  139b20d8e6c5b496de61f033f642d0e3dbff528d 2
> >  d79ce1670bdcb76e6d1da2ae095e890ccb326ae9 1
> > -7c7cd714e262561f73f3079dfca4e8724682ac21 3
> 
> This one is very curious. It's iterating a hash, which _seems_ like it would
> produce non-deterministic output. But neither this test nor the hashmap test
> it is based on sorts the output, and they pass consistently for me. I assume
> that's because while hash ordering is not guaranteed, it happens to be the
> same as long the pattern of inserts is the same (with our implementation,
> which does not do any hash randomization).
> 
> But I am scratching my head as to what could be different on your platform
> that would cause a different ordering (especially when the hashmap test this
> is based on doesn't get one!).
> 
> I guess in some sense it may not be worth tracking down, and we should just
> sort the output of a hash iteration unconditionally when comparing it to
> expected output.

Definitely a head scratcher. Is it possible that the bucket() function, which uses

	key->hash & (map->tablesize - 1);

might better use

	key->hash % (map->tablesize - 1);

I have not seen a bucket computation done this way before so that surprised me, not that it should make a difference on hash-determinism. The only thing that might is an uninitialized stack variable, which on this platform's C compiler will not initialize. Global statics are always 0 unless otherwise specified, but I'm not sure about stack-local (but there's nothing wrong I can see in hashmap.c on those points.

Sorting the output seems like a safe option, providing that the hash is itself demonstrably solid otherwise.

Cheers,
Randall

