From: Eli Barzilay <eli@barzilay.org>
Subject: Problem with git merge/rebase with conflicts
Date: Thu, 6 May 2010 06:06:04 -0400
Message-ID: <19426.38028.501924.921359@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 12:06:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9xyB-0004co-Hz
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 12:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473Ab0EFKGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 06:06:08 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:37591 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab0EFKGH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 06:06:07 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9xy0-0005RD-Ga
	for git@vger.kernel.org; Thu, 06 May 2010 06:06:04 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146473>

I'm writing about merging and rebasing with conflicts, and there's
something weird with it -- after this setup:

  mkdir /tmp/r1; cd /tmp/r1; git init
  echo foo > file; git add file; git commit -m first
  cd /tmp; git clone r1 r2
  cd /tmp/r1; echo abc > file; git commit -m abc file
  cd /tmp/r2; echo xyz > file; git commit -m xyz file
  git fetch

1. I get this:

     $ git merge origin
     ...CONFLICT...
     $ git status -s
     UU file
     $ echo xyz > file
     $ git add file
     $ git status -s

   and there's nothing -- it's all clean after that `add', without
   committing and without anything said.  If this is intentional, it
   would be nice if there was some message from `git add'...  And it
   would also be nice if I'd seen it mentioned anywhere, but
   practically everything I've read said the same: `git add' and then
   `git commit', no mention of that second step being optional.

2. I have some other sample repository that exhibits the behavior with
   the "resolution" going the other way, but here -- starting from the
   same setup:

     $ git merge origin
     ...CONFLICT...
     $ echo abc > file
     $ git add file
     $ git status -s
     M  file
     $ git commit
     ...get an editor without the conflict resolution template thing...
     $ git log --graph --all --oneline
     * 2d3744b Huh?
     * 98c46da xyz
     | * 4744b19 abc
     |/  
     * c8915c2 first

   This looks like I never did any merge.

     $ git merge origin
     Merge made by recursive.
     $ git log --graph --all --oneline
     *   94e69e9 Merge remote branch 'origin'
     |\  
     | * 4744b19 abc
     * | 2d3744b Huh?
     * | 98c46da xyz
     |/  
     * c8915c2 first

   And this looks even more wrong...

3. Again, starting from the same setup:

     $ git rebase origin
     ...CONFLICT...
     $ git status -s
     UU file
     $ echo abc > file
     $ git add file
     $ git status -s
                       <- nothing
     $ git rebase --continue
     Applying: xyz
     No changes - did you forget to use 'git add'?

   which is probably related to the above.  I could use --skip, but
   now that I edited it manually I can't remember that --skip does
   what I already did.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
