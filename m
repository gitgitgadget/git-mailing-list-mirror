From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 16:06:40 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805281455100.19665@iabervon.org>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com> <7vfxs2uytm.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0805281326520.19665@iabervon.org>
 <7vskw2tgu2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 22:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Rvx-0006eL-Gw
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 22:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbYE1UGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 16:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYE1UGs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 16:06:48 -0400
Received: from iabervon.org ([66.92.72.58]:43291 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbYE1UGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 16:06:48 -0400
Received: (qmail 8485 invoked by uid 1000); 28 May 2008 20:06:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 May 2008 20:06:40 -0000
In-Reply-To: <7vskw2tgu2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83132>

On Wed, 28 May 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Report a non-fatal error, mark in the index that that entry is not 
> > reflected in the working directory, and allow the user to manipulate it 
> > with commands that don't really need the working directory content.
> >
> > $ git checkout origin/master
> > Warning: couldn't create 't/t5100/nul' in your working directory; ignoring 
> > working directory for this filename.
> > $ git mv t/t5100/nul t/t5100/nul-plain
> > $ ls t/t5100/nul-plain
> > t/t5100/nul-plain
> >
> > The working directory doesn't really have to be absolutely vital to git's 
> > functioning (of course, the project you've checked out is going to have 
> > problems unless you fix things). In particular, it should be possible, on 
> > a machine with a broken filesystem, to modify a project that triggers the 
> > filesystem breakage to not trigger it,...
> 
> Now that is somebody who thinks before types.

Well, and I've got the background to know what's possible and how git can 
keep things straight.

> Marking that the filesystem does not match what's in index is already
> done, so you could argue that an alternative would be not to stop in the
> middle of checkout_entry() loop and instead check out as much as we could,
> write out the index perhaps, and signal error, _AFTER_ updating everything
> else, including the HEAD.  We try to be atomic when able (e.g. on a broken
> patch, "apply" does not apply early half the patch and fail but rejects
> the whole thing), but checkout_entry() loop is not something you can
> sanely make atomic (it needs to first remove existing files and even
> directories before writing new files), so that alternative approach might
> be easier to work with.

Ah, yes, CE_VALID. But it doesn't quite work as well as I'd like, because 
it doesn't ignore fstat/readdir not finding anything on the filesystem, so 
it comes out looking deleted, at least if you're actually on Linux (with a 
hack in create_file to refuse to create certain filenames for testing).

Also "git mv CE_VALID-source dest" doesn't ignore the filesystem like it 
should (for this use, anyway). Perhaps we need an additional flag for "the 
filesystem is irrelevant for this entry".

> Care to follow it up with a patch?

Unfortunately, I don't think I'll have a chance for a while to actually 
work on git code. But if someone else (Avery?) wants to try it, I think 
giving a big warning, setting CE_VALID, and returning 0 in entry.c before 
the "unable to create file" message is the right thing to start with. And 
someone with Windows access should figure out what happens next.

I think the right test for this is if create_file() returns EEXIST, but 
readdir doesn't show anything. For that matter, it might be useful to have 
logic that notes the situation where you seem to have file A instead of 
file B, but fstat("B") returns A's inode, and marks the index to say that 
entry B is listed in the filesystem as A instead.

	-Daniel
*This .sig left intentionally blank*
