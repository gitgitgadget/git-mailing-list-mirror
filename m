Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C2C20756
	for <e@80x24.org>; Tue, 17 Jan 2017 20:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdAQU0u (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 15:26:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51376 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750941AbdAQU0t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 15:26:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B07F8612D2;
        Tue, 17 Jan 2017 15:21:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CfgfdC8ebuanQbzKO/hdOOsNYDg=; b=Nv7aWm
        WtyW/r7u8LduDToIjD+jE/bWY17gYHo0coTMJ+VoQpHkCYh9iLKsY41uEbCnHK9N
        UPuWaDJ294Olsdhzoet+qQB+9jRI/8QMBfqmXQfECtne1tN8xIqPYCjzcPV4VqXV
        P7JioUlw4Jcc8y3VPQv8L6AOzkRiFecudCBok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ffMlq9lTlcEfu+8HBgngFPssWcQy35/g
        4nKQbPe4Q5PRPQOlkI+7BP8EyUkNNjkcacX4iOWhYNSiLN/lOT/6IsDvN2aLFGk/
        S2eSw+JUGoiyeGax3qbkwe9xmgzxSSn4S2zuk+XnPRE/UlqMXysJnyxeBNlLEqij
        +FtR51MFgYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8830612D1;
        Tue, 17 Jan 2017 15:21:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06AD3612D0;
        Tue, 17 Jan 2017 15:21:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] stash --continue
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
Date:   Tue, 17 Jan 2017 12:21:10 -0800
In-Reply-To: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net> (Stephan Beyer's
        message of "Mon, 16 Jan 2017 00:56:00 +0100")
Message-ID: <xmqqy3y9e8uh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D19CAF0-DCF2-11E6-AC9A-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> This led to the idea to have something like "git stash --continue"[1]
> that would expect the user to "git add" the resolved files (as "git
> status" suggests) but then leads to the expected result, i.e. the index
> being the same as before the conflict, the stash being dropped (if "pop"
> was used instead of "apply"), etc.
>
> Likewise, some "git stash --abort"[2] might be useful in case you did
> "git stash pop" with the wrong stash in mind.
>
> What do you think about that?

"git stash pop --continue" (and "git stash apply --continue") would
make quite a lot of sense.  I like it very much primarily because it
will give us an opportunity to correct a major UI glitches around
applying stashed changes to the working tree.

Don't people find it strange that "stash pop" that applies cleanly
would not touch the index, leaving (an equivalent of) the changes
stashed earlier floating in the working tree, but "stash pop" that
conflicts and needs a three-way merge touches the index and the
usual way of concluding the manual conflict resolution is "git add"
the paths, meaning that the changes that were not ready hence
floating in the working tree back when the stash was made goes into
the index when the user concludes "stash pop"?

With an explicit "--continue", we can fix that so that we reset the
index to the HEAD.  That way, whether the changes have conflict with
the HEAD's tree or not, the end user after "stash pop" will see the
changes in the working tree and "git diff" (no HEAD argument or
"--cached" option) will consistently show what came from the stash.
