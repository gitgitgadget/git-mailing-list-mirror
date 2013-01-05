From: Jeff King <peff@peff.net>
Subject: Re: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in
 repack_without_ref)
Date: Sat, 5 Jan 2013 11:12:15 -0500
Message-ID: <20130105161215.GA24900@sigill.intra.peff.net>
References: <20121221080449.GA21741@sigill.intra.peff.net>
 <50DAB447.8000101@alum.mit.edu>
 <201212271611.52203.mfick@codeaurora.org>
 <201212310330.53835.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <sop@google.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 17:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrWMS-0004CJ-6n
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 17:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab3AEQMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 11:12:20 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44481 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791Ab3AEQMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 11:12:19 -0500
Received: (qmail 28141 invoked by uid 107); 5 Jan 2013 16:13:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 Jan 2013 11:13:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2013 11:12:15 -0500
Content-Disposition: inline
In-Reply-To: <201212310330.53835.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212702>

On Mon, Dec 31, 2012 at 03:30:53AM -0700, Martin Fick wrote:

> The general approach is to setup a transaction and either 
> commit or abort it.  A transaction can be setup by renaming 
> an appropriately setup directory to the "ref.lock" name.  If 
> the rename succeeds, the transaction is begun.  Any actor can 
> abort the transaction (up until it is committed) by simply 
> deleting the "ref.lock" directory, so it is not at risk of 
> going stale.

Deleting a directory is not atomic, as you first have to remove the
contents, putting it into a potentially inconsistent state. I'll assume
you deal with that later...

> One important piece of the transaction is the use of uuids.  
> The uuids provide a mechanism to tie the atomic commit pieces 
> to the transactions and thus to prevent long sleeping process 
> from inadvertently performing actions which could be out of 
> date when they wake finally up.

Has this been a problem for you in practice? Avoiding this is one of the
reasons that git does not take out long locks; instead, it takes the
lock only at the moment it is ready to write, and aborts if it has been
updated since the longer-term operation began. This has its own problems
(you might do a lot of work only to have your operation aborted), but I
am not sure that your proposal improves on that.

Your proposal does sound like it could potentially improve robustness
when killing stale transactions (i.e., you know that the transaction
originator will never wake up and think it still has the lock). But
again, is that a problem in practice? Git typically holds ref locks for
a few syscalls. If you are conservative about leaving potentially stale
locks in place (e.g., give them a few minutes to complete before
assuming they are now bogus), you will not run into that problem.

The more conservative you are about treating a lock as stale, of course,
the less performant you will be in the face of stale locks. But since
they're the exception, that isn't a big problem in practice (at least it
has not been for me).

> In each case, the atomic 
> commit piece is the renaming of a file.   For the create and 
> update pieces, a file is renamed from the "ref.lock" dir to 
> the "ref" file resulting in an update to the sha for the ref.

I think we've had problems with cross-directory renames on some
filesystems, but I don't recall the details. I know that Coda does not
like cross-directory links, but cross-directory renames are OK (and in
fact we fall back to the latter when the former does not work).

Ah, here we go: 5723fe7 (Avoid cross-directory renames and linking on
object creation, 2008-06-14). Looks like NFS is the culprit.

> In the case of a delete, the actor may verify that "ref" 
> currently contains the sha to "prune" if it needs to, and 
> then renames the "ref" file to "ref.lock/uuid/delete". On 
> success, the ref was deleted.
> 
> Whether successful or not, the actor may now simply delete 
> the "ref.lock" directory, clearing the way for a new 
> transaction.  Any other actor may delete this directory at 
> any time also, likely either on conflict (if they are 
> attempting to initiate a transaction), or after a grace 
> period just to cleanup the FS.  Any actor may also safely 
> cleanup the tmp directories, preferably also after a grace 
> period.

Hmm. So what happens to the "delete" file when the ref.lock directory is
being deleted? Presumably deleting the ref.lock directory means doing it
recursively (which is non-atomic). But then why are we keeping the
delete file at all, if we're just about to remove it?

What happens if another process wants to cancel a transaction that is
partially done? That is, the ref.lock directory is created, but it
contains the uuid subdir? It sounds like it's OK to just delete from it,
and the original process will then fail at its rename?

> One neat part about this scheme is that I believe it would be 
> backwards compatible with the current locking mechanism since 
> the transaction directory will simply appear to be a lock to 
> older clients.  And the old lock file should continue to lock 
> out these newer transactions.

Yeah, I don't see anything that would prevent that. The current code
only cares about open("$ref.lock", O_EXCL). But that should be correct
and atomic with respect to the renamed directories. You are depending on
atomic directory renames. Those aren't used anywhere yet in git, as far
as I know. So that may run into problems (but there's no reason this
system couldn't be optional for filesystems that are more abled, and
other systems could fall back to the straight-file locking).


So in response to your question, no, I don't see any real showstoppers
here. And unlike the "all refs are files in a directory" scheme, it's
confined to writing, which solves the readdir() atomicity questions I
had there.

I still can't say I'm super excited about it, just because it seems like
a solution in search of a problem that I have not experienced myself.
But if it's solving a problem for you, I don't want to discourage you
from pursuing it.

> To be honest, I suspect I missed something obvious because 
> this seems almost too simple to work.  I am ashamed that it 
> took me so long to come up with (of course, I will be even 
> more ashamed :( when it is shown to be flawed!)  This scheme 
> also feels extensible. if there are no obvious flaws in it, I 
> will try to post solutions for ref packing and for multiple 
> repository/ref transactions also soon.

Fixing the minor remaining races on ref packing would be nice, but I do
not think those are a problem of the on-disk lock representation. The
reason they are not fixed now is from an attempt to keep lock contention
low between unrelated updates (something which we should probably give
up on in favor of correctness; but that is orthogonal to whether we do
it with the existing file locks or with a new system).

A much stronger fix for that would be to record deletes in the loose ref
storage so that we don't have to update the packed-refs file as often
(because it is inherently a lock bottleneck, and because it is wasteful
when you have a very large number of refs). But that means dealing with
directory/file conflicts between deleted and existing branches, which is
a pain.

-Peff
