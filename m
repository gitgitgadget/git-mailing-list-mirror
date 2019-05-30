Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64181F462
	for <e@80x24.org>; Thu, 30 May 2019 08:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfE3Irl (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 04:47:41 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:59659 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfE3Irl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 04:47:41 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45F1Rt66gKz5tlB;
        Thu, 30 May 2019 10:47:38 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 032A220B3;
        Thu, 30 May 2019 10:47:37 +0200 (CEST)
Subject: Re: [PATCH 00/52] fix some -Wmissing-field-initializer warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <cf0b720e-ad29-79e7-17d5-b69d50e7007e@ramsayjones.plus.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0f1c5a49-f971-848d-700e-9c124ae8e617@kdbg.org>
Date:   Thu, 30 May 2019 10:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cf0b720e-ad29-79e7-17d5-b69d50e7007e@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

I had a brief look at the series. IMO, it is a mistake to appease
-Wmissing-field-initializer.

We have two sorts of initializers:

 - zero initializers: they just want to null out every field,
   like CHILD_PROCESS_INIT and ad-hoc initializers of structs
   such as xpparam_t pp = { 0 }; in range-diff.c

 - value initializers are always macros, such as STRING_LIST_INIT_DUP
   and the OPT_* family.

I am strongly against forcing zero initializers to write down a value
for every field. It is much more preferable to depend on that the
compiler does the right thing with them. -Wmissing-field-initializer
would provide guidance in the wrong direction. A zero initializer looks
like this: = { 0 }; and nothing else.

(And for this reason, I also think it is wrong to change 0 to NULL in
initializers to appease sparse's "zero used as pointer value" warning.
Let the compiler do the right thing.)

Value initializers are a different matter. The changes you have prepared
around struct option initializers are good, IMO. Whether or not you add
trailing zeros to the macros makes no difference for the users of the
macros.

-- Hannes
