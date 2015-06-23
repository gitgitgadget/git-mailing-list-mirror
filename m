From: Jeff King <peff@peff.net>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 07:47:16 -0400
Message-ID: <20150623114716.GC12518@peff.net>
References: <1435020656.28466.8.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 13:47:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Mfl-0007gd-3a
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 13:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbbFWLrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 07:47:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:50428 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754134AbbFWLrT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 07:47:19 -0400
Received: (qmail 23259 invoked by uid 102); 23 Jun 2015 11:47:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 06:47:18 -0500
Received: (qmail 18333 invoked by uid 107); 23 Jun 2015 11:47:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 07:47:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jun 2015 07:47:17 -0400
Content-Disposition: inline
In-Reply-To: <1435020656.28466.8.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272453>

On Mon, Jun 22, 2015 at 08:50:56PM -0400, David Turner wrote:

> The db backend runs git for-each-ref about 30% faster than the files
> backend with fully-packed refs on a repo with ~120k refs.  It's also
> about 4x faster than using fully-unpacked refs.  In addition, and
> perhaps more importantly, it avoids case-conflict issues on OS X.

Neat.

Can you describe a bit more about the reflog handling?

One of the problems we've had with large-ref repos is that the reflog
storage is quite inefficient. You can pack all the refs, but you may
still be stuck with a bunch of reflog files with one entry, wasting a
whole inode. Doing a "git repack" when you have a million of those has
horrible cold-cache performance. Basically anything that isn't
one-file-per-reflog would be a welcome change. :)

It has also been a dream of mine to stop tying the reflogs specifically
to the refs. I.e., have a spot for reflogs of branches that no longer
exist, which allows us to retain them for deleted branches. Then you can
possibly recover from a branch deletion, whereas now you have to dig
through "git fsck"'s dangling output. And the reflog, if you don't
expire it, becomes a suitable audit log to find out what happened to
each branch when (whereas now it is full of holes when things get
deleted).

Does your solution handle something like that?

I was thinking of actually moving to a log-structured ref storage.
Something like:

  - any ref write puts a line at the end of a single logfile that
    contains the ref name, along with the normal reflog data

  - the logfile is the source of truth for the ref state. If you want to
    know the value of any ref, you can read it backwards to find the
    last entry for the ref. Everything else is an optimization.

    Let's call the number of refs N, and the number of ref updates in
    the log U.

  - we keep a key/value index mapping the name of any branch that exists
    to the byte offset of its entry in the logfile. This would probably
    be in some binary key/value store (like LMDB). Without this,
    resolving a ref is O(U), which is horrible. With it, it should be
    O(1) or O(lg N), depending on the index data structure.

  - the index can also contain other optimizations. E.g., rather than
    point to the entry in the logfile, it can include the sha1 directly
    (to avoid an extra level of indirection). It may want to include the
    "peeled" value, as the current packed-refs file does.

  - Reading all of the reflogs (e.g., for repacking) is O(U), just like
    it is today. Except the storage for the logfile is a lot more
    compact than what we store today, with one reflog per file.

  - Reading a single reflog is _also_ O(U), which is not as good as
    today. But if each log entry contains a byte offset of the previous
    entry, you can follow the chain (it is still slightly worse, because
    you are jumping all over the file, rather than reading a compact set
    of lines).

  - Pruning the reflog entries from the logfile requires rewriting the
    whole thing. That's similar to today, where we rewrite each of the
    reflog files.

One of the nice properties of this system is that it should be very
resilient to corruption and races. Most of the operations are either
appending to a file, or writing to a tempfile and renaming in place.
The exception is the key/value index, but if we run into any problems
there, it can be rebuilt by walking over the logfile (for a cost of
O(U)).

I dunno. Maybe I am overthinking it. But it really feels like the _refs_
are a key/value thing, but the _reflogs_ are not. You can cram them into
a key/value store, but you're probably operating on them as a big blob,
then.

> I chose to use LMDB for the database.  LMDB has a few features that make
> it suitable for usage in git:

One of the complaints that Shawn had about sqlite is that there is no
native Java implementation, which makes it hard for JGit to ship a
compatible backend. I suspect the same is true for LMDB, but it is
probably a lot simpler than sqlite (so reimplementation might be
possible).

But it may also be worth going with a slightly slower database if we can
get wider compatibility for free.

> To test this backend's correctness, I hacked test-lib.sh and
> test-lib-functions.sh to run all tests under the refs backend. Dozens
> of tests use manual ref/reflog reading/writing, or create submodules
> without passing --refs-backend-type to git init.  If those tests are
> changed to use the update-ref machinery or test-refs-be-db (or, in the
> case of packed-refs, corrupt refs, and dumb fetch tests, are skipped),
> the only remaining failing tests are the git-new-workdir tests and the
> gitweb tests.

I think we'll need to bump core.repositoryformatversion, too. See the
patches I just posted here:

  http://thread.gmane.org/gmane.comp.version-control.git/272447

-Peff
