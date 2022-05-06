Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB4FC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 16:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388174AbiEFQke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 12:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348993AbiEFQkd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 12:40:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EFA286D1
        for <git@vger.kernel.org>; Fri,  6 May 2022 09:36:50 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8A5C17D675;
        Fri,  6 May 2022 12:36:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=e0Jo19tLnq5j
        Yy09MMOq1T0ulrUV8sYqxie5JC/WnTU=; b=Md/PxaP3etT4fIoPpPS+na7/hhdM
        xq5FF2w//BRt1LXuanwvR+kKAkceCVXk/bUe+a7/mAwFvlmrgPl1IsuHXUspzX8K
        nKdtnuOwlAZKDdVoQPo0+LX4ZvKQDwdywmIzMxmnz88LovRY8sjPLUYwMW6OkfAC
        3Yo9bKDSiZAwL/0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EB4817D674;
        Fri,  6 May 2022 12:36:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14FDB17D673;
        Fri,  6 May 2022 12:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Jason Hatton <jhatton@globalfinishing.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
References: <CY4PR16MB16552D74E064638BEC11ECB1AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
        <f3f883cb-9141-6871-0f3d-3d3293a17f5f@iee.email>
Date:   Fri, 06 May 2022 09:36:43 -0700
In-Reply-To: <f3f883cb-9141-6871-0f3d-3d3293a17f5f@iee.email> (Philip Oakley's
        message of "Fri, 6 May 2022 11:22:57 +0100")
Message-ID: <xmqqr156obxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B77F67D2-CD5A-11EC-8564-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> This "Munge" above isn't telling the reader 'why'/'what' is going on.
> The comment should in some way highlight that a zero size result is
> special, and that we have the roll over issue when the stored in 32 bit=
s
> - the double duty of racy vs changed in the stat data heuristic.
> Synonyms of 'munge' ?
>
>
>> + */
>> +unsigned int munge_st_size(off_t st_size) {
>> +	unsigned int sd_size =3D st_size;
>> +
>> +	if(!sd_size && st_size)

Style.

>> +		return 0x80000000;
>> +	else
>> +		return sd_size;
>> +}

This may treat non-zero multiple of 4GiB as "not racy", but has
anybody double checked the concern R=C3=A9ne brought up earlier that a
4GiB file that was added and then got rewritten to 2GiB within the
same second would suddenly start getting treated as not racy?

The patch (the firnal version of it anyway) needs to be accompanied
by a handful of test additions to tickle corner cases like that.

Thanks, all, for working on this.
