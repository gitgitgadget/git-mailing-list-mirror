Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB58C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6D064E22
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbhBDSZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:25:29 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55557 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbhBDSZV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:25:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CAE9122513;
        Thu,  4 Feb 2021 13:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OoqTxXIXAFiPZOux/aKPosTKqug=; b=km7L2R
        ARl+ATKg6HWQooQDoyQI3AO8Hoy1dhimv4viP2ll5vi+hQpWB3osQBgWNwY7ZPKD
        HgEQDr3a73oEXk66VtUF5bryhzvIPk+bnPKV2ctvvtnvT6VC/dth2WiGrWqUTGDg
        EAyk1pYNIEEE+fySwUOBxMDeo45Lxe5FX474M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IOOOjUwBs1LS+fNnxMiRcrOfW5FMqT/M
        Tar0Vk1YkPNBew+UTfoiiqar+BDGg94zBKNBODHmei/F0gR2uC5Hb5uypPz1nOfl
        uGTWd8x6gahaJ66iGAj+EXIsPWuI8Q4rmEqNB0fGpc8E39RAMPd14gYLHXKclgLe
        0sIuYenQhEw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9515E122512;
        Thu,  4 Feb 2021 13:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DBBC6122511;
        Thu,  4 Feb 2021 13:24:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH] builtin/clone.c: add --no-shallow option
References: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2102041458410.54@tvgsbejvaqbjf.bet>
Date:   Thu, 04 Feb 2021 10:24:35 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2102041458410.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 4 Feb 2021 15:00:13 +0100 (CET)")
Message-ID: <xmqqlfc37kt8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CA2792E-6716-11EB-B301-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> in addition to what Junio said:
>
> On Thu, 4 Feb 2021, Li Linchao via GitGitGadget wrote:
>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index e335734b4cfd..b07d867e6641
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -858,6 +860,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
>>  		free(remote_name);
>>  		remote_name = xstrdup(v);
>>  	}
>> +	if (!strcmp(k, "clone.rejectshallow")) {
>> +		option_no_shallow = 1;
>
> This needs to use `git_config_bool(k, v)` to allow for
> `clone.rejectShallow = false`.

Thanks.  I completely missed that.

