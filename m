Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AEAC25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 07:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjAVHs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 02:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVHs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 02:48:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C580513D56
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 23:48:54 -0800 (PST)
Received: (qmail 4957 invoked by uid 109); 22 Jan 2023 07:48:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Jan 2023 07:48:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27770 invoked by uid 111); 22 Jan 2023 07:48:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Jan 2023 02:48:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Jan 2023 02:48:52 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/6] hash-object: use fsck to check objects
Message-ID: <Y8zqZH+X6fOoCOYV@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8ifa7hyqxSbL92U@coredump.intra.peff.net>
 <97faa323-a5b9-e459-70d7-3f6318446898@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97faa323-a5b9-e459-70d7-3f6318446898@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2023 at 10:36:08AM +0100, René Scharfe wrote:

> Am 19.01.23 um 02:39 schrieb Jeff King:
> >
> > Though I do find the use of strlen() in decode_tree_entry()
> > a little suspicious (and that would be true of the current code, as
> > well, since it powers hash-object's existing parsing check).
> 
> strlen() won't overrun the buffer because the first check in
> decode_tree_entry() makes sure there is a NUL in the buffer ahead.
> If get_mode() crosses it then we exit early.

Yeah, that was what I found after digging deeper (see my patch 7).

> Storing the result in an unsigned int can overflow on platforms where
> size_t is bigger.  That would result in pathlen values being too short
> for really long paths, but no out-of-bounds access.  They are then
> stored as signed int in struct name_entry and used as such in many
> places -- that seems like a bad idea, but I didn't actually check them
> thoroughly.

Yeah, I agree that the use of a signed int there looks questionable. I
do think it's orthogonal to my series here, as that tree-decoding is
used by the existing hash-object checks.

But it probably bears further examination, especially because we use it
for the fsck checks on incoming objects via receive-pack, etc, which are
meant to be the first line of defense for hosters who might receive
malicious garbage from users.

We probably ought to reject trees with enormous names via fsck anyway. I
actually have a patch to do that, but of course it depends on
decode_tree_entry() to get the length, so there's a bit of
chicken-and-egg. We probably also should outright reject gigantic trees,
which closes out a whole class of integer truncation problems. I know
GitHub has rejected trees over 100MB for years for this reason.

> get_mode() can overflow "mode" if there are too many octal digits.  Do
> we need to accept more than two handfuls in the first place?  I'll send
> a patch for at least rejecting overflow.

Seems reasonable. I doubt there's an interesting attack here, just
because the mode isn't used to index anything. If you feed a garbage
mode that happens to overflow to something useful, you could just as
easily have sent the useful mode in the first place.

> Hmm, what would be the performance impact of trees with mode fields
> zero-padded to silly lengths?

Certainly it would waste some time parsing the tree, but you could do
that already with a long pathname. Or just having a lot of paths in a
tree. Or a lot of trees.

-Peff
