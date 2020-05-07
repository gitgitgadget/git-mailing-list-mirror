Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845B3C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE032083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgEGMZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 08:25:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:40082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725923AbgEGMZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 08:25:51 -0400
Received: (qmail 31209 invoked by uid 109); 7 May 2020 12:25:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 12:25:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16407 invoked by uid 111); 7 May 2020 12:25:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 08:25:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 08:25:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200507122549.GB3057274@coredump.intra.peff.net>
References: <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <20200506004612.GE927@danh.dev>
 <xmqqr1vx90mt.fsf@gitster.c.googlers.com>
 <20200506142500.GA2429@danh.dev>
 <xmqqa72l81pe.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa72l81pe.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 09:31:25AM -0700, Junio C Hamano wrote:

> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > On 2020-05-05 20:56:58-0700, Junio C Hamano <gitster@pobox.com> wrote:
> >> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> >> > +--------------
> >> > +$ git checkout --orphan ci-config
> >> > +$ cp contrib/ci-config-allow-ref allow-ref
> >> > +$ $EDITOR allow-ref
> >> > +$ git rm -rf .
> >> 
> >> This sounds horrible.  You just nuked the entire files in the
> >> working tree you use for your everyday Git hacking to edit a
> >> single file.
> >
> > It isn't that horrible as it sounds. It only removes the files that are
> > currently added in index, which is the same with tracked files in old
> > branch, and we can get it back by switching back to old branch.
> >
> > I decided to make an orphanage branch because I would like to save
> > time and network bandwidth for the "check-ci" jobs.
> 
> I didn't say it is wrong to record a tree with a single file
> (allow-ref) in a commit that is pointed by the ci-config ref.
> 
> I would have expected you to create such a commit in an otherwise
> empty repository, and push into your fork of Git at GitHub.  That
> way, you won't have to checkout and/or refresh the index all of the
> 3800+ files.

Yeah, I agree that all of the mechanisms for dealing with the unrelated
history are somewhat awkward. Another issue is that you can't just:

  git clone --single-branch -b refs/ci/config my-config

to work on it, because "-b" wants only heads or tags (we could address
that by putting it in refs/heads/ci-config or similar).

If we do go the javascript route, perhaps it would make sense for
refs/ci/config to be a single blob containing a snippet of javascript
with several functions. And then we could just eval() that and call the
appropriate functions (if defined).

Then a sample can live in the main repo with something like:

  # This file contains functions which will be run by the GitHub
  # Actions CI script.
  #
  # You may customize it for your own fork by modifying it on any branch
  # you like, and installing with:
  #
  #  git push <remote> $(git rev-parse HEAD:ci/config):refs/ci/config
  #
  # [allow_ref() sample definition and documentation....]

That sidesteps most of those issues.

-Peff
