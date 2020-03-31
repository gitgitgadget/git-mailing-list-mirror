Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2715EC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F227E2145D
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p8EcdSV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCaSVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:21:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54673 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaSVg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 14:21:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE580B6C3B;
        Tue, 31 Mar 2020 14:21:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cKuRY/yFSR9VKJiyO9VQSYRCa5I=; b=p8EcdS
        V3BamlloCHh9OcyVfZIH94e0B1TuZJSAocSJPmBks8SU44Nt0N/OtYGzmgWws3xz
        1Nh31ThtLM/BVdoHzyoJoCp8axh/ehOY6fKVcHs1kHf5m5Yc8WLaq6xA/W31xdBL
        VyeoaxVdVHgTeok6A2l4Hp19lJmZoXOF68mtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LNI3RiQqF2G04Uw4/pmDbpSlQ7w5Fl0c
        4kYwILqJc1aQPLKQUBWo864+V5+EikH4UjgMT6Mg1oqVb6vIKNMBjFsBFUR08eCT
        c7OQtVa9ra8DFzNaZ2AcZBS8iN1jq7beLGGRGCZCGKg3/t6zxyMikrhoEgNs55T9
        qsuZsB89ah0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2C85B6C3A;
        Tue, 31 Mar 2020 14:21:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BF6F6B6C37;
        Tue, 31 Mar 2020 14:21:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] diff: restrict when prefetching occurs
References: <b956528c-412b-2f38-bd90-1fa2ae4b8604@gmail.com>
        <20200331165058.53637-1-jonathantanmy@google.com>
        <d1995983-c5b2-8d44-3949-10286b3f7c0e@gmail.com>
Date:   Tue, 31 Mar 2020 11:21:30 -0700
In-Reply-To: <d1995983-c5b2-8d44-3949-10286b3f7c0e@gmail.com> (Derrick
        Stolee's message of "Tue, 31 Mar 2020 13:48:10 -0400")
Message-ID: <xmqqlfng75cl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 723DC072-737C-11EA-B2CA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>>> +		for (i = 0; i < rename_dst_nr; i++) {
>>>> +			if (rename_dst[i].pair)
>>>> +				continue; /* already found exact match */
>>>> +			add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
>>>
>>> Could this be reversed instead to avoid the "continue"?
>> 
>> Hmm...I prefer the "return early" approach, but can change it if others
>> prefer to avoid the "continue" here.
>
> The "return early" approach is great and makes sense unless there is
> only one line of code happening in the other case. Not sure if there
> is any potential that the non-continue case grows in size or not.
>
> Doesn't hurt that much to have the "return early" approach, as you
> wrote it.

Even with just one statement after the continue, in this particular
case, the logic seems to flow a bit more naturally.  "Let's see each
item in this list.  ah, this has already been processed so let's
move on.  otherwise, we may need to do something a bit more."  It
also saves one indentation level for the logic that matters ;-)

>>>> +		for (i = 0; i < rename_src_nr; i++)
>>>> +			add_if_missing(options->repo, &to_fetch, rename_src[i].p->one);
>>>
>>> Does this not have the equivalent "rename_src[i].pair" logic for exact
>>> matches?

One source blob can be copied to multiple destination path, with and
without modification, but we currently do not detect the case where
a destination blob is a concatenation of two source blobs.  So we
can optimize the destination side ("we are done with it, no need to
look---we won't find anything better anyway as we've found the exact
copy source") but we cannot do the same optimization on the source
side ("yes, this one was copied to path A, but path B may have a
copy with slight modification), I would think.
