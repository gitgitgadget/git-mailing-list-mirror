Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A3720899
	for <e@80x24.org>; Thu, 27 Jul 2017 21:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdG0VBj (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 17:01:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64862 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751441AbdG0VBi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 17:01:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA38D8917C;
        Thu, 27 Jul 2017 17:01:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1KYwmc45CpPbcl0D62VFLoJxx4E=; b=CjwonX
        /udRhZ7AkdF9Bjj9t/IxMImGKURn5ZIe6IhnrdWzoKANqEcd1RhSqy8DEfOT4nky
        cS72viD5bXxsOmbenhXITeofm6jsemj125Gyp6v1m7fBatW112GNCMavnakodwhN
        fhAV1QUHnnuzHOirmbNi8Yg9SgZOBrPkoeBTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CKzKyE35lKhC818/vKr4Y3ofjs8rgNAq
        kqeoueqBdGpev7fJLM+vsRFpsygIOaLs+k8XXkn1c6ZJx3v8nSM29gfhtE3vvt0h
        u/Z02BaXFHiy+AS+3yeKHGYheJYtrwCqcC61l+oBmnDmH/XW37YDbH6+Xac1Q8/Z
        cJ61i4n543o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E202D8917B;
        Thu, 27 Jul 2017 17:01:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 501FF89178;
        Thu, 27 Jul 2017 17:01:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Raman Gupta <rocketraman@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] Git rerere and non-conflicting changes during conflict resolution
References: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
        <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
        <xmqqo9s8uuth.fsf@gitster.mtv.corp.google.com>
        <20170725205843.bi6kyqjlzyodmxuq@sigill.intra.peff.net>
        <xmqqeft3u0u5.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 27 Jul 2017 14:01:30 -0700
In-Reply-To: <xmqqeft3u0u5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 26 Jul 2017 00:14:10 -0700")
Message-ID: <xmqqfudhmw5x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4040996-730E-11E7-BF18-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> From the user's perspective, calling X "rerere" would probably be OK[1].
>> But from an implementation perspective (and to keep the existing
>> plumbing available and unchanged), it probably makes sense to call it
>> something else, and have it run both rerere and a new plumbing command
>> to do the merge-fix work (or call it nothing, and assume that users will
>> either touch the plumbing directly or will use "git merge" to trigger
>> both).
>> ...
>> I think it should be its own plumbing tool that merge calls alongside
>> rerere. ;)
>
> As long as we use the database keyed with <A,B> and take the merge
> base into account, "git am" and "git cherry-pick" would not be able
> to use the merge-fix machinery, so in that sense, calling X "rerere"
> would not be OK, but I agree with your general sentiment about the
> UI visible to the end users.

Actually, I guess "cherry-pick" could use it if we think hard and
long enough and come up with an ideal scheme to compute the index
into the merge-fix database.

Imagine this topology:

       A---o---o---...        topic #1
      /
 o---o---o---...              mainline
      \
       o---B---o---C---...    topic #2

where topic #1 renames 'xyzzy' to 'frotz' at commit A, and topic #2
adds a new mention of 'xyzzy' in file F at commit B and another in
file E at commit C.

In the ideal world, we would have two merge-fix database entries,
one that turns 'xyzzy' in file F to 'frotz' that is keyed by the
pair of commits <A,B>, and the other that does the same in file E
that is keyed by <A,C>.  When merging the topic #1 and the topic #2
together, or when merging the topic #2 to a mainline that already
has merged the topic #1, the merge-fix machinery notices that one
side has A but not B nor C, and the other side has B and C but not
A, and finds these two merge-fixes and applies on top of the textual
merge.

If we are cherry-picking C to something that already has A, then, we
should be able to notice that the history that receives the cherry-pick
has A but not C, and C, which is being picked, does not have A, and
decide that merge-fix <A,C> is relevant.

If we do this purely with commit object name, it will still not work
if we cherry-pick A to mainline and then we cherry-pick C.  The
mainline may hae change from A but does not have the exact commit A.

Which brings us back to your earlier idea to use something like
patch-id to identify these individual changes.  I am not sure how we
can structure the merge-fix database so that we can efficiently find
which "changes" are already on a branch.
