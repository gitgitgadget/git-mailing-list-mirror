Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7887E1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 15:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbdBHP5i (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 10:57:38 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:41484 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbdBHP5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 10:57:05 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 3BBF6C703;
        Wed,  8 Feb 2017 15:40:28 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (mailhost.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 35618100494;
        Wed,  8 Feb 2017 15:40:28 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 21D02125EA0;
        Wed,  8 Feb 2017 15:40:28 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        pranit.bauva@gmail.com, peff@peff.net, pclouds@gmail.com,
        sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous branch"
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
        <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>
        <20170206181026.GA4010@ubuntu-512mb-blr1-01.localdomain>
        <xmqqtw86zzk4.fsf@gitster.mtv.corp.google.com>
        <20170207191450.GA5569@ubuntu-512mb-blr1-01.localdomain>
Date:   Wed, 08 Feb 2017 15:40:28 +0100
In-Reply-To: <20170207191450.GA5569@ubuntu-512mb-blr1-01.localdomain>
        (Siddharth Kannan's message of "Tue, 7 Feb 2017 19:14:50 +0000")
Message-ID: <vpqh944eof7.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> Making a change in sha1_name.c will touch a lot of commands
> (setup_revisions is called from everywhere in the codebase), so, I am
> still trying to figure out how to do this such that the rest of the
> codepath remains unchanged.

Changing sha1_name.c is the way to go *if* we want all commands to
support this. Just like other ways to name a revision...

> I hope that you do not mind this side-effect, but rather, you intended
> for this to happen, right? More commands will start supporting this
> shorthand, suddenly.  (such as format-patch, whatchanged, diff to name
> a very few).

... but: the initial implementation of this '-' shorthand was
special-casing a single command (IIRC, "git checkout") for which the
shorthand was useful.

In a previous discussion, I made an analogy with "cd -" (which is the
source of inspiration of this shorthand AFAIK): "-" did not magically
become "the last visited directory" for all Unix commands, just for
"cd". And in this case, I'm happy with it. For example, I never need
"mkdir -", and I'm happy I can't "rm -fr -" by mistake.

So, it's debatable whether it's a good thing to have all commands
support "-". For example, forcing users to explicitly type "git branch
-d @{1}" and not providing them with a shortcut might be a good thing.

I don't have strong opinion on this: I tend to favor consistency and
supporting "-" everywhere goes in this direction, but I think the
downsides should be considered too. A large part of the exercice here is
to write a good commit message!

Another issue with this is: - is also a common way to say "use stdin
instead of a file", so before enabling - for "previous branch", we need
to make sure it does not introduce any ambiguity. Git does not seem to
use "- for stdin" much (most commands able to read from stdin have an
explicit --stdin option for that), a quick grep in the docs shows only
"git blame --contents -" which is OK because a revision wouldn't make
sense here anyway.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
