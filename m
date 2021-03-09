Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF478C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4265230
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 19:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhCITOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 14:14:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64801 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCITOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 14:14:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DE7EA1CC7;
        Tue,  9 Mar 2021 14:14:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZPWe7qR03u/MHrxS1yX58BVv0D4=; b=nKqwZz
        PQuWRFjppviu3eLU3iFC6lAkeDaFTriqy3VErY5hPElRl5tTU1Z7kqEx1S2dMwUx
        yFC1zd0yoZFK4oz4uVL7uD3MwKFHUI5CXpRcvyh76lvnarBlP96n3a2+TBs+ni98
        rj906zZtC14MAnZJN0HMU/OpV7cyR6/U5SbxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u1G49qHeta8Kus06fZJZHhdxnQAOVlSe
        9DmppEnNeq64JG1AHu1RWS4G/dYWqIEWNhP7Xe0o1nccueDmadEpx+SxxxUxRKOA
        HRi5Y4c7NZVeTG2DBU7WpIPWwc3e3mxt1yH4Cuc/FcT/LMcGBkxV4FDZFgz30oSt
        MQHBwo/8Cug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 154F6A1CC6;
        Tue,  9 Mar 2021 14:14:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FD65A1CC4;
        Tue,  9 Mar 2021 14:13:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <xmqqv9a58a18.fsf@gitster.c.googlers.com>
        <20210308191424.12149-1-jonathantanmy@google.com>
        <xmqqft155tiu.fsf@gitster.c.googlers.com>
Date:   Tue, 09 Mar 2021 11:13:58 -0800
In-Reply-To: <xmqqft155tiu.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 08 Mar 2021 11:34:33 -0800")
Message-ID: <xmqqwnugywax.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A2B79E2-810B-11EB-A77B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>> I dunno how involved the necessary surgery would be, though.  If
>>> this is easy to work around, perhaps it might be a better option for
>>> the overall project to ship the upcoming release with this listed as
>>> a known breakage.
>>
>> I don't think it's too difficult - I think we'll only need to filter out
>> the --pack_header when we figure out the arguments to pass for the
>> packfiles given by URI. I'll take a look.
>
> What you sent earlier is a much better band-aid than "keep the
> single args array but filter an element out in only one codepath"
> band-aid, I would think.
>
> Any change that is more involved than a single-liner trivial bugfix
> would be too late for this cycle, as we'd be cutting -rc2 by the end
> of tomorrow.

I was looking at the index_pack_args vs pass_header codepath in
fetch-pack.c again after finishing the -rc2 stuff, and noticed
something curious.

Before running the command to process in-stream packdata, we have
this bit:

	if (index_pack_args) {
		int i;

		for (i = 0; i < cmd.args.nr; i++)
			strvec_push(index_pack_args, cmd.args.v[i]);
	}

where cmd.args is what the original code (before the "we need to
prepare the index pack arguments for the offline HTTP transfer"
logic was bolted onto this codepath), so it could of course have
things like "--fix-thin", "--promisor", when we are processing an
in-stream packfile that has sufficiently large number of objects and
choose "index-pack" to process it.  None of them should be given to
the "index-pack" that processes the offline packfile that is given
via the packfile URI mechanism.

Also, because this loop copies everything in cmd.args, if our
in-stream packdata is small, cmd.args.v[0] would be "unpack-objects",
and we end up asking the command to explode the (presumably large
enough to be worth pre-generating and serving via CDN) packfile that
is given via the packfile URI mechanism.

What I think I am seeing in the code is that there are many things
other than "pass_header" that fundamentally cannot be reused between
the processing of the in-stream packdata and the offline packfile
given by the packfile URI (e.g. the in-stream one may want to use
"unpack-objects" to avoid accumulating too many tiny packs, so there
is nothing to be shared with "index-pack" that will always be used
for the offline one), and any attempt to "reuse" cmd.args while
"filtering out" inappropriate bits is fragile and unfruitful.

Instead, I think we should not touch index_pack in the earlier part
of the function at all (both reading, writing, or even checking for
NULL-ness), and use the "if (index_pack_args)" block we already have
(i.e. the one before we call start_command() to process the
in-stream packdata) to decide what the command line to process the
offline pack should look like.  That way, we won't ever risk such a
confusion like running "unpack-objects" instead of "index-pack" (but
we can choose to do so deliberately, of course---the important point
is to recognise that the in-stream pack and the offline one are
independant and we should decide how to cook them separately).

