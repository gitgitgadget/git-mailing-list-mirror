Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A781F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfHMUdA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 16:33:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59109 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfHMUdA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 16:33:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70394171689;
        Tue, 13 Aug 2019 16:32:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fe3nEkTQGQAH
        wT3x7QNjDwRp7UA=; b=Z2d4ANadeEd7B21TBnUKo18p9Gg35DBsZI5t9TKxPk3A
        NzWirHshzVRDWsAS/stSa5QUKZGTwapGz98R3KlR9zwdgHp4biv3b7nkkjamUtk7
        TJFptpNqcpjyZ+vM8dMw+jRMV6AN1q1ReXKZvS1CHb1AOAGnorfw62ADB9xPsx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=C3LE/J
        RU3XqE1EpGqY3YPS9RI9KbAqQknTyiqRL9HcwPSQwpLRihbILKQ6TL0K/Grx4hT/
        cXzwCpXFO0r1M805kVJK2LvlqMATy1Gq6p+EFjuqMiNqdxzb/4dk4PWAAB62wmjm
        U7h8VkCG2G+GymS2WlMA0ocB58zGTdnDfoOcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 664D7171688;
        Tue, 13 Aug 2019 16:32:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8BB1171687;
        Tue, 13 Aug 2019 16:32:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Varun Naik <vcnaik94@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [RFC PATCH] unpack-trees.c: handle empty deleted ita files
References: <20190813160353.50018-1-vcnaik94@gmail.com>
        <b7f4b745-8942-6d90-dbc5-7f79f2cc323e@web.de>
Date:   Tue, 13 Aug 2019 13:32:56 -0700
In-Reply-To: <b7f4b745-8942-6d90-dbc5-7f79f2cc323e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 13 Aug 2019 20:08:06 +0200")
Message-ID: <xmqqr25o7qmf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8939BC3C-BE09-11E9-A7A8-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 13.08.19 um 18:03 schrieb Varun Naik:
>> It is possible to delete a committed file from the index and then add =
it
>> as intent-to-add. Several variations of "reset" and "checkout" should
>> resurrect the file in the index from HEAD. "merge", "cherry-pick", and
>> "revert" should all fail with an error message. This patch provides th=
e
>> desired behavior even when the file is empty in HEAD.
>>
>> The affected commands all compare two cache entries by calling
>> unpack-trees.c:same(). A cache entry for an ita file and a cache entry
>> for an empty file have the same oid. So, the cache entry for an empty
>> deleted ita file was previously considered the "same" as the cache ent=
ry
>> for an empty file. This fix adds a comparison of the intent-to-add bit=
s
>> so that the two cache entries are no longer considered the "same".
>>
>> Signed-off-by: Varun Naik <vcnaik94@gmail.com>
>> ---
>> I am marking this patch as RFC because it is changing code deep in
>> unpack-trees.c, and I'm sure it will generate some controversy :)
>
> Lacking experience with intent-to-add I don't see why this would be
> controversial.

The "same()" function here is used to compare two cache entries
(either came from the in-core index, or fabricated out of one of the
tree objects as a potential merge result to replace the one in the
index), and is expected to tell if they are the same or the
different, which is used for example in a logic like "if the one in
the index and the one came from HEAD are not the same, then it is
not safe to continue the merge", "if the one came from HEAD and the
one from the other branch are the same, just keep the one from the
index (which may or may not be the same as HEAD)".

The original code considered that two entries with the same mode and
the same "contents" are the same.  As nobody sane tracks an empty
file for an extended span of history, that meant that most of the
time, intent-to-add entries, which has the normal mode bits for the
blobs (with or without the executable bit) and object name for a
zero length blob, would have been judged "different".

This change extends the logic to the case in which the contents
recorded in the tree-ishes is also a zero length blob.  We used to
say the I-T-A entry was the same as the recorded blob, but whether
the recorded one in the tree-ish is 0-length or 1-byte blob, this
patch does not want it to be declared the "same" as any I-T-A entry.

So in that sense, it makes the behaviour for I-T-A entries
consistent.  But it is a separate matter if the consistency is good;
we do not want our code to be consistently wrong ;-)

>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 50189909b8..9b7e6b01c4 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -1661,6 +1661,7 @@ static int same(const struct cache_entry *a, con=
st struct cache_entry *b)
>>  	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
>>  		return 0;
>>  	return a->ce_mode =3D=3D b->ce_mode &&
>> +	       !ce_intent_to_add(a) =3D=3D !ce_intent_to_add(b) &&
>
> Why the bangs?  This would work just as well and be slightly easier to
> read without negating both sides, wouldn't it?

Looking at the implementation of that macro, I agree.  If it were
"returns non-zero for true, zero for false, we do not guarantee that
we return the same non-zero value for true all the time", then these
bangs do make sense, but that is not the case here.

But more importantly, can both sides of the comparison be I-T-A
entries?

I offhand do not think such a situation can arise (a cache entry
with I-T-A bit on can only come from the in-core index, IIUC, and
never from a tree-ish in this codepath), but if we encouter such a
case, I would imagine that we do not want to treat an I-T-A entry to
be the same with anything else, including another I-T-A entry.

So perhaps=20

+	!ce_intent_to_add(a) && !ce_intent_to_add(b) &&

i.e. "a cache entry is eligible to be same with something else only
when its I-T-A bit is unset".

I dunno.

>>  	       oideq(&a->oid, &b->oid);
>>  }
>>
>>
