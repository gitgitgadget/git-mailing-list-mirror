Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40591C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 21:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444416AbiEFV1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 17:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442687AbiEFV1S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 17:27:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1CB6EC64
        for <git@vger.kernel.org>; Fri,  6 May 2022 14:23:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D8D011AA65;
        Fri,  6 May 2022 17:23:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Tw74FJ75GZUs
        j3rV4COR+2Qh1ovPNH2fW3Zfz4E45BQ=; b=NbICAS3o8SNO/gyo6S0jgFy8HkVx
        /SmQ2G1oGtiXXypIm1NdU37wVS3Mv2DBQpv8668aHoVPeEvKwyG4TT8dKelczYv7
        kEUXs2LlfKKjDrWY5J/LB4EEAeiiEPUXDheCN6L6nivmS7QjpVJ8uI0a9kHYcvTz
        SZMbCKZT55nvbNk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02F2111AA62;
        Fri,  6 May 2022 17:23:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5BA3D11AA61;
        Fri,  6 May 2022 17:23:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Jason Hatton <jhatton@globalfinishing.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
References: <CY4PR16MB16552D74E064638BEC11ECB1AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
        <f3f883cb-9141-6871-0f3d-3d3293a17f5f@iee.email>
        <xmqqr156obxg.fsf@gitster.g>
        <dd2ffc74-af7e-c2fb-8466-f16e419c39d6@iee.email>
Date:   Fri, 06 May 2022 14:23:29 -0700
In-Reply-To: <dd2ffc74-af7e-c2fb-8466-f16e419c39d6@iee.email> (Philip Oakley's
        message of "Fri, 6 May 2022 22:17:35 +0100")
Message-ID: <xmqq8rrejqy6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C6A76BCE-CD82-11EC-A169-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> This may treat non-zero multiple of 4GiB as "not racy", but has
>> anybody double checked the concern R=C3=A9ne brought up earlier that a
>> 4GiB file that was added and then got rewritten to 2GiB within the
>> same second would suddenly start getting treated as not racy?
> This is the pre-existing problem, that ~1in 2^31 size changes might not
> get noticed for size change. The 0 byte / 4GiB change is an identical
> issue, as is changing from 3 bytes to 4GiB+3 bytes, etc., so that's no
> worse than before (well maybe twice as 'unlikely').

OK, it added one more case to 2^32-1 existing cases, I guess.

>> The patch (the firnal version of it anyway) needs to be accompanied
>> by a handful of test additions to tickle corner cases like that.
> They'd be protected by the EXPENSIVE prerequisite I would assume.

Oh, absolutely.  Thanks for spelling that out.

