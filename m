Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B9E1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbdGYUlE (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:41:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61120 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751472AbdGYUlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:41:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF92374692;
        Tue, 25 Jul 2017 16:41:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VOTPV+gZQv6U+vb7Ifm60BnO/08=; b=It7iAR
        ij0d+rbo6vG/bW3SdhrRIhNz+qa46XivgwmGUWGhmHoVkHC6/g9Gs1F7uLCSGrDr
        FAIa8Kt7/OXD7Mge+pRwW5cbydxW3znjaz5fTRyfjDFn5nTxdY0Vayddhg71qAxh
        3cgHtyijAAHVBsLEkb1MJbrCmR8RvLU0W6vkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kXfghR7W+YlAjQaRV5cL8Eij+9mbREub
        Y3CIg/y0WPrmVGFqjfrRn4LxKUdJpISvOhaOr5I3dQxkXuDXrPD0YYpFZ0el2O8r
        lT9UoAAZzlPyU2NH+OR5PsQ5RfZ9il6N3SMr+fwnOVzYO4uoUh6FnmaddlQZdLYU
        8VBwsOpRj/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3DFE74690;
        Tue, 25 Jul 2017 16:41:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C26B7468E;
        Tue, 25 Jul 2017 16:41:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Raman Gupta <rocketraman@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] Git rerere and non-conflicting changes during conflict resolution
References: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
        <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
        <xmqqo9s8uuth.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 25 Jul 2017 13:40:59 -0700
In-Reply-To: <xmqqo9s8uuth.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 25 Jul 2017 13:26:34 -0700")
Message-ID: <xmqqk22wuu5g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9193C424-7179-11E7-AF52-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> To populate the database, we'd need a reverse.
> ...
>  * Then the user tells Git that semantic conflicts were resolved and
>    need to be recorded (just like running "git rerere" manually,
>    before "git commit" automatically does it for them these days).
>    This will result in the following:
>
>    - The database is updated so that key <A, B> yields the
>      "merge-fix" commit;
> ...

I probably should have been aiming for stars, as I were outlining
the ideal merge-fix logic.  The key <A, B> is merely a default, and
the worst one at that.  There should be a way for the user to tell
which exact pair of commits (i.e. another side branch that was
merged earlier to the mainline A that renamed 'xyzzy' to 'frotz'
wholesale, and the exact commit on the side branch B that added an
extra mention of 'xyzzy').  

If the logic can figure out what these two commits are without
user's help, mechanically by only looking at the merge-fix commit,
that would be even better.  But I do not believe in miracles, so...

