Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5752E1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 09:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJCQ35 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 12:29:57 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:31564 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeJCQ35 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 12:29:57 -0400
Received: from [192.168.2.201] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 7dfdgZfltoI6L7dfegQs2m; Wed, 03 Oct 2018 10:42:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538559738;
        bh=nl0b/SPtv1ngNkmPCn7Gj04rCvp+IezOLvcOdvx39XE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X2f0y1tkTZQMgYCi7ATlwesDO64TOOukfVatDKaDfdU3RpGBEVTee53PpvwSStybC
         E9cGyYzlQKxX9nM9sYYd4CnUkgIHQS35Ro69SXSzd5WtSWZGOlFQtLOswDQmVrXKo9
         EXwW+nTfeDbBrKYNKtitsyK+GNBdRrdKA+r3nrQI=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=lSSdJbUITO7A6sTHS7sA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] diff --color-moved-ws: fix a memory leak
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
 <20181002175514.31495-3-phillip.wood@talktalk.net>
 <CAGZ79kbX+DssZaCS_fV-eNR828Yd-vsLJ6F58Lifn2f8j+oXvA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <5821aa37-b1aa-9118-5920-cfa60b243032@talktalk.net>
Date:   Wed, 3 Oct 2018 10:42:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbX+DssZaCS_fV-eNR828Yd-vsLJ6F58Lifn2f8j+oXvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOueUwqpIhllKQIvQDvHrIEfdJ92zdzU50gn4NQdPf14tULbGagmnmQWhgDbNitIjBJg6HzCTTWXY8yr2lVKRj839J1gqiQ8Ko44qCjACt4RjfHKaYES
 sJJMuzH/hn0b45KGcQ1+WjlHgTqeXeGKPuniaK5ErQ6+F0tRkrEjNahIWsYHHtDtXeNs3UbVBXwWdxaJkpjt9nB/IGn0GVMhG5LgZxLokHhezT2sCcf4kMs/
 eKqwNVEPjFyYn4Tu4NHa4uxIhB46Nyg0P5Nk3Du7/LM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2018 20:08, Stefan Beller wrote:
> On Tue, Oct 2, 2018 at 10:55 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Don't duplicate the indentation string if we're not going to use it.
>> This was found with asan.
> 
> Makes sense,
> 
> Thanks,
> Stefan
> 
> With compute_ws_delta growing bigger here (and having only one caller),
> I wonder if we want to pass 'match' instead of match->es (and pmb_nr),
> such that the function can also take care of
>     pmb[pmb_nr++].match = match;

Wouldn't we still need to increment pmb_nr in the caller though, in
which case I'm not sure it saves much.

> Then the function is not a mere compute_ws_delta, but a whole
> setup_new_pmb(...) thing. Undecided.
> 

