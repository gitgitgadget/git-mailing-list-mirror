From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 01:47:44 -0800
Message-ID: <7v8xeqh6bj.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 10:47:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKAYM-0008Vh-Ko
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 10:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbXBVJrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 04:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbXBVJrq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 04:47:46 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57136 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbXBVJrp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 04:47:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222094745.YGFG233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 04:47:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SZnk1W0071kojtg0000000; Thu, 22 Feb 2007 04:47:45 -0500
In-Reply-To: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
	(Francis Moreau's message of "Thu, 22 Feb 2007 09:22:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40343>

"git-am" deserves a section in the user-manual on its own.
Perhaps the following can be massaged into JBF's User Manual,
but probably with copyediting and spellfixes.

First, the basics.
------------------

When "git am ./mbox" stops in the middle, you will find
these files in the .dotest/ directory:

0002 0003 0004...::

        Numbered files are split e-mails, yet to be applied, and
        the first one is the one that failed to apply.  Already
        applied ones are removed so they may not begin with
        0001.

next, last::

        These files are used to control sequencing.  'next' is
        the patch you are applying, and 'last' is the number of
        the last patch in the series.

info msg msg-clean final-commit patch::

        These files record information of the patch you are
        applying.  'info' lists the metainformation for the
        commit to be made, 'msg' is the raw message extracted
        from e-mail, 'msg-clean' is a copy of it after stripping
        excess whitespaces, and 'final-commit' is after adding
        sign-off lines (when -s is given).  'patch' is the patch
        text itself.

There are two strategies to resume an "am" that stopped because
a patch does not apply.

One is to fix the patch into applicable shape in whatever way
you can think of, and attempt to apply it again, with "git am".

The other is to update your index to the desired state after
applying the given patch in whatever way you can think of, and
continue with "git am --resolved".

You can also choose not to continue, but skip one patch.  You
can say:

	$ git reset --hard
        $ git am --skip

to skip that particular patch.  This advances 'next' and
continues with the remainder.

[jc: I think that is not what you want in your RFH, but I am
spelling it out for inclusion in the User Manual -- this comment
itself should be removed if somebody wants to include this
message to the manual.]

Now, let's go on to "whatever way you can think of".


Fixing patch text
-----------------

Linus's way is to visit the ./mbox file in the editor, remove
the messages that have already been applied cleanly, edit the
offending patch text to make it applicable.  Then:

	$ git reset --hard
        $ rm -fr .dotest
        $ git am edited-mailbox-file

A variant of this approach is to edit .dotest/patch to make it
applicable, and then say (without removing .dotest/ directory,
of course):

	$ git am

But these are probably reserved for people who are comfortable
editing the patch text.


Applying by hand
----------------

If you (as most people) are not comfortable editing the patch
text you can update your working tree to pretend that the patch
applied cleanly.  You can do number of things:

 * Use "git apply --index -C<n> .dotest/patch" to attempt
   applying the patch with reduced context.

 * Use "git apply --reject .dotest/patch" to get apply only
   hunks that apply cleanly, while getting *.rej files.

 * Use "GNU patch" with less strict options, perhaps like

	$ patch -p1 --fuzz=<n> --ignore-whitespace

Whatever you do, do not forget that your goal with this strategy
is to prepare your index into a shape that the patch should have
made it into, if it applied cleanly.  In other words, after you
are done, "git diff --cached HEAD" should produce what the
original patch in .dotest/patch should have contained.  Also,
typically, "git diff" at that point should say nothing (unless
you know what you are doing).

So, if you used "git apply" without --index (or plain "GNU
patch"), do not forget to "git add" to register the result in
the index.  Especially, if the patch adds a new file, do not
forget to include it in the index!

After you are done, you would continue with:

	$ git am --resolved


Letting git work harder
-----------------------

It _could_ be that the original submitter prepared the patch to
a different branch of your repository than the branch you are
trying to apply the patch to.  Sometimes I get a patch that is
against my 'next' but the change does not depend on what is only
in 'next' and should be applied to 'master' (or even 'maint').
If you have the pre-image blobs the patch was created against,
and the patch was created with git and records "index" lines
like these correctly:

        diff --git a/builtin-config.c b/builtin-config.c
        index 0f9051d..f1433a4 100644

then you can tell git to fall back on 3-way merge to apply the
patch.  After seeing "git am ./mbox" fail, you could try
(without doing anything else):

	$ git am -3

This can result in one of three things:

 * It can complain, with "Patch does not record usable index
   information".  When this happens, you are back to square-one.
   Your repository does not have enough blobs for it to fall
   back on 3-way merge.  The operation did not change anything
   in your working tree nor what are in .dotest/ directory, so
   it did not do any further harm.  You have to use one of the
   two strategies described above instead.

 * It can successfully fall back on 3-way merge and cleanly
   apply the patch.  Lucky you.

 * It can fall back on 3-way merge but the merge can conflict.

In the third case, the usual conflict resolution techniques you
would use during a conflicted merge applies, except that you do
NOT conclude it with "git commit".

This "3-way" is in fact a variant of "Applying by hand"
strategy, and your goal is still to update the index into the
shape the original patch should have made into.  After you
resolve the conflict, you do "git add" the resolved path (or if
the patch is about removing a path and if you do want to remove
that path, then "git rm").  Make sure that "git diff --cached
HEAD" output matches what you think .dotest/patch should have
contained.  Then:

	$ git am --resolved

to continue.
