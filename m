From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Wed, 11 Feb 2009 16:19:27 +1300
Organization: Catalyst IT (NZ) Ltd
Message-ID: <499243BF.1010701@catalyst.net.nz>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de> <20090210164430.GN30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, gitster@pobox.com,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 04:53:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX69l-0007If-GJ
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 04:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbZBKDox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 22:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbZBKDow
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 22:44:52 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:36178 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZBKDov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 22:44:51 -0500
X-Greylist: delayed 1494 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Feb 2009 22:44:51 EST
Received: from [2404:130:0:1000:e25f:90ff:fe7d:1d00]
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <sam.vilain@catalyst.net.nz>)
	id 1LX5dI-0001ZF-Ca; Wed, 11 Feb 2009 16:19:28 +1300
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20090210164430.GN30949@spearce.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109371>

Shawn O. Pearce wrote:
>> The point you raised earlier, that there would be a lot of ambiguity if 
>> we allow both flat and fan-out directory structures, is a valid point, 
>> though.
> 
> Yup.  The flat vs. fan-out is a problem.
  [...]
> Notes on commits though are a hell of a problem.  SHA-1 is just so
> uniform at distributing the commits around the namespace that even
> with just the 200 most recent commits we wind up with a commit in
> almost every "bucket", assuming a two hex digit fan-out bucket like
> the loose object directory.

I think my patch from 1 Feb addressed this, at least for the operations
it implemented.

I just don't see why you need to decide up front what the split is going
to be.  Just read the next tree, descend into the closest matching tree
until you find the record you are looking for and that's it.  Sure, my
patch just loads it all and throws it into a hash - this should still be
efficient for short log operations even if the hash table ends up 1MB.
But why take my guess.  Let's stress test it.

'lorem' is the binary in the Text::Lorem Perl module.  It generates a
paragraph of random Latin text.

 wilber:~/src/git$ time git-log | wc -l
 256072

 real    0m0.709s
 user    0m0.608s
 sys     0m0.116s
 wilber:~/src/git$ git rev-list HEAD | wc -l
 17678
 wilber:~/src/git$ cat > my-editor
 #!/bin/sh

 ( lorem; echo ) > $1
 wilber:~/src/git$ chmod +x my-editor
 wilber:~/src/git$ export EDITOR=`pwd`/my-editor
 wilber:~/src/git$ export GIT_NOTES_SPLIT=2
 wilber:~/src/git$ time git-rev-list HEAD | while read rev
 > do ./git-notes.sh edit $rev; done
 fatal: unable to create '.git/refs/notes/commits.lock': File exists
 error: Ref refs/notes/commits is at
5f0732975b4acf237912a31e7ce14aa86d2e8179 but expected
725a2d119d2725e7d821906ad085bfbadbf43c8e
fatal: Cannot lock the ref 'refs/notes/commits'.
 [...]
 fatal: unable to write new index file
 Could not read index
 fatal: unable to write new index file
 Could not read index
 fatal: unable to write new index file
 Could not read index
 fatal: unable to write new index file
 Could not read index
 fatal: unable to write new index file
 Could not read index

 real    76m16.927s
 user    43m55.909s
 sys     19m33.005s

Oo.  Nasty errors there but never mind that for now.  Obviously some
remaining issues in the shell script.

What did I get out of that?

 wilber:~/src/git$ git-ls-tree -r refs/notes/commits | wc
   12043   48172 1144085
 wilber:~/src/git$

Hey well that's not too bad.  Enough to be a good test.  How long does
"git-log" take now?

 wilber:~/src/git$ time ./git-log | wc -l
 292201

 real    0m13.740s
 user    0m0.852s
 sys     0m0.716s
 wilber:~/src/git$ time ./git-log | wc -l
 292201

 real    0m1.335s
 user    0m0.856s
 sys     0m0.512s

Not bad!  Cool cache performance sucked there but only a 50% slowdown
for reading almost twice the number of objects.  Let's try 200 commits:

 wilber:~/src/git$ time git-log -200 | wc -l
 2877

 real    0m0.027s
 user    0m0.008s
 sys     0m0.020s

 wilber:~/src/git$ time ./git-log -200 | wc -l
 3477

 real    0m0.081s
 user    0m0.056s
 sys     0m0.020s

Quite a big slowdown proportionally, but not a huge amount in absolute
terms.  And we didn't even make the builtin-log machinery smart enough
to skip unneeded trees!

>  In a slightly unrelated
> thread offlist I have been talking with Sam Vilain about using Git
> as a database backend for tuple storage.
  [...]
> This would make the git-notes.sh code a *lot* more complex, as you
> can't just toss everything into an index file and then update it with
> a single update-index call.  Doing a tree split is much more work and
> requires removing and adding back all of the affected path names.
> (Its also perhaps unreasonable anyway to load 17,491 paths into a
> temporary index just to twiddle a note for the latest commit.)

Hehe, horribly overcomplicated for this use case... many applicable
ideas though.

> For the "git database" thing above, I've been contemplating the
> idea of an index stored external from the Git object database.
> Sam thinks indexes should be in the object database tree, but
> I'm considering storing them outside entirely because we can
> make the indexes more easily searched by a hash or binary search,
> like pack-*.idx.  Whenever the "database ref" gets moved we'd need
> to run a "sync" utility to bring these external indexes current.
> But they could also be more efficiently scanned.

Well either way it's a file you've got to scan somehow ... guess it
doesn't matter much whether it's in-tree or not.  I was actually saying
that there are some use cases where you might want to keep indexes in
the history and some where you don't.  Keeping them in-tree is not
normalised, but there are good use cases for it - eg efficient retrieval
of pre-computed aggregates that don't need to be up to the second, or
for instances where you want your nodes to be able to "hit the ground
running" after synchronisation without having to reindex.

For the use case we originally talked about I don't think you'd want any
indexes in-tree at all.

But I'd like to steer this thread well away from the database stuff I'm
drafting ... it's a lot more comprehensive, notes are a very simple hash
relationship.
-- 
Sam Vilain, Perl Hacker, Catalyst IT (NZ) Ltd.
phone: +64 4 499 2267        PGP ID: 0x66B25843
