Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C5BC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJQT3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiJQT26 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 15:28:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD278BCD
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 12:27:39 -0700 (PDT)
Received: (qmail 27772 invoked by uid 109); 17 Oct 2022 19:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 19:27:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10093 invoked by uid 111); 17 Oct 2022 19:27:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 15:27:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 15:27:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com, vdye@github.com, gitster@pobox.com
Subject: Re: [PATCH] builtin/repack.c: remove redundant pack-based bitmaps
Message-ID: <Y02shQFeXkwYd2g6@coredump.intra.peff.net>
References: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
 <Y02YzYS172skpbAb@coredump.intra.peff.net>
 <221017.868rlejn4z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221017.868rlejn4z.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 08:50:07PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Oct 17 2022, Jeff King wrote:
> 
> > On Wed, Oct 12, 2022 at 03:05:33PM -0400, Taylor Blau wrote:
> > [...]
> >> [...]
> >> +	for_each_string_list_item(item, include) {
> >> +		strbuf_addstr(&path, item->string);
> >> +		strbuf_strip_suffix(&path, ".idx");
> >> +		strbuf_addstr(&path, ".bitmap");
> >> +
> >> +		if (unlink(path.buf) && errno != ENOENT)
> >> +			die_errno(_("could not remove stale bitmap: %s"),
> >> +				  path.buf);
> >
> > We could downgrade this to a warning, since there is no downside to
> > retaining those files (aside from wasted space). In
> > remove_redundant_pack(), we call into unlink_pack_path(), which just
> > ignores unlink errors (though arguably it should at least warn).
> 
> An ENOENT would indicate a race with a concurrent process.

In the code above, I don't think it is. We included some packs in the
midx, and we know that their bitmaps (if any) are now redundant. So we
remove them by calling unlink() speculatively, rather than asking "do we
have this file? If so, unlink".

Likewise in remove_redundant_pack(). We are not just removing the
packfiles, but speculatively removing their .rev, .bitmap, .promisor,
etc. If they don't exist, that's perfectly normal. Arguably we could
notice and complain if the .pack or .idx went away in the interim, since
those would indicate a race.

So I think the code above is right to ignore ENOENT. The one in
remove_redundant_pack() does so, too, but it also ignores everything
else.

> But at that point should we be ignoring other unlink() errors?  Maybe we
> should additionally be ignoring EBUSY.

For most errors besides ENOENT, I think a warning is the right thing. It
is OK that we failed to remove the file (it does not make the overall
operation a failure). But it may be helpful for the user to let them
know that the cruft was left (e.g., for EPERM or EIO). And that applies
here and in remove_redundant_pack().

Really, both here and remove_redundant_pack() should probably be using
unlink_or_warn(). Though if you did want to notice the race on deleting
the actual .pack file, it would need to be hand-coded.

-Peff
