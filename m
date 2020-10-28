Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03E3C4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AAF20790
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgJ1XIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:08:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:40646 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbgJ1XHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:07:46 -0400
Received: (qmail 23584 invoked by uid 109); 28 Oct 2020 09:41:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Oct 2020 09:41:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31471 invoked by uid 111); 28 Oct 2020 09:41:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Oct 2020 05:41:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Oct 2020 05:41:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] verify_path(): disallow symlinks in
 .gitattributes and .gitignore
Message-ID: <20201028094105.GA175280@coredump.intra.peff.net>
References: <20201005121609.GA2907272@coredump.intra.peff.net>
 <20201005121645.GG2907394@coredump.intra.peff.net>
 <20201027033518.GH2645313@google.com>
 <20201027075853.GH3005508@coredump.intra.peff.net>
 <xmqqv9ev9vnf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9ev9vnf.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 03:00:36PM -0700, Junio C Hamano wrote:

> > +	/*
> > +	 * Now we have a path in "target" that only go down into the tree.
> > +	 * Disallow any interior "../", like "foo/../bar". These might be
> > +	 * OK, but we cannot know unless we know whether "foo" is itself a
> > +	 * symlink. So err on the side of caution.
> > +	 */
> > +	while (*target) {
> > +		const char *v;
> > +		if (skip_prefix(target, "..", &v) && (!*v || is_dir_sep(*v)))
> > +			return 1;
> > +		target++;
> > +	}

Just reading over the patch again, I suspect this is overly eager to
find ".." that is not bordered by a directory separator on the left-hand
side (e.g., I think it will match "foo../").

> > +int safe_symlink(const char *target, const char *linkpath)
> > +{
> > +	if (!allow_external_symlinks &&
> > +	    symlink_leaves_repo(target, linkpath)) {
> > +		errno = EPERM;
> > +		return -1;
> > +	}
> > +
> > +	return symlink(target, linkpath);
> > +}
> 
> OK.  This is only about blocking creation of new symbolic links that
> goes outside the working tree.  It obviously is a good thing to do.
> 
> We have some "symlink safety" in various parts of the system [*1*],
> and I wonder if we can somehow consolidate the support to a more
> central place.

Note that it is overly conservative, as described in the comment quoted
at the top of this email. It's possible that other code might be able to
be more accurate because it can see "/foo/" in the middle of a symlink
target and actually _look_ at "foo".  Does it exist, is it a symlink
itself, etc.

Whereas here we're taking a purely textual look at the target. We have
to, I think, because we don't know if or when that "foo" will get
updated. And maybe that same restriction applies to other parts of the
system, or maybe not.

At any rate, I don't really have plans to push this particular topic
forward, at least not in the near term. I was mostly sharing it in case
anybody found it useful. If somebody wants to run with it, please be my
guest.

-Peff
