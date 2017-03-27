Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04FCB20969
	for <e@80x24.org>; Mon, 27 Mar 2017 06:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbdC0GHG (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 02:07:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64596 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751394AbdC0GHF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 02:07:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3533B748C2;
        Mon, 27 Mar 2017 02:07:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vdYlfrEcTueSKanHRVCZzhiQyQw=; b=ZOn28O
        rHpZoIr/kVKU8UYinULJNwtCnqAyQ8bwAevG/lBHhKDmj9Q1a78QGh0s+X+x3cBx
        LfgGuKAWuxB6NpFvkI6/HZcOwQClxVs8LZdaG4d1ZHmwYSL4pxfkOjoeliwzFuvb
        oDZGkr4tzDkrntqD1qeeIalj9T2yoiW+W6iRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uVTNaMwfLgK0VkXmUBMd5h/++rXuyp7K
        cJEVnbwIgwBiEUwmw1MZU83bCRPuzkXY9zQ/h/Pk38VahoWxGjja1aMEJVdVxfOL
        +dXW6lNHBo3VtGnk2Y9NwTuFgLE8cupUlO2cI1Aby3ZjitqmOWdziwR4SWXjkwzK
        ky1EKBz25rw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D14B748C1;
        Mon, 27 Mar 2017 02:07:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B052748C0;
        Mon, 27 Mar 2017 02:07:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
        <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
        <20170326061826.yx6nh3k2ps6uyyz6@sigill.intra.peff.net>
        <xmqqinmv4ojt.fsf@gitster.mtv.corp.google.com>
        <20170327011140.icqfc4lqlarvae6l@sigill.intra.peff.net>
Date:   Sun, 26 Mar 2017 23:07:02 -0700
In-Reply-To: <20170327011140.icqfc4lqlarvae6l@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 26 Mar 2017 21:11:40 -0400")
Message-ID: <xmqqbmsn2qyh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9924665A-12B3-11E7-A8D4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> If a malicious site can craft two packfiles that hash to the same,
>> then it can first feed one against a fetch request, then feed the
>> other one when a later fetch request comes, and then the later pack
>> is discarded by the "existing data wins" rule.  Even though this
>> later pack may have all the objects necessary to complete the refs
>> this later fetch request asked for, and an earlier pack that
>> happened to have the same pack trailer hash doesn't have these
>> necessary objects, the receiver ends up discarding this necessary
>> pack.  The end result is that the receiver's repository is now
>> corrupt, lacking some objects.
>
> No, I don't think so. We don't trust the trailer hash for anything to do
> with corruption; we actually inflate the objects and see which ones we
> got. So the victim will notice immediately that what the attacker sent
> it is insufficient to complete the fetch (or push), and will refuse to
> update the refs. The fetch transfer, but nobody gets corrupted.

In the scenario I was presenting, both the original fetch that gives
one packdata and the later fetch that gives another packdata (which
happens to share the csum-file trailing checksum) satisfy the "does
the new pack give us enough objects to really complete the tips of
refs?" check.  The second fetch transfers, we validate the packdata
using index-pack (we may pass --check-self-contained-and-connected
and we would pass --strict if transfer-fsck is set), we perhaps even
store it in quarantine area while adding it to the list of in-core
packs, make sure everything is now connected from the refs using
pre-existing packs and this new pack.  The index-pack may see
everything is good and then would report the resulting pack name
back to index_pack_lockfile() called by fetch-pack.c::get_pack().

That was the scenario I had in mind.  Not "bogus sender throws a
corrupt pack at you" case, where we check the integrity and
connectivity of the objects ourselves.

And the trailer hash the sender added at the end of the pack data
stream does not have to come into the picture.  When we compute that
ourselves for the received pack data, because the sender is trying a
successful collision attack (they gave us one pack that hashes to
certain value earlier; now they are giving us the other one), we
would end up computing the same.

But even though both of these packs _are_ otherwise valid (in the
sense that they satisfactorily transfer objects necessary to make
the refs that were fetched complete), because we name the packs
after the trailer hash and we cannot have two files with the same
name, we end up throwing away the later one.

As I said, it is a totally different matter if this attack scenario
is a practical threat.  For one thing, it is probably harder than
just applying the straight "shattered" attack to create a single
object collision--you have to make two packs share the same trailing
hash _and_ make sure that both of them record data for valid
objects.  But I am not convinced that it would be much harder
(e.g. I understand that zlib deflate can be told not to attempt
compression at all, and the crafted garbage used in the middle part
of the "shattered" attack can be such a blob object expressed as a
base object--once the attacker has two such packfiles that hash the
same, two object names for these garbage blobs can be used to
present two versions of the values for a ref to be fetched by these
two fetch requests).
