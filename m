From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Mon, 2 Jul 2007 21:09:55 -0400
Message-ID: <20070703010955.GA5322@thunk.org>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org> <46896EF2.70006@vilain.net> <20070702215859.GA20597@thunk.org> <20070702221639.GB20597@thunk.org> <46898815.6030607@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 03:10:11 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5WuA-000866-Ix
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 03:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323AbXGCBKI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 21:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbXGCBKI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 21:10:08 -0400
Received: from THUNK.ORG ([69.25.196.29]:34486 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756845AbXGCBKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 21:10:06 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I5X1o-0007Ir-8Q; Mon, 02 Jul 2007 21:18:04 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I5Wtv-0004e4-Nc; Mon, 02 Jul 2007 21:09:55 -0400
Content-Disposition: inline
In-Reply-To: <46898815.6030607@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51437>

On Tue, Jul 03, 2007 at 11:19:49AM +1200, Sam Vilain wrote:
> Thanks for that, it mostly works, however it doesn't seem to notice if I
> abort without making the merge complete (on emacs21).  In my smartmerge
> script (http://utsl.gen.nz/scripts/smartmerge) I detect this condition
> based on the presence of merge markers, possibly dubious but pragmatic.

Hmm, well, here's a way of fixing it.  (See attached, below.)  It adds
a new command 'x', which when you hit it in the ediff control window,
exits with a error status of '1', indicating that the merge has
failed.  This is something which emerge, kdiff3, tkdiff, et. al all
support; but which ediff doesn't.

> I still don't really understand why having to save the merged buffer and
> exit is such a huge issue.  Already I have to select "-t emerge" to get
> emerge.  I would have thought it would be better to just make the other
> mode available, and let the user figure it out.

I'm just exploring alternatives.  Basically, it just seems interesting
that ediff has a lot of nice features, but also has some incredibly
user-hostile features.  The first time I tried using ediff, I indeed
tried saving the buffer and exiting it.  That's when I discovered that
after I changed the focus to the merge window and saved it, when I
tried typing ^X^C, the exit failed with the error message "Attempt to
delete a surrogate minibuffer frame".  That's the sort of thing that
will cause non-elisp programmers to run screaming off into the
distance.

So if you are going to save the merge the buffer and exit, you *have*
to use the 'q' command, and endure the loads of stupid questions
issued by ediff, OR, you can discover that ^X^C in the ediff control
window doesn't actually cause emacs to exit, but it does make the
ediff control window go away.  (Which is another insane bit of ediff's
UI design... why should ^X^C do something completely different in the
ediff control window?!?)

So yeah, we can add ediff as an optional support that people have to
explicitly request, but quite frankly, having played with it, I don't
know why anyone would use it without a huge number of fix ups, which
is why I was trying to make ediff actually be usable for someone who
doesn't mind typing ^X^C twice, for no good reason, after figuring out
that this illogical thing is what you actually need to do to exit
ediff.  (I actually read the help text first, so I got treated to the
really annoying ediff-quit behavior before I figured out the double
^X^C trick.)

						- Ted

;; use-ediff-instead.el
;;
;; This emacs lisp snippet should be placed in your .emacs.el file in
;; order to use the ediff package instead of emerge for git-mergetool.
;; Ediff has more whiz-bang features, but unfortunately it doesn't
;; integrate well with shell scripts that try to invoke ediff from an
;; emacs shell invocation.  This script tries to address these problems.

(defun ediff-write-merge-buffer ()
  (let ((file ediff-merge-store-file))
    (set-buffer ediff-buffer-C)
    (write-region (point-min) (point-max) file)
    (message "Merge buffer saved in: %s" file)
    (set-buffer-modified-p nil)
    (sit-for 1)))

(defun ediff-abort ()
  "Abort the ediff session without a non-zero exit status"
  (interactive)
  (kill-emacs 1))

(defun ediff-setup-abort ()
  (define-key ediff-mode-map "x" 'ediff-abort))

(defun emerge-files-command ()
  (let ((file-a (nth 0 command-line-args-left))
	(file-b (nth 1 command-line-args-left))
	(file-out (nth 2 command-line-args-left)))
    (setq command-line-args-left (nthcdr 3 command-line-args-left))
    (setq ediff-quit-hook 'kill-emacs
	  ediff-quit-merge-hook 'ediff-write-merge-buffer
	  ediff-keymap-setup-hook 'ediff-setup-abort)
    (ediff-merge-files file-a file-b  nil file-out)))

(defun emerge-files-with-ancestor-command ()
  (let (file-a file-b file-anc file-out)
    ;; check for a -a flag, for filemerge compatibility
    (if (string= (car command-line-args-left) "-a")
	;; arguments are "-a ancestor file-a file-b file-out"
	(progn
	  (setq file-a (nth 2 command-line-args-left))
	  (setq file-b (nth 3 command-line-args-left))
	  (setq file-anc (nth 1 command-line-args-left))
	  (setq file-out (nth 4 command-line-args-left))
	  (setq command-line-args-left (nthcdr 5 command-line-args-left)))
        ;; arguments are "file-a file-b ancestor file-out"
        (setq file-a (nth 0 command-line-args-left))
        (setq file-b (nth 1 command-line-args-left))
        (setq file-anc (nth 2 command-line-args-left))
        (setq file-out (nth 3 command-line-args-left))
        (setq command-line-args-left (nthcdr 4 command-line-args-left)))
    (setq ediff-quit-hook 'kill-emacs
	  ediff-quit-merge-hook 'ediff-write-merge-buffer
	  ediff-keymap-setup-hook 'ediff-setup-abort)
    (ediff-merge-files-with-ancestor file-a file-b file-anc nil file-out)))

;; End of use-ediff-instead.el
