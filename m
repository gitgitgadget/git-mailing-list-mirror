Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DC9EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 07:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjF0HzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 03:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjF0Hyf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 03:54:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C61FFA
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 00:54:28 -0700 (PDT)
Received: (qmail 31982 invoked by uid 109); 27 Jun 2023 07:54:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 07:54:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14769 invoked by uid 111); 27 Jun 2023 07:54:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 03:54:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 03:54:27 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] repack: only repack .packs that exist
Message-ID: <20230627075427.GE1226768@coredump.intra.peff.net>
References: <pull.1546.git.1687287782439.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1546.git.1687287782439.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 07:03:02PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> 
> In 73320e49add (builtin/repack.c: only collect fully-formed packs,
> 2023-06-07), we switched the check for which packs to collect by
> starting at the .idx files and looking for matching .pack files. This
> avoids trying to repack pack-files that have not had their pack-indexes
> installed yet.
> 
> However, it does cause maintenance to halt if we find the (problematic,
> but not insurmountable) case of a .idx file without a corresponding
> .pack file. In an environment where packfile maintenance is a critical
> function, such a hard stop is costly and requires human intervention to
> resolve (by deleting the .idx file).
> 
> This was not the case before. We successfully repacked through this
> scenario until the recent change to scan for .idx files.
> 
> Further, if we are actually in a case where objects are missing, we
> detect this at a different point during the reachability walk.

I'd worry less about missing objects here, and more that we could be in
a race in which git-repack sees some partial state and decides to take
some action that causes harm. For example, in a "git repack -ad", could
we later mistakenly delete a .idx file because we thought it had no
matching pack? The repack itself would be happy, but it might be causing
headaches for later processes.

I _think_ the answer is "no", because any file we skip via
collect_pack_filenames() won't make it into the list of either the
existing nonkept or kept packs, and we use "nonkept" list to do the
deletion.

So it seems like missing a pack here (whether racily or not) could at
most result in cruft being left in place, or a bad --geometric decision
being made, etc. Which makes the stakes reasonably low, I think.

> In other cases, Git prepares its list of packfiles by scanning .idx
> files and then only adds it to the packfile list if the corresponding
> .pack file exists. It even does so without a warning! (See
> add_packed_git() in packfile.c for details.)

Interesting. I'd have expected a warning. ;)

I also kind of wonder if this repack code should simply be loading and
iterating the packed_git list, but that is a much bigger change.

> This case is much less likely to occur than the failures seen before
> 73320e49add. Packfiles are "installed" by writing the .pack file before
> the .idx and that process can be interrupted. Packfiles _should_ be
> deleted by deleting the .idx first, followed by the .pack file, but
> unlink_pack_path() does not do this: it deletes the .pack _first_,
> allowing a window where this process could be interrupted. We leave the
> consideration of changing this order as a separate concern. Knowing that
> this condition is possible from interrupted Git processes and not other
> tools lends some weight that Git should be more flexible around this
> scenario.

Hmm. So it really sounds to me like unlink_pack_path() is doing the
wrong thing. And once fixed, we would (assuming no other similar spots)
cease to see any races with this code. At which point would we still
want the looseness provided by this patch?

I.e., is the concern concurrent races, or is it leftover cruft (possibly
from a killed process, crash, etc)?

If the latter, then we might still want to quietly skip them. But it
makes me wonder how such .idx files should get cleaned up in the longer
term.

I'm kind of guessing that what you've seen is actually leftover cruft,
if only because I wouldn't expect concurrent unlinking to be very common
(it implies two repacks running at the same time, which is generally a
bad idea). Whereas new packs being written would be common (via
index-pack, etc from pushes).

> Add a check to see if the .pack file exists before adding it to the list
> for repacking. This will stop a number of maintenance failures seen in
> production but fixed by deleting the .idx files.

OK. The fact that this brings things in line with add_packed_git() is
compelling to me, and I think the stakes are pretty low for this causing
us to do something confusing.

It does make me feel like we should be doing something similar to
git-prune's prune_cruft(): any non-.pack file in objects/pack with an
old mtime and no matching .pack file should be a candidate for deletion.
I don't _think_ we have anything like that now, but it would clean these
in the longer term. I'm OK with that being a separate topic, though.

-Peff
