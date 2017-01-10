Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7D620756
	for <e@80x24.org>; Tue, 10 Jan 2017 21:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbdAJVer (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 16:34:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62028 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751395AbdAJVeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 16:34:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE4D35FCD1;
        Tue, 10 Jan 2017 16:34:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GuzkTp46QZGGow3SQ/f9vyMXn2g=; b=cp2rVX
        2lsq7ILhlC+fhSo7zsSwRH5Bbde+YuwzUoUgjxDeMsCLHfy3h+HWKRdvdRasiQKu
        FXzIm15168cK8co5nCMJqTFcdH17y8ucv3Up8vqRNPa1Fvg/AlA5jxIFnV4gCIEP
        +gPasigm8DyPfKIX/zMQY0Cr4UTkXMjYwDqsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KIH/Te7wZnYMlUaayGGdfpRq2oxOA8wt
        Apcl3eldqFVg1OtE1Z7P3IeNee8Y+wEXq/bFtEVs7uv9neKmswG8y2mX6szAqMt9
        MjWPXLCTWG9wEchoPd/MFn693tI1w1Rr4g++HsiDa5FVRGA3Y4tvXHokoBOEI8TM
        Cgs9nJfFveo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A29B65FCD0;
        Tue, 10 Jan 2017 16:34:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE8D55FCCF;
        Tue, 10 Jan 2017 16:34:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCHv2 4/5] unpack-trees: factor file removal out of check_updates
References: <20170109194621.17013-1-sbeller@google.com>
        <20170109194621.17013-5-sbeller@google.com>
        <xmqqd1fusmsu.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbXVCvZuj6rTckGwOfFtRSFpx9p611oKfFLAayTgB242Q@mail.gmail.com>
Date:   Tue, 10 Jan 2017 13:34:43 -0800
In-Reply-To: <CAGZ79kbXVCvZuj6rTckGwOfFtRSFpx9p611oKfFLAayTgB242Q@mail.gmail.com>
        (Stefan Beller's message of "Tue, 10 Jan 2017 12:51:03 -0800")
Message-ID: <xmqq37gqr43w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A87982C-D77C-11E6-BCA5-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As far as I understand the operations now, a working tree operation
> is done like this:
>
> * First compute the new index, how the world would look like
>   (don't touch a thing in the working tree, it is like a complete
>   dry run, that just checks for potential loss of data, e.g.
>   untracked files, merge conflicts etc)
> * remove all files to be marked for deletion
> * add and update all files that are new or change content.
>
> check_updates does the last two things listed here, which in the
> grand scheme of things looked odd to me.

In the grand scheme of things, the flow has always been understood
more like this two-step process:

    - compute the result in core (rejecting an inconsistent result
      before touching the working tree)

    - reflect the result to the working tree

and the latter is done by check_updates().  

Removing gone entries before instanciating possibly new entries is
done in order to make room where we can create a new path D/F in the
result, after removing an old path D [*1*].  But it is merely an
implementation detail of the latter, i.e. "reflect the result to the
working tree.

It is arguably true that check_updates() is not about "checking" but
is about "doing", hence is misnamed.

[Footnote]

*1* If the result computed in-core wants to create D/F, it must have
removal of D---otherwise the result is inconsistent.
