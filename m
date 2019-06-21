Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59BEB1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 16:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFUQFh (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 12:05:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57962 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUQFh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 12:05:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1AE668F5F;
        Fri, 21 Jun 2019 12:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kXZMJjy8G0Oh
        j2TWekaQYV5QspM=; b=kbuntiSjMqAQv2SA03mNSl5CkJ+b+JKJbAN5wf6H1Zo7
        lwePC9R9XrS1U5Kq0kwQt0oviy7LWvY2SIVeFg5sg5DktFmgj+2PHJvJEA91lPAZ
        iyYE40UZSibBthdGoSmhekIBs9c+16IK7ThLyqceXXAjbOchBBCouW1eA5HLYsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mSzYn6
        y+RpQJcxmaO2rRYEzXVlWDo00eUCX6vckAbnNJoCZYIENQrg+ry5F1ewv1Q9pzaP
        lqXETjUxW4NIMdvBnHWWI9b3Un8LJJZrtyKufZeLonfAxSargJuZdWTLal9BJjXc
        swdYH00eLjE0YaLmK/gJRMA+QwAzo2J+An/MI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B747168F5E;
        Fri, 21 Jun 2019 12:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A406468F5C;
        Fri, 21 Jun 2019 12:05:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH] push: make "HEAD:tags/my-tag" consistently push to a branch
References: <20190526225445.21618-1-avarab@gmail.com>
        <20190621144447.21769-1-avarab@gmail.com>
Date:   Fri, 21 Jun 2019 09:05:26 -0700
In-Reply-To: <20190621144447.21769-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 21 Jun 2019 16:44:47 +0200")
Message-ID: <xmqq4l4ily9l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6354856E-943E-11E9-BC01-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This resulted in a case[1] where someone on LKML did:
>
>     git push kvm +HEAD:tags/for-linus
>
> Which would have created a new "refs/heads/tags/for-linus" branch in
> their "kvm" repository. But since they happened to have an existing
> "refs/tags/for-linus" reference we pushed there instead, and replaced
> an annotated tag with a lightweight tag.

I do not think that is a problematic behaviour in the context of
asking Linus to pull when every time a merge window opens.  One
would keep refs/tags/for-linus at the publishing site, and update it
(forcing as necessary) before request-pull.  If it went to a branch
with confusing name tags/for-linus, that would be a disaster.

> Now we'll print out the following advice when this happens, and act
> differently as described therein:
>
>     hint: The <dst> part of the refspec matched both of:
>     hint:
>     hint:   1. tags/my-tag -> refs/tags/my-tag
>     hint:   2. tags/my-tag -> refs/heads/tags/my-tag
>     hint:
>     hint: Earlier versions of git would have picked (1) as the RHS star=
ts
>     hint: with a second-level ref prefix which could be fully-qualified=
 by
>     hint: adding 'refs/' in front of it. We now pick (2) which uses the=
 prefix
>     hint: inferred from the <src> part of the refspec.
>     hint:
>     hint: See the "<refspec>..." rules  discussed in 'git help push'.

"matched" in past tense means that your example scenario actually
has such a confusing branch?  Then I think the above is OK (or just
silently updating the branch is also fine, I think).  If there were
no such branch currently, the above woudl be a serious regression,
but as long as both exist, I think it is probably OK.  From my quick
scan of your new tests, I couldn't quite tell if that case (i.e. the
a tag "my-tag" exists but a bbranch "tags/my-tag"does not exist at
the receiving end when push happens, and the tag is updated without
touching the branch nor giving extra warnings and hints) is covered,
though.

Thanks.

