Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E61B1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934150AbeGIR4p (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:56:45 -0400
Received: from s019.cyon.net ([149.126.4.28]:46056 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933846AbeGIR4m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2W0r5WWypeSfW/9f0sreKKEs91ga2T/ySjCQoj4YVKE=; b=lu9sPViAIIjAMTD+bZD9Exc84W
        aRENToYKsXoobv6+IAlkpsQ/r5yRVoS2f+bbqPQB863Fr/aS8G+NcZditTHJNZSxsiCzVbom61+33
        iQ2RkOFo0uCyBWQUWTLuJe1WX1xoGMVp9VIcVu8ZaYO19u2nldNixZrMd8gf34mqUQ2RzzHSP/DXo
        BLVCFUPPOisGV7PMuJJQBIvRfNz3J7di34kZzgvHBIT9no+AIYO4bNvjRAhdvo7hR53hK1n3nCmu5
        y/gaD8p6CfB/RRfEKycDPix0EwHyuiUZX5EXwnKhC/qubBmraANDBB5bft+mmmc8/7sWkRJsx/hKx
        bSPScJ/A==;
Received: from [10.20.10.233] (port=27850 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fcaOt-00CJka-29; Mon, 09 Jul 2018 19:56:41 +0200
Subject: Re: [RFC PATCH 6/6] utf8.c: avoid char overflow
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180708144342.11922-7-dev+git@drbeat.li>
 <nycvar.QRO.7.76.6.1807091513130.75@tvgsbejvaqbjf.bet>
 <0ceeb342fec1d0868b81cd64941df53c@drbeat.li>
 <xmqqd0vwfjxt.fsf@gitster-ct.c.googlers.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <c42bd49e-15b0-2fc6-b92e-3d0108843aea@drbeat.li>
Date:   Mon, 9 Jul 2018 19:56:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0vwfjxt.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.07.18 18:33, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>>>> -static const char utf16_be_bom[] = {0xFE, 0xFF};
>>>> -static const char utf16_le_bom[] = {0xFF, 0xFE};
>>>> -static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
>>>> -static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
>>>> +static const unsigned char utf16_be_bom[] = {0xFE, 0xFF};
>>>> +static const unsigned char utf16_le_bom[] = {0xFF, 0xFE};
>>>> +static const unsigned char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
>>>> +static const unsigned char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
>>>
>>> An alternative approach that might be easier to read (and avoids the
>>> confusion arising from our use of (signed) chars for strings pretty
>>> much
>>> everywhere):
>>>
>>> #define FE ((char)0xfe)
>>> #define FF ((char)0xff)
>>>
>>> ...
>>
>> I have tried this first (without the macros, though), and thought
>> it looked really ugly. That's why I chose this solution. The usage
>> is pretty local and close to function has_bom_prefix().
> 
> I found that what you posted was already OK, as has_bom_prefix()
> appears only locally in this file and that is the only thing that
> cares about these foo_bom[] constants.  Casting the elements in
> these arrays to (char) type is also fine and not all that ugly,
> I think, and between the two (but without the macro) I have no
> strong preference.  I wonder if writing them as '\376' and '\377'
> as old timers would helps the compiler, though.
> 

Yes, it does, as I found out in
https://public-inbox.org/git/e3df2644b59b170e26b2a7c0d3978331@drbeat.li/

But I prefer hex; it's closer to the usual definition of the BOM bytes.

Beat
