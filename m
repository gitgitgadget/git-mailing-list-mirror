From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sharing between local "work" and "nightly build" git repos
Date: Fri, 13 Jul 2007 11:23:03 -0700
Message-ID: <7vfy3snoxk.fsf@assigned-by-dhcp.cox.net>
References: <7154c5c60707121636l585b42d4l931b08f1468ddfc@mail.gmail.com>
	<7vmyy1rwza.fsf@assigned-by-dhcp.cox.net>
	<7154c5c60707121727k36854891u82afc4a8be822861@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "David Frech" <nimblemachines@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 20:23:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Pnb-0000Gq-W6
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 20:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933154AbXGMSXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 14:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759667AbXGMSXM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 14:23:12 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47665 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760089AbXGMSXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 14:23:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713182307.OBHM1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Jul 2007 14:23:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P6P61X00M1kojtg0000000; Fri, 13 Jul 2007 14:23:07 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52408>

"David Frech" <nimblemachines@gmail.com> writes:

> Could you, for my sake and the list's (if others are as confused) be
> clearer about the distinctions among -l, -s, and --reference? Exactly
> what they do, and their orthogonality (or lack of) really isn't clear
> from reading the man page.

Clone "-l" makes the new repository share the initial set of
objects from the original by hardlinking each and every file
under .git/objects/.  After "-l" clone, two repositories are
truly independent, except for the fact that the new one
obviously treats the old one as its "origin".

There are a few implications:

 - New objects created in the new repository is not visible in
   the original repository and vice versa.  If you do
   development in the new repository, and push the results back
   to the original, the push will involve object transfer.  If
   your original one is updated (perhaps with git-pull from the
   upstream), you would need to update the clone separately.

 - You can safely rewind the refs in the original repository and
   run git-prune there without worrying about corrupting the
   cloned repository.

Clone "-s" does not make hardlinked copy like "-l" makes.  It
creates an entry in .git/objects/info/alternates file in the new
repository, that instructs git that any object missing in the
new repository should be looked up in the cloned repository.
New objects created in the original will be shared with the
cloned repository because of this, but the sharing does not
happen in the other direction.  Also if you run "rebase" (or
"reset --hard" to rewind the tip of branches) in the original
repository and then run git-gc, it would cause some objects to
become unneeded in the original repository and they can get
discarded.  If your cloned repository depends in them, you will
be in trouble.  So you would need to be a bit careful when you
use "-s" --- the rule of thumb is not to rewind the branches, or
if you do, make sure the cloned ones are kept in sync
(i.e. rewind the commits lost in the original the same way in
the clone).

The "--reference" option uses the same mechanism as "-s" uses to
share objects from a local repository.  It is useful if you have
a repository of a different project that is related to the
project you are cloning from outside.  For example, if you have
a copy of LInus's Linux 2.6 kernel repository locally, and if
you want to clone 2.6.x.y maintenance "stable" repository, you
know the two repositories are alike and share a lot of objects,
so you would:

    $ git clone --reference ../linus-2.6/ git://.../linux-2.6.x.y/ stable.git

To this option, because it uses the same "alternate object
store" mechanism as "-s" option does, the same "be careful
rewinding the branches in the original" caveat applies.  Because
Linus never rewind his branches, the above clone is safe.

For the purpose of "keep rebuilding 'next' from git.git
repository", because my 'next' will never rewind by social
convention, you do not have to worry about the "original
repository being rewound and losing objects" problem, either, as
long as 'next' is the branch you rebuild in the "nightly"
repository.
