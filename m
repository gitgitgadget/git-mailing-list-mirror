From: colin@horizon.com
Subject: Re: How to create independent branches
Date: 8 Apr 2006 19:15:20 -0400
Message-ID: <20060408231520.27044.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 01:15:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSMeW-0001VG-NT
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 01:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWDHXPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 19:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWDHXPV
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 19:15:21 -0400
Received: from science.horizon.com ([192.35.100.1]:23596 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965045AbWDHXPV
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 19:15:21 -0400
Received: (qmail 27045 invoked by uid 1000); 8 Apr 2006 19:15:20 -0400
To: peter.baumann@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18535>

  669  git-symbolic-ref HEAD refs/heads/slave
  670  echo "ref: refs/heads/master" > .git/HEAD
  671  git-symbolic-ref HEAD refs/heads/slave
  672  git add bar

> Another question. I'd like to create a totaly independent branch (like
> the "todo" branch in git). Is there a more user friendly way than doing
> 
> git-checkout -b todo
> rm .git/refs/heads/todo
> rm .git/index
> rm <all_files_in_your_workdir>
> 
> ... hack hack hack ...
> git-commit -a
> 
> I looked all over the docs, but can't find anything obvious.

If I undertstand, you basically want to create a second
initial commit, so you have two trees in your repository.

Well, an initial commit is just a commit object with no parents.

Try:
- Set up the workdir the way you want.  You have to git-add
  any newly added files, but git-update-index (called by
  git-commit -a) will remove from the index any files
  removed from the working directory, so you don't have to
  worry about those.
- Make sure refs/heads/todo doesn't exist
- "git-symbolic-ref HEAD refs/heads/todo"
  This makes HEAD a symlink (well, symref) to refs/heads/todo,
  which doesn't exist.
- git-commit -a
  Since the HEAD link doesn't exist, this does an initial
  commit.

It's not supremely user friendly, because multiple initial commits can
lead to problems down the road trying to merge, so you'd better know what
you're doing.

Another option is to just set up a second working directory, with a
shared object store, and do the checkin from there.  You can have the
.git/refs directories shared (via a symlink) or not.  If they're not
shared, you can later make them shared by copying over the relevant refs.


Oh, yes, note that if you fat-finger the "git-symbolic-ref HEAD" command,
any attempts to fix it will complain "not a git repository".
That's because a reference to refs/heads/ in HEAD is how git
identifies a repository.  "echo ref: refs/heads/master > .git/HEAD"
will fix it.
