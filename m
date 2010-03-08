From: Tait <git.git@t41t.com>
Subject: Re: a few beginner git questions
Date: Mon, 8 Mar 2010 10:55:05 -0800
Message-ID: <20100308185505.GP2480@ece.pdx.edu>
References: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com> <20100306070533.GL2480@ece.pdx.edu> <15b345f1003062102l22ac2d2fn3ed5b73221bf4216@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 19:55:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Noi6l-0003Hp-7M
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 19:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab0CHSzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 13:55:10 -0500
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:45321 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab0CHSzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 13:55:08 -0500
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o28It58J030296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Mar 2010 10:55:05 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o28It56E013280;
	Mon, 8 Mar 2010 10:55:05 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o28It5iU013279;
	Mon, 8 Mar 2010 10:55:05 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <15b345f1003062102l22ac2d2fn3ed5b73221bf4216@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (rcpt.cat.pdx.edu [131.252.208.107]); Mon, 08 Mar 2010 10:55:05 -0800 (PST)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rcpt.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at rcpt.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141777>

> How, then, do I update code?  ie. I perform my initial clone, make
> some changes and commit / push them.  Someone else then comes along,
> makes some changes and commits them.  The next day, I do Remote ->
> Fetch from -> origin to update my code to the latest in Git but
> c:\git\test\clone\README is exactly the same as it was before.  How do
> I update the initial clone such that I can edit the updated files?

As Dmitry already said, you can either merge in the upstream changes,
or rebase your own changes on top of the upstream changes. I usually
rebase.

Here's my typical workflow. It may not be elegant, but it works well
for me. Hopefully it's useful for you, because understanding workflow
was one of the most intimidating parts of learning git for me.

git pull   # equivalent of git fetch + git merge
           # ... my local master is always clean; this is a fast-forward
git checkout -b exp_smoothing 
           # create a new branch to work
vi         # start making my intended changes
git add    # stage my changes
vi         # make some more changes I don't want to commit, like enabling 
           # debug, bypassing some uninteresting code, etc.
gcc        # oops, there were syntax errors
vi
git add    # to stage just the relevant fixes (or git add -p)
git commit # save my progress
run        # discover some things to fix
...        # repeat the bit from gcc to here many times over
run        # It works ..  maybe it's a few days since I started
           # By now, my history is an ugly mess
git rebase -i exp_smoothing^
           # I re-order, combine, and split commits
           # When I'm done, the history is neat and logical
git checkout master
           # switch back to master (which is still clean)
git pull origin
           # get any updates from the last couple days
           # there will be no conflicts; it's a fast-forward

My history looks like this:

               exp_smoothing branch
              |-- a <-- b <-- c <-- d
              v
master: Z <-- Y <-- X <-- W <-- V

Before switching back to master and doing pull, I only knew about Z
and Y, and in my own local repository, I added a, b, c, d, which are
the cleaned-up version of my exp_smoothing development. When I did
a git pull, I incorporated X, W, and V.

Picking up with the workflow again...

git checkout exp_smoothing
           # back to my work-in-progress branch
git rebase master
           # replay exp_smoothing on top of the new master (now 
           # at V instead of Y)
           # resolve conflicts, if X, W, V conflict with a, b, c, d

History is now:
                         exp_smoothing branch
                        |-- a' <-- b' <-- c' <-- d'
master:                 v
Z <-- Y <-- X <-- W <-- V

git checkout master
git merge exp_smoothing
           # because I resolved all the conflicts during the rebase
           # this should merge conflict-free, as a fast-forward.
git push origin
           # publish my changes (to master) for the rest of the world
git branch -d exp_smoothing
           # exp_smoothing is merged into master; no need to keep it 
           # around anymore

The last four steps occur very quickly. The final history is:

master: Z <-- Y <-- X <-- W <-- V <-- a' <-- b' <-- c' <-- d'

Given my workflow, why branch at all? Sometimes I may be working
on more than one branch at a time, or I may get interrupted on
exp_smoothing development to make a regression fix to master, or
maybe I discover that I don't want to merge exp_smoothing until the
next major version release. It's just easier to manage as a separate
branch up until the last four or six steps. I can rebase exp_smoothing
on top of master over and over again until I finally merge and publish
it.

Tait
