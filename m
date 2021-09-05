Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9672EC433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6904960F5E
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 13:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhIENFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 09:05:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:39726 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhIENFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 09:05:10 -0400
Received: (qmail 8669 invoked by uid 109); 5 Sep 2021 13:04:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 05 Sep 2021 13:04:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22713 invoked by uid 111); 5 Sep 2021 13:04:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Sep 2021 09:04:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 5 Sep 2021 09:04:05 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
Message-ID: <YTTARcEvpXWSDfYW@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
 <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 05, 2021 at 04:20:02PM +0800, ZheNing Hu wrote:

> But here is a terrible fact: we did not use ref_array_sort() for sorting here.
> So in fact, for_each_fullref_in() does the sorting work () for us by
> default sort (%(refname)),
> This may be due to the file system or some implementation of ref_iterator.
> But this limit the application of this optimization when we use other
> atoms to sort.

Right. This technique does not help at all if you use --sort. I do think
it's reasonable to rely on the sorted output of the for_each_ref()
functions; other parts of Git likely do as well, so I think we'd try
pretty hard to maintain that (and no, it's not a filesystem thing; we do
make sure to sort it ourselves; see the calls to sort_ref_dir()).

> > +       /*
> > +        * the %(symref) placeholder is broken with pretty_print_ref(),
> > +        * which our streaming code uses. I suspect this is a sign of breakage
> > +        * in other callers like verify_tag(), which should be fixed. But for
> > +        * now just disable streaming.
> > +        *
> > +        * Note that this implies we've parsed the format already with
> > +        * verify_ref_format().
> > +        */
> > +       if (need_symref)
> > +               return;
> > +
> 
> I haven’t taken a closer look at why pretty_print_ref() does not
> support %(symref),
> we can skip it first.

I think it's just because pretty_print_ref() does not take a "flag"
parameter for the caller. So it never sees that REF_ISSYMREF is set.

There aren't many callers of that function, so I think nobody ever
really noticed. But you can see the bug like this:

  git init repo
  cd repo
  
  git commit --allow-empty -m foo
  git tag -s -m bar annotated &&
  git symbolic-ref refs/tags/symref refs/tags/annotated
  
  # this is ok; ref-filter handles the flags
  git tag --list --format='list: %(refname) %(symref)'
  
  # not ok; we do not tell the formatter about the flags, so it does
  # not notice that "symref" is a symref
  git tag --verify --format='verify: %(refname) %(symref)' annotated symref

I notice that the --verify output also shows the short refname, which
makes me wonder if %(symref) would have other bugs there (because it
has to re-resolve the ref to come up with the symref destination).

> Unfortunately, this optimization may not be helpful for git cat-file --batch,
> see [1], batch_object_write() directly constructs a ref_array_item and call
> format_ref_array_item() to grab data, It does not use ref_array. So it also
> does not have this malloc() | free() overhead.

Right. It would only be helped by the "quick" formats in the second
patch (and by skipping the malloc/free of the individual
ref_array_items).

-Peff
