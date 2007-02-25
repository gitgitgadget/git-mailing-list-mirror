From: Junio C Hamano <junkio@cox.net>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 11:54:36 -0800
Message-ID: <7vlkimrp1f.fsf@assigned-by-dhcp.cox.net>
References: <45E1E47C.5090908@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 20:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLPSD-0007QO-7J
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 20:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbXBYTyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 14:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbXBYTyi
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 14:54:38 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52124 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbXBYTyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 14:54:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225195437.IVJB2670.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 14:54:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Tvuc1W0091kojtg0000000; Sun, 25 Feb 2007 14:54:37 -0500
In-Reply-To: <45E1E47C.5090908@verizon.net> (Mark Levedahl's message of "Sun,
	25 Feb 2007 14:33:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40572>

Mark Levedahl <mlevedahl@verizon.net> writes:

> I am trying autoCRLF in git compiled from next (75415c455dd307), find
> some behavior that is probably different than desired dealing with a
> file where the only changes are to line endings:
>
> create a text file (foo) with \n endings, check it in.
> $ u2d foo
> $ git diff foo
> diff --git a/foo b/foo
> $ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   foo
> #
> $ git ci -m 'x' foo
> # On branch master
> nothing to commit (working directory clean)
>
> So, git commit will not check in the file, but git status shows an
> unclean file and git diff shows no actual differences.

Unless you are doing something other than what you demonstrated
above, I think what 'diff' and 'commit' steps show is expected,
even without autoCRLF.  'git status' might be buggy.

	create a file (foo), check it in.
	$ touch foo
        $ git diff foo
        diff --git a/foo b/foo
        $ git commit -m 'x' foo
        # On branch master
        nothing to commit (working directory clean)

So in order to validate my conjecture that 'git-status' is
buggy, can you try this:

	(1) Do your sequence from "create a text file (foo) with
            \n endings" to "git ci -m 'x' foo", as you depicted
            above.

	(2) Without doing anything else, run "git diff" again, 

With my sequence above, "git diff" should say nothing because 
"update-index --refresh" run inside "git-status" (and "git-commit")
would notice 'foo' has not changed.

Ah, I know what is going on.  "update-index --refresh" notices
that lstat(2) says the size is different between what is
recorded in the index, and does not actually compare and refresh
the entry.

But that is a very important optimization, and I do not think we
would want to cripple that for autoCRLF.

I think this should work for you.

        create a text file (foo) with \n endings, check it in.
        $ u2d foo
	$ git update-index foo
        $ git diff foo
        $ git status
	$ git commit

I think the same --refresh check kicks in for "git add" (I did
not try), so if you replace the above "git update-index foo"
with "git add foo" it may not work.  You would want to try that,
too.
