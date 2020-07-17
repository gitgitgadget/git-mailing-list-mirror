Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E90DC28E87
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 06:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA9321744
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 06:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgGQG1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:27:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:59854 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgGQG1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 02:27:24 -0400
Received: (qmail 28709 invoked by uid 109); 17 Jul 2020 06:27:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jul 2020 06:27:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 684 invoked by uid 111); 17 Jul 2020 06:27:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jul 2020 02:27:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jul 2020 02:27:23 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Compressing packed-refs
Message-ID: <20200717062723.GA1179001@coredump.intra.peff.net>
References: <20200716221026.dgduvxful32gkhwy@chatter.i7.local>
 <xmqqsgdrf64c.fsf@gitster.c.googlers.com>
 <20200716225429.i7pb6xorkwdsf5fn@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716225429.i7pb6xorkwdsf5fn@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 06:54:29PM -0400, Konstantin Ryabitsev wrote:

> Let me offer a more special-case (but not crazy) example from 
> git.kernel.org. The newer version of grokmirror that I'm working on is 
> built to take advantage of the pack-islands feature that was added a 
> while back. We fetch all linux forks into a single "object storage" 
> repo, with each fork going into its own 
> refs/virtual/[uniquename]/(heads|tags) place. This means there's lots of 
> duplicates in packed-refs, as all the tags from torvalds/linux.git will 
> end up duplicated in almost every fork.
> 
> So, after running git pack-refs --all, the packed-refs file is 50-ish MB 
> in size, with a lot of same stuff like:

We do the same thing at GitHub. 50MB is on the easy side. We have cases
in the gigabytes.

> etc, duplicated 600 times with each fork. It compresses decently well 
> with gzip -9, and *amazingly* well with xz -9:
> 
> $ ls -ahl packed-refs
> -rw-r--r--. 1 mirror mirror 46M Jul 16 22:37 packed-refs
> $ ls -ahl packed-refs.gz
> -rw-r--r--. 1 mirror mirror 19M Jul 16 22:47 packed-refs.gz
> $ ls -ahl packed-refs.xz
> -rw-r--r--. 1 mirror mirror 2.3M Jul 16 22:47 packed-refs.xz

Yes, it does compress well. Just gzipping like that would have worked
once upon a time, when accessing it meant reading the whole thing
linearly. These days, though, we mmap() the file and binary-search it.
That lets us examine a subset of the refs quickly (this is from our
torvalds/linux.git fork network):


  $ wc -c packed-refs 
  2394623761 packed-refs

  $ time git for-each-ref | wc -l
  19552978
  
  real	1m12.297s
  user	1m2.441s
  sys	0m10.235s

  $ time git for-each-ref refs/remotes/2325298 | wc -l
  2590
  
  real	0m0.077s
  user	0m0.025s
  sys	0m0.055s

> Which really just indicates how much duplicated data is in that file. If 
> reftables will eventually replace refs entirely, then we probably 
> shouldn't expend too much effort super-optimizing it, especially if I'm 
> one of the very few people who would benefit from it. However, I'm 
> curious if a different sorting strategy would help remove most of the 
> duplication without requiring too much engineering time.

You definitely could store it in a more efficient way. Reftables will
have most of the things you'd want: prefix compression, binary oids,
etc.  I wouldn't be opposed to a tweak to packed-refs in the meantime if
it was simple to implement. But definitely we'd want to retain the
ability to find a subset of refs in sub-linear time. That might get
tricky and push it from "simple" to "let's just invest in reftable".

You might also consider whether you need all of those refs at all in the
object storage repo. The main uses are:

  - determining reachability during repacks; but you could generate this
    on the fly from the refs in the individual forks (de-duplicating as
    you go). We don't do this at GitHub, because the information in the
    duplicates is useful to our delta-islands config.

  - getting new objects into the object store. It sounds like you might
    do this with "git fetch", which does need up-to-date refs. We used
    to do that, too, but it can be quite slow. These days we migrate the
    objects directly via hardlinks, and then use "update-ref --stdin" to
    sync the refs into the shared storage repo.

  - advertising alternate ref tips in receive-pack (i.e., saying "we
    already know about object X" if it's in somebody else's fork, which
    means people pulling from Linus and then pushing to their fork don't
    have to send the objects again). You probably don't want to
    advertise all of them (just sifting the duplicates is too
    expensive). We use core.alternateRefsCommand to pick out just the
    ones from the parent fork. We _do_ still use the copy of the refs in
    our shared storage, not the ones in the actual fork. But that's
    because we migrate objects to shared storage asynchronously (so it's
    possible for one fork to have refs pointing to objects that aren't
    yet available to the other forks).

So it's definitely not a no-brainer, but possibly something to explore.

-Peff
