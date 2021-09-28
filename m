Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E845CC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CFE613A9
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbhI1XTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:19:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57214 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243153AbhI1XTD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:19:03 -0400
Received: (qmail 11800 invoked by uid 109); 28 Sep 2021 23:17:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 23:17:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5640 invoked by uid 111); 28 Sep 2021 23:17:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 19:17:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 19:17:22 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Message-ID: <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 02:26:38AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> The tmp_objdir API provides the ability to create temporary object
> directories, but was designed with the goal of having subprocesses
> access these object stores, followed by the main process migrating
> objects from it to the main object store or just deleting it.  The
> subprocesses would view it as their primary datastore and write to it.
> 
> For the --remerge-diff option we want to add to show & log, we want all
> writes of intermediate merge results (both blobs and trees) to go to
> this alternate object store; since those writes will be done by the main
> process, we need this "alternate" object store to actually be the
> primary object store.  When show & log are done, they'll simply remove
> this temporary object store.

I think this is consistent with the original design of tmp_objdir. I
just never needed to do anything in-process before, so overriding the
environment of sub-processes was sufficient.

I do think these are dangerous and may cause bugs, though. Anything you
write while the tmp_objdir is marked as "primary" is going to go away
when you remove it. So any object names you reference outside of that,
either:

  - by another object that you create after the tmp_objdir is removed;
    or

  - in a ref

are going to turn into repository corruption. Of course that's true for
the existing sub-processes, too, but here we're touching a wider variety
of code.

Obviously the objects we write as part of remerge-diff are meant to be
temporary, and we'll never reference them in any other way. And usually
we would not expect a diff to write any other objects. But one thing
that comes to mind if textconv caching.

If you do a remerge diff on a blob that uses textconv, and the caching
feature is turned on, then we'll write out a new blob with the cached
value, and eventually a new tree and refs/notes/ pointer referencing it.
I'm not sure of the timing of all of that, but it seems likely to me
that at least some of that will end up in your tmp_objdir.

If you remove the tmp_objdir as the primary as soon as you're done with
the merge, but before you run the diff, you might be OK, though.

If not, then I think the solution is probably not to install this as the
"primary", but rather:

  - do the specific remerge-diff writes we want using a special "write
    to this object dir" variant of write_object_file()

  - install the tmp_objdir as an alternate, so the reading side (which
    is diff code that doesn't otherwise know about our remerge-diff
    trickery) can find them

And that lets other writers avoid writing into the temporary area
accidentally.

In that sense this is kind of like the pretend_object_file() interface,
except that it's storing the objects on disk instead of in memory. Of
course another way of doing that would be to stuff the object data into
tempfiles and just put pointers into the in-memory cached_objects array.

It's also not entirely foolproof (nor is the existing
pretend_object_file()). Any operation which is fooled into thinking we
have object X because it's in the fake-object list or the tmp_objdir may
reference that object erroneously, creating a corruption. But it's still
safer than allowing arbitrary writes into the tmp_objdir.

  Side note: The pretend_object_file() approach is actually even better,
  because we know the object is fake. So it does not confuse
  write_object_file()'s "do we already have this object" freshening
  check.

  I suspect it could even be made faster than the tmp_objdir approach.
  From our perspective, these objects really are tempfiles. So we could
  write them as such, not worrying about things like fsyncing them,
  naming them into place, etc. We could just write them out, then mmap
  the results, and put the pointers into cached_objects (currently it
  insists on malloc-ing a copy of the input buffer, but that seems like
  an easy extension to add).

  In fact, I think you could get away with just _one_ tempfile per
  merge. Open up one tempfile. Write out all of the objects you want to
  "store" into it in sequence, and record the lseek() offsets before and
  after for each object. Then mmap the whole result, and stuff the
  appropriate pointers (based on arithmetic with the offsets) into the
  cached_objects list.

  As a bonus, this tempfile can easily be in $TMPDIR, meaning
  remerge-diff could work on a read-only repository (and the OS can
  perhaps handle the data better, especially if $TMPDIR isn't a regular
  filesystem).

> We also need one more thing -- `git log --remerge-diff` can cause the
> temporary object store to fill up with loose objects.  Rather than
> trying to gc that are known garbage anyway, we simply want to know the
> location of the temporary object store so we can purge the loose objects
> after each merge.

This paragraph confused me. At first I thought you were talking about
how to avoid calling "gc --auto" because we don't want to waste time
thinking all those loose objects were worth gc-ing. But we wouldn't do
that anyway (git-log does not expect to make objects so doesn't call it
at all, and anyway you'd expect it to happen at the end of a process,
after we've already removed the tmp_objdir).

But I think you just mean: we can build up a bunch of loose objects,
which is inefficient. We don't want to gc them, because that's even less
efficient. So we want to clean them out between merges.

But I don't see any code to do that here. I guess that's maybe why
you've added tmp_objdir_path(), to find them later. But IMHO this would
be much better encapsulated as tmp_objdir_clear_objects() or something.

But simpler still: is there any reason not to just drop and re-create
the tmp-objdir for each merge? It's not very expensive to do so (and
certainly not compared to the cost of actually writing out the objects).

-Peff
