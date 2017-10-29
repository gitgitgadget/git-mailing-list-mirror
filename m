Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007782055E
	for <e@80x24.org>; Sun, 29 Oct 2017 01:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbdJ2BWq (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 21:22:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60783 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751209AbdJ2BWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 21:22:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F1ABAD569;
        Sat, 28 Oct 2017 21:22:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Uzbsr16xmIOk8A4cR46YNqnv+Y=; b=LtZrG/
        Q2HPiUTZBEWFieP1vbl+wUP2YXkfDojf/AmCEzMWQBAiY59EyoyR6cK6vz9kdOuj
        uFtUK+pq8FG0kimL9HLY6GanimcmgenRxJelRVOLEWnq2Wh++/1FlwrPeCZkhWNq
        x6QXdJ9bi805ictOxKiJBOuiSyC89odYZIynM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uFgMt/i+l19eAlXo70WOFs6BaekfsSUe
        WqfFPr5bHHbiSOe2VdAhHrY8ZICjFUNpJCxJEpKTce3ICZPcjX5q7oV4SG1EqmGN
        lNMg+cospjjGFSRPbRLRJ7Y/gtZMZTEAMzhB0du1zx04HSwNp5bP6n9Py0GN8PK7
        y3IfbAM2hsM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74BCBAD568;
        Sat, 28 Oct 2017 21:22:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2C1DAD567;
        Sat, 28 Oct 2017 21:22:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] convert diff flags to be stored in a struct
References: <20171027222853.180981-1-bmwill@google.com>
Date:   Sun, 29 Oct 2017 10:22:42 +0900
In-Reply-To: <20171027222853.180981-1-bmwill@google.com> (Brandon Williams's
        message of "Fri, 27 Oct 2017 15:28:50 -0700")
Message-ID: <xmqq60aybvdp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA07F926-BC47-11E7-A6C6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> There has be some desire to add additional flags to the diff machineery
> (https://public-inbox.org/git/20171024000931.14814-1-sbeller@google.com/) but
> due to the limits of the number of bits in an unsigned int on some systems we
> can't add any additonal flags to the 'flags' variable.  This series converts
> the flags to be stored in bitfields in a struct instead of in bit positions in
> an unsigned int.

I haven't checked the patches yet, but its smallness look promising.
One reason why I didn't do this myself long time ago was because I
suspected that we may be passing an unsigned int that is a collection
of flags as a parameter in many codepaths (to which I did not see a
good conversion once we start using discrete bitfields in a struct,
without passing a "flags" struct instead, which felt somewhat ugly).

> Some thoughts:
>  * We may want to do a follow on patch to convert all the flags from being in
>    uppercase to lower case.

If and only if we do not use macros to set/clr/test, this makes a
lot of sense.  Otherwise, probably not.

>  * Maybe we can figure out how to remove the 'touched_flags' things (since its
>    only used in one place) and then we may even be able to stop needing to use
>    macros to set/clr/test the flags.

Yup.  That is closely tied with the above one, but back then we
didn't think of a better implementation than the "this was given
from the command line" vs "this was initialized and kept", so we
need some thought.

Thanks for starting this.

> Brandon Williams (3):
>   add: use DIFF_OPT_SET macro to set a diff flag
>   reset: use DIFF_OPT_SET macro to set a diff flag
>   diff: convert flags to be stored in bitfields
>
>  builtin/add.c    |  2 +-
>  builtin/commit.c |  7 +++--
>  builtin/log.c    |  2 +-
>  builtin/reset.c  |  2 +-
>  diff-lib.c       |  6 ++--
>  diff.c           |  3 +-
>  diff.h           | 96 +++++++++++++++++++++++++++++++++-----------------------
>  sequencer.c      |  5 +--
>  8 files changed, 72 insertions(+), 51 deletions(-)
