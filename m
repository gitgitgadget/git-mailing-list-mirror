Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA626202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 12:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdKSMfP (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 07:35:15 -0500
Received: from mail.zeus.flokli.de ([88.198.15.28]:60592 "EHLO zeus.flokli.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750865AbdKSMfO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 07:35:14 -0500
Received: from localhost (unknown [185.104.140.104])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 1764B37EF9C;
        Sun, 19 Nov 2017 12:35:13 +0000 (UTC)
Date:   Sun, 19 Nov 2017 13:35:11 +0100
From:   Florian Klink <flokli@flokli.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: honor $PATH
Message-ID: <20171119123511.pck5aqak4yyc6367@tp.flokli.de>
References: <20171118124249.26479-1-flokli@flokli.de>
 <20171118210109.ttp7bnihi3xb4xvs@genre.crustytoothpaste.net>
 <xmqqd14foz7p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqd14foz7p.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20171027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17-11-19 10:04:58, Junio C Hamano wrote:
>"brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> This patch adds support for PATH, but it also removes the fixed paths.
>> On many systems, unprivileged users don't have /usr/sbin in their PATH,
>> and I know of no systems which provide /usr/lib as a PATH value.
>> Therefore, it's possible that this change will break automatic detection
>> of sendmail for many users.
>
>It is more than possible ;-) that this change alone is a regression.
>
>> I think what you probably want to do is use entries in PATH first, and
>> leave the two old values as backups at the end.
>
>I do not think it would make things worse if the change were to do
>the two standard places first and then try elements on the $PATH;
>split of $PATH needs to be done carefully (Windows?), though.

Support to detect sendmail binaries in windows' PATH seems a bit more complex.
The separator is different, and PATHEXT would need to be considered too.  I'm
not even sure if having a sendmail binary in PATH on windows is something usual
or if defaulting to smtp to localhost (what we currently do) is good enough (tm).
If we want to start parsing PATH under windows too, I'd suggest to use
File::Which instead of implementing it on our own.

>I would feel a lot more worried about trying elements on the $PATH
>first and then using the two standard places as fallback.  If the
>order of addition matters at all, that would mean that trying
>elements on $PATH first and then falling back to the two standard
>places *will* change the behaviour---for the affected users, we used
>to pick one of these two, but now we would pick something different.
>sendmail is usually installed out of the way of $PATH for regular
>users for a reason, so picking anything whose name happens to be
>sendmail that is on $PATH does not sound right.
>
>Of course, for users who do not have sendmail at one of the two
>standard places _and_ has one on one of the directories on $PATH,
>the order in which we check would not make a difference, so my
>suggestion would be to do the other way around.

I could happily provide a patch that does it the other way round, too. But let's
first decide on what to do with windows ;-)

Cheers,
Florian
