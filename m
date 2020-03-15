Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F4C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 19:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5DC20575
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 19:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SvNJDs82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgCOTay (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 15:30:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56197 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCOTay (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 15:30:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FC6BC4882;
        Sun, 15 Mar 2020 15:30:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K86q8Pi+oIhD
        wg3bLVNsWUPmpBs=; b=SvNJDs82ZoKf8ps2si3FFmkDpjesXmb294xr3t0ER1Ex
        93UXaswBL48U1TR7kckZsF7yesUFiOVPzUANcK5p7N8VD766gunOt1o5paQba9qI
        1QluAdvT4H2kkv76/p5wTJ5AIoanSbjoUp5PWhjVW8nyrMyJIPdreqJW2NapEiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=U+qhrh
        SMDhqUDL6L6FgCR2wtrCRP0lUiglcYZjgal+yobP/h2N1jy1hVByei5ZoHrLFwEB
        uVYezTXrexznjee+hVwv829f/3a5Y+5Qi3NrppbJRuQTLJaSyFLqHl0GrR1dXY1y
        YvSkcthZrNGXd/I6GAXRsT9c9FVjMokRdVeEM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 375BFC4881;
        Sun, 15 Mar 2020 15:30:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7EEEAC487E;
        Sun, 15 Mar 2020 15:30:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/8] builtin/clone: compute checkout metadata for clones
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
        <20200310182046.748959-6-sandals@crustytoothpaste.net>
        <20200315103929.GH3122@szeder.dev>
Date:   Sun, 15 Mar 2020 12:30:47 -0700
In-Reply-To: <20200315103929.GH3122@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sun, 15 Mar 2020 11:39:29 +0100")
Message-ID: <xmqqo8sxa00o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 79D58FEE-66F3-11EA-AE1A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Mar 10, 2020 at 06:20:43PM +0000, brian m. carlson wrote:
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 1ad26f4d8c..00e5427ef1 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -780,11 +780,12 @@ static int checkout(int submodule_progress)
>>  	if (!strcmp(head, "HEAD")) {
>>  		if (advice_detached_head)
>>  			detach_advice(oid_to_hex(&oid));
>> +		free(head);
>> +		head =3D NULL;
>
> Coccinelle suggests to use FREE_AND_NULL(head) instead.

Thanks; squashed to update 'pu'.
