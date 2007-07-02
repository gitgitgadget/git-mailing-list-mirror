From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Sun, 1 Jul 2007 22:04:01 -0400
Message-ID: <20070702020401.GD28917@thunk.org>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 04:04:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5BGz-0001L3-Cq
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 04:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbXGBCEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 22:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755683AbXGBCEP
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 22:04:15 -0400
Received: from THUNK.ORG ([69.25.196.29]:49375 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660AbXGBCEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 22:04:14 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I5BOh-0002lj-VW; Sun, 01 Jul 2007 22:12:16 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I5BGj-00014r-EL; Sun, 01 Jul 2007 22:04:01 -0400
Content-Disposition: inline
In-Reply-To: <20070629040328.GG29279@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51335>

On Fri, Jun 29, 2007 at 12:03:28AM -0400, Theodore Tso wrote:
> I'll have to look at the two and see why people like one over the
> other, and then we'll have to pick which one should be the default.
> Although as I've said, past a certain point people should just put
> their personal preference in .gitconfig.

After looking at ediff, it is definitely the more polished and
featureful compared to emerge --- except in one critical area, which
is calling as a mergeing tool from a shell script or command line.
Ediff fundamentally assumes that it fired off from inside an emacs
environment, whereas emerge is much friendly as an external merge
program. 

This can be shown in the relatively easy way emerge can be run from
the command-line:

	emacs -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$path"

... where as with ediff, you have to run it this way:

	emacs --eval "(ediff-merge-files-with-ancestor \"$LOCAL\" \"$REMOTE\" \"$BASE\" nil \"$path\")"

Unfortunately, it's not enough.  Ediff doesn't have an "abort" command
which returns a non-zero exit status, and when you use the "quit"
command, it asks you a series of obnoxious questions:

Quit this Ediff session? (y or n)
File /usr/projects/git/test/testfile.c exists, overwrite? (y or n)
Merge buffer saved in /usr/projects/git/test/testfile.c
<delay for 3 annoying seconds>
Merge buffer saved.  Now kill the buffer? (y or n)

... and then it leaves you in the emacs window, and you have to type
^X^C by hand.

So while ediff is more featureful, its integration is so lacking that
it is incredibly annoying to use.

Which leaves us with the interesting question.  We could just
integrate it, but not make it the default (the above makes ediff just
far too annoying for a user who is not expecting it).  

Alternatively, we could patch around the problem.  The following emacs
lisp code fixes the ediff issues:

(defun ediff-write-merge-buffer ()
  (let ((file ediff-merge-store-file))
    (set-buffer ediff-buffer-C)
    (write-region (point-min) (point-max) file)
    (message "Merge buffer saved in: %s" file)
    (set-buffer-modified-p nil)
    (sit-for 1)))

(setq ediff-quit-hook 'kill-emacs
      ediff-quit-merge-hook 'ediff-write-merge-buffer)

But the only clean way of adding that to git-mergetool would be something like this:

	emacs --eval "(progn (defun ediff-write-merge-buffer () (let ((file ediff-merge-store-file)) (set-buffer ediff-buffer-C) (write-region (point-min) (point-max) file) (message \"Merge buffer saved in: %s\" file) (set-buffer-modified-p nil) (sit-for 1))) (setq ediff-quit-hook 'kill-emacs ediff-quit-merge-hook 'ediff-write-merge-buffer) (ediff-merge-files-with-ancestor \"$LOCAL\" \"$REMOTE\" \"$BASE\" nil \"$path\")"

But that seems too ugly to live, and it could break in the future if
ediff ever changes some of its internal variables.


Alternatively, we could file a bug report with the ediff folks, and
request that they add an 'ediff-files-with-ancestor-command and
'ediff-files-command just as emerge does.  The problem with that
approach is that ediff is shipped with emacs, and emacs has a release
cycle measured in **years**.


So my current thinking is that ediff will *not* be the default for
git-mergetool if emacs is present, and that emerge will be used for
now, because of these problems.

Comments?

						- Ted
