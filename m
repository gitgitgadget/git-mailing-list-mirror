Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639B9C2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105F9241A7
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgKRCGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 21:06:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:33344 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgKRCGT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 21:06:19 -0500
Received: (qmail 20151 invoked by uid 109); 18 Nov 2020 02:06:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Nov 2020 02:06:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7365 invoked by uid 111); 18 Nov 2020 02:06:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 21:06:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 21:06:18 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
Message-ID: <20201118020618.GE650959@coredump.intra.peff.net>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
 <20201117233313.GB642410@coredump.intra.peff.net>
 <CAMP44s1HhiDYfji9L2sj3QbCDmsb9dnrLCS6cQJPbmS1F3vKoQ@mail.gmail.com>
 <20201118012230.GB650959@coredump.intra.peff.net>
 <CAMP44s1t3CKF3btQwSwaz_Pu2fE6PGyb+_iMW8dAbY3aE3mH7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s1t3CKF3btQwSwaz_Pu2fE6PGyb+_iMW8dAbY3aE3mH7w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 07:45:21PM -0600, Felipe Contreras wrote:

> > Yes, I have run into that, and it's definitely annoying. The
> > refs/remotes/<remote>/HEAD symref is created by clone, but is not
> > updated by "fetch". That's intentional, because it's supposed to
> > represent a local choice (that is merely seeded by the remote side). But
> > it seems like adding it if it's missing might be reasonable.
> 
> The equivalent of this choice is in "git remote add -m":
> 
>   With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD`
>   is set up to point at remote's `<master>` branch. See also the
>   set-head command.

Wow, I'm not sure how that option escaped my notice for all these years.
Of course it would be much more useful if it pulled the value from the
remote HEAD (but again, unless we use "-f" we are not contacting the
remote at all).

> This is of course inconsistent. Is it the "head", or is it the "master"?
> 
> Presumably if we want to avoid the term "master", then this option
> needs to be renamed.

Agreed that the naming is bad.

> In my opinion unless this option has been explicitly set,
> "origin/HEAD" should keep track of whatever remote head is set.
> 
> If somebody updates its remote HEAD from "master" to "main", then
> origin/HEAD should be updated accordingly. Granted, this may be some
> overhead in the 99.999% of the cases where the remote HEAD is the
> same, so it may not be worth even thinking about it.
> 
> But at least the first fetch after "git remote add" should fetch it,
> in my opinion (unless it's manually configured already). I'm not sure
> if origin/HEAD can contain some placeholder so that "git fetch" knows
> what to do.

If it's simply not present (which is the case now after "git remote
add"), then it might be reasonable for "git fetch" to use that as the
hint to fill it in. That would also make "git remote add -f" just work,
I believe.

It does mean that you can _change_ the value of origin/HEAD, but you
wouldn't be allowed to delete it without fetch trying to re-create it.
I suspect this is quite rare, but we might want an escape hatch config.
E.g., remote.origin.updateHEAD that can be set to one of:

  - never; do not touch it

  - create-if-missing; as discussed here

  - always; update it on every fetch

And then it is just a question of what the default is. Currently it is
"never". I suspect most people would be happy with "always", but it does
break some existing flows. But perhaps "create-if-missing" is a good
medium.

-Peff
