From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 11:55:48 -0500
Message-ID: <20070130165548.GF25950@spearce.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 17:55:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBwGx-000199-QP
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 17:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965614AbXA3Qzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 11:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965618AbXA3Qzw
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 11:55:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34149 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965614AbXA3Qzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 11:55:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBwGm-0001cY-6a; Tue, 30 Jan 2007 11:55:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1461920FBAE; Tue, 30 Jan 2007 11:55:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38170>

Mike Coleman <tutufan@gmail.com> wrote:
> 1.  As of today, is there any real safety concern with either tool's
> repo format?  Is either tool significantly better in this regard?
> (Keith Packard's post hints at a problem here, but doesn't really make
> the case.)

I think the Git format is tighter in terms of compression,
and simpler in terms of understanding and writing code.  I have
personally written the code to read and write the Git repository
format in both C and Java, and in both cases it falls out in just
a few hundred lines of code (assuming you have libz handy to do
the compression/decompression for you).

The Git format is completely safe with regards to parallel
modification of a repository, which is good for shared repositories
that might have multiple people pushing into it at once.

Git's format is also safe with regards to *any* update.
You literally cannot destroy the repository during an update.
Its impossible.  You'd have to physically destroy the storage device.
(OK, that's overstating it a bit, but it is really hard.)

The point Keith was making was the Git format is "add-only".
Once something has been stored, we NEVER modify it again.  This
bypasses any sort of possible problems that can occur with partial
modifications caused by a process aborting in the middle of a change.

I think hg modifies files as it goes, which could cause some issues
when a writer is aborted.  I'm sure they have thought about the
problem and tried to make it safe, but there isn't anything safer
than just leaving the damn thing alone.  :)
 
> 2.  Does the git packed object format solve the performance problem
> alluded to in posts from a year or two ago?

Yes.  By a huge margin.  Git's *fast*.  Ignore anything from a year
or two ago.
 
> 3.  Someone mentioned that git bisect can work between any two
> commits, not necessarily just one that happens to be an ancestor of
> the other.  This sounds really cool.  Can hg's bisect do this, too?

No clue.
 
> 4.  What is git's index good for?  I find that I like the idea of it,
> but I'm not sure I could justify it's presence to someone else, as
> opposed to having it hidden in the way that hg's dircache (?) is.  Can
> anyone think of a good scenario where it's a pretty obvious benefit?

Its a good way to stage the stuff in your next commit.  By that I
mean you edit some code.  Then you look at what differs between the
index and your working directory.  You decide "this hunk is good, it
passed the tests, I want to commit that, so toss it into the index".
Now that hunk isn't different anymore.

When it comes time to commit, all of your already reviewed stuff is
staged in the index.  You just need to issue a commit and supply
the message.  But you can leave modified stuff in the working
directory, even for files that were alerady updated in the index.

This really helps during a merge.  Only the stuff which Git could
not merge for you is seen as different between the index and the
working directory; all of the stuff that Git merged for you is
already staged in the index.  So you can focus on the conflicts,
and stage their resolutions into the index as you go.  This makes
it easier to work through larger merges where more than 1 or 2
files contains conflicts.

> 5.  I think I read that there'd been just one incompatible change over
> time in the git repo format.  What was it?

A LONG time ago, like in the very first version Linus offered out
to the public, we computed the identity of an object using the
SHA-1 hash of the *compressed* data.  This is sensitive to the
compression settings used, and was not the best idea as a result.

It was very quickly changed to compute the identity of the object
using the SHA-1 has of the raw (user) data, removing any dependence
on the compression routine to always yield the same result for the
same input.

We haven't had a change since then.  We have added some new
compression options which are just that, options.  If you use them
older Git binaries won't necessarily recognize the repository data,
but these are off by default and can be enabled on a per-repository
basis.  E.g. if you are only using newer Git on a given system you
can enable the newer compression features on all of the repositories
on that system.
 
> 6.  Does either tool use hard links?  This matters to me because I do
> development on a connected machine and a disconnected machine, using a
> usb drive to rsync between.  (Perhaps there'll be some way to transfer
> changes using git or hg instead of rsync, but I haven't figured that
> out yet.)

Git can use hardlinks if you ask it to.  We only use them for the
repository files, not for the user's actual source files.

Git has its own native transport (git-push, git-fetch) which can
move data between two Git repositories via local filesystem access,
SSH, HTTP, FTP, and rsync (latter two are read-only transports).
 
> 7.  I'm a fan of Python, and I'm really a fan of using high-level
> languages with performance-critical parts in a lower-level language,
> so in that regard, I really like hg's implementation.  If someone
> wanted to do it, is a Python clone of git conceivable?  Is there
> something about it that just requires C?

Yes, a Python clone of Git is conceivable.  Indeed, there is a
pure Java clone in process (jgit) for an Eclipse plugin (egit).
If you wanted to rewrite Git in Python, knock yourself out.
But we've ported all of our Python to C, as its just faster.
 
> 8.  It feels like hg is not really comfortable with parallel
> development over time on different heads within a single repo.
> Rather, it seems that multiple repos are supposed to be used for this.
> Does this lead to any problems?  For example, is it harder or
> different to merge two heads if they're in different repo than if
> they're in the same repo?

No clue.  I know multiple heads in one Git repository works
*awesome*.  Especially on large repositories (>10k files) as the time
required to start a new branch is only the time needed to update the
files in the working directory which don't have the correct version.
Usually that's a small percentage (<200) of the files and thus its
very fast to switch to a new branch of development, and switch back.

On a decent UNIX system (and my Mac OS X PowerBook doesn't really
count) flipping branches in git-gui is almost immediate.  You pick
the branch in the menu and *wham* its switched.  And that's my
PowerBook, which as I said, doesn't quite count as good UNIX
system...

-- 
Shawn.
