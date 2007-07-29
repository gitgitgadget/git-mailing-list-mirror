From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Sat, 28 Jul 2007 22:38:54 -0400
Message-ID: <20070729023854.GA17204@thunk.org>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org> <46896EF2.70006@vilain.net> <20070702215859.GA20597@thunk.org> <20070702221639.GB20597@thunk.org> <46898815.6030607@vilain.net> <20070703010955.GA5322@thunk.org> <85hcno287w.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 04:39:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEygm-0007eb-Iy
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 04:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958AbXG2CjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 22:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755735AbXG2CjF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 22:39:05 -0400
Received: from THUNK.ORG ([69.25.196.29]:37944 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681AbXG2CjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 22:39:00 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IEyof-0007n2-Rc; Sat, 28 Jul 2007 22:47:34 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IEygI-000446-4D; Sat, 28 Jul 2007 22:38:54 -0400
Content-Disposition: inline
In-Reply-To: <85hcno287w.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54076>

On Sat, Jul 28, 2007 at 11:22:43AM +0200, David Kastrup wrote:
> Ted, I think you are somewhat missing the main audience here.  The
> main audience are people who actually _use_ Emacs, and those will be
> comfortable with the concept "save to have changes persist, don't save
> if you don't want changes to persist, exit using C-x # or C-x C-c as
> appropriate".  Basically, it would appear that you try figuring out
> how to make ediff appeal to non-Emacs users.  But those would not have
> emacs/emacsclient in their EDITOR variable in the first place.
> 
> I have been bitten by mergetool calling emacs rather than emacsclient,
> resulting in a non-working merge (since the default directory was set
> differently from what the call expected due to my use of the desktop
> package), and mergetool afterwards assuming that the not-even-started
> merge was successful.  A royal nuisance, and completely unworkable.

Emacsclient is a completely different problem, or at least adds a
whole new dimention, compared to the ediff/emerge issue.  You can't
run either emerge or ediff using the emacsclient in emacs21, since it
lacks support for either the -e or the -f command-line option.  All
you can do in emacs21 when using eamcsclient is to request emacs to
edit a file.  

One of the problems with emacs is that it is so customizable that
people can set up emacs in such a way that different ways of launching
emacs may lead to surprises, thanks to their .emacs21.  This makes
supporting emacs based merging clients to be highly problematic.  Use
of the desktop package is one way in which things can be quite
surprising.  Worse yet, the desktop package is only in emacs22 and up.
(And emacs 22 was *just* released, not all that long ago; many people
may still be using emacs21).  So if we use emacs --no-desktop to
disable the desktop package, it will cause emacs21 to complain about
an unknown option.  Joy.  Which means that to avoid running into
problems with emacs22 users who are using the desktop package,
git-mergetool is going to have to find out in advance whether emacs21
or emacs22 (or an emacs development 23.0.0 snapshot) is in use; on a
debian system you can have 3 or 4 emacs installed simultaneously.  What fun.

In any case, the main issue is that there is an emerging (sorry)
standard about how merge tools are supposed to work, in terms of being
able to support 2-way or 3-way merges, about being able to specify
which file (and which file only, in the best case) should be used as
the output file as the result of the merge, and about how tools can
signal either a successful merge, or a request by the user to abort
the merge becuase things didn't work out for one reason or another.

The problem is that ediff doesn't really fit this model.  For people
who really want to live their life in emacs, and using emacs as their
desktop (not for me, but maybe for some folks), maybe it would be
better for those folks to simply build a git-mergetool.el that ran
100% in emacs, instead of trying to shift back and forth between the
command-line and emacs, would make everyone happier.  Right now
git-mergetool needs to ask questions about the disposition of
symlinks, permission changes, etc.  If it is done as a
git-mergetool.el which is tied into git.el and ediff, it could be a
lot more seamless.

> While it may be nice to have some Lisp preparation for people who
> don't want to touch or learn Emacs _except_ for using it for merging
> in git, I think we should first cater to people actually using Emacs
> already.

Catering to the hard-core Emacs folks is *hard*.  I knew someone who
had PDP-10 assembly language in their .emacs.el file, and one day his
custom emacs extension worked again when he started playing with the
KLH10 PDP-10 emulator, and reused his .emacs.el startup file there....
Of course, at some level folks like that will always need to fend for
themselves.

As I said earlier, I don't have a huge objection to support ediff in
some degraded mode (I think the UI is ghastly bad), if users
explicitly request it, but I would *not* want to make it the default
and spring it on some unsuspecting user.  Quite frankly, right now the
KDE and GNOME tools are way better either emerge or ediff, so they are
only really useful as a default in the terminal-only case.

     	    	      		       - Ted
