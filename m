Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75327C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 18:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjARSjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjARSjc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 13:39:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320AB47E
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 10:39:31 -0800 (PST)
Received: (qmail 2275 invoked by uid 109); 18 Jan 2023 18:39:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 18:39:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23842 invoked by uid 111); 18 Jan 2023 18:39:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 13:39:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 13:39:30 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 15/19] object-file.c: release the "tag" in check_tag()
Message-ID: <Y8g84mABtIiHmxTI@coredump.intra.peff.net>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
 <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <patch-v4-15.19-66c24afb893-20230117T151202Z-avarab@gmail.com>
 <7e571cdd-c0fa-7519-848c-b0bc4613abab@web.de>
 <Y8gqJESD/wbEHZYb@coredump.intra.peff.net>
 <fd883d86-0c85-6c72-a331-2e8b2064befe@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd883d86-0c85-6c72-a331-2e8b2064befe@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 07:05:32PM +0100, René Scharfe wrote:

> >   2. The point of this code is to find malformed input to hash-object.
> >      We're probably better off feeding the buffer to fsck_commit(), etc.
> >      It does more thorough checks, and these days it does not need an
> >      object struct at all.
> 
> I like the second one, as long as it won't check too much.  c879daa237
> (Make hash-object more robust against malformed objects, 2011-02-05) added
> the checks that are now in object-file.c and intended to only validate the
> internal structure of objects, not relations between.  It gave the example
> to allow adding a commit before its tree, which should be allowed.  And
> IIUC fsck_object() fits that bill.

Yes, I think it will do what the right thing here. And having just
written up a quick series, the only tests which needed changes were ones
with syntactic problems. :)

I'll send it out in a few minutes.

> > Either of which would naturally fix the leak for tags. I'm not sure
> > there actually is a leak for commits, as commit structs don't store any
> > strings themselves.
> 
> parse_commit_buffer() allocates the list of parents.

Yes, but it does so with lookup_commit(), so the resulting commit
objects are themselves reachable from the usual obj_hash, and thus not
leaked.

> Hmm, and it looks them up.  Doesn't this violate the goal to allow
> dangling references?

No, because lookup_commit() is just about creating an in-process struct.
It doesn't look at the object database at all (though it would complain
if we had seen the same oid in-process as another type).

-Peff
