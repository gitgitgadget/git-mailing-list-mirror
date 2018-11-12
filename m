Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015C01F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbeKLWPu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:15:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:35316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729244AbeKLWPu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:15:50 -0500
Received: (qmail 23527 invoked by uid 109); 12 Nov 2018 12:22:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 12:22:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10130 invoked by uid 111); 12 Nov 2018 12:22:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:22:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 07:22:45 -0500
Date:   Mon, 12 Nov 2018 07:22:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     nbelakovski@gmail.com, rafa.almas@gmail.com, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ref-filter: add worktree atom
Message-ID: <20181112122245.GB3956@sigill.intra.peff.net>
References: <20180927204049.GA2628@rigel>
 <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181111235831.44824-2-nbelakovski@gmail.com>
 <xmqqsh061u7o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsh061u7o.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 07:11:23PM +0900, Junio C Hamano wrote:

> > +	}
> > +
> > +	string_list_sort(&atom->u.worktree_heads);
> > +
> > +	free_worktrees(worktrees);
> > +	return 0;
> > +}
> 
> So..., this function collects any and all branches that are checked
> out in some worktree, and sort them _without_ dedup.  The user of
> the resulting information (i.e. atom->u.worktree_heads) cannot tell
> where each of the listed branches is checked out.
> 
> I wonder if "The worktree at /local/src/wt1 has this branch checked
> out" is something the user of %(worktree) atom, or a variant thereof
> e.g. "%(worktree:detailed)", may want to learn, but because that
> information is lost when this function returns, such an enhancement
> cannot be done without fixing this funciton.

Hmm. I think for the purposes of this series we could jump straight to
converting %(worktree) to mean "the path of the worktree for which this
branch is HEAD, or the empty string otherwise".

Then the caller from git-branch (or anybody wanting to emulate it) could
still do:

  %(if)%(worktree)%(then)+ %(refname)%(end)

As a bonus, the decision to use "+" becomes a lot easier. It is no
longer a part of the format language that we must promise forever, but
simply a porcelain decision by git-branch.

> Also, I am not sure if this "list of some info on worktrees" really
> belongs to an individual atom.  For one thing, if a format includes
> more than one instance of %(worktree) atoms, you'd iterate over the
> worktrees as many times as the number of these atoms you have.  Is
> there another existing atom that "caches" expensive piece of
> information per used_atom[] element like this one?  Essentially I am
> trying to convince myself that the approach taken by the patch is a
> sane one by finding a precedent.

Yes, we faced this a bit with Olga's cat-file conversion patches (where
we had a shared struct object_info). There probably should just be a
file-global data-structure storing the worktree info once (in an ideal
world, it would be part of a "struct ref_format" that uses no global
variables, but that is not how the code is structured today).

> > +		} else if (!strcmp(name, "worktree")) {
> > +			if (string_list_has_string(&atom->u.worktree_heads, ref->refname))
> 
> I thought we were moving towards killing the use of string_list as a
> look-up table, as we do not want to see thoughtless copy&paste such
> a code from parts of the code that are not performance critical to a
> part.  Not very satisfying.
> 
> 	I think we can let this pass, and later add a wrapper around
> 	hashmap that is meant to only be used to replace string-list
> 	used for this exact purpose, i.e. key is a string, and there
> 	is no need to iterate over the existing elements in any
> 	sorted order.  Optionally, we can limit the look up to only
> 	checking for existence, if it makes the code for the wrapper
> 	simpler.

This came up over in another thread yesterday, too. So yeah, perhaps we
should move on that (I am OK punting on it for this series and
converting it later, though).

-Peff
