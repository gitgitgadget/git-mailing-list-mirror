From: Jeff King <peff@peff.net>
Subject: Re: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in
 repack_without_ref)
Date: Sat, 29 Dec 2012 03:10:21 -0500
Message-ID: <20121229081021.GC15408@sigill.intra.peff.net>
References: <20121221080449.GA21741@sigill.intra.peff.net>
 <50DAB447.8000101@alum.mit.edu>
 <201212271611.52203.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 09:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TorVE-0001hX-Qe
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 09:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab2L2IK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 03:10:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38621 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128Ab2L2IKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 03:10:25 -0500
Received: (qmail 27714 invoked by uid 107); 29 Dec 2012 08:11:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 03:11:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 03:10:21 -0500
Content-Disposition: inline
In-Reply-To: <201212271611.52203.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212297>

On Thu, Dec 27, 2012 at 04:11:51PM -0700, Martin Fick wrote:

> For a single user repo this is not a big deal, the lock can 
> always be cleaned up manually (and it is a rare occurrence).  
> However, in a multi user server environment, possibly even 
> from multiple hosts over a shared filesystem such as NFS, 
> stale locks could lead to serious downtime and risky recovery 
> (since it is currently hard to figure out if a lock really is 
> stale).  Even though stale locks are probably rare even today 
> in the larger shared repo case, as git scales to even larger 
> shared repositories, this will eventually become more of a 
> problem *1.  Naturally, this has me thinking that git should 
> possibly consider moving towards a lockless design for refs 
> in the long term.

FWIW, I am involved in cleaning up stale locks for a very large git
hosting site. It actually happens surprisingly little. I think it is
mostly because git holds actual locks for a very short period of time
(just enough to check that the value is unchanged from when we started a
lengthy operation, and then atomically write the new value).

So I agree it would be cool (and maybe open up new realms of
scalability) for git to be lockless, but in my experience, this isn't
that pressing a problem (and any solutions are not going to be backwards
compatible, so there is going to be a high deployment cost).

> My idea is based on using filenames to store sha1s instead of 
> file contents.  To do this, the sha1 one of a ref would be 
> stored in a file in a directory named after the loose ref.  I 
> believe this would then make it possible to have lockless 
> atomic ref updates by renaming the file.
> 
> To more fully illustrate the idea, imagine that any file 
> (except for the null file) in the directory will represent the 
> value of the ref with its name, then the following 
> transitions can represent atomic state changes to a refs 
> value and existence:

Hmm. So basically you are relying on atomic rename() to move the value
around within a directory, rather than using write to move it around
within a file. Atomic rename is usually something we have on local
filesystems (and I think we rely on it elsewhere). Though I would not be
surprised if it is not atomic on all networked filesystems (though it is
on NFS, at least).

> 1) To update the value from a known value to a new value 
> atomically, simply rename the file to the new value.  This 
> operation should only succeed if the file exists and is still 
> named old value before the rename.  This should even be 
> faster than today's approach, especially on remote filesystems 
> since it would require only 1 round trip in the success case 
> instead of 3!

OK. Makes sense.

> 2) To delete the ref, simply delete the filename representing 
> the current value of the ref.  This ensures that you are 
> deleting the ref from a specific value.  I am not sure if git 
> needs to be able to delete refs without knowing their values?  
> If so, this would require reading the value and looping until 
> the delete succeeds, this may be a bit slow for a constantly 
> updated ref, but likely a rare situation (and not likely 
> worse than trying to acquire the ref-lock today).  Overall, 
> this again would likely be faster than today's approach.

We do sometimes delete without knowing the value. In most cases we would
not want to do this, but for some "force"-type commands, we do. You
would actually have the same problem with updating above, as we
sometimes update with the intent to overwrite whatever is there.

> 3) To create a ref, it must be renamed from the null file (sha 
> 0000...) to the new value just as if it were being updated 
> from any other value, but there is one extra condition: 
> before renaming the null file, a full directory scan must be 
> done to ensure that the null file is the only file in the 
> directory (this condition exists because creating the 
> directory and null file cannot be atomic unless the filesystem 
> supports atomic directory renames, an expectation git does 
> not currently make).  I am not sure how this compares to 
> today's approach, but including the setup costs (described 
> below), I suspect it is slower.

Hmm. mkdir is atomic. So wouldn't it be sufficient to just mkdir and
create the correct sha1 file?  A simultaneous creator would fail on the
mkdir and abort. A simultaneous reader might see the directory, but it
would either see it as empty, or with the correct file. In the former
case, it would treat that the same as if the directory did not exist.

Speaking of which, you did not cover reading at all, but it would have
to be:

  dh = opendir(ref);
  if (!dh) {
          if (errno == ENOENT)
                  return 0; /* no such ref */
          else
                  return error("couldn't read ref");
  }

  while ((ent = readdir(dh)) {
          if (ent->d_name[0] == '.')
                  /*
                   * skip "." and "..", and leave room for annotating 
                   * refs via dot-files
                   */
                   continue;
          /* otherwise, we found it */
          if (get_sha1_hex(ent->d_name, sha1) < 0)
                  return error("weird junk in ref dir?");
          return 1; /* found it */
  }
  return 0; /* did not contain an entry; ref being created? Retry? */


Is readdir actually atomic with respect to directory updates? That is,
if I am calling readdir() and somebody else is renaming, what do I get?
POSIX says:

   If a file is removed from or added to the directory after the most
   recent call to opendir() or rewinddir(), whether a subsequent call to
   readdir() returns an entry for that file is unspecified.

If I get one or the other file (that is, the old name or the new one),
it is OK. It does not matter which, as it is a race whether I see the
old value or the new one during an update. But according to POSIX, it is
possible that I may see neither.

I suppose we could rewinddir() and retry. We might hit the race again
(if somebody else is updating quickly), but realistically, this will
happen very infrequently, and we can just keep trying until we win the
race and get a valid read.

> I don't know how this new scheme could be made to work with 
> the current scheme, it seems like perhaps new git releases 
> could be made to understand both the old and the new, and a 
> config option could be used to tell it which method to write 
> new refs with.  Since in this new scheme ref directory names 
> would conflict with old ref filenames, this would likely 
> prevent both schemes from erroneously being used 
> simultaneously (so they shouldn't corrupt each other), except 
> for the fact that refs can be nested in directories which 
> confuses things a bit.  I am not sure what a good solution to 
> this is?

I think you would need to bump core.repositoryformatversion, and just
never let old versions of git access the repository directly. Not the
end of the world, but it certainly increases deployment effort. If we
were going to do that, it would probably make sense to think about
solving the D/F conflict issues at the same time (i.e., start calling
"refs/heads/foo" in the filesystem "refs.d/heads.d/foo.ref" so that it
cannot conflict with "refs.d/heads.d/foo.d/bar.ref").

-Peff
