From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GSoC 2009 Prospective student
Date: Tue, 24 Feb 2009 07:55:39 -0800
Message-ID: <20090224155539.GU22848@spearce.org>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com> <m3y6vxupvf.fsf@localhost.localdomain> <20090223155836.GI22848@spearce.org> <200902241638.08300.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Rohan Dhruva <rohandhruva@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:57:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbzef-0003nz-KV
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbZBXPzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 10:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbZBXPzl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:55:41 -0500
Received: from george.spearce.org ([209.20.77.23]:41797 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbZBXPzk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 10:55:40 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 21D6E38210; Tue, 24 Feb 2009 15:55:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902241638.08300.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111304>

Jakub Narebski <jnareb@gmail.com> wrote:
> 
> I (and Nicolas) by 'sorting order' mean here ordering of objects and
> deltas in the pack file, i.e. whether we get _exactly_ the same (byte
> for byte) packfile for the same want/have exchange (your proposal), or
> even for the same arguments to git-pack-objects (which is a necessary,
> although I think not sufficient condition).

I know.

My proposal though didn't require the same byte-for-byte pack file.
Only that the objects were in a predictable order.  It didn't permit
resuming in the middle of an object.  If the last object in the pack
was truncated the client would resume by getting that object again,
and may get a different byte sequence for that object representation.

Its a b**ch to know where you stopped though, as you could be in
a long string of deltas whose base is in the portion you didn't
yet receive.  Which means you can't identify that string that you
already have, and pack-objects on resume can't assume you have
those objects, because you only have the deltas for them and are
lacking a way to restore them.

> Can we assume that packfiles are named correctly (i.e. name of packfile
> match SHA-1 footer)?

Wrong.

The hash in "pack-$hash.pack"/"pack-$hash.idx" is *not* the 20 byte
SHA-1 footer.  Its the 20 byte SHA-1 of the sorted object names who
are in that pack.

We should try not to assume that the pack's file name matches the
sorted object names, but we can assume that the pack file name is
"pack-$hash.pack" where $hash is a 40 character hexadecimal string.
The dumb commit walkers already have this restriction built into
them, and have for quite some time.

Any pack writers, including fast-import, honor this naming standard
in order to ensure they are compatible with the existing dumb
commit walkers.
 
> Therefore I think that restartable clone for "dumb" (commit walker)
> protocols is easy GSoC project, while restartable clone for "smart"
> (generate packfile) protocols is at least of medium difficulty, and
> might be harder.

Probably quite right.  Unfortunately the majority of the git
repositories out there are served with the smart protocol, because
it is more efficient.  :)
 
> Still, we can have the following situation:
> 
>   *---*---o---.---.---. ....  .---o---*---*   <-- some ref
> 
>       ^                               ^
>       |                               |
>       a                               b
> 
> where '*' means that we have commit and all its object fully in packfile
> (i.e. if they are delta, there is base for delta in packfile), 'o' means
> incomplete, for example commit with some o blobs missing, and '.' means
> missing commit object.
> 
> Because git deals with continuous range, we can tell on restart of clone
> that we have 'a', and that we want 'b', but without further extensions
> to git protocols, where we can tell that we have some objects (to
> exclude), but not assume anything about their requirements; something
> that if I remember correctly was implemented in some floating 'lazy
> clone' patch (well, lazy loading of blobs patch)...

Err, yes.  Which is why I wanted to put a stable sort order on the
objects in the pack.  If you do that then you can specify a range
within range of objects being fetched.

E.g. in the diagram above if the client said "want b, have a" during
a "git fetch" we can apply the stable ordering to all objects in
that range "a..b", and then apply another subrange to that where the
client says "complete until Q", where "Q" denotes a position in that
sorted list.  Thus we only need to transmit the remaining elements.
 
> As Nico said in the presence of threaded packing ordering of _objects_
> on _packfile_ might be not deterministic.

Yea, ick.  I haven't looked at the threaded code in enough detail
to know how it behaves.  But from what I read in discussion on the
list it really makes it impossible to get a stable ordering because
the delta base selected for an object can differ depending on which
thread handled that object, and if OFS_DELTA is being used then the
base must go before the delta, making the order somewhat determined
by which thread handled which object.

IIRC, my proposal was pre-threaded delta code being introduced.
Now that we have threaded delta code as the default on many
platforms... yea, this is likely *not* a good project for someone
who is new to Git.  Its become a lot more difficult.
 
> I'll try to add 'pack file cache for git-daemon' proposal to 
> GSoC2009Ideas page... but I cannot be mentor (or even co-mentor) for
> this idea.

The pack file cache project is likely easier than restarting a
pack file.  Especially in the face of the threaded delta code.

There are difficult details about making the cache secure so we can't
overwrite repository data due to a buffer overflow.  Or making
the cache prune itself so it doesn't run out of disk.  Etc.
We've talked about a cache before on list.

On a related note, I remember I wrote a patch that saved packs during
"git push", before we added "git gc --auto", as crude attempt to
incrementally repack a repository during other operations.

-- 
Shawn.
