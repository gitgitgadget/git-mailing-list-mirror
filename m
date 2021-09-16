Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA72AC433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45796120C
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbhIPVq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:46:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:49498 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234847AbhIPVqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:46:24 -0400
Received: (qmail 8461 invoked by uid 109); 16 Sep 2021 21:45:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Sep 2021 21:45:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9399 invoked by uid 111); 16 Sep 2021 21:45:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Sep 2021 17:45:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Sep 2021 17:45:02 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
Message-ID: <YUO63qy2/5wibY4/@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
 <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
 <YTTARcEvpXWSDfYW@coredump.intra.peff.net>
 <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
 <YTeo/dCFfpAIfo3K@coredump.intra.peff.net>
 <CAOLTT8Ru-Zhmo5j=jNjWexrahT0qAO5zEMW09XT00-TCca-SkA@mail.gmail.com>
 <YTtrF8C0mmT6kBJT@coredump.intra.peff.net>
 <CAOLTT8RPzutEQxbr9cu=ze7rgPKvG6Ghu4b2Bi47eStY1TqGzQ@mail.gmail.com>
 <CAOLTT8SYxUbfG7YvAs03nwRdee8JfNPUYCCpKcFoAgBjB2oqLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8SYxUbfG7YvAs03nwRdee8JfNPUYCCpKcFoAgBjB2oqLw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 10:23:43PM +0800, ZheNing Hu wrote:

> ZheNing Hu <adlternative@gmail.com> 于2021年9月15日周三 下午8:27写道：
> >
> > > So yes, it's complicated. And it must be explained to the user that
> > > "%(refname)" behaves slightly differently with "git tag --verify", but
> > > that is unavoidable if we do not want to break scripts (it _already_
> > > behaves slightly differently, and we just never told anyone).
> > >
> 
> $ git tag --verify --format='verify: %(refname) %(symref)' annotated symref
> verify: annotated
> verify: symref
> $ git tag --verify --format='verify: %(refname) %(symref)'
> refs/tags/annotated refs/tags/symref
> error: tag 'refs/tags/annotated' not found.
> error: tag 'refs/tags/symref' not found.

This is expected. When you provide a tag name on the command line of
"git tag" it is assumed to be a non-qualified name in refs/tags/ (and
ditto for git-branch and refs/heads/). It is tempting to try to be
friendly and accept fully-qualified refs there, but it would create
ambiguities (e.g., you could really have refs/tags/refs/tags/foo as a
ref).

I think we can ignore that for our purposes here, though. It's a
question of input from the command-line, and we focus on just the output
that we produce.

> $ git verify-tag --format='verify: %(refname) %(symref)' annotated
> symref
> verify: annotated
> verify: symref
> $ git verify-tag --format='verify: %(refname) %(symref)'
> refs/tags/annotated refs/tags/symref
> verify: refs/tags/annotated
> verify: refs/tags/symref
> 
> As we can see, there is a slight difference between git tag --verify and
> git verify-tag: git tag --verify can not handle refs' fullname refs/tags/*
> (because read_ref_full() | read_ref() can't handle them). So, as a standard,
> which characteristics should we keep?

Whereas are you notice here, verify-tag takes any name (which could be
fully qualified), and uses it as-is. In fact, it might not even be a ref
at all! You can say "git verify-tag c06b72d02" if you want to. And as a
plumbing tool, we should make sure this continues to work. For example,
careful scripts may resolve a ref into an object, and want to continue
talking about that object without worrying about the ref being changed
simultaneously.

But it also creates a weirdness for "git verify-tag --format". We do not
necessarily even have a ref to show. So IMHO the feature is somewhat
mis-designed in the first place. But we should probably continue to
support it as best we can.

The best I can come up with is:

  - when we resolve the name, if it was a ref, we should record that.
    I think this is hard to do now. It would probably require
    get_oid_with_context() learning to report on the results it got from
    dwim_ref().

  - if we have a refname, then feed it to pretty_print_ref() as a
    fully-qualified name. And pass whatever "default lstrip=2" magic we
    come up with for "git tag --verify". That would mean that "git
    verify-tag --format=%(refname) v2.33.0" would behave the same before
    and after.

  - if we didn't get a refname, then...I guess continue to pass the name
    the user gave us into pretty_print_ref()? That would keep "git
    verify-tag --format=%(refname) c06b72d02" working as it does today.

The alternative is to do none of those things, and just document that
"verify-tag" is weird:

  - its %(refname) reports whatever you gave it, whether it is a ref or
    not

  - some advanced format placeholders like %(symref) may not work if you
    don't pass a fully-qualified ref

-Peff
