Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDEC1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 16:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfILQqp (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 12:46:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58853 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbfILQqo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 12:46:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1994244F9;
        Thu, 12 Sep 2019 12:46:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wZPyKMwFASy1bYp+YL/HsxrxL5s=; b=MKZmrW
        AliQUYHPPZDMj785Ew0vHI0UTf/qrPKHBRrGUKzgDLOUjiBx1mKc3ZUka7IDaivs
        w8C3NKGJrVbX94ZpbukcMHoc10iLzMsEsLgAn46oy8bcArreq5AqklO+yZDKLUvd
        wm/ekS2L/p5tgc+FI1wW0xZnoMp9fm93qepN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qb6S7WBFIyKkuHhDl7d3A47HNxPs399v
        xnfB/IlA8oXM/Vg4bm9bIe7rguW00VQdVXBbJE0Qaw6NaIWOz8gaSX+Xy6exEpNf
        Sgm60AMUaR7qkOr5Bjiu5Qx3oMM8zTgzMhe/Z6Vx+g938GZ6VV2iuxxHH4RsUDCZ
        UBtcW8wuwWc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8925244F8;
        Thu, 12 Sep 2019 12:46:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D105244F7;
        Thu, 12 Sep 2019 12:46:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Joel Teichroeb <joel@teichroeb.net>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 1/3] factor out refresh_and_write_cache function
References: <20190829182748.43802-1-t.gummerer@gmail.com>
        <20190903191041.10470-1-t.gummerer@gmail.com>
        <20190903191041.10470-2-t.gummerer@gmail.com>
        <xmqqwoemo131.fsf@gitster-ct.c.googlers.com>
        <20190906141812.GA128436@cat>
        <nycvar.QRO.7.76.6.1909111155540.5377@tvgsbejvaqbjf.bet>
        <20190911175201.GA11444@cat>
Date:   Thu, 12 Sep 2019 09:46:37 -0700
In-Reply-To: <20190911175201.GA11444@cat> (Thomas Gummerer's message of "Wed,
        11 Sep 2019 18:52:01 +0100")
Message-ID: <xmqqh85hh382.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E41E768A-D57C-11E9-9947-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 09/11, Johannes Schindelin wrote:
>> Hi Thomas,
>> 
>> On Fri, 6 Sep 2019, Thomas Gummerer wrote:
>> > Oops, I didn't realize there was another series in flight that also
>> > introduces 'repo_refresh_and_write_index'.  Probably should have done
>> > a test merge of this with pu.
>> 
>> Yep, our patches clash. I would not mind placing my patch series on top
>> of yours, provided that you can make a few changes that I need ;-)
>
> Sounds good.  Looking ahead further I don't mind these changes at all!
>
>> > Right, and if gentle is set to false, it avoids writing the index,
>> > which seems fine from my perspective.
>> 
>> This also suggests that it would make sense to avoid
>> `LOCK_DIE_ON_ERROR`, _in particular_ because this is supposed to be a
>> library function, not just a helper function for a one-shot built-in
>> (don't you like how this idea "it is okay to use exit() to clean up
>> after us, we don't care" comes back to bite us?).
>
> Yup, returning an error for this definitely makes sense, especially
> for future proofing.
>
>> > >  - This version allows to pass pathspec, seen and header_msg, while
>> > >    the one in builtin-add-i cannot limit the part of the index
>> > >    getting refreshed with pathspec.  It wouldn't be a brain surgery
>> > >    to use this version and adjust the caller (there only is one) in
>> > >    the builtin-add-i topic.
>> >
>> > 'pathspec', 'seen' and 'header_msg' are not used in my version either,
>> > I just implemented it for completeness and compatibility.  So I'd be
>> > fine to do without them.
>> 
>> Oh, why not keep them? I'd rather keep them and adjust the caller in
>> `builtin-add-i`.
>
> Great, I'm happy to keep them.
>
>> > There's two more differences between the versions:
>> >
>> >  - The version in my series allows passing in write_flags to be passed
>> >    to write_locked_index, which is required to convert the callers in
>> >    builtin/merge.c.
>> 
>> I can always pass in 0 as `write_flags`.
>> 
>> >  - Dscho's version also calls 'repo_read_index_preload()', which I
>> >    don't do in mine.  Some callers don't need to do that, so I think it
>> >    would be nice to keep that outside of the
>> >    'repo_refresh_and_write_index()' function.
>> 
>> Agreed.
>> 
>> > I can think of a few ways forward here:
>> >
>> >  - I incorporate features that are needed for the builtin-add-i series
>> >    here, and that is rebased on top of this series.
>> 
>> I'd prefer this way forward. The `builtin-add-i` patch series is
>> evolving more slowly than yours.
>
> Great!  I'll send an updated version of my series soon.  Thanks!

I just read the conclusion you two reached (after being down and
offline for two days) and found the reasoning totally sensible.

Thanks, both of you, for working well together.
