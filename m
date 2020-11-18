Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12C4C6379D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 01:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91855221FB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 01:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgKRBWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 20:22:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:33282 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbgKRBWb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 20:22:31 -0500
Received: (qmail 19910 invoked by uid 109); 18 Nov 2020 01:22:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Nov 2020 01:22:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6968 invoked by uid 111); 18 Nov 2020 01:22:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 20:22:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 20:22:30 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
Message-ID: <20201118012230.GB650959@coredump.intra.peff.net>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
 <20201117233313.GB642410@coredump.intra.peff.net>
 <CAMP44s1HhiDYfji9L2sj3QbCDmsb9dnrLCS6cQJPbmS1F3vKoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s1HhiDYfji9L2sj3QbCDmsb9dnrLCS6cQJPbmS1F3vKoQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 06:18:03PM -0600, Felipe Contreras wrote:

> On Tue, Nov 17, 2020 at 5:33 PM Jeff King <peff@peff.net> wrote:
> > On Tue, Nov 17, 2020 at 04:47:56PM -0600, Felipe Contreras wrote:
> 
> > > This should be easy to do if we make "origin" be a pseudo ref that
> > > points to "origin/HEAD" (and we could introduce "origin/@").
> >
> > Didn't we already do this long ago? refs/remotes/%s/HEAD is special in
> > the dwim_ref() lookup:
> >
> >   $ git rev-parse --symbolic-full-name origin
> >   refs/remotes/origin/master
> 
> Hmmm. For some reason none of my remotes do have a HEAD.
> 
> If I do "git remote add", and then fetch, the HEAD doesn't seem to be present.

Yes, I have run into that, and it's definitely annoying. The
refs/remotes/<remote>/HEAD symref is created by clone, but is not
updated by "fetch". That's intentional, because it's supposed to
represent a local choice (that is merely seeded by the remote side). But
it seems like adding it if it's missing might be reasonable.

I'm not sure if "git remote add" should be doing it (it already can do
it with "git remote set-head -a", but that is not the default when
adding a new remote, which otherwise does not contact the network at
all). Or if "git fetch" should be doing it. Certainly having "fetch
--update-remote-head" would be fine, but that doesn't really solve the
problem (which is that people don't realize they need to specify it).

There was some related discussion in:

  https://lore.kernel.org/git/CAEXP2g8-reK+u2FaO=mMP-nsvuDDWGpwV_tyKG5L5XpU=1LQeg@mail.gmail.com/

but I don't think any patches came out of that.

-Peff
