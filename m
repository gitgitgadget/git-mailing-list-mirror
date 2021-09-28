Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7FDC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A5E613A9
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243363AbhI1Xl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:41:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:57282 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243355AbhI1Xl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:41:56 -0400
Received: (qmail 11975 invoked by uid 109); 28 Sep 2021 23:40:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 23:40:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6148 invoked by uid 111); 28 Sep 2021 23:40:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 19:40:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 19:40:14 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Message-ID: <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
References: <xmqq8rzhmsi7.fsf@gitster.g>
 <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 11:46:40PM -0700, Elijah Newren wrote:

> > * en/remerge-diff (2021-08-31) 7 commits
> >  - doc/diff-options: explain the new --remerge-diff option
> >  - show, log: provide a --remerge-diff capability
> >  - tmp-objdir: new API for creating and removing primary object dirs
> >  - merge-ort: capture and print ll-merge warnings in our preferred fashion
> >  - ll-merge: add API for capturing warnings in a strbuf instead of stderr
> >  - merge-ort: add ability to record conflict messages in a file
> >  - merge-ort: mark a few more conflict messages as omittable
> >
> >  A new presentation for two-parent merge "--remerge-diff" can be
> >  used to show the difference between mechanical (and possibly
> >  conflicted) merge results and the recorded resolution.
> >
> >  Will merge to 'next'?
> 
> It has been a month that it's been cooking with no issues brought up,
> and it's been in production for nearly a year...
> 
> But just this morning I pinged peff and jrnieder if they might have
> time to respectively look at the tmp-objdir stuff (patch 5, plus its
> integration into log-tree.c in patch 7) and the ll-merge.[ch] changes
> (patch 3).  I don't know if either will have time to do it, but
> perhaps wait half a week or so to see if they'll mention they have
> time?  Otherwise, yeah, it's probably time to merge this down.

Sorry to take so long. I think this is a very exciting topic, and I
appreciate being called into to look at tmp-objdir stuff, because it can
be quite subtle.

I just left a rather long-ish mail in the thread, but the gist of it is
that I'm worried that there's some possibility of corruption there if
the diff code writes objects. I didn't do a proof-of-concept there, but
I worked one up just now. Try this:

  # make a repo
  git init repo
  cd repo
  echo base >file
  git add file
  git commit -m base

  # two diverging branches
  echo main >file
  git commit -am main
  git checkout -b side HEAD^
  echo side >file
  git commit -am side

  # we get a conflict, and we resolve
  git merge main
  echo resolved >file
  git commit -am merged

  # now imagine we had a file with a diff driver. I stuffed it
  # in here after the fact, but it could have been here all along,
  # or come as part of the merge, etc.
  echo whatever >unrelated
  echo "unrelated diff=foo" >.gitattributes
  git add .
  git commit --amend --no-edit

  # set up the diff driver not just to do a textconv, but to cache the
  # result. This will require writing out new objects for the cache
  # as part of the diff operation.
  git config diff.foo.textconv "$PWD/upcase"
  git config diff.foo.cachetextconv true
  cat >upcase <<\EOF &&
  #!/bin/sh
  tr a-z A-Z <$1
  EOF
  chmod +x upcase

  # now show the diff
  git log -1 --remerge-diff

  # and make sure the repo is still OK
  git fsck

The remerge diff will correctly show the textconv'd content (because
it's not in either parent, and hence an evil merge):

  diff --git a/unrelated b/unrelated
  new file mode 100644
  index 0000000..982793c
  --- /dev/null
  +++ b/unrelated
  @@ -0,0 +1 @@
  +WHATEVER

but then fsck shows that our cache is corrupted:

  Checking object directories: 100% (256/256), done.
  error: refs/notes/textconv/foo: invalid sha1 pointer 1e9b3ecffca73411001043fe914a7ec0e7291043
  error: refs/notes/textconv/foo: invalid reflog entry 1e9b3ecffca73411001043fe914a7ec0e7291043
  dangling tree 569b6e414203d2f50bdaafc1585eae11e28afc37

Now I'll admit the textconv-cache is a pretty seldom-used feature. And
that there _probably_ aren't a lot of other ways that the diff code
would try to write objects or references. But I think it speaks to the
kind of subtle interactions we should worry about (and certainly
corrupting the repository is a pretty bad outcome, though at least in
this case it's "just" a cache and we could blow away that ref manually).

-Peff
