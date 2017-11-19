Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8CA2036D
	for <e@80x24.org>; Sun, 19 Nov 2017 01:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760432AbdKSBFB (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 20:05:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58053 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760313AbdKSBFB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 20:05:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22D30BFC5F;
        Sat, 18 Nov 2017 20:05:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yg9bDpP6YVFGOoWDys7B+ZqW8Js=; b=lAde79
        FZYVdcKImEAyI5FLmy4PDMh1KwiYI4f+r7Xs616imgrg7eO8Jw8EH3NJxeGh2OEj
        oBD4czahjcPgFPNUO+aIgFRhkF7mfawx9oW1iPiiLaemLZE4nKFkUFT7hVvO/YcJ
        tK7J9FKsZi9LJMUxjzE9QM0FTjLt2EH4/WGMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fwweTUrZspDsgqIBS6rh0svCvZ5zg7V7
        Fej7HM/tkaQ8Iq9UGn1zfgTCwm7v9L+TZNM5AIPS8tNZ0bQYMrwn5D7FTkJqMjom
        JgCUDRhfJspI6T1mDJ/F9nfQQIeAazvMuscwt8R83NWRXZ061IvbB8wTPitzApfJ
        rmM8GSHaymU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 189D0BFC5D;
        Sat, 18 Nov 2017 20:05:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86A47BFC5B;
        Sat, 18 Nov 2017 20:04:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Florian Klink <flokli@flokli.de>, git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: honor $PATH
References: <20171118124249.26479-1-flokli@flokli.de>
        <20171118210109.ttp7bnihi3xb4xvs@genre.crustytoothpaste.net>
Date:   Sun, 19 Nov 2017 10:04:58 +0900
In-Reply-To: <20171118210109.ttp7bnihi3xb4xvs@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Sat, 18 Nov 2017 21:01:09 +0000")
Message-ID: <xmqqd14foz7p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA49D9E8-CCC5-11E7-8C26-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This patch adds support for PATH, but it also removes the fixed paths.
> On many systems, unprivileged users don't have /usr/sbin in their PATH,
> and I know of no systems which provide /usr/lib as a PATH value.
> Therefore, it's possible that this change will break automatic detection
> of sendmail for many users.

It is more than possible ;-) that this change alone is a regression.

> I think what you probably want to do is use entries in PATH first, and
> leave the two old values as backups at the end.

I do not think it would make things worse if the change were to do
the two standard places first and then try elements on the $PATH;
split of $PATH needs to be done carefully (Windows?), though.  

I would feel a lot more worried about trying elements on the $PATH
first and then using the two standard places as fallback.  If the
order of addition matters at all, that would mean that trying
elements on $PATH first and then falling back to the two standard
places *will* change the behaviour---for the affected users, we used
to pick one of these two, but now we would pick something different.
sendmail is usually installed out of the way of $PATH for regular
users for a reason, so picking anything whose name happens to be
sendmail that is on $PATH does not sound right.

Of course, for users who do not have sendmail at one of the two
standard places _and_ has one on one of the directories on $PATH,
the order in which we check would not make a difference, so my
suggestion would be to do the other way around.
