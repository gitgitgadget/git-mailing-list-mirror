From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Date: Tue, 23 Oct 2012 18:23:18 -0400
Message-ID: <20121023222318.GA3055@sigill.intra.peff.net>
References: <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk>
 <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com>
 <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos>
 <20121023205119.GA27729@sigill.intra.peff.net>
 <alpine.LFD.2.02.1210232307480.2756@ionos>
 <20121023214717.GA29306@sigill.intra.peff.net>
 <522C1DF17AF50042AD8AE87F7887BD3D0B60880C30@exch.hq.tensilica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marc Gauthier <marc@tensilica.com>
X-From: linux-arch-owner@vger.kernel.org Wed Oct 24 00:23:31 2012
Return-path: <linux-arch-owner@vger.kernel.org>
Envelope-to: glka-linux-arch@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arch-owner@vger.kernel.org>)
	id 1TQmsl-0007xb-8I
	for glka-linux-arch@plane.gmane.org; Wed, 24 Oct 2012 00:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933467Ab2JWWXW (ORCPT <rfc822;glka-linux-arch@m.gmane.org>);
	Tue, 23 Oct 2012 18:23:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51650 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933386Ab2JWWXV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Oct 2012 18:23:21 -0400
Received: (qmail 23009 invoked by uid 107); 23 Oct 2012 22:24:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:24:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:23:18 -0400
Content-Disposition: inline
In-Reply-To: <522C1DF17AF50042AD8AE87F7887BD3D0B60880C30@exch.hq.tensilica.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208260>

On Tue, Oct 23, 2012 at 03:06:59PM -0700, Marc Gauthier wrote:

> Can a later commit be eventually be made to reference some set
> of notes added so far, so they become part of the whole history
> signed by the HEAD SHA1?  hence pulled/pushed automatically as
> well.  Otherwise do you not end up with a forever growing separate
> tree of notes that loses some of the properties of being behind
> the head SHA1 (and perhaps less scalable in manageability)?
> Also that way notes are separate only temporarily.

Interesting idea. It would be tough to do with existing objects. There
are really only two ways for a commit to reference objects:

  1. Via a parent header. But we would not want to include the notes
     tree as a separate parent. The semantics are all wrong, and would
     make your commit look like a nonsense merge.

  2. As an entry in a tree. But we do not enforce connectivity of
     commits referenced in trees, because that is the way that
     submodules are implemented.

So I think we would have to add a new header that says "also, here are
some notes for my history". That has two problems:

  1. It's not backwards compatible. People with the new version of git
     will expect to have objects referenced by the new header, but older
     servers may not provide those objects (and vice versa). We can add
     a protocol extension to communicate this, but fundamentally you are
     going to lose the object connection any time it passes through a
     repo running an older git.

  2. It's impure from the perspective of git's data model. Adding in the
     notes reference is not really a property of the commit. It's more
     like saying "Oh, these other things happened to _past_ commits, and
     I'm just now mentioning them". So you pick an arbitrary commit to
     attach it to. What are the semantics with relation to that commit's
     position in the history graph? If I have a commit that is identical
     but without the notes reference, it will have a different sha1. But
     is it the same commit?

So it's a bit ugly. I think I'd rather build out the transfer
infrastructure to pass the notes references around more gracefully
without trying to shoehorn them into the commit graph.

> As for automating the inclusion of notes in the flow, can that
> be conditional on some pattern in the note, so that e.g. the
> Acked-by's get included and folded in automatically, whereas
> others do not, according to settings?

Yeah. You can store arbitrary data in notes (e.g., one of the existing
uses of notes is to record metadata on the patch emails that led to a
commit). Right now you typically separate it out by data type into
separate refs, and then you ask git log to show you particular ones (so
we see refs/notes/commits with "--notes", but you can do "--notes=foo"
to see refs/notes/foo, or even show multiple refs).

For the fold-on-rebase idea, I'd think you would want something similar,
like setting rebase.foldNotes to "foo" to say "refs/notes/foo contains
pseudo-headers that should be folded in like a signed-off-by".

-Peff
