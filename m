Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4FDC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF6E21655
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wIF9OUkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEGTbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:31:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50592 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgEGTbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 15:31:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0509D946C;
        Thu,  7 May 2020 15:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8BvHj15EvLdfqS6PIIznQP0T4pM=; b=wIF9OU
        kdzPo0swCCQDOLBttdtvnjOAbsQzRLWSiDVVy6gZd2l5oPVcPjwheZXbx9/GPXmj
        QTtkuAW0XDO1/z+CaLGDhCBUoCUsOvHkX4mjELnIPKcD5AFC4uZ9Vy6Ze6tza00y
        ruT0eAhm4880EF2Ecm4TGvCvw21ny5Ie5iuWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gPT7cSud3/MDTSlbjvlpXKuDzudFXdcS
        l1vSRHKf8dw/enskQYO3TWwlNqky7C80tHLBSO8QDa3avzjmfee5rQBRsmohOkiw
        uW+aqDpOh0ZBMZDxJRChY3RqGNPSMfC0n5dlgpiiNE+zDc20Iud8Si4s0bZgV5Fl
        0xMmTazFyg0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9F52D946B;
        Thu,  7 May 2020 15:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F2325D9469;
        Thu,  7 May 2020 15:31:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] auto-gc: pass --quiet down from am, commit, merge and rebase
References: <20200506094327.GC31637@rillettes>
        <20200506201830.92818-1-gitster@pobox.com>
        <20200506201830.92818-3-gitster@pobox.com>
        <20200507172201.GD26677@syl.local>
Date:   Thu, 07 May 2020 12:31:17 -0700
In-Reply-To: <20200507172201.GD26677@syl.local> (Taylor Blau's message of
        "Thu, 7 May 2020 11:22:01 -0600")
Message-ID: <xmqq5zd74k56.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 534B72F6-9099-11EA-A230-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Junio,
>
> On Wed, May 06, 2020 at 01:18:30PM -0700, Junio C Hamano wrote:
>> These commands take the --quiet option for their own operation, but
>> they forget to pass the option down when they invoke "git gc --auto"
>> internally.
>>
>> Teach them to do so using the run_auto_gc() helper we added in the
>> previous step.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/am.c     | 3 +--
>>  builtin/commit.c | 3 +--
>>  builtin/merge.c  | 3 +--
>>  builtin/rebase.c | 3 +--
>>  4 files changed, 4 insertions(+), 8 deletions(-)
>
> Very nicely done. Sorry that these took me a little while to look at.
> This and the patch before it both have my:
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,
> Taylor

Thanks.
