Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C2AC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3805C61132
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhDNVHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 17:07:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56290 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhDNVHb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 17:07:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD924B8140;
        Wed, 14 Apr 2021 17:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ILvDsHcoTjF9
        8taWhfFIO/JsAvw=; b=rG/20gWXKI6OqLtwQzPQ41D4mkjIEApnwbQTWrS+gpSF
        BgH8VIpnlxS3XzhPudvarA2MZHIP/oHpIiN3j5SYL7avwVKTVWFapLFI0GIeP73N
        oPRgmk4y30hYW38vjwcLB4LyXreE8EUa35fd58bQVjyk+dkqp7DRL3vokVpk8/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QNFNDw
        tvji9mRSiw18ZMpWwmmVMmduo+Iudr7SKDhf2mFV8HbSoj/JunNtRqWflwlN5cKj
        +mML47tklrvQAEshFD7FX/bCcZvnDbETE7IqnGZnjShPbs7lCG2Y4/5t3v68dTy7
        7fdR5M8lMxvGm0nXZxPcsbCkdRQij2DYg5rxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3738B813F;
        Wed, 14 Apr 2021 17:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 36A18B813D;
        Wed, 14 Apr 2021 17:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
References: <cover.1617967252.git.ps@pks.im> <cover.1618234575.git.ps@pks.im>
        <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
        <xmqqfsztlwxb.fsf@gitster.g> <YHbZNL0gzw0+1k5h@ncase>
Date:   Wed, 14 Apr 2021 14:07:07 -0700
In-Reply-To: <YHbZNL0gzw0+1k5h@ncase> (Patrick Steinhardt's message of "Wed,
        14 Apr 2021 13:59:48 +0200")
Message-ID: <xmqqmtu0y3r8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F61AFEA-9D65-11EB-8058-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> I however have to wonder why this need so much code (in other words,
>> why do we need more than just adding something similar to this block
>> in the revision.c machinery:
>>=20
>> 	} else if (!strcmp(arg, "--objects")) {
>> 		revs->tag_objects =3D 1;
>> 		revs->tree_objects =3D 1;
>> 		revs->blob_objects =3D 1;
>>=20
>> that flips <type>_objects member bits?) though.
>
> So if we make this part of the rev machinery, I guess your idea is that
> we can just put the logic into `show_object()`?

Not necessarily.  I was making a lot more na=C3=AFve observations.

 * Even though we have 3 independent (tag|tree|blob)_objects bits,
   they are all set to true with "--objects" or they are cleared
   without.  There is no codepath that flips these bits to set some
   but not all of them to be set.

 * But if we look at the the hits from

    $ git grep -C2 -E -e '([.]|->)(tag|tree|blob)_objects' \*.[ch]

   it is clear that the code is (at least trying to be) prepared for
   them to be set independently.  The .tree_objects member is often
   checked without checking others to mark the tree objects on the
   edge of the range uninteresting, for example.

   It of course is unknown how well the code is actually prepared
   for these three bits to be set independently, as nobody can set
   these bits independently.

 * Which makes a na=C3=AFve reader to wonder if it would be sufficient
   to have a silly option, like this:

 	} else if (!strcmp(arg, "--filter=3Dobject:type=3Dtree")) {
 		revs->tag_objects =3D 0;
 		revs->tree_objects =3D 1;
 		revs->blob_objects =3D 0;

   in the same if/else if/... cascade as the above (and other types
   as well), in order to do the same thing as this series.

And, the above led to the question---the patches in your series
apparently do a lot more (even if we discount the option parsing
part), and I was wondering if that is because the independence
between these three bits the existing code aspires to maintain is
broken.

> Anyway, this is assuming that I'm not misinterpreting what you mean by
> your above comment. So please let me know if I misunderstood.
