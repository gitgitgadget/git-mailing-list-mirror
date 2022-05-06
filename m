Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA66C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 21:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiEFVVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 17:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444391AbiEFVVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 17:21:22 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B661289
        for <git@vger.kernel.org>; Fri,  6 May 2022 14:17:37 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nn5KR-0005hk-FN;
        Fri, 06 May 2022 22:17:36 +0100
Message-ID: <dd2ffc74-af7e-c2fb-8466-f16e419c39d6@iee.email>
Date:   Fri, 6 May 2022 22:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jason Hatton <jhatton@globalfinishing.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CY4PR16MB16552D74E064638BEC11ECB1AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
 <f3f883cb-9141-6871-0f3d-3d3293a17f5f@iee.email> <xmqqr156obxg.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqr156obxg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05/2022 17:36, Junio C Hamano wrote:
>>> + */
>>> +unsigned int munge_st_size(off_t st_size) {
>>> +	unsigned int sd_size = st_size;
>>> +
>>> +	if(!sd_size && st_size)
> Style.
Ah, the same line / braces choice (as per coding guidelines).
>>> +		return 0x80000000;
>>> +	else
>>> +		return sd_size;
>>> +}
> This may treat non-zero multiple of 4GiB as "not racy", but has
> anybody double checked the concern Réne brought up earlier that a
> 4GiB file that was added and then got rewritten to 2GiB within the
> same second would suddenly start getting treated as not racy?
This is the pre-existing problem, that ~1in 2^31 size changes might not
get noticed for size change. The 0 byte / 4GiB change is an identical
issue, as is changing from 3 bytes to 4GiB+3 bytes, etc., so that's no
worse than before (well maybe twice as 'unlikely').

>
> The patch (the firnal version of it anyway) needs to be accompanied
> by a handful of test additions to tickle corner cases like that.
They'd be protected by the EXPENSIVE prerequisite I would assume.
Any particular test t/txxx that they should be placed in (I'm not that
familiar with the test suit)
--
Philip
