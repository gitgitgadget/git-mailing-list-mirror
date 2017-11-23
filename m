Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BD520954
	for <e@80x24.org>; Thu, 23 Nov 2017 02:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbdKWCfY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 21:35:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62760 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751861AbdKWCfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 21:35:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57844A04DD;
        Wed, 22 Nov 2017 21:35:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EzWa9SQfH256C/7cqdYDU4RS9dw=; b=OWRMkQ
        IXmrHMahi6XWs1Szp7sF0rlZeri2B68gTas7uBtFUqnWRXy9dOo3jgQjKIkG4Ynq
        m/H1qacyz1U/1qhDeAEfytUUZJLKoCu6aArQQkiyQyneR3xD2rKRmSGCrE4ffiMc
        GZ9HHNfaGUcbwkSjuT5uIjq4QkGVW2ki5gLGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KmXy/Nf5x5TEesZja2L46dYtpigivvhh
        xJXlkdrf3Q7EpbtqoEevOzvytRItoY/g+aaMz0KtOQ5OC9HSo8Vp96cZhU6xwFbW
        HlUKjzFFF16krgyp2zO4IbbyjpCZqvhrF6oCLiJNqUitADypDbQ8msdO81fpxxjs
        DjorwqVNBOQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50233A04DC;
        Wed, 22 Nov 2017 21:35:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD24AA04DB;
        Wed, 22 Nov 2017 21:35:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
        <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
        <xmqqd14cjr13.fsf@gitster.mtv.corp.google.com>
        <20171121225744.GA21197@sigill>
        <xmqqwp2jxf5l.fsf@gitster.mtv.corp.google.com>
        <20171122223613.GA1405@sigill>
Date:   Thu, 23 Nov 2017 11:35:21 +0900
In-Reply-To: <20171122223613.GA1405@sigill> (Jeff King's message of "Wed, 22
        Nov 2017 17:36:14 -0500")
Message-ID: <xmqqpo89rac6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4786596-CFF6-11E7-884A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So there are four cases we care about for this call in fetch:
>
>   1. We fed a real sha1 and got a commit (or peeled to one).
>
>   2. We fed a real sha1 which resolved to a non-commit, and we got NULL.
>
>   3. We fed a real sha1 and the object was missing or corrupted, and we
>      got NULL.
>
>   4. We fed a null sha1 and got NULL.
>
> Right now we lump cases 2-4 together as "do not do a fast-forward
> check". That's fine for 2 and 4, but probably not for 3. We can easily
> catch case 4 ourselves (if we care to), but distinguishing case 3 from
> the others is hard. How should lookup_commit_reference_gently() signal
> it to us?

Not limiting us to the caller in the "fetch" codepath, I think the
expectation by callers of lookup_commit_reference_gently() in the
ideal world would be:

 - It has an object name, and wants to use it as point in the commit
   DAG to define the traversal over the DAG, if it refers to a
   commit known to us.

 - It does not know if these object names represent a tag object, a
   commit object, or some other object.  It does not know if the
   local repository actually has them (e.g. we received a "have"
   from the other side---missing is expected).

 - Hence, it would happily accept a NULL as "we do not have it" and
   "we do have it, but it is not a commit-ish".

And from that point of view, 2, 3a (missing), and 4 (0{40}) to yield
NULL is perfectly fine.  3b (exists but broken) may be a noteworthy
event, but for the purpose of the caller, it may want to proceed as
if the object is missing from our end, so it might deserve warning()
but not die(), at least as the default behaviour.
