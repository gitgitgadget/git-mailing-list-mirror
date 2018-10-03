Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A20F1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 09:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJCQ03 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 12:26:29 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:26872 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbeJCQ03 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 12:26:29 -0400
Received: from [192.168.2.201] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 7dcHgZfRhoI6L7dcIgQruG; Wed, 03 Oct 2018 10:38:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538559531;
        bh=Awwbn+b26aya/nFYaud/HncRDa/CiI8ICd/nhAWKPT4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dNFLUXVDdcgqYs7dDDXL1j11BFARG+0kaZp1Jm1TrYPdjmYKJbqmLiQxuP2Ei0i7Q
         GHZYevBf2Kaz4Q2nSaY4dk58tToL/6zcXlXodIbsJCdisihWNvu5F+q+nCItsXf0D7
         QwDkVmroI4xzjtRM3EhXoQ3qTMu9gWpmzcX3zc2Q=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=1XWaLZrsAAAA:8 a=g2lF1XOz61mOFc2_x0QA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] diff --color-moved-ws: fix double free crash
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
 <CAGZ79kYqACgoNShaPBQQSUN1B_dhmdxHxBV6YZoNAd39f6XMjw@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1c6b26a2-45ca-df76-8baa-61790cb963ac@talktalk.net>
Date:   Wed, 3 Oct 2018 10:38:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYqACgoNShaPBQQSUN1B_dhmdxHxBV6YZoNAd39f6XMjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD0VuY+MFHvyR6H/m8FPueVablNjEGTrIzyp8KWhfHX8i218VWY3/stbwmkbbplhFJqbWKt6UC5/cOPOK3hRYEP0wEIot1Y4pH4uHULo5zkP5Rb3fvpR
 ClSlwKk8h8BErt28VCebd/zziWuiDyNLqt4Fzs82SmjARXUb36uI/C8lDBJoy8gTu/nODzUOlivzGe+3sYz+tybuHUkUeGHlB6vayP+u5brKu57Z9pic+QlF
 iTCsEHd7Gpzs3aKNGd08yaWciHBQHYHHtUYozzq2YKY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

Thanks for looking at these patches

On 02/10/2018 19:49, Stefan Beller wrote:
> On Tue, Oct 2, 2018 at 10:55 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> 
>> The solution is to store the ws_delta in the array of potential moved
>> blocks rather than with the lines. This means that it no longer needs
>> to be copied around and one block cannot overwrite the ws_delta of
>> another. Additionally it saves some malloc/free calls as we don't keep
>> allocating and freeing ws_deltas.
> 
> Another solution would be to duplicate the copy-arounds, that it only
> fixes the double free, but having another layer of abstraction
> (moved block vs line) makes sense as then we don't need to copy
> it forward.
> 
> With this patch applied the diff as mentioned works and having the
> ws deltas with the blocks instead of the
> 
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> 
> 
>>  static void pmb_advance_or_null_multi_match(struct diff_options *o,
> [...]
>>         for (i = 0; i < pmb_nr; i++) {
>>                 if (got_match[i]) {
>>                         /* Carry the white space delta forward */
> 
> I would think this comment is obsolete as well with this patch?

Yes you're right I should have removed that. As there are some changes
needed to some other comments I'll re-roll

Best Wishes

Phillip

> 
> With or without that nit addressed, this patch is
> Reviewed-by: Stefan Beller <sbeller@google.com>
> 

