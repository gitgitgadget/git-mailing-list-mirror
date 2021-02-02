Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FDDC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6193D64DCC
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBBFBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:01:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57561 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhBBFBO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 00:01:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2CB7124420;
        Tue,  2 Feb 2021 00:00:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O/nPsBekP0lRoX0+wIeF86I9pVY=; b=Cz4mhc
        1Vycz2MlBd5SkwV3veFVei7RvMNYKEK4ahEf33TUrSKvs8sLW/JcenhygJ+AxGHL
        IMYYD9BbjEOWv1XhWEIOJkp6CwiR86P2Qd4LMc2mEM62o1AD5QBJftSnBaqHv0Ru
        nNHNRSXiPhzS3RAnd52Y4NEtDGpaVVRxN6ycA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ScSX+JpA4Hoh4EXtffaVa2hk+khu6WIS
        cX/mZiwio0V8B54e1s0brsJxb9zUD1nLUMzxhQakR0Qfd4aXhURBlc591iI7PvJ9
        RXmTaYD3bMQzy4tcoUVgxR+rgsTR0vVklTyRKfRdLmav0E0vlaDOKRhYNpllKTfA
        6N71Fp+QpZQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB56C12441D;
        Tue,  2 Feb 2021 00:00:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED3D012441C;
        Tue,  2 Feb 2021 00:00:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
References: <xmqqtuqzs8m5.fsf@gitster.c.googlers.com>
        <20210202022024.1791749-1-jonathantanmy@google.com>
Date:   Mon, 01 Feb 2021 21:00:28 -0800
In-Reply-To: <20210202022024.1791749-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 1 Feb 2021 18:20:24 -0800")
Message-ID: <xmqqk0rrhxn7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9265F58E-6513-11EB-87A9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> So a dangling symref, e.g. "refs/remotes/origin/HEAD -> trunk" when
>> no "refs/remotes/origin/trunk" exists, is not reported to send_ref()
>> in the same way as an unborn "HEAD"?
>
> I've tried it, and yes, for_each_namespaced_ref() will not report it.
> Looking at the code, I think it is packed_ref_iterator_advance() which
> checks for broken objects and skips over them.
>
>> I would have expected that we'd
>> report where it points at, and for that to work, you'd have to use
>> not just the vanilla send_ref() as the callback, but something that
>> knows how to do "are we expected to send unborn symrefs" logic, like
>> send_possibly_unborn_head does.
>> 
>> That "changed to tolerate ... should work" worries me.
>> 
>> If "for_each_namespaced_ref(send_ref, &data)" will never call send_ref()
>> with NULL (as in (void *)0) oid, then that would be OK,
>
> If it called send_ref() with (void *)0 OID, it would segfault with the
> current code, which calls oid_to_hex() on the OID unconditionally.
>
>> but if it
>> ends up calling with NULL somehow, it is responsible to ensure that
>> data->symrefs is true and flag has REF_ISSYMREF set, or send_ref()
>> would misbehave, (see the first part of your message, which I am
>> responding to), no?
>
> If it did, then yes.

So, in other words, the series is *only* about HEAD and no other
symrefs are reported when dangling as "unborn"?
