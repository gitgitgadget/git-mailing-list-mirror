From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Tue, 10 Oct 2006 12:49:27 -0400
Message-ID: <20061010164927.GC16412@spearce.org>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com> <4529B77A.707@gmail.com> <Pine.LNX.4.64.0610090904360.3952@g5.osdl.org> <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 18:49:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXKnR-0000oQ-Ji
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 18:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWJJQtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 12:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWJJQtc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 12:49:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:5090 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030202AbWJJQtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 12:49:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GXKnC-000410-RS; Tue, 10 Oct 2006 12:49:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CB85420FB00; Tue, 10 Oct 2006 12:49:27 -0400 (EDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28636>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> However, I don't think that scenario is hard to support and Git can
> have a much better story to tell than keyword substituting SCMs.
> 
> If we have a tool that I can pass a file or a directory tree and will
> find the (perfectly|closely) matching trees and related commits.
> 
> For the single file case, searching for an exact SHA1 match is easy,
> as is by path. If we get a file without a path it gets a bit harder --
> is there a way to scan the object store for blobs of around a given
> size (as the packing code does) from Perl? Actually, if we find a
> relatively close match, it'd be useful to ask git if it's deltified
> and ask for other members of the delta chain.

git-verify-pack -v will print every SHA1, its type and its
decompressed size.  It also prints who its delta base is.  Its also
not very fast.  However if you run that on a pack file once and
cache the result then you have much of the data you are looking for.

You can find objects within a margin of error of the blob size,
then find all objects in those delta chains.  Then start fetching
those objects and comparing contents.  But this is brutal and will
take a long time due to the sheer number of objects that probably
would fall into that size bucket.

The single file case without a path is not an easy problem.  Even if
you have an exact SHA1 match (an unmodified file) its difficult
to find what commits used that SHA1 somewhere within their trees.
You need to unpack every tree in every commit and test every
entry for a match.  That's going to take a while on any decent
sized repository.

Most maintainers would just toss the modified file pack at the sender
and say "Uh, where did this file come from?!"  And rightly so.

A maintainer familiar with that section of the repository might
recognize some of the file contents and be able to guess the
filename.  So in short I don't think the single file case without
filename is doable, and I don't think its very useful either.
 
> For the directory tree case, the ideal thing would be to build a
> temporary index without getting the blobs in the object store, and
> then do a first pass trying to match tree SHA1s. If the user has
> modified a few files in a large project, it'll be trivial to find a
> good candidate commit for delta. OTOH, if the user has indulged in
> wide ranging search and replace... it will be well deserved pain ;-)

You have a chance in the tree case.  If you have the entire tree
as a working directory and the modifications made are limited to
a handful of paths then you can load that working directory into a
set of tree objects and perform a match process by walking backwards
through the commit chains looking for trees which have a high number
of paths in common with the working directory.

Unfortunately this also has limited use (but I have one myself!).
If you got the entire working directory from a submitter than that
implies they took your entire distribution, unpacked it, hacked away,
repacked it and sent you the tar/zip file.  That's significantly
larger than a simple patch file produced by diff -R.  As a maintainer
you probably should be kicking that back at the user and saying
"Uh, please submit a patch instead, thanks."


I actually have a scenario where I'm using Git to track another
(much, much crappier) file revision storage tool that would probably
benefit from this, but the benefit is relatively low.

I'm completely unable to read that tool's version data.  The only
thing I can get from that tool is a snapshot of files as they exist
at the point in time that I am running the snapshot.  The snapshots
aren't always consistent with themselves.  Worse they take upwards
of 30 minutes to run, can only run on a Windows desktop, and consume
100% of the CPU while running.  So we cannot get them very often.

I have several users working on those files in Git through a common
shared repository.  We send changes to that file revision storage
tool on a frequent basis, say up to 3-5 times per day.  Each such
change is basically a squashed merge commit in Git terminology,
so the fine grained commits in Git aren't being preserved by that
storage tool, despite being in our shared Git repository.

Many days later most of the changes the users put into the storage
tool suddenly appear on the next snapshot we obtain from it.  I say
most because sometimes the powers that be either don't permit a
change to show up in the snapshot and delay it for a while, or
because they actually wanted to include a change but someone fat
fingered the storage controls and the change got omitted.  Yet the
powers that be *believe* the change is included, right up through
testing accusing development of not fixing the bug despite the fix
being there in the file revision storage tool.

Now I'd like to take these snapshots every so often, load them
into Git on a special branch just for the snapshots, then generate
a merge commit on that branch which merges the real commit that
corresponds as closely as possible to to this snapshot into the
snapshot branch.  Part of the reason for doing this is to look
for unexpected differences between what Git has and what the file
revision storage tool has.

But doing that is nearly impossible, so I don't.

-- 
Shawn.
