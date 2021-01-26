Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C6C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 10:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195B820723
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 10:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhA0KP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 05:15:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:39976 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S313686AbhAZXFN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 18:05:13 -0500
Received: (qmail 27847 invoked by uid 109); 26 Jan 2021 23:04:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jan 2021 23:04:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5098 invoked by uid 111); 26 Jan 2021 23:04:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 18:04:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 18:04:17 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 3/3] clone: respect remote unborn HEAD
Message-ID: <YBCf8SI3fK+rDyox@coredump.intra.peff.net>
References: <YAnr8lBESOO+ACL/@coredump.intra.peff.net>
 <20210126182212.2337587-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126182212.2337587-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 10:22:12AM -0800, Jonathan Tan wrote:

> > On Tue, Dec 22, 2020 at 01:54:20PM -0800, Jonathan Tan wrote:
> > 
> > > @@ -1323,10 +1325,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> > >  		remote_head = NULL;
> > >  		option_no_checkout = 1;
> > >  		if (!option_bare) {
> > > -			const char *branch = git_default_branch_name();
> > > -			char *ref = xstrfmt("refs/heads/%s", branch);
> > > +			const char *branch;
> > > +			char *ref;
> > > +
> > > +			if (unborn_head_target &&
> > > +			    skip_prefix(unborn_head_target, "refs/heads/", &branch)) {
> > > +				ref = unborn_head_target;
> > > +				unborn_head_target = NULL;
> > > +			} else {
> > > +				branch = git_default_branch_name();
> > > +				ref = xstrfmt("refs/heads/%s", branch);
> > > +			}
> > >  
> > >  			install_branch_config(0, branch, remote_name, ref);
> > > +			create_symref("HEAD", ref, "");
> > >  			free(ref);
> > >  		}
> > 
> > In the old code, we never called create_symref() at all. It makes sense
> > that we'd do it now when unborn_head_target is not NULL. But what about
> > in the "else" clause there? Now we're adding an extra create_symref()
> > call.
> 
> The "else" branch you're referring to is the one enclosing all of the
> lines quoted above, I believe?

I meant this clause:

> > > +                 } else {
> > > +                         branch = git_default_branch_name();
> > > +                         ref = xstrfmt("refs/heads/%s", branch);
> > > +                 }

which used to be what we always did unconditionally. So in the original
code, we did not call create_symref() in this code path. Afterwards, we
call it for the unborn HEAD (which I can buy is necessary) but _also_
for that regular path. I.e., why is the new code not:

  if (unborn_head_target && ...) {
          ref = unborn_head_target;
	  unborn_head_target = NULL;
	  create_symref("HEAD", ref, "");
  } else {
          branch = git_default_branch_name();
	  ref = xstrfmt("refs/heads/%s", branch);
  }

I.e., I don't understand:

  - why create_symref() wasn't need before (assuming it was not), and
    why it is OK to run it now in the non-unborn code path

  - why we need create_symref() in the unborn path (which is probably
    something mundane)

I can even buy the argument that it is simply for consistency, so that
all of the HEAD-setup commands are shared between the two paths. And
that it is OK to do so, because we are just overwriting what init-db did
before (even if sometimes it is the same thing). But I feel like that
deserves explanation in the commit message. :)

-Peff
