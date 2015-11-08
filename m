From: Marc Haber <mh+git@zugschlus.de>
Subject: how to check for uncommitted/unstaged changes on remote side before
 pushing
Date: Sun, 8 Nov 2015 22:23:20 +0100
Message-ID: <20151108212320.GA18762@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 22:57:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvXxp-0003vo-Vt
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 22:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbbKHV50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 16:57:26 -0500
Received: from torres.zugschlus.de ([85.214.131.164]:54132 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbbKHV5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 16:57:25 -0500
X-Greylist: delayed 2044 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2015 16:57:25 EST
Received: from mh by torres.zugschlus.de with local (Exim 4.80)
	(envelope-from <mh+git@zugschlus.de>)
	id 1ZvXQm-0004xW-Ca
	for git@vger.kernel.org; Sun, 08 Nov 2015 22:23:20 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281043>

Hi,

I am trying to abuse git as a code distribution channel and would like
to be able to trigger redistribution just by git push.

The idea is to push to a remote to the branch that is currently
checked out followed by a git reset --hard in the post-receive hook. I
have already figured out that I need to set receive.denyCurrentBranch
to ignore to be able to push to the currently checked out branch.

I am also aware that it is a good idea to git pull before git push
just in case there were local commits on the remote.

git reset --hard will unconditionally throw away local uncommitted
changes. I would like to detect this situation on the remote and abort
the receive progress. But my pre-receive hook does not work as
intended. Here is my code:

#!/bin/bash

echo "this is the pre-receive hook on $HOSTNAME"

if [ "$(git status --porcelain | wc -l)" -ne 0 ]; then
  echo "there are uncommitted changes"
  echo "PWD=$PWD"
  echo "git status --porcelain"
  git status --porcelain
  echo "end git status"
  exit 1
fi

When I invoke my hook from the remote, everything is fine:

mh@jessie:~/.stdacct$ .git/hooks/pre-receive
this is the pre-receive hook on jessie
there are uncommitted changes
PWD=/home/mh/.stdacct
git status --porcelain
 M dotfiles/.bashrc
 M hooks/pre-receive-hook
?? hooks/pre-receive-hook~
end git status
mh@jessie:~/.stdacct$ 

However, the output is different when invoked during a push:

[7/504]mh@swivel:~/git/stdacct$ git push jessie
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 363 bytes | 0 bytes/s, done.
Total 4 (delta 3), reused 0 (delta 0)
remote: this is the pre-receive hook on jessie
remote: there are uncommitted changes
remote: PWD=/home/mh/.stdacct/.git
remote: git status --porcelain
remote: ?? HEAD
remote: ?? ORIG_HEAD
remote: ?? config
remote: ?? description
remote: ?? hooks/applypatch-msg.sample
remote: ?? hooks/commit-msg.sample
remote: ?? hooks/post-receive
remote: ?? hooks/post-update.sample
remote: ?? hooks/pre-applypatch.sample
remote: ?? hooks/pre-commit.sample
remote: ?? hooks/pre-push.sample
remote: ?? hooks/pre-rebase.sample
remote: ?? hooks/pre-receive
remote: ?? hooks/prepare-commit-msg.sample
remote: ?? hooks/update.sample
remote: ?? index
remote: ?? index.lock
remote: ?? info/
remote: ?? logs/
remote: ?? objects/
remote: ?? refs/
remote: end git status
To ssh://jessie/home/mh/.stdacct
 ! [remote rejected] jessie -> jessie (pre-receive hook declined)
error: failed to push some refs to 'ssh://jessie/home/mh/.stdacct'

It looks like the hook thinks that it is invoked inside the .git/hooks
directory which is not considered part of the repository.

What is going wrong here?

If my entire approach is wrong, what is the recommended way to prevent
a repository with unstaged or uncommitted changes from being pushed to?

Greetings
Marc


-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
