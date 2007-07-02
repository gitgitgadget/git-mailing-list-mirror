From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Mon, 2 Jul 2007 10:48:00 -0400
Message-ID: <20070702144800.GA4720@thunk.org>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org> <7v1wfr1qn8.fsf@assigned-by-dhcp.cox.net> <20070702030521.GA4798@thunk.org> <7vr6nrz9yx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 16:48:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5NCs-0002pn-KC
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 16:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbXGBOsO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 10:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755770AbXGBOsN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 10:48:13 -0400
Received: from THUNK.ORG ([69.25.196.29]:59243 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402AbXGBOsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 10:48:12 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I5NJw-0004w0-ON; Mon, 02 Jul 2007 10:56:09 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I5NC4-00018w-G2; Mon, 02 Jul 2007 10:48:00 -0400
Content-Disposition: inline
In-Reply-To: <7vr6nrz9yx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51372>

On Sun, Jul 01, 2007 at 09:49:10PM -0700, Junio C Hamano wrote:
> The reason I personally use emacsclient is not about the
> start-up delay, but with the access to existing buffers,
> keyboard macros, Gnus buffers, ... IOW the access to the
> "session" while editing.  I suspect people with long running
> Emacs session use emacsclient for that reason.

Sure, but do you need access to existing buffers, keyboard, macros,
etc., if you're simply firing up an emacs to handle a merge conflict?
If the goal is just to run a merge application, then firing up a
separate process makes a lot more sense.

One other thing which I just noticed is that emacs21's emacsclient
does NOT support the -f or -e option.  And a lot of people may still
be using emacs21.  So in any case, at the moment we are in fact using
to fire up a separate process when using emerge or ediff.  I suppose
we could try testing to see if the user is running emacs21 or emacs22
if EDITOR==emacsclient, but there's no easy way of doing this short of
doing something heavyweight such as firing up emacs and asking to eval
some lisp that prints the value of emacs-version to stdout.  And even
then we would have to fix emerge to do the right thing when invoked
via emacsclient.  Yuck...

This still leaves us with the question about whether the following to
fix ediff is acceptable:

   	  emacs --eval "(progn (defun ediff-write-merge-buffer () (let ((file ediff-merge-store-file)) (set-buffer ediff-buffer-C) (write-region (point-min) (point-max) file) (message \"Merge buffer saved in: %s\" file) (set-buffer-modified-p nil) (sit-for 1))) (setq ediff-quit-hook 'kill-emacs ediff-quit-merge-hook 'ediff-write-merge-buffer) (ediff-merge-files-with-ancestor \"$LOCAL\" \"$REMOTE\" \"$BASE\" nil \"$path\"))"

In my mind it's on the hairy edge. Alternatively we just never use
ediff by default, and assume that either expert users can hack their
.emacs.el file to have the right overrides will use ediff, or who are
willing to put up with ediff's user-hostile approach to quitting an
merge session.

						 -  Ted
