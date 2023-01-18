Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8F2C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 17:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjARRTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 12:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjARRTi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 12:19:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF2138B58
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 09:19:34 -0800 (PST)
Received: (qmail 1019 invoked by uid 109); 18 Jan 2023 17:19:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 17:19:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23104 invoked by uid 111); 18 Jan 2023 17:19:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 12:19:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 12:19:32 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 15/19] object-file.c: release the "tag" in check_tag()
Message-ID: <Y8gqJESD/wbEHZYb@coredump.intra.peff.net>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
 <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <patch-v4-15.19-66c24afb893-20230117T151202Z-avarab@gmail.com>
 <7e571cdd-c0fa-7519-848c-b0bc4613abab@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e571cdd-c0fa-7519-848c-b0bc4613abab@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2023 at 08:58:24PM +0100, René Scharfe wrote:

> Am 17.01.23 um 18:11 schrieb Ævar Arnfjörð Bjarmason:
> > Fix a memory leak that's been with us ever since c879daa2372 (Make
> > hash-object more robust against malformed objects, 2011-02-05). With
> > "HASH_FORMAT_CHECK" (used by "hash-object" and "replace") we'll parse
> > tags into a throwaway variable on the stack, but weren't freeing the
> > "item->tag" we might malloc() when doing so.
> >
> > The clearing that release_tag_memory() does for us is redundant here,
> > but let's use it as-is anyway. It only has one other existing caller,
> > which does need the tag to be cleared.
> 
> Calling it is better than getting our hands dirty with tag internals
> here.
> 
> There's similar leak in check_commit() in the same file, but plugging it
> would require exporting unparse_commit().  Or perhaps using the heavy
> hammer that is release_commit_memory()?  Anyway, it doesn't seem simple
> to me, so that would be a patch for a separate series.

I think both of these cases are a bit sketchy, because they create an
object struct on the stack, and not via alloc_*_node(), which may
violate assumptions elsewhere. In the case of the tag, it's probably OK.
For the commit, though, the "index" field is going to be 0, which may
confuse release_commit_memory(). It calls free_commit_buffer(), which is
going to use that index to try to free from the buffer slab.

So I'd be wary of calling that. I'm also slightly skeptical of the
existing code that calls parse_commit_buffer(), but I think it works. We
do not attach the buffer to the commit object there (good), and we pass
"0" for check_graph, so the graph code (which IIRC also uses the index
for some slab lookups) isn't run.

I think this code would be better off either:

  1. Just allocating an object struct in the usual way. I understand the
     desire not to spend extra memory, but parse_commit_buffer() is
     going to allocate structs under the hood for the tree and parent
     commits anyway.

  2. The point of this code is to find malformed input to hash-object.
     We're probably better off feeding the buffer to fsck_commit(), etc.
     It does more thorough checks, and these days it does not need an
     object struct at all.

Either of which would naturally fix the leak for tags. I'm not sure
there actually is a leak for commits, as commit structs don't store any
strings themselves.

I don't think any of that needs to hold up Ævar's current series,
though. Fixing the leak this way in the meantime is OK, and then if we
switch to one of the other techniques, the problem just goes away.

-Peff
