Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA7C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559F961A57
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352358AbhJAG5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 02:57:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:58908 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352317AbhJAG5W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 02:57:22 -0400
Received: (qmail 26328 invoked by uid 109); 1 Oct 2021 06:55:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Oct 2021 06:55:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8515 invoked by uid 111); 1 Oct 2021 06:55:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Oct 2021 02:55:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Oct 2021 02:55:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
Message-ID: <YVaw6agcPNclhws8@coredump.intra.peff.net>
References: <20210930121058.5771-1-chiyutianyi@gmail.com>
 <20210930132004.16075-1-chiyutianyi@gmail.com>
 <87pmsqtb2p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmsqtb2p.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 03:42:29PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > In addition to using 'receive.maxInputSize' to limit the overall size
> > of the received packfile, a new config variable
> > 'receive.maxInputObjectSize' is added to limit the push of a single
> > object larger than this threshold.
> 
> Maybe an unfair knee-jerk reaction: I think we should really be pushing
> this sort of thing into pre-receive hooks and/or the proc-receive hook,
> i.e. see 15d3af5e22e (receive-pack: add new proc-receive hook,
> 2020-08-27).

Yes, this could be done as a hook, but it's actually kind of tricky.
We have a similar max-object-size limit in our fork at GitHub, and it's
implemented inside index-pack (we don't have a match in unpack-objects,
but we always run index-pack on incoming packs).

Unlike the patches here, ours is limiting the logical size of an object
(so a 100MB blob limit is on the uncompressed size). It happens in
sha1_object(), where we have that size.

The main reason we put it there is for performance. index-pack is
already computing the size, so it's free to check it there. But it does
make some things awkward. Rather than just dying with "woah, some object
is too big", it's nice to tell the user "hey, the object 1234abcd at
foo.bin is too big". To do that, we actually collect the list of too-big
objects and index them anyway (remember that we're in the quarantine
directory, so nothing is permanent until later). We write the list to a
".large-objects" file in the quarantine directory. And then hooks are
free to produce a much nicer message (e.g., by running something like
"log --find-objects" to get the path name at which we see the blob).

It would be nice if the hook could just find the objects itself, but
there are some gotchas:

  - finding the list of pushed objects is awkward and/or expensive. You
    can use rev-list, but that's very costly, as it has to inflate all
    of the new trees. You really just want the list of what's in the
    quarantine directory, but there's no single command to get that. You
    have to run show-index on the incoming pack, plus poke through the
    loose object directories.

    It would be much easier if "cat-file --batch-all-objects" could be
    asked to only look at local objects. That would also allow some
    other optimizations to reduce the cost. For instance, even when
    iterating packs, cat-file then feeds each sha1 back to
    oid_object_info(), even though we already know the exact pack/offset
    where it can be found. Likewise, it could be taught some basic
    filtering (like "show only objects with size > X") to avoid dumping
    millions of oid/size pairs to a separate script to do the filtering.

    But all of that would just be approaching the speed of having
    index-pack do the check, since it has the size already there.

  - it wouldn't help index-pack at all with memory attacks by malicious
    pushers. Here somebody accidentally pushed up a big blob, and it
    caused unpack-objects to OOM. But I also remember a problem ages ago
    where some of the fsck_tree() code had an integer overflow
    vulnerability, which could only be triggered by a gigantic tree.
    In the patch we use at GitHub, we allow large blobs to make it to
    the hook level, but too-large trees, commits, and tags are
    unceremoniously aborted with an immediate die(). Real users
    accidentally try to push 2GB objects. Trees of that size are no
    accident. :)

    Having index-pack enforce size limits helps a bit there. And
    streaming large blobs helps protect against accidents. But there are
    still OOM problems with maliciously constructed inputs, because the
    delta code only works on full buffers (so it really wants to
    construct the whole object before we get to the sha1_object()
    limits). It would be nice if this could stream the output, but I
    suspect it would require pretty major surgery to the delta code.

    Instead, we've put in a crude limit by having receive-pack set
    GIT_ALLOC_LIMIT in the environment, which then ensures that its
    child index-pack won't allocate too much (the limit we use is much
    higher than the more user-facing object limit, because the point is
    just to avoid DoS attacks, and not enforce any kind of policy).

    It might be nice to have a config option for setting this limit (and
    perhaps even putting it at a reasonable defensive default).

So I do think there are some interesting paths forward for doing more of
this in hooks, but there's work to be done to get there.

> The latter pre-dates c08db5a2d0d (receive-pack: allow a maximum input
> size to be specified, 2016-08-24), which may or may not be relevant
> here.

Yeah, I introduced that limit. It wasn't really about object size or
memory, but just about the fact that without it, a malicious pusher can
just send you bytes forever which the server will write to disk. It also
helps with the most naive kind of large-object attacks, but it wouldn't
help with a cleverly constructed delta.

It is, unfortunately, a pretty unceremonious die(), and has caused more
than one support ticket (especially because GitHub has used 2GB for the
limit for ages, and the practical limit for repositories has been
growing).

So there. That's probably more than anybody wanted to know about push
limits. ;) I'm happy to share any of the code from GitHub's fork in
these areas. The main reason I haven't is just that some of it is just
kind of ugly and may need polishing (e.g., the whole "write to
.large-objects" is really an awful interface).

-Peff
