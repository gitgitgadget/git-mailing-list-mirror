From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Date: Tue, 23 Oct 2012 17:22:45 -0400
Message-ID: <20121023212245.GA28828@sigill.intra.peff.net>
References: <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com>
 <20121019213548.GR2616@ZenIV.linux.org.uk>
 <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk>
 <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com>
 <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos>
 <20121023205119.GA27729@sigill.intra.peff.net>
 <CAHkRjk6x9ToVzY7jv1ZxPt57F6agcH7SfHZpZNpHC3QP3PZp3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Catalin Marinas <catalin.marinas@arm.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Oct 23 23:23:05 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TQlwH-0000zu-0V
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Oct 2012 23:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab2JWVWu (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Oct 2012 17:22:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51585 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884Ab2JWVWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Oct 2012 17:22:48 -0400
Received: (qmail 22424 invoked by uid 107); 23 Oct 2012 21:23:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 17:23:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 17:22:45 -0400
Content-Disposition: inline
In-Reply-To: <CAHkRjk6x9ToVzY7jv1ZxPt57F6agcH7SfHZpZNpHC3QP3PZp3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208252>

On Tue, Oct 23, 2012 at 10:09:46PM +0100, Catalin Marinas wrote:

> > It is spelled:
> >
> >   git notes add -m <comment> SHA1
> >
> > The resulting notes are stored in a separate revision-controlled branch
> > and can be pushed and pulled like regular refs. Note, though, that the
> > default refspecs do not yet include refs/notes, so you'd have to add
> > them manually. The workflows around notes are not very mature yet, so if
> > you start using them, feedback would be appreciated.
> 
> What would be nice is that notes are pushed/pulled automatically with
> standard git push/fetch/pull commands. Usually git walks the DAG
> starting with the pulled commit or tag and following the parents. With
> notes, the reference is reversed, the note pointing to the commit and
> not the other way around. So handling this automatically in Git would
> be really useful.

Right, that's what I meant about the refspecs. You can configure git to
push or pull them automatically, but it is not the default. Something
like:

  git config --add remote.origin.fetch '+refs/notes/*:refs/notes/origin/*'

would be a start, but you'd also want to "git notes merge" upstream's
changes into your local notes (you _could_ just fetch straight into
refs/notes/, but if you are making your own notes locally, you have to
resolve it somehow). Exactly how to make this smooth is one of the workflow
considerations; there's been discussion, but most people aren't using
the feature, so we don't have a lot of data.

If you are asking whether we could "auto-follow" notes for commits that
have been fetched like we do for tags, the answer is "not really". The
notes tree is version-controlled as a whole, so you generally fetch the
whole thing or not. And the remote does not advertise note information
the same way we advertise peeled tag references, so a client does not
know which notes are available for fetch. The intended strategy is to
pull in the notes or not (though you can have multiple notes refs with
different names, and fetch just a subset of them).

> The other feature I'd like is that notes are automatically folded in
> the log during git rebase (maybe similar to the squash option). If you
> rebase, you lose all the notes (though this depends on the workflow,
> it may not be needed with published branches).

Git-rebase can automatically copy notes from one commit to another
during a rebase, but you need to set notes.rewriteRef to do so (see "git
help config" for details). The reason for this conservative default is
that some notes may not be appropriate for automatic copying (e.g., a
notes tree containing QA approval should probably be invalidated during
a rebase, whereas one with commentary probably should).

Squashing the notes into the commit message during rebase would be a
useful feature (at least for some type of notes), but that feature does
not currently exist (and as far as I recall, this is the first it has
been proposed).

Again, I think a lot of this comes down to the fact that not many people
are really using notes for their daily workflow, so these itches are not
coming up and getting scratched.

-Peff
