Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607ACEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjF0QWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjF0QWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:22:11 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504D730E6
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687882918; x=1688487718; i=l.s.r@web.de;
 bh=a+6z0Rwm30ZcmVnSGxqchZXtkF22OQctNF3ELnoF01k=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=q6w1KBp+cPf2Eugz1TOEyCqkHhnvhmcoW16bkVa4Amv2e/cNINJ+14dhFreL2LUQaPcqydy
 6KTIBUj6SlJ15YlOuBxPy8UkV8QfPq1ahXGPUFUeayklVgxYygk3ZmpKUNWBoL/AvDd82hWpG
 f1DJCLVTNLt9PwFP3omABtp5lri7ReJGantYGtSn1KHf6OcsPNhI2PK8BJdtMF2Gutk8mMXpG
 CC9XfZEeaGDJMCEq3e+a73cLb+Qp/w5uLrS7D4aYVaBPIUtpsZ96fN4YEtfPwDVzUvZfZ5uGM
 5/gSaEYnR3Jj1VGLuxN3aHVkrUxnFjjjXAzk1PeJZ5ZwbrC0/71w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.106]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO9K-1pf7gM0KLQ-00ZYEk; Tue, 27
 Jun 2023 18:21:58 +0200
Message-ID: <6fc5092d-2095-5b44-cc26-1e7208a342f0@web.de>
Date:   Tue, 27 Jun 2023 18:21:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] strbuf: factor out strbuf_expand_step()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <caf8e100-1308-cb4e-d61a-4e15ee3f47f7@web.de>
 <20230627082622.GH1226768@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230627082622.GH1226768@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6IBgs3myTsv30zn2k8bP+KirOvBRUNwLBBvcS3S8sJPKsu2yBXq
 Se56BYzyYhSoWziN/8OYgq+rLuCQ0e3JhQncHlB//xwCiPMYQbjQScmfRvaSYZBPGEf35RB
 sI/+wI3DHI4umlWwV2pMRC6q/iGXH8WjZn3mTupq5m9+oYFU04C8ZwkPZylMOjzN8E2ntJB
 qrnkVFQNK9fHTqhPJeEJA==
UI-OutboundReport: notjunk:1;M01:P0:IYmgBklfOdo=;WmVivx/hv56YRsh7nQpFPF3W4+9
 A9g9V4yTi58ts1tBM1eE+pGuNqBbiKMqaKNdfDDPDc1SN40yfsWidI55eiiMf5cEICwr2d0yb
 kbgRMEJ6rQFJ3CdxAwiHIPStY2+jesITsldV3uLlfslz5qAwZD+/+wDMLxocy0KzRcDeiJkdZ
 BFjCYq/EDz+Epejhr6ePhIH7qezaFTbECCyI/T23Z1hIQ2KV1gejjr7L6NB1AaMslpPCigifb
 V7dR2W/RuNBmWDtmbhUzzd06s6Bk37ftIS/qAphjGJrE1V2rmagMe124miVrvKRztVCxYwFsC
 L+oseKR3o1qe+mdKeKXV3tj+p7yZ1DJ8Wq5EtJO1dS8en3/Aq+0Dsd/bG4DPSoFBZaGxKjEVN
 hx2Bn5xf7+xhRKqDED+z29xBINsAIH6rzQpF8FOqMg1taKu6uT78EFr2wTFMion6YtY6vtYyf
 GbGAAoUyLiGd3Zt5e4bKN37uvuWUzzt7TvwV7orIuf9vFzAWTuk4Qtf9FPAnRTa67BxJMqvPh
 z52jIwWCnjSeL66g70TnBT0CKZjAhVaSNn4jS6FsxgPMfWi5XpVJ12SQKCSAKIzbw3Zp2ZJDc
 Ilr04Oy17oFWmN8sd9dMhKTgoCcwM4TGLgfl56WROhllmWg+N/hAaBDfZOndw3ougTIiwrk+J
 Egzl+Ny32EzW2aCw2QLM5WnQnrMYTRMzfpuC+K6NMqQ0D/nSrFXl3LDB6VhRQ+fMEYoMIt+a1
 MM3qccoRJFPVe7P4eOA5m+r7BtRl4aJ9hSgzwgoxURPjqZ9F+pFV9M2BtSFx0IM05oGSSeNoT
 tqiYdhXb3cA2xZKIemEVbArLBloACtFDbA5uj4G5OvPX2XKGJz8KBYszhOyZ5e53lA/G6mn1K
 B5qwCEYcHlSPZiR0eFsNt3JVEPpnYgYgORHHGuSIA5tMw9U+7dbpugC6bzuU3fbH1ZNtML5JL
 5SE07A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.23 um 10:26 schrieb Jeff King:
> On Sat, Jun 17, 2023 at 10:41:44PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Extract the part of strbuf_expand that finds the next placeholder into =
a
>> new function.  It allows to build parsers without callback functions an=
d
>> the overhead imposed by them.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/branch.c | 13 ++-----------
>>  strbuf.c         | 28 ++++++++++++++--------------
>>  strbuf.h         |  8 ++++++++
>>  3 files changed, 24 insertions(+), 25 deletions(-)
>
> I was a little surprised to see the change in branch.c here (as well as
> the one in strbuf_addftime), since the commit message just says
> "extract..." and doesn't mention them.

Fair point, the other extraction sources should have been mentioned as
well somehow.

> They do serve as examples of how it can be used, so I think it's OK. But
> it made me wonder: is this all of the sites? Or are these just examples?

These are all that I could find.

Ren=C3=A9
