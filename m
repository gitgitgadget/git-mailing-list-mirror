From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Date: Tue, 23 Oct 2012 17:47:17 -0400
Message-ID: <20121023214717.GA29306@sigill.intra.peff.net>
References: <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com>
 <20121019213548.GR2616@ZenIV.linux.org.uk>
 <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk>
 <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com>
 <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos>
 <20121023205119.GA27729@sigill.intra.peff.net>
 <alpine.LFD.2.02.1210232307480.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Gleixner <tglx@linutronix.de>
X-From: linux-kernel-owner@vger.kernel.org Tue Oct 23 23:47:41 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TQmK3-0001Dd-5Q
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Oct 2012 23:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab2JWVrX (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Oct 2012 17:47:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51611 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab2JWVrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Oct 2012 17:47:21 -0400
Received: (qmail 22697 invoked by uid 107); 23 Oct 2012 21:48:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 17:48:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 17:47:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1210232307480.2756@ionos>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208256>

On Tue, Oct 23, 2012 at 11:25:06PM +0200, Thomas Gleixner wrote:

> > The resulting notes are stored in a separate revision-controlled branch
> 
> Which branch(es) is/are that ? What are the semantics of that?

They are stored in refs/notes/commits by default, but you can have
multiple notes refs if you want to store logically distinct sets of
notes.

A notes ref's tree is just a tree whose entries are sha1s, and the file
contents contain the notes themselves (the sha1s are broken down into
subdirectories for performance, but "git notes" handles this behind the
scenes). Technically you could check it out as a branch, edit, and
commit, but "git checkout" is not happy to have a HEAD outside of
refs/heads/, so you are stuck with plumbing like:

  $ git checkout `git rev-parse refs/notes/commits`
  $ edit edit edit
  $ git commit ...
  $ git update-ref refs/notes/commits HEAD

It's probably not good for much beyond exploring how notes are
implemented. See "git help notes" for more discussion.

> Assume I commit something to branch "foo"
> 
> Now I get that late Ack/Reviewed-by and want to associate that to that
> commit in branch "foo". Does that go into "notes/foo" ?

No. It would go into refs/notes/commits, or you could ask it to go to
refs/notes/acks if you wanted to keep them separate from your default
notes. It is indexed by commit object, not by branch (so if that branch
later goes away, the notes are always still attached to the commit
objects, assuming they got merged in).

> Later when I send a pull request to my upstream maintainer for branch
> "foo" does he get "notes/foo" automagically or do I have to request to
> pull him that separately?

No, he would have to pull your notes separately. Most of the discussion
around sharing has been configuring the default refspec configuration to
fetch notes.  But in the kernel you guys use a lot of one-off pulls
without configured remotes. I'm not sure what the right workflow would
be. It might simply be to ask git to always pull particular notes
commits at the same time (so you might push your notes to
refs/notes/for-linus, and then git would automatically grab the notes
when somebody pulls refs/heads/for-linus).

> Either way is fine for me, though something which lets me "automate"
> that would be appreciated. I can work around that easily as my pull
> requests are generated via scripts, so I can add the secondary one for
> the dependent "notes" branch if necessary. Though it would be nice to
> avoid that. Avoiding that, i.e having a straight connection (maybe
> configurable) between "foo" and "notes/foo" and the commits which have
> not yet hit my upstream maintainer would make my life easier. I.e. I
> just have to check "foo" for stuff which is not upstream yet instead
> of checking both, but that might just be my laziness.
> 
> Thoughts?

That all makes sense. Putting extra work on the puller is not a good
long-term solution. So while sending them an extra "also pull these
notes" line, even if it ends up being a cut-and-pastable single-liner,
is not great (even if it is the most flexible thing). Using a convention
based on name-equivalence seems like a sensible compromise.

-Peff
