Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244DFC433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1A320659
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VTycNIqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIHVBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:01:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61607 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgIHVA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 17:00:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64C11E74A5;
        Tue,  8 Sep 2020 17:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ylRFPpfue6ZI+CO1lRc7vbX3x2g=; b=VTycNI
        qCbTe9u1OGAB3LvP3DaM2DLVZ7GCH68sbh70MKnDYO/Puw3LUBKFEeSi+Hwgwb5s
        syfA7B4OkG3Ne8Vd7qZJeWDOGSYeUKeK89uIf8WEWcd2m5VXcuuWE/MoCPQroZ+u
        m5qxlNxKYx7S/iXchHn8m2DTTPUweZkYmZ1gY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rcB+1CYZ/XZI4LyBBqrbeRHZBP+L2gYO
        kR4quGk7ZSoHhOfYnG7kOrkChXSzQBOAoSlb1ZsAlmTSVbYKYIFOrRckfbu2ss5t
        +T+uQdmF1dlbs2HbqPjrqVvw52vgjdSve2jWBPSO3XrC3G4GaKdXca8lPkV4gmoj
        Tx5pEH+L7/I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D1A1E74A3;
        Tue,  8 Sep 2020 17:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C8B18E74A1;
        Tue,  8 Sep 2020 17:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
        <xmqqmu211s43.fsf@gitster.c.googlers.com>
        <20200908160021.GB40807@mail.clickyotomy.dev>
Date:   Tue, 08 Sep 2020 14:00:52 -0700
In-Reply-To: <20200908160021.GB40807@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Tue, 8 Sep 2020 21:30:21 +0530")
Message-ID: <xmqqmu20x9tn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 622A81E8-F216-11EA-8CEE-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> to the updated tip of the remote instead. The condition:
>
> 	if (!oideq(&ref->old_oid, &ref->old_oid_expect))
>
> would evaluate false since we're using `use_tracking`. This essentially
> reduces the behavior of `--force-with-lease=<ref>` to `--force` in this
> scenario.

Yes, that is exactly why I have kept saying that the form without
<expect> is not safe and cannot be made safer especially when
auto-fetching is involved.

> Right, I agree with what is described above. But, in this patch, we are
> looking at the reflog of the _local_ branch that is going to be updated
> on the remote side. The point of going through the reflog is to see if
> the current tip its remote-tracking branch is present in one of the
> reflog entries implying that any new changes (pushes from another user)
> in the meantime aren't ignored and overwritten with our push.
> Would that be an incorrect assumption?

I am afraid it is.  You may have looked at it and even kept it
locally, to be looked at later, without letting it affect what you
are going ot force-push in any way.  You might later come back and
resurrect their change on top of what you force pushed, or more
likely you may simply forget, especially if the forced push goes
through without failing.

> Yes, that sounds like a good way to mitigate this issue; but that being
> said, setups where `--force-with-lease` is being used as an alias for
> `--force` should probably be taken into consideration though.

We cannot help, and it is not our job to dispel, misconfigurations
and misconceptions caused by following bad pieces of advice other
people gave our users, though.
