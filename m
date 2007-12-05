From: Junio C Hamano <gitster@pobox.com>
Subject: Re: builtin command's prefix question
Date: Wed, 05 Dec 2007 14:12:23 -0800
Message-ID: <7vlk88n648.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0712050856t5d730779q82783fdb9876f41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 23:12:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J02U7-0005EY-7j
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 23:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbXLEWMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 17:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbXLEWMa
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 17:12:30 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35926 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbXLEWM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 17:12:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 07B532F0;
	Wed,  5 Dec 2007 17:12:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5947A9D494;
	Wed,  5 Dec 2007 17:12:47 -0500 (EST)
In-Reply-To: <fcaeb9bf0712050856t5d730779q82783fdb9876f41@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Wed, 5 Dec 2007 23:56:50 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67203>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> I have been looking at setup_git_directory_gently() lately. From my
> understanding, setup_git_directory* will return a string called
> "prefix" that is passed to builtin commands. What is the exact meaning
> of this prefix?

Some historical background is in order.  For a long time, we only worked
from the very top of the work tree and nowhere else.  The path you get
from the user on the command line was supposed to be relative to the top
of the work tree, the user was supposed to be at the top of the work
tree, no work from subdirectories.

This was limiting, so "setup" was introduced.  The commands originally
worked only from the top would chdir up to the top of the work tree if
it was run from a subdirectory.  This however needs adjustments to the
paths we get from the user from the command line (or stdin for commands
that take such).  If we claim we work from a subdirectory, we should
interpret path given by the user who is in a subdirectory as relative to
that subdirectory.  The way to do this adjustment is to prefix the
subdirectory path to the path given by the user.

So, if you start a command from Documentation/ subdirectory, like this:

	$ cd Documentation
	$ git ls-files howto

internally, ls-files would:

 * Notice it was run from Documentation/ subdirectory;

 * cd up to the top level;

 * prefix "Documentation/" to the pathspec given by the user
   (i.e. "howto"), to form "Documentation/howto";

 * Act as before, except that it strips "Documentation/" from its usual
   output, to retain the illusion of working from that subdirectory.

And prefix is "Documentation/" (note the trailing slash) in such a
case.  If you run from the top, it is NULL to signal that there is no
need to do any of these tricks.

> ... Correct me if I'm wrong. In early (read: no worktree)
> days, cwd was moved to working root directory and prefix contained
> relative path from working root directory to the original cwd. So it
> had a few implications:

>  1. A non-empty prefix indicates cwd has been moved

Correct (I do not know if we care, though)

>  2. If cwd is moved, it is moved to working root directory

Correct ("we always work from top of the tree internally" matters)

>  3. cwd+prefix should point to the current directory at the time the
> command was issued (let's call it "user cwd")

Correct.

> Things change a bit since the rise of worktree:
>  - If GIT_DIR is set and GIT_WORK_TREE is not, prefix is relative to
> the to-be-set-up worktree, but cwd is not changed, so point 3 is gone.
>  - If GIT_DIR is not set and GiT_WORK_TREE is,
>   - and it is found that user cwd is inside a gitdir (bare repo), cwd
> has been moved and prefix is empty, cwd+prefix no longer point to user
> cwd
>   - for other cases, cwd may not be worktree (the real worktree will
> be setup in setup_work_tree or setup_git_directory)

The intention is:

 * If GIT_DIR is set but not GIT_WORK_TREE (nor core.worktree in
   config), you are either inside project.git/ directory of bare
   repository or at the toplevel of worktree-full directory.  This has
   been the traditional behaviour before GIT_WORK_TREE and we shouldn't
   break the existing setups that assume this behaviour.  So in that
   sense, with this combination:

   - If the repository is bare, the value of the prefix should not
     matter; the command that wants to look at prefix by definition
     wants to run from a subdirectory but there is no notion of
     "the user directory being a subdirectory of the top of the work
     tree" in a bare repository;

   - If the repository is not bare, the user directory _MUST_ be at the
     top of the work tree, as that is what the traditional behaviour is.
     Anything else would break existing setups.

     IOW, if you use GIT_DIR and still want to run from a subdirectory
     of the worktree, you must have either GIT_WORK_TREE or
     core.worktree to tell where the top of the worktree is, and if you
     don't, then you must be at the top.

   So the right thing to do in this case is not going anywhere and using
   prefix=NULL.

 * I would say it is a misconfiguration if GIT_DIR is not set and
   GIT_WORK_TREE is, as the sole purpose of GIT_WORK_TREE is so that you
   can work from a subdirectory when you set GIT_DIR.  I may be missing
   an obvious use case that this is useful, but I do not think of any.
   Dscho may be able to correct me on this, as he fixed up the original
   work tree series that was even messier quite a bit during the last
   round.
