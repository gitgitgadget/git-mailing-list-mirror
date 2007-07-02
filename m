From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Sun, 1 Jul 2007 23:05:21 -0400
Message-ID: <20070702030521.GA4798@thunk.org>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org> <7v1wfr1qn8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 05:05:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5CEM-0008Iq-BC
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 05:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723AbXGBDF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 23:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756661AbXGBDF1
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 23:05:27 -0400
Received: from THUNK.ORG ([69.25.196.29]:45284 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756616AbXGBDF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 23:05:26 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I5CLx-0002vA-46; Sun, 01 Jul 2007 23:13:29 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I5CE5-0008Se-Q1; Sun, 01 Jul 2007 23:05:21 -0400
Content-Disposition: inline
In-Reply-To: <7v1wfr1qn8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51337>

On Sun, Jul 01, 2007 at 07:32:59PM -0700, Junio C Hamano wrote:
> Theodore Tso <tytso@mit.edu> writes:
> 
> > Unfortunately, it's not enough.  Ediff doesn't have an "abort" command
> > which returns a non-zero exit status, and when you use the "quit"
> > command, it asks you a series of obnoxious questions:
> >
> > ...
> > Alternatively, we could patch around the problem.  The following emacs
> > lisp code fixes the ediff issues:
> 
> But that would be changing the behaviour globally, and not
> limited to the particular session invoked from git-mergetool,
> wouldn't it?  If that is the case it would be a hard sell to
> Emacs users, especially the ones that keep their Emacs running
> forever and have emacsclient as their EDITOR, I would think.

The emacs lisp code I gave there was the minimal necessary so it
could be passed on the command-line; I was trying to keep it small.

Obviously, the patch that would have to get sent to the ediff folks
would have to be much more generalized --- in fact, probably the right
thing to do is to send a full patch that actually implemented
ediff-merge-files-command and ediff-merge-files-with-ancestoers-commands.

As far as people using emacsclient as their editor, it would be simple
enough to have the emacs lisp code test to see if
server-buffer-clients is non-nill; if it is, then we know that this
merge request was trigered by emacsclient, and so (server-done) should
be called instead of (kill-emacs).  Emerge does not do this; arguably
this is a bug in emerge.

The other way we could deal with this problem is to fire up a separate
emacs even if EDITOR is emacsclient, on the theory that
EDITOR=emacsclient meants that the user prefers emacs, but it doesn't
necessarily mean that we have to *use* emacsclient, especially when
emerge currently doesn't DTRT with emacsclient.

One thing that did cross my mind is that we could put code which
patched ediff.el and emerge.el in /usr/share/git/lisp/... and then
passed called emacs with something like this "emacs -l
$sharedir/lisp/ediff-patches.el ...".  But this implies packaging
emacs lisp files with git, and I'm not at ALL sure we want to go
there.  Personally, I still like kdiff3 as my personal favorite
mergetool, and given that emacs starts up pretty fast these days, I've
given up on emacsclient, but I know there are certainly people who use
them.

(Mmmm...., I just pulled down an early emacs 23 snapshot with Xft
support enabled, so I can enjoy the anti-aliased font goodness.  Even
with all of the Gtk and Xft bloat, the emacs 23 snapshot is still
quick snappy to fire up.)

					- Ted
