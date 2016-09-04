Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4770F1FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 07:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbcIDHCA (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 03:02:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750881AbcIDHB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 03:01:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22D9F33093;
        Sun,  4 Sep 2016 03:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vXL9oK1L2+WJ
        OvAMFaLDPjBTVP0=; b=j/4JbNsLw+gt2M/CCyYdEJ5tEj1JbrKnlpmWih2mPSkh
        XYg3Su2lFJD1rfm2Um8IYOZAAiNnFFbU5uw/vZutnMSungiFH8vh94ObxwmwuBaK
        xvUEaga2E8woJiFU3m50wjqmkSjRDF06X7nOS0fGPIaLQDZTOpGFco8ktnRTkfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JloRcz
        mV+7ADBtyor/8DQLsA5ALtbF52rfGD9xjyAJTbIa1FXSV46mzn/7O5kIIVg12R1x
        AgyI3OfJcJZh3XN4lM5VyyumpDvh1CYbmLHWZkQiCpuaFiUDc8fZXraKYIkDiYsS
        GYdKzY3WkYScEj0P9bd2icsWyO8HLz23xIJUM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A5C633091;
        Sun,  4 Sep 2016 03:01:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9691433090;
        Sun,  4 Sep 2016 03:01:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Aaron M Watson <watsona4@gmail.com>, git@vger.kernel.org,
        Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] stash: allow ref of a stash by index
References: <1472944878.19860.4.camel@gmail.com>
        <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net>
Date:   Sun, 04 Sep 2016 00:01:55 -0700
In-Reply-To: <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 3 Sep 2016 21:52:09 -0400")
Message-ID: <xmqqd1kkqhb0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7850CF4A-726D-11E6-B0FA-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
>> index 92df596..af11cff 100644
>> --- a/Documentation/git-stash.txt
>> +++ b/Documentation/git-stash.txt
>> @@ -35,11 +35,12 @@ A stash is by default listed as "WIP on
>> 'branchname' ...", but
>> =C2=A0you can give a more descriptive message on the command line when
>> =C2=A0you create one.
>> =C2=A0
>> -The latest stash you created is stored in `refs/stash`; older
>> -stashes are found in the reflog of this reference and can be named us=
ing
>> -the usual reflog syntax (e.g. `stash@{0}` is the most recently
>> -created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}=
`
>> -is also possible).
>> +The latest stash you created is stored in `refs/stash`; older stashes
>> +are found in the reflog of this reference and can be named using the
>> +usual reflog syntax (e.g. `stash@{0}` is the most recently created
>> +stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}` is als=
o
>> +possible). Stashes may also be references by specifying just the stas=
h
>> +index (e.g. the integer `n` is equivalent to `stash@{n}`).
>
> Yay, a documentation update. Should it be s/references/referenced/ in
> the second-to-last line?

This seems whitespace damaged, though.   I see a few &nbsp; at the
beginning of lines.

Also, Aaron, next time please refrain from reflowing the paragraph
unnecessarily.  I am guessing that you only added one sentence at
the end of an existing paragraph, and such a patch should clearly
show that the only change it did is to append at the end.  Reflowing
will force reviewers to compare the preimage and postimage word by
word to spot what other things were changed.

> So I don't think this is technically a regression in any
> currently-functioning behavior, but it seems like a step in the wrong
> direction to add yet another layer of blind parsing.

Yes.  I agree that the implementation of this patch goes in the
wrong direction, even though it means well.

>> diff --git a/t/t3907-stash-index.sh b/t/t3907-stash-index.sh
>> new file mode 100755
>> index 0000000..72a1838
>> --- /dev/null
>> +++ b/t/t3907-stash-index.sh
>
> Double yay, tests.
>
> Do we really need a whole new script for this, though? There are alread=
y
> "stash show" tests in t3903. We should be able to repeat one of them
> using "2" instead of "stash@{2}" (for example).

Yes, it seems a lot better direction to go.  The existing script
t3903 may want to see a bit of modernization clean-up before that to
happen, though.

Thanks for a review.

