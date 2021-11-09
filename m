Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39775C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150B76112D
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbhKIVli convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 9 Nov 2021 16:41:38 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53071 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhKIVlg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 16:41:36 -0500
Received: (Authenticated sender: robin@jarry.cc)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 42B9260009;
        Tue,  9 Nov 2021 21:38:46 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 09 Nov 2021 22:38:45 +0100
Message-Id: <CFLKOIVJ8EX0.2PWQ6PCXZ340A@diabtop>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Jan Smets" <jan.smets@nokia.com>,
        "Stephen Morton" <stephen.morton@nokia.com>,
        "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v2] receive-pack: ignore SIGPIPE while reporting status
 to client
From:   "Robin Jarry" <robin@jarry.cc>
References: <20211104133546.1967308-1-robin.jarry@6wind.com>
 <20211106220358.144886-1-robin@jarry.cc> <xmqqzgqd11dp.fsf@gitster.g>
In-Reply-To: <xmqqzgqd11dp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano, Nov 09, 2021 at 22:10:
> All of the above talks about the pre-receive hook, but it is unclear
> how that is relevant to this change.  The first paragraph says
> "... is not killed", and if that was a bad thing (in other words, it
> should be killed but is not, and that is a bug worth fixing), and if
> this patch changes the behaviour, then that paragraph is worth
> saying.  Similarly for the other two.
>
> > Before running the post-receive hook, status info is reported back to
> > the client. Since the client has died, receive-pack is killed by SIGPIPE
> > and post-receive is never executed.
>
> In other words, regardless of what happens (or does not happen) to
> the pre-receive hook, which may not even exist, if "git push" dies
> before the post-receive hook runs, this paragraph applies, no?  
>
> What I am getting at is that this can (and should) be the first
> paragraph of the description without losing clarity.

You're right. I wanted to give context to better explain why
receive-pack is not killed while running the pre-receive hook but
afterwards. This should go into another commit which fixes that issue.

I will reword accordingly.

> >  		execute_commands(commands, unpack_status, &si,
> >  				 &push_options);
> > +		sigchain_push(SIGPIPE, SIG_IGN);
> >  		if (pack_lockfile)
> >  			unlink_or_warn(pack_lockfile);
>
> Shouldn't we start ignoring SIGPIPE here, not before we try to
> unlink the lockfile?

I initially wanted to avoid getting SIGPIPE'd while printing a warning
if the lockfile cannot be unlinked. Maybe this means the repository
integrity is compromised and we are well beyond ensuring post-receive is
executed or not. I do not know git internals well enough to be sure.

What do you think?

-- 
Robin
