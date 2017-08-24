Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391EE208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 08:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbdHXIA6 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 24 Aug 2017 04:00:58 -0400
Received: from 3.mo64.mail-out.ovh.net ([46.105.34.112]:33405 "EHLO
        3.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdHXIA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 04:00:56 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 391F28AAC5;
        Thu, 24 Aug 2017 10:00:54 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Aug 2017 10:00:49 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [RFC 0/3] imap-send curl tunnelling support
To:     Jeff King <peff@peff.net>
CC:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        <git@vger.kernel.org>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net>
 <0beb0a6c-acb3-ae24-5c52-95747f74c07f@suse.de>
 <20170823214349.k4ayl2urqepch7p4@sigill.intra.peff.net>
Openpgp: preference=signencrypt
Message-ID: <e11d4449-8377-dbd7-3ad5-441baf7446b6@morey-chaisemartin.com>
Date:   Thu, 24 Aug 2017 10:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <20170823214349.k4ayl2urqepch7p4@sigill.intra.peff.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS4.indiv2.local (172.16.1.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 9779003643690280925
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 23/08/2017 à 23:43, Jeff King a écrit :
> On Mon, Aug 21, 2017 at 09:34:19AM +0200, Nicolas Morey-Chaisemartin wrote:
>
>>>> It appears curl do not support the PREAUTH tag.
>>> Too bad. IMHO preauth is the main reason to use a tunnel in the first
>>> place.
>> It shouldn't be too hard to add support for this in curl.
>> If it's the main usecase, it'll simply means the curl tunnelling
>> should be disabled by default for older curl (in this case, meaning
>> every version until it gets supported) versions.
> Yes, I agree. I was hoping when we started this discussion that we were
> more ready to switch to curl-by-default. But sadly, that isn't close to
> being the case. But hopefully we can at least end up with logic that
> lets us use it in the easy cases (no tunneling) and falls back in the
> harder ones.
>
> -Peff
I opened a bug upstream and they already fixed this.
https://github.com/curl/curl/pull/1820

At least bleeding edge curl user should be able to use this.
I'm not sure where to go with these patches now.

1) There does not seem to be an easy/clean workaround for the lack of socketpair on windows.
Fidling with a loopback AF_UNIX?AF_LOCAL socket should work but it means creating a socket file somewhere which pulls a lot of potential issues (where to put it ? Post-mortem cleanup ? Parallel imap-send ?)

2) The PREAUTH support won't largely be available  for a while (curl, release, distro, etc.)
- If this is the main use case, it does not make much sense to puch curl; tunneling support without this. I could push the code and only enable the curl tunneling for the next curl release ?
  Meaning no one (or close to no one) would use this until some later
  This also means very little testing (apart from mine) until the next curl version gets widely available
- If this is not the main case (or at least the non PREAUTH is important enough), it would make sense to get this changes in.
  But it would probably need some more to code to either fallback to legacy mode when curl failed (due to PREAUTH) or detect PREAUTH and directly use the legacy mode.

Nicolas

