Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFBAC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E81205C9
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEGOCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 10:02:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:40246 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725969AbgEGOCK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 10:02:10 -0400
Received: (qmail 32451 invoked by uid 109); 7 May 2020 14:02:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 14:02:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17837 invoked by uid 111); 7 May 2020 14:02:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 10:02:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 10:02:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200507140208.GA3060463@coredump.intra.peff.net>
References: <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <xmqqlfm69il6.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2005061623520.56@tvgsbejvaqbjf.bet>
 <xmqqeerx81wy.fsf@gitster.c.googlers.com>
 <20200507121727.GA3057274@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507121727.GA3057274@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 08:17:27AM -0400, Jeff King wrote:

> > But doesn't this (i.e. uses: actions/github-script) still pay the
> > cost of spinning up a VM?  How expensive is it to check out a small
> > tree with a single file, whether it is ref-whitelist or allow-ref?
> 
> I suspect this script mechanism may be much cheaper. I don't know the
> implementation details, but spinning up a nodejs container to run a
> javascript snippet should be much cheaper than a full ubuntu VM running
> "git clone" (the clone itself should be super cheap because it's a
> shallow single-branch clone of a tree with one file in it, but getting
> there is relatively heavy-weight).

Sorry, this is all complete nonsense. There is no magical nodejs
container in Actions. You still have to say "runs-on: ubuntu-latest". So
it's still spinning up that VM and then running inside there.

I just did a timing with three jobs:

  noop:
    runs-on: ubuntu-latest
    steps:
    - run: exit 0

  script:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/github-script@0.9.0
      with:
        script: |
            const req = {
              owner: context.repo.owner,
              repo: context.repo.repo,
              ref: "refs/ci/config"
            };

            try {
              req.tree_sha = (await github.git.getRef(req)).data.object.sha;
              (await github.git.getTree(req))
              .tree.filter(e => e.path == 'ref-whitelist').map(e => {
                req.file_sha = e.sha;
              });
              const list = Buffer.from((await github.git.getBlob(req)).data.content, 'base64').toString('UTF-8');
              core.setOutput('enabled', `\n${list}`.indexOf(`\n${{github.ref}}\n`) < 0 ? 'no' : 'yes');
            } catch (e) {
              core.setOutput('enabled', 'yes');
            }

  checkout:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      continue-on-error: true
      with:
        ref: refs/ci/config
    - run: ./allow-ref ${{ github.ref }}

and they took 1, 2, and 3 seconds respectively. They spend 2s getting
the environment set up and the actions loaded. So the API one spent less
than 1s on the network, but the single-file checkout spent slightly
more. Given the timing variations I've seen, I wouldn't be surprised if
it sometimes goes the other way. But even if those numbers are accurate,
I don't think the cost difference is enough to force our hand either
way.

-Peff
