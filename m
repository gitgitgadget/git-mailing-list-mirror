Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C7C1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeHITb6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 15:31:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:48690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730634AbeHITb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 15:31:57 -0400
Received: (qmail 26912 invoked by uid 109); 9 Aug 2018 17:06:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 17:06:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11332 invoked by uid 111); 9 Aug 2018 17:06:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 13:06:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 13:06:10 -0400
Date:   Thu, 9 Aug 2018 13:06:10 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     git@vger.kernel.org
Subject: Re: Help with "fatal: unable to read ...." error during GC?
Message-ID: <20180809170609.GE1439@sigill.intra.peff.net>
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
 <20180808160612.GC1607@sigill.intra.peff.net>
 <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
 <20180808182436.GA19096@sigill.intra.peff.net>
 <249be5d3dada9a4b1b5282896a9a11e12c1ffd2a.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <249be5d3dada9a4b1b5282896a9a11e12c1ffd2a.camel@mad-scientist.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 08, 2018 at 10:45:49PM -0400, Paul Smith wrote:

> On Wed, 2018-08-08 at 14:24 -0400, Jeff King wrote:
> > If so, can you try running it under gdb and getting a stack trace?
> > Something like:
> > 
> >   gdb git
> >   [and then inside gdb...]
> >   set args pack-objects --all --reflog --indexed-objects foo </dev/null
> >   break die
> >   run
> >   bt
> > 
> > That might give us a clue where the broken object reference is coming
> 
> Here we go.  I can rebuild with -Og or -O0 if more detailed debugging
> is needed; most everything appears to be optimized out:

No, I think this is enough to give a general sense of the problem
location.

> Compressing objects: 100% (107777/107777), done.
> Writing objects:  54% (274416/508176)   
> Thread 1 "git" hit Breakpoint 1, die (err=err@entry=0x5a373a "unable to read %s") at usage.c:119
> 119     {
> (gdb) bt
> #0  die (err=err@entry=0x5a373a "unable to read %s") at usage.c:119
> #1  0x00000000004563f3 in get_delta (entry=<optimized out>) at builtin/pack-objects.c:143
> #2  write_no_reuse_object () at builtin/pack-objects.c:308
> #3  0x0000000000456592 in write_reuse_object (usable_delta=<optimized out>, limit=<optimized out>, entry=<optimized out>, f=<optimized out>) at builtin/pack-objects.c:516
> #4  write_object (write_offset=<optimized out>, entry=0x7fffc9a8d940, f=0x198fb70) at builtin/pack-objects.c:518
> #5  write_one () at builtin/pack-objects.c:576
> #6  0x00000000004592f0 in write_pack_file () at builtin/pack-objects.c:849
> #7  cmd_pack_objects (argc=<optimized out>, argv=<optimized out>, prefix=<optimized out>) at builtin/pack-objects.c:3354
> #8  0x0000000000404f06 in run_builtin (argv=<optimized out>, argc=<optimized out>, p=<optimized out>) at git.c:417
> #9  handle_builtin (argc=<optimized out>, argv=<optimized out>) at git.c:632
> #10 0x0000000000405f21 in run_argv (argv=0x7fffffffe210, argcp=0x7fffffffe21c) at git.c:761
> #11 cmd_main (argc=<optimized out>, argc@entry=6, argv=<optimized out>, argv@entry=0x7fffffffe448) at git.c:761
> #12 0x0000000000404b15 in main (argc=6, argv=0x7fffffffe448) at common-main.c:45

So that's quite unexpected. I assumed we'd have hit this problem while
deciding _which_ objects to write. But we get all the way to the point
of writing out the result before we notice it's missing.

I don't think I've run such a case before, but I wonder if "pack-objects
--all" is too lax about adding missing blobs during its object traversal
(especially during the "unreachable but recent" part of the traversal
that I mentioned, which should silently omit missing objects). I played
around with recreating this situation, though, and I don't think it's
possible to cause the results you're seeing. We come up with a list of
recent objects, but we only use it as a look-up index for discarding
too-old objects. So:

  - it wouldn't ever cause us to choose to write an object into a pack,
    which is what you're seeing

  - we'd never consider a missing object; it's a pure lookup table, and
    the actual list of objects we consider is found by walking the set
    of packs

So that's probably a dead end.

What I really wonder is where we found out about that object name in the
first place. Can you instrument your Git build like this:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 71056d8294..5ff6de5ddf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1112,6 +1112,13 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
 	uint32_t index_pos;
+	static const struct object_id funny_oid = {
+		"\xc1\x04\xb8\xfb\x36\x31\xb5\xc5\x46\x95"
+		"\x20\x6b\x2f\x73\x31\x0c\x02\x3c\x99\x63"
+	};
+
+	if (!oidcmp(oid, &funny_oid))
+		warning("found funny oid");
 
 	display_progress(progress_state, ++nr_seen);
 

and similarly get a backtrace when we hit that warning()? (Or if you're
a gdb expert, you could probably use a conditional breakpoint, but I
find just modifying the source easier).

-Peff
