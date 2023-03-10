Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CBAC6FD1C
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 09:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCJJc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCJJc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 04:32:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00191DABB1
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:29:40 -0800 (PST)
Received: (qmail 19234 invoked by uid 109); 10 Mar 2023 09:29:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 09:29:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10497 invoked by uid 111); 10 Mar 2023 09:29:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 04:29:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 04:29:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] add-patch: handle "* Unmerged path" lines
Message-ID: <ZAr4g63CnHADBvXJ@coredump.intra.peff.net>
References: <xmqqy1o8wdgi.fsf@gitster.g>
 <bff58f23-6188-9b1e-b23a-fc3d94e9f72f@gmail.com>
 <ZAmfqC9WMl3XeyEr@coredump.intra.peff.net>
 <xmqqcz5hby0p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz5hby0p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 10:05:58AM -0800, Junio C Hamano wrote:

> >   - we could print a warning that the path is ignored. We don't do that
> >     for "diff --cc" entries, either, though often those involve an index
> >     refresh that will print "my-conflict: needs merge" or similar.
> >
> >     Doing so would require parsing the path name from the line. We don't
> >     seem to quote it in any way, though. So a name like "foo\nbar" would
> >     probably produce confusing output (though this patch would do the
> >     right thing; we'd have a dummy entry for "foo", and then just
> >     tack the useless "bar" line onto it). We should decide what the diff
> >     side should produce before we start trying to parse it here.
> 
> We should write a name like "foo\ndiff --git a/foo b/foo" off as "if
> it hurts, don't do it" ;-).

Yeah, I don't have a huge amount of sympathy for people with such names.
Any time there's parsing ambiguity like this, it makes me wonder if
there are security implications, of course. But it seems pretty unlikely
here. You'd need some combination like:
 
  - a system that does diffs of untrusted content

  - it allows diffs using "--cached", and allows unmerged paths

  - it mixes the resulting output with other trusted lines that do
    interesting things.

I'd be really interested to hear of such a system if it exists. It seems
like a unicorn. :)

Still, on principle, it feels like the diff output ought to be quoting
the name in the usual way.

> >   - arguably we could shrink the list to only non-conflicted entries
> >     beforehand. That's what the "patch" menu item does if you run a full
> >     add--interactive. But it would be slower (you have to run an extra
> >     diff now). On the other hand, that is what the perl version did (and
> >     it consistently printed "ignoring unmerged: foo", and then said "No
> >     changes".
> 
> We already lost scripted version so it is not a solace that it
> worked correctly X-<.

Heh. I meant it less as solace (and I do think that failing to print
"ignoring unmerged" lines is a real, if minor, regression). I more meant
that the perl version happily ran an extra "diff" to determine the set
of unmerged files up front, and nobody seemed to be sad about the extra
cost.

> I do not know what to think that it took this
> long for people to hit this issue after 1fc18798 (Merge branch
> 'js/use-builtin-add-i', 2022-05-30).  The work to reimplement "add
> -i" in C started at f83dff60 (Start to implement a built-in version
> of `git add --interactive`, 2019-11-13) and looking at the output of 
> 
>     $ git log --format='%cI %h %s' --merges --grep="add-[ip]"
> 
> it seems that we have caught and fixed more bugs before we made it
> the default than after, and all the more recent fixes are on the
> smaller side, so I think we are in a good shape.

I am not too surprised. I am an avid "-p" user who has been running with
the builtin version since before it became the default, and hadn't
noticed any of this yet. To trigger the BUG you need:

  - unmerged files, which are already skipped by "-p" anyway

  - to use "reset -p" or similar to do an index-only manipulation (and
    I'd wager 90+% of "-p" usage is via "add -p")

  - have an unmerged file sort lexically at the front of the modified
    paths

Which is a bit specific. Just the first one is enough to notice the
lack of "ignoring unmerged" lines for "add -p", but since the index
refresh reports the path, I don't think I noticed that the wording was
slightly different.

In short, I feel OK saying that any bug we haven't flushed out at this
point is going to be either obscure or minor.

> >   - it's a little weird that the interactive-patch parser will complain
> >     if the first line of the diff is garbage, but not if it sees garbage
> >     later on. If we were more strict, that would have triggered the BUG()
> >     rather than tacking the unknown line to the hunk (and we _should_ be
> >     able to recognize arbitrary hunk lines by their "[-+ ]" prefixes).
> 
> There is recount_edited_hunk() but I am not sure if it can be relied
> upon (I've seen emacs's diff edit mode miscounting lines).

I would expect that to complain of unknown lines, too, but it doesn't
seem to (it looks like it just skips them). Maybe that is a feature, but
I'd think it would be nice to notice when the user forgets to add a
space at the beginning of a context line. I guess the diff doesn't apply
then. :)

> Another weird thing is that we do not complain if a patch does not
> have any hunk, but I guess we are lucky---that is what this fix
> takes advantage of ;-).

Yeah. If it barfed on that, then "add -p" would complain whenever you
had unmerged files, which I think people _would_ have noticed.

I don't have immediate plans to work on any of this, but just to write
down my notes for later, I think we may want to:

  - handle quoting in "diff --cached" output for unmerged lines

  - explicitly mention unmerged files that are ignored. The test I added
    here in t3701 could be modified to check its stderr.

    That can happen either by checking them up front with an extra diff,
    or by just noticing the "diff --cc" and "* Unmerged" lines while
    parsing the regular diff.

  - Either way, once these are handled explicitly, we can probably add
    an assertion that we don't have files without any hunks/mode
    changes.

  - Look into whether recount_edited_hunk() should be more picky about
    its input (or if that would annoy people who leave extra cruft in
    the file).

-Peff
