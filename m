Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B7C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED30F20882
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgJZTpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:45:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:37666 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbgJZTpU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:45:20 -0400
Received: (qmail 9307 invoked by uid 109); 26 Oct 2020 19:45:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Oct 2020 19:45:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10353 invoked by uid 111); 26 Oct 2020 19:45:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Oct 2020 15:45:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Oct 2020 15:45:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] remote: add meaningful exit code on missing/existing
Message-ID: <20201026194519.GB16150@coredump.intra.peff.net>
References: <20201026144825.26537-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026144825.26537-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 03:48:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Change the exit code for the likes of "git remote add/rename" to exit
> with 2 if the remote in question doesn't exist, and 3 if it
> does. Before we'd just die() and exit with the general 128 exit code.

I can't think of a particular reason not to do this. Though I suspect
anything scripting may generally be better off using git-config directly
for more flexibility and power.

> The motivation for this is a discussion around some code in GitLab's
> gitaly which wanted to check this, and had to parse stderr to do so:
> https://gitlab.com/gitlab-org/gitaly/-/merge_requests/2695

I didn't immediately see there the use cases you'd put this to. If it's
something like "add an origin remote for fetching from a mirror", then
that it is probably reasonable. But if you're thinking of something that
may grow without bound (e.g., one remote per fork of the repository),
keep in mind that modifying the config file is linear to its size (so
creating or deleting N remotes is N^2).

>  Documentation/git-remote.txt | 11 ++++++++++
>  builtin/remote.c             | 42 ++++++++++++++++++++++++------------
>  t/t5505-remote.sh            | 16 +++++++-------
>  3 files changed, 47 insertions(+), 22 deletions(-)

The patch itself looks good to me, with one minor nit:

> +EXIT STATUS
> +-----------
> +
> +On success, the exit status is `0`.
> +
> +When subcommands such as 'add', 'rename' and 'remove' can't find the
> +remote in question the exit status is `2`, when the remote already
> +exists the exit status is `3`.

This is a run-on sentence; the comma after `2` should be a period.

I'd also put an Oxford comma after `rename`, but that's a stylistic
choice. :)

-Peff
