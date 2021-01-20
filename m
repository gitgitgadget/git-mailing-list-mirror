Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F49CC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD4B23142
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 07:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbhATHHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 02:07:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65302 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbhATHHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 02:07:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B592211E2BA;
        Wed, 20 Jan 2021 02:06:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/QCETXuZI8eFq5DnvBB2doqM0U8=; b=XwYwmB
        EIRv+H+8z8GG4GVPnszq8+n2qxL//4nToG4vqqiXfXiEbaBI/nQQ/1ZZZ5YtcMu7
        dFXdufKNhNbfjBi1Puy0QX2Dmc8HWCG92t7Onz9j9ld0QmfPS5kaLHS1E8SkTrpU
        td/1+RveN74Iss6Nhk4SpyOsGdAKGRKxnRhWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mv/RFVPqYnd0zCrCzBp8tKG0Eywrgaeh
        mXKe2fBkWz/OSGCpZYL82hePH1Yph7mTZPBp+9HOgfqKK6NVpOtXoE8nVUa1ah2X
        tqPUS2kCNqvhlpKjQZ1z+nMn/mUHboOccRCsKRkvjyidt/OjKaBTZ4P1/83IcBVy
        uR6Km9HVNfE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A200211E2B9;
        Wed, 20 Jan 2021 02:06:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0AAA11E2B8;
        Wed, 20 Jan 2021 02:06:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com
Subject: Re: [PATCH RESEND] refs: Always pass old object name to reftx hook
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
        <ae5c3b2b783f912a02b26142ecd753bf92530d2f.1610974040.git.ps@pks.im>
        <xmqq4kjdkgol.fsf@gitster.c.googlers.com> <YAfNcyZ7mj4J69XT@ncase>
Date:   Tue, 19 Jan 2021 23:06:15 -0800
In-Reply-To: <YAfNcyZ7mj4J69XT@ncase> (Patrick Steinhardt's message of "Wed,
        20 Jan 2021 07:28:03 +0100")
Message-ID: <xmqqft2wgk9k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD5C03A4-5AED-11EB-9EA1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> Even without this change, the current value the hook can learn by
>> looking the ref up itself if it really wanted to, no?
>
> I think the biggest problem is that right now, you cannot discern the
> actual intention of the user because the information provided to the
> hook is ambiguous in the branch creation case: "$ZERO_OID $NEW_OID $REF"
> could mean the user intends to create a new branch where it shouldn't
> have existed previously. BUT it could also mean that the user just
> doesn't care what the reference previously pointed to.

Yes, it can mean both, but when you pretend to be that hook,
wouldn't you check if the ref exists?  If not, the user is trying to
create it, and otherwise, the user does not know or care what the
original value is, no?

> The user could now try to derive the intention by manually looking up
> the current state of the reference. But that does feel kind of awkward
> to me.

So in short, with respect to the OLD slot, there are three kind of
end-user intention that could be conveyed to the hook:

 (1) the user does not care, so 0{40} appears in the OLD slot here,
 (2) the user is creating, so 0{40} apears in the OLD slot here, and
 (3) the user does care, and this is the OID in the OLD slot,

And (1) and (2) cannot be separated without looking at the ref (in
other words, if the hook really cares, it can find it out).

But if you replace 0{40} with the current OID, then you are making
it impossible to tell (1) and (3) apart.  The hook cannot tell the
distinction even if it is willing to go the extra mile.

So that sounds like a strict disimprovement to me.

If you can invent a way to help the hook to tell all three apart, I
am very much interested.  It would earn you a bonus point if you can
do so without breaking backward compatibility (but I doubt that it
is possible).

> To me, having clearly defined semantics ("The script always gets old and
> new value of the branch regardless of what the user did") is preferable
> to having ambiguous semantics.

But "The script always gets old that was given by the user and the
new value to be stored" is very clearly defined semantics already.

On the other hand, "The script gets a non-NULL object name in both
cases, either when the user says s/he does not care, or when the
user insists that the old value must be that, and it is not just
ambiguous but is impossible to tell apart" is worse than just being
ambiguous.
