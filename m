Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C5D20756
	for <e@80x24.org>; Mon, 16 Jan 2017 09:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdAPJ0h (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 04:26:37 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:37471 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdAPJ0f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 04:26:35 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jan 2017 04:26:34 EST
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id E58BBC4FD;
        Mon, 16 Jan 2017 10:17:13 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id E09A710034B;
        Mon, 16 Jan 2017 10:17:13 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id DB21A60324;
        Mon, 16 Jan 2017 10:17:13 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Manuel Ullmann <ullman.alias@posteo.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation/bisect: improve on (bad|new) and (good|bad)
References: <20170113144405.3963-1-chriscool@tuxfamily.org>
        <xmqqinpihiwz.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 16 Jan 2017 10:17:14 +0100
In-Reply-To: <xmqqinpihiwz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 13 Jan 2017 11:14:04 -0800")
Message-ID: <vpqfukjpdnp.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.5.11 (smtps.univ-grenoble-alpes.fr [0.0.0.0]); Mon, 16 Jan 2017 10:17:13 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> The following part of the description:
>>
>> git bisect (bad|new) [<rev>]
>> git bisect (good|old) [<rev>...]
>>
>> may be a bit confusing, as a reader may wonder if instead it should be:
>>
>> git bisect (bad|good) [<rev>]
>> git bisect (old|new) [<rev>...]
>>
>> Of course the difference between "[<rev>]" and "[<rev>...]" should hint
>> that there is a good reason for the way it is.
>>
>> But we can further clarify and complete the description by adding
>> "<term-new>" and "<term-old>" to the "bad|new" and "good|old"
>> alternatives.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  Documentation/git-bisect.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks.  The patch looks good.

Looks good to me too.

> I think the answer to the question "why do we think we need a single
> bisect/bad?" is "because bisection is about assuming that there is
> only one commit that flips the tree state from 'old' to 'new' and
> finding that single commit".

I wouldn't say it's about "assuming" there's only one commit, but it's
about finding *one* such commit, i.e. it works if there are several such
commits, but won't find them all.

> But what if bad-A and bad-B have more than one merge bases?  We
> won't know which side the badness came from.
>
>                           o---o---o---bad-A
>                          /     \ / 
>     -----Good---o---o---o       / 
>                          \     / \
>                           o---o---o---bad-B
>
> Being able to bisect the region of DAG bound by "^Good bad-A bad-B"
> may have value in such a case.  I dunno.

I could help finding several guilty commits, but anyway you can't
guarantee you'll find them all as soon as you use a binary search: if
the history looks like

--- Good --- Bad --- Good --- Good --- Bad --- Good --- Bad

then without examining all commits, you can't tell how many good->bad
switches occured.

But keeping several bad commits wouldn't help keeping the set of
potentially guilty commits small: bad commits appear on the positive
side in "^Good bad-A bad-B", so having more bad commits mean having a
larger DAG to explore (which is a bit counter-intuitive: without
thinking about it I'd have said "more info => less commits to explore").

So, if finding all guilty commits is not possible, I'm not sure how
valuable it is to try to find several of them.

OTOH, keeping several good commits is needed to find a commit for which
all parents are good and the commit is bad, i.e. distinguish

Good
    \
     Bad <-- this is the one.
    /
Good

and

Good
    \
     Bad <-- need to dig further
    /
 Bad

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
