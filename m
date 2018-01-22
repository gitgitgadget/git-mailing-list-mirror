Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60F71F424
	for <e@80x24.org>; Mon, 22 Jan 2018 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeAVKEB (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 05:04:01 -0500
Received: from mail.strova.dk ([83.169.38.5]:52496 "EHLO mail.strova.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbeAVKEA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 05:04:00 -0500
Received: from novascotia (users-1190.st.net.au.dk [130.225.0.251])
        by mail.strova.dk (Postfix) with ESMTPSA id BBF2260845;
        Mon, 22 Jan 2018 11:03:58 +0100 (CET)
Date:   Mon, 22 Jan 2018 11:03:57 +0100
From:   Mathias Rav <m@git.strova.dk>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Mathias Rav <m@git.strova.dk>, git@vger.kernel.org
Subject: Re: [PATCH] files_initial_transaction_commit(): only unlock if
 locked
Message-ID: <20180122110357.683b21a7@novascotia>
In-Reply-To: <8328c28a-d93b-1076-20d3-823dbddf7e4c@alum.mit.edu>
References: <20180118143841.1a4c674d@novascotia>
        <20180118141914.GA32718@sigill.intra.peff.net>
        <xmqqwp0do5sg.fsf@gitster.mtv.corp.google.com>
        <8328c28a-d93b-1076-20d3-823dbddf7e4c@alum.mit.edu>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-22 10:25 +0100 Michael Haggerty <mhagger@alum.mit.edu>:
> On 01/19/2018 11:14 PM, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> >   
> >> On Thu, Jan 18, 2018 at 02:38:41PM +0100, Mathias Rav wrote:
> >>  
> >>> Running git clone --single-branch --mirror -b TAGNAME previously
> >>> triggered the following error message:
> >>>
> >>> 	fatal: multiple updates for ref 'refs/tags/TAGNAME' not allowed.
> >>>
> >>> This error condition is handled in files_initial_transaction_commit().
> >>>
> >>> 42c7f7ff9 ("commit_packed_refs(): remove call to `packed_refs_unlock()`", 2017-06-23)
> >>> introduced incorrect unlocking in the error path of this function,
> >>> which changes the error message to
> >>>
> >>> 	fatal: BUG: packed_refs_unlock() called when not locked
> >>>
> >>> Move the call to packed_refs_unlock() above the "cleanup:" label
> >>> since the unlocking should only be done in the last error path.  
> >>
> >> Thanks, this solution looks correct to me. It's pretty low-impact since
> >> the locking is the second-to-last thing in the function, so we don't
> >> have to re-add the unlock to a bunch of error code paths. But one
> >> alternative would be to just do:
> >>
> >>   if (packed_refs_is_locked(refs))
> >> 	packed_refs_unlock(refs->packed_ref_store);
> >>
> >> in the cleanup section.  
> > 
> > Yeah, that may be a more future-proof alternative, and just as you
> > said the patch as posted would be sufficient, too.  
> 
> Either solution LGTM. Thanks for finding and fixing this bug.
> 
> But let's also take a step back. The invocation
> 
>     git clone --single-branch --mirror -b TAGNAME
> 
> seems curious. Does it even make sense to use `--mirror` and
> `--single-branch` at the same time? What should it do?
> 
> Normally `--mirror` implies (aside from `--bare`) that the remote
> references should be converted 1:1 to local references and should be
> overwritten at every fetch; i.e., the refspec should be set to
> `+refs/*:refs/*`.
> 
> To me the most plausible interpretation of `--mirror --single-branch -b
> BRANCHNAME` would be that the single branch should be fetched and made
> the HEAD, and the refspec should be set to
> `+refs/heads/BRANCHNAME:refs/heads/BRANCHNAME`. It also wouldn't be very
> surprising if it were forbidden to use these options together.
> 
> Currently, we do neither of those things. Instead we fetch that one
> reference (as `refs/heads/BRANCHNAME`) but set the refspec to
> `+refs/*:refs/*`; i.e., the next fetch would fetch all of the history.
> 
> It's even more mind-bending if `-b` is passed a `TAGNAME` rather than a
> `BRANCHNAME`. The documentation says that `-b TAGNAME` "detaches the
> HEAD at that commit in the resulting repository". If `--single-branch -b
> TAGNAME` is used, then the refspec is set to
> `+refs/tags/TAGNAME:refs/tags/TAGNAME`. But what if `--mirror` is also used?
> 
> Currently, this fails, apparently because `--mirror` and `-b TAGNAME`
> each independently try to set `refs/tags/TAGNAME` (presumably to the
> same value). *If* this is a useful use case, we could fix it so that it
> doesn't fail. If not, maybe we should prohibit it explicitly and emit a
> clearer error message.
> 
> Mathias: if you encountered this problem in the real world, what were
> you trying to accomplish? What behavior would you have expected?

I wanted a shallow, single-commit clone of a single tag into a bare
repo. Concretely, I wanted to change the Arch Linux build script for
linux-tools to make a shallow clone of the Linux kernel rather than an
ordinary clone, for a tagname corresponding to a released kernel
version. (Of course, it would have been better to change the build
script to download a tarball instead of using git, but without
knowledge of the build script it seemed easier for me to just change
the git invocation.)

Currently, Arch Linux's build script uses
`git clone --mirror "$url" "$dir"` to clone a remote repo;
a StackExchange post [1] suggested changing this to
`git clone --mirror --depth 1 "$url" "$dir"`. (The post also adds
`--single-branch`, but this is implied by `--depth`.)

[1] https://unix.stackexchange.com/a/203335/220010

Naively I added `-b TAGNAME` to fetch just a single tag, but this
resulted in the error.

If I remove `--mirror`, i.e. invoke `git clone --depth 1 -b TAGNAME`,
then the refspec is `+refs/tags/TAGNAME:refs/tags/TAGNAME` as might be
expected, but this results in a non-bare repo.

If instead I change `--mirror` to `--bare`, i.e. invoke
`git clone --bare --depth 1 -b TAGNAME`, this results in a cloned
repository with no `remote.origin.fetch` refspec at all.
I would expect the refspec in this case to be set to
`+refs/tags/TAGNAME:refs/tags/TAGNAME` (just as with `--mirror`).

/Mathias
