Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4296A1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933419AbdBPSRB (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:17:01 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:52526 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933100AbdBPSRA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:17:00 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id A851BC45E;
        Thu, 16 Feb 2017 19:16:57 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps1.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id A33791004A9;
        Thu, 16 Feb 2017 19:16:57 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 9A16A125EAE;
        Thu, 16 Feb 2017 19:16:57 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Johan Hovold <johan@kernel.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>, Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
References: <20170216174924.GB2625@localhost>
Date:   Thu, 16 Feb 2017 19:16:57 +0100
In-Reply-To: <20170216174924.GB2625@localhost> (Johan Hovold's message of
        "Thu, 16 Feb 2017 18:49:24 +0100")
Message-ID: <vpqlgt6hug6.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> Hi,
>
> I recently noticed that after an upgrade, git-send-email (2.10.2)
> started aborting when trying to send patches that had a linux-kernel
> stable-tag in its body. For example,
>
> 	Cc: <stable@vger.kernel.org>	# 4.4
>
> was now parsed as
>
> 	"stable@vger.kernel.org#4.4"
>
> which resulted in
>
> 	Died at /usr/libexec/git-core/git-send-email line 1332, <FIN> line 1.

This has changed in e3fdbcc8e1 (parse_mailboxes: accept extra text after
<...> address, 2016-10-13), released v2.11.0 as you noticed:

> The problem with the resulting fixes that are now in 2.11.1 is that
> git-send-email no longer discards the trailing comment but rather
> shoves it into the name after adding some random white space:
>
> 	"# 3 . 3 . x : 1b9508f : sched : Rate-limit newidle" <stable@vger.kernel.org>"
>
> This example is based on the example from
> Documentation/process/stable-kernel-rules.rst:
>
> 	Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
>
> and this format for stable-tags has been documented at least since 2009
> and 8e9b9362266d ("Doc/stable rules: add new cherry-pick logic"), and
> has been supported by git since 2012 and 831a488b76e0 ("git-send-email:
> remove garbage after email address") I believe.
>
> Can we please revert to the old behaviour of simply discarding such
> comments (from body-CC:s) or at least make it configurable through a
> configuration option?

The problem is that we now accept list of emails instead of just one
email, so it's hard to define what "comments after the email", for
example

Cc: <foo@example.com> # , <boz@example.com>

Is not accepted as two emails.

So, just stripping whatever comes after # before parsing the list of
emails would change the behavior once more, and possibly break other
user's flow. Dropping the garbage after the email while parsing is
possible, but only when we use our in-house parser (and we currently use
Perl's Mail::Address when available).

So, a proper fix is far from obvious, and unfortunately I won't have
time to work on that, at least not before a while.

OTOH, the current behavior isn't that bad. It accepts the input, and
extracts a valid email out of it. Just the display name is admitedly
suboptimal ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
