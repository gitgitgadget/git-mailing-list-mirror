Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3842C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A3C64F96
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhCKA7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:59:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62035 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCKA7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:59:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98E91ADF82;
        Wed, 10 Mar 2021 19:59:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cIecINQ//XjksrFSwtC3hWYgx7c=; b=k2xiiq
        sv42pIOHIODocxfmD/mpN3Q0BwZvqcgRBAFciCWA9ryt71T5j2FIQdaYksBdGR6n
        kDpTLzJX5gSya8Fk6HR2hGMZwuyqw0QPiMewYC1SCm/QBwlKBgUHqyq44eoriMXk
        twkTec+5b+0ojcGJ1EaWkE9EApJUDJmCzz2QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YI8HwaKnuBwXnbii+8Q/wmuu1HuWRSri
        eDz2DZKedtkysA9aZl2qEn0WhCb6F0kyYM6Mag+/bnyRwHDyXV7mxn8QG0SuOWrz
        2zUOwDIiLzVAq0SsgAgb/hhBHWGctuRab1qd+xo/asr4F9FTciYh7/5upNLK8WFj
        UtIA/peWWrA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73E6CADF80;
        Wed, 10 Mar 2021 19:59:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7B6BADF7E;
        Wed, 10 Mar 2021 19:59:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <xmqq5z1ykckc.fsf@gitster.g>
        <20210310232906.2135256-1-jonathantanmy@google.com>
Date:   Wed, 10 Mar 2021 16:59:43 -0800
In-Reply-To: <20210310232906.2135256-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 10 Mar 2021 15:29:06 -0800")
Message-ID: <xmqqlfauh5ds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1107AA32-8205-11EB-87C6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Then get_pack() can move a lot of code out of it to this helper and
>> just call it.  The processing the other packfile obtained by the
>> packfile URI mechanism out of band can open the packstream and call
>> the helper the same way.  When packfile URI mechanism is in use, both
>> invocations of the helper would get "you are not alone so fsck may
>> hit missing objects" bit, if fsck-objects are asked for.
>> 
>> That would avoid the "duplicated logic" and still allow the code to
>> choose the best disposition of the incoming packdata per packfile.
>> 
>> In an extreme case, it is not hard to imagine that somebody prepares
>> a very small base packfile and feed it via packfile URI mechanism,
>> but have accumulated so many objects that are not yet rolled into an
>> updated base packfile---cloning from such a repository may result in
>> running unpack-objects for the packfile that came out of band, while
>> processing the in-stream packfile with index-pack.
>> 
>> Hmm?
>
> Your suggestion (as opposed to the current situation, in which we're
> locked into using index-pack for the out-of-band packfiles) would make
> this possible, yes.

Just to make sure, I am not interested in running unpack-objects on
oob packfiles, as they are expected to be "so old, big and not
changing that it is worth pre-generating" packfiles, so "yes the
approach would make that useless thing possible" is not a useful
criteria to judge how good the alternative approach would be.  If
the approach results in a cleaner design that gives us more
flexibility without risking unnecessary code duplication, it would
be a good sign that the approach is more sound than the direction we
took so far, though.

Thanks.
