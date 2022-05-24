Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC514C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbiEXU6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbiEXU6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:58:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA1629827
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:58:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63F5F1271DC;
        Tue, 24 May 2022 16:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RGT7BNVLWITwwkm+NWgB6fj+okTJ4ODseQ0luS
        JQ/Fc=; b=d96j/lCGPufwUAeqVm+vfHsMEwGua1aamxA2kHIefhimBzaCabKyM4
        BunOUC3aw8Q2We5z0ODYT7+TtbpPdp+2NFSAoZzVXKS6bIbLGALwbQh8U5YIE2+Z
        OFl3MKeiS/fb1DEPxJYPl98G17tyADA59QRpt0zzBOHUJcNMUN5jI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B3291271DA;
        Tue, 24 May 2022 16:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C57BF1271D9;
        Tue, 24 May 2022 16:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] compat/win32/syslog: fix use-after-realloc
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
        <d0ade6531bc77b654c28cf7b1bfa42523150c015.1653351786.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2205241431400.352@tvgsbejvaqbjf.bet>
Date:   Tue, 24 May 2022 13:58:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205241431400.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 May 2022 14:39:41 +0200 (CEST)")
Message-ID: <xmqqy1yqfy0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49A3E4D8-DBA4-11EC-9FD5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  		str = realloc(str, st_add(++str_len, 1));
>
> Since it has been raised elsewhere: Why is that `++str_len` not turned
> into an `st_add()`?
> ...
> Now you know,

I'd be more worried about a macro looking thing evalutating its
parameters more than once, though.  But unlike st_addN(), st_add()
is an inline function so we do not have to worry about that ;-)

>> @@ -50,6 +51,7 @@ void syslog(int priority, const char *fmt, ...)
>>  			warning_errno("realloc failed");
>>  			return;
>>  		}
>> +		pos = str + offset;

The adjustment using ofs is very much straight-forward.  Nicely
spotted and nicely corrected.

Thanks.
