Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B4FC1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 02:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfKSCxC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 21:53:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64535 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfKSCxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 21:53:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A77FD8C157;
        Mon, 18 Nov 2019 21:52:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I7pJJQcWwX+MacYg6CqvFxcvUSw=; b=hY1BXO
        V2at3JGl8AYzTWbM6/7wLuZ9CDpFfqa7AOGlpSS5Rc7GRfA0ofh/NL9gOkzC9R4T
        Zq0UXrbevp/ktNKnEcTpTdG7/qYxZ36eFWSDN3sbriScRcfO4ifLDXmA02rA5HWN
        zuNkD65I8t+CE5mYcA7+PLMrg12SxzxX+T3hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PvnvI1AcltHaICtb060+tGzy9SnRqz8a
        yhWWO+9zGggKjqtH39PteSHL/Hd5Uf+Vdac5UfM3IIc9oNDrn84jEN/gohSLTW7C
        +mbWdXP9inlmfE2SIZZMW7UWbPWcatyEL6p6OYJAS4pZOsBYXALc00sXfCggWNEV
        ufjaVBauQoo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0B178C156;
        Mon, 18 Nov 2019 21:52:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D19728C155;
        Mon, 18 Nov 2019 21:52:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git rev-parse --show-toplevel inside `.git` returns 0 and prints nothing
References: <CA+dzEBmrMavFJeyPSQr2wA9kFZwz_Kfr6PFBLRfLJ-EuCVXJnA@mail.gmail.com>
Date:   Tue, 19 Nov 2019 11:52:54 +0900
In-Reply-To: <CA+dzEBmrMavFJeyPSQr2wA9kFZwz_Kfr6PFBLRfLJ-EuCVXJnA@mail.gmail.com>
        (Anthony Sottile's message of "Mon, 18 Nov 2019 14:26:53 -0800")
Message-ID: <xmqqk17wziex.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B09DCF92-0A77-11EA-9BA9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Sottile <asottile@umich.edu> writes:

> I would expect it to either:
> - exit nonzero
> - produce the full path to the root of the repository
>
> would a patch be accepted which changes it to do one of those two
> things? I'd be happy to contribute such a patch

The most important invariant for the "--show-toplevel" and the
"--show-prefix" options was that when they are concatenated the
result matches the current directory in a working tree.  So I think
the result is undefined when you are not anywhere in the working
tree.

Having said that, as scripts that want to know if they are inside
.git directory (either directly in it, or in its subdirectories)
should not be relying on the behaviour, and instead be using the
"--is-inside-git-dir" option, I suspect that it won't be too
disruptive to change the behaviour after all these years.  

But it is no longer year 2007 and with widespread use of Git, it is
almost guaranteed to break somebody's script ;-)

If I were designing the feature today, with today's rest-of-git in
mind, I would say

 - In a bare repository, exit with non-zero status after giving an
   error message "no working tree".

 - In a repository that has a single associated working tree, show
   the path to the top-level of that working tree and exit with zero
   status.

In a repository that has more than one working trees (which is one
of the things "todasy's rest-of-git" has that did not exist back
when --show-prefix/--show-toplevel etc. were invented), then what?
Would it make sense to show the primary working tree?  What if the
worktree(s) were made off of a bare repository, in which case nobody
is the primary?

If we were changing "--show-toplevel", we may need to make changes
to "--show-prefix" to things consistent, but I am not sure what it
should say when run outside a working tree.  It should continue to
give nothing; it may make sense to exit with non-zero status, but
I'd rather let sleeping dogs lie.  Nobody is hurting by the command
exiting with zero status (the same question applies to the
"--show-toplevel" option, for that matter, though), when the result
is undefined.

So...  I dunno.



