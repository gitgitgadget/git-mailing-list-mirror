From: Jeff King <peff@peff.net>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Wed, 24 Jun 2015 05:14:17 -0400
Message-ID: <20150624091417.GB5436@peff.net>
References: <1435020656.28466.8.camel@twopensource.com>
 <20150623114716.GC12518@peff.net>
 <1435083516.28466.24.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 11:14:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7glH-0007VQ-6m
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 11:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbbFXJOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 05:14:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:50893 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750954AbbFXJOU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 05:14:20 -0400
Received: (qmail 9477 invoked by uid 102); 24 Jun 2015 09:14:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 04:14:20 -0500
Received: (qmail 26178 invoked by uid 107); 24 Jun 2015 09:14:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 05:14:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jun 2015 05:14:17 -0400
Content-Disposition: inline
In-Reply-To: <1435083516.28466.24.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272542>

On Tue, Jun 23, 2015 at 02:18:36PM -0400, David Turner wrote:

> > Can you describe a bit more about the reflog handling?
> > 
> > One of the problems we've had with large-ref repos is that the reflog
> > storage is quite inefficient. You can pack all the refs, but you may
> > still be stuck with a bunch of reflog files with one entry, wasting a
> > whole inode. Doing a "git repack" when you have a million of those has
> > horrible cold-cache performance. Basically anything that isn't
> > one-file-per-reflog would be a welcome change. :)
> 
> Reflogs are stored in the database as well.  There is one header entry
> per ref to indicate that a reflog is present, and then one database
> entry per reflog entry; the entries are stored consecutively and
> immediately following the header so that it's fast to iterate over them.

OK, that make sense. I did notice that the storage for the refdb grows
rapidly. If I add a millions refs (like refs/tags/$i) with a simple
reflog message "foo", I ended up with a 500MB database file.

That's _probably_ OK, because a million is getting into crazy
territory[1].  But it's 500 bytes per ref, each with one reflog entry.
Our ideal lower bound is probably something like 100 bytes per reflog
entry:

  - 20 bytes for old sha1
  - 20 bytes for new sha1
  - ~50 bytes for name, email, timestamp
  - ~6 bytes for refname (1000000 is the longest unique part)

That assumes we store binary[2] (and not just the raw reflog lines), and
reconstruct the reflog lines on the fly. It also assumes we use some
kind of trie-like storage (where we can amortize the cost of storing
"refs/tags/" across all of the entries).

Of course that neglects lmdb's overhead, and the storage of the ref tip
itself. But it would hopefully give us a ballpark for an optimal
solution. We don't have to hit that, of course, but it's food for
thought.

[1] The homebrew/homebrew repository on GitHub has almost half a million
    ref updates. Since this is storing not just refs but all ref
    updates, that's actually the interesting number (and optimizing the
    per-reflog-entry size is more interesting than the per-ref size).

[2] I'm hesitant to suggest binary formats in general, but given that
    this is a blob embedded inside lmdb, I think it's OK. If we were to
    pursue the log-structured idea I suggested earlier, I'm torn on
    whether it should be binary or not.

> > It has also been a dream of mine to stop tying the reflogs specifically
> > to the refs. I.e., have a spot for reflogs of branches that no longer
> > exist, which allows us to retain them for deleted branches.
> [...]
> That would be cool, and I don't think it would be hard to add to my
> current code; we could simply replace the header with a "tombstone".
> But I would prefer to wait until the series is merged; then we can build
> on top of it.

Yeah, I think you can add it easily to basically any system that does
not have the filesystem D/F conflicts in its storage (i.e., having
"refs/foo" does not block data under "refs/foo/bar").

> > But it may also be worth going with a slightly slower database if we can
> > get wider compatibility for free.
> 
> There's a JNI interface to LMDB, which is, of course, not native.  I
> don't think it would be too hard to entirely rewrite LMDB in Java, but
> I'm not going to have time to do it for the forseeable future.  I've
> asked Howard Chu if he knows of any efforts in progress.

Yeah, I think JNI is not enough for Eclipse folks. I don't think this is
a task that you would necessarily need to take on. More just something
to think about for the future when picking a format.

> Thanks, that's valuable.  For the refs backend, opening the LMDB
> database for writing is sufficient to block other writers.  Do you think
> it would be valuable to provide a git hold-ref-lock command that simply
> reads refs from stdin and keeps them locked until it reads EOF from
> stdin?  That would allow cross-backend ref locking.

I'm not sure what you would use it for. If you want to update the refs,
then you can specify a whole transaction with "git update-ref --stdin",
and that should work whatever backend you choose. Is there some other
operation you want where you hold the lock for a longer period of time?

-Peff
