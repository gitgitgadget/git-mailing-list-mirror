Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA4C19F2D
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 08:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiHKIdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiHKIdN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 04:33:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630E88A7DE
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 01:33:12 -0700 (PDT)
Received: (qmail 8558 invoked by uid 109); 11 Aug 2022 08:33:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Aug 2022 08:33:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19845 invoked by uid 111); 11 Aug 2022 08:33:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Aug 2022 04:33:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Aug 2022 04:33:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Xavier Morel <xavier.morel@masklinn.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] fsck: downgrade tree badFilemode to "info"
Message-ID: <YvS+x35sxXmO5H1h@coredump.intra.peff.net>
References: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
 <YvQdR3sDqDMCIjIE@coredump.intra.peff.net>
 <xmqqo7wriwfl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7wriwfl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 03:08:14PM -0700, Junio C Hamano wrote:

> I was almost sure that before we "unified" the codepath for normal
> tree reading and the one used for fsck in a mistaken way, which was
> fixed in this series, we were catching these anomalous mode bits,
> but the suspected regression is too long ago that it does not make a
> practical difference if it was always broken or it was broken long
> time ago.  The risk to start complaining on existing projects is the
> same either way.

I agree with the "it was so long ago it does not matter", but for the
sake of posterity, here's what my digging found:

  - we got the mode fsck checks in 64071805ed (git-fsck-cache: be
    stricter about "tree" objects, 2005-07-27), though there is a proto
    version that is even a little older. Back then we were using a
    linked list to hold the parsed tree entries (!), but it was parsed
    by a central spot in parse_tree_buffer().

  - that linked list code went away in 15b5536ee4 (Remove last vestiges
    of generic tree_entry_list, 2006-05-29). But...

  - ...by then we already had 1b0c7174a1 (tree/diff header cleanup.,
    2006-03-29), which had tree_entry_extract(). And that commit
    introduced canon_mode, including the same "set unexpected things to
    a default", though of course back then it waas S_IFDIR since
    gitlinks didn't exist. ;)

  - that canon_mode() was just a rename from DIFF_FILE_CANON_MODE(),
    which ultimately came from 67574c403f ([PATCH] diff: mode bits
    fixes, 2005-06-01)

So some form of canon_mode() does predate the fsck checks, but I _think_
the fsck code was using the old linked-list version until 15b5536ee4,
and would not have been affected. So yes, there were probably 10 months
in 2005-2006 where we would have detected these. :)

Again, probably not important, but it was interesting for me at least to
see the evolution of the tree code. Most of those changes predate my
involvement with the code.

-Peff
