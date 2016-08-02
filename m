Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA991F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 17:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbcHBRFk (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 13:05:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030321AbcHBREv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 13:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D17832890;
	Tue,  2 Aug 2016 13:01:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xN2MeYOtV+K3S2lvkL0IdJf4VVY=; b=G3UjHX
	JmGBDyCGpplk8G2HMqr1F4adhV5KYP0pFe5jY54Ir06LiHQxX7nW+zE+WWgNGHd8
	/BoMxQ+ilk+YOS+nmr5rOv9/XpD3iAEPVfq715bN+m/ntzH02ai50i/EAbliZrxt
	pDkWFoIPmexOKqW1nu5xuLjMfIKcEwXXB10nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mO0wgIFiwDBbF1dERiLCCbZnxMAuRKl8
	0SWSRASlyhhi21SsfXt01rRt+iI9Um86Ckhi/RgUJjWBrQqNC/nkoF11iZ4ldls5
	lxmyNwwzii+NCqpdS3UgEDGM+KC/ce9bdFyBZLSn5UstXjAp1srniPOFXS2deGfu
	Um8XYsYLEBI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 854993288F;
	Tue,  2 Aug 2016 13:01:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 081EB3288E;
	Tue,  2 Aug 2016 13:01:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 1/4] patch-ids: stop using a hand-rolled hashmap implementation
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-2-kcwillford@gmail.com>
	<xmqqoa5gmas6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607301056120.11824@virtualbox>
	<xmqqy44gi7bp.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608021013010.79248@virtualbox>
Date:	Tue, 02 Aug 2016 10:01:09 -0700
In-Reply-To: <alpine.DEB.2.20.1608021013010.79248@virtualbox> (Johannes
	Schindelin's message of "Tue, 2 Aug 2016 12:30:36 +0200 (CEST)")
Message-ID: <xmqqshunf6lm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B725DBDE-58D2-11E6-8718-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 1 Aug 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > It would be a serious bug if hashmap_entry_init() played games with
>> > references, given its signature (that this function does not have any
>> > access to the hashmap structure, only to the entry itself):
>> >
>> > 	void hashmap_entry_init(void *entry, unsigned int hash)
>> 
>> I do not think we are on the same page.  The "reference to other
>> resource" I wondered was inside the hashmap_entry structure, IOW,
>> "the entry itself".
>
> Oh, I see now.
>
>> Which is declared to be opaque to the API users,
>
> Actually, not really. We cannot do that in C: we need to define the struct
> in hashmap.h so that its size is known to the users.

What I meant was what Documentation/technical/api-hashmap.txt said.
I know that we cannot embed a true "opaque" structure in C just as
you do.

> That is the reason, I guess, why we have the documentation in
> Documentation/technical/api-hashmap.txt: it would have to talk about your
> hypothetical hashmap_entry_clear() (which would better be named
> *_release() BTW, unless I misunderstood what you want a hypothetical
> future version of that function to do).

I think there is no misunderstanding on your part.  I am following
the conclusion (as I recall) of a discussion on the list not in so
distant past about X_free(x) that frees the resource an instance of
"struct X" holds and also the instance itself, and X_clear(x) that
only frees the resources without freeing the instance (the latter of
which allows x to be on stack, you do X_init(&x) and conclude with
X_clear(&x)).  The name X_clear() is more in line with existing API
functions like string_list_clear(), argv_array_clear().  An oddball
is strbuf_release(), which I think made you make the above comment.

>> I have a slight preference to avoid the lazy "void *", but that is
>> an unrelated tangent.
>
> Oh, we are already safely in Unrelated Tangent Land for a while, I would
> think. Nothing of what we are discussing in this thread has anything to do
> with Kevin's patch series,...

Oh, no question about that.  Go back to my review, to which your
message I am responding to is a reply to.  What you wrote are all
about things after "This is a tangent, but this made me wonder if it
is safe to simply free(3) the result...", which pointed out rough
points in the hashmap API from the API user's point of view and
suggested a few possible improvement opportunities.

>> I am saying that an uneven over-enginnering is bad.
>
> Hmm. I guess that the _init() function could be replaced by an _INIT macro
> a la STRBUF_INIT. Not sure it is really worth the effort, though.

I do not think so, as X_init() and X_INIT() from the point of view
of the API user would not make much difference; as long as the
documentation does not say it is safe to make it go out of scope
without "deinitialize" it, the reader will be left wondering.
