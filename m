Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1D91F404
	for <e@80x24.org>; Fri, 15 Dec 2017 02:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbdLOCS6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 21:18:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53645 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754594AbdLOCS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 21:18:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 476D5CCF55;
        Thu, 14 Dec 2017 21:18:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+OsQ8dsygcu510M/X24E4j5PYpM=; b=Y0Zv23
        OZaqWAu0MuceLyi2wXPXn08p8h3BK3DZVCSpo3KXlT/5koinwpe2dlfPx6a1nXFC
        soOSI9PoGXUZH5cZKL9EgkU1og27XNmoVj7kNUAlnnRaLzrr4OHLpEtBc2IdvWAq
        KCmEORUD7bVTONmRtoZuaT6J4wk+kHOohoh6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NWiOGe42Yu7D4dfw5g78nRbp3ME622n1
        bSaVyS71wz2QQEiHduQn3dYE6kxScFC0RNIP5j/GBwi/VHzb1fdbkZfkxucJ+Nz1
        NxU9s2QnfzKmJMVsL74GkgmV8jKlYGxxHP8y7qPI9PCkVSUKjIbrJ6w6lR3c0I16
        rD9YIAzrpVs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F8D7CCF54;
        Thu, 14 Dec 2017 21:18:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5016CCF53;
        Thu, 14 Dec 2017 21:18:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore: add a filter to find a specific blob
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
        <20171212012422.123332-1-sbeller@google.com>
        <20171214212234.GC32842@aiede.mtv.corp.google.com>
        <CAGZ79kZdUuoM79n09ziG0F7WCWNLpZ2AiFA6fb_qgND1b3_F9A@mail.gmail.com>
        <20171214225200.GA44616@aiede.mtv.corp.google.com>
Date:   Thu, 14 Dec 2017 18:18:55 -0800
In-Reply-To: <20171214225200.GA44616@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 14 Dec 2017 14:52:00 -0800")
Message-ID: <xmqq374cspgw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DCC4948-E13E-11E7-89EB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Regarding finding a better name, I would want to hear from others,
>> I am happy with --find-object, though I can see --pickaxe-object
>> or --object--filter to be a good narrative as well.
>
> Drat, I was hoping for an opinion.

I think it would make it a better companion to --pickaxe but we need
to align its behaviour a little bit so that it plays better with the
"--pickaxe-all" option, and also needs to hide mode and name only
changes just like pickaxe.  

After all, the diffcore-blobfind code was written while looking at
the diffcore-pickaxe's code in another window shown in the pager,
and I tend to agree with your earlier message that this is an
extreme case of -S<contents> where the contents happens to be the
whole file.
