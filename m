From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: modifying the commits before push
Date: Wed, 18 Jan 2012 21:18:34 +0100
Message-ID: <4F17291A.8020600@dirk.my1.cc>
References: <87wr8o3nq0.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, sds@gnu.org
X-From: git-owner@vger.kernel.org Wed Jan 18 21:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnby0-00077o-Qi
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 21:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab2ARUSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 15:18:40 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:38139 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab2ARUSj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 15:18:39 -0500
Received: from [84.176.45.85] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Rnbxs-00005b-Qo; Wed, 18 Jan 2012 21:18:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <87wr8o3nq0.fsf@gnu.org>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188760>

Am 18.01.2012 18:49 schrieb Sam Steingold:
> Hi,
> I am trying to push:
> $ git status
> # On branch master
> # Your branch is ahead of 'origin/master' by 4 commits.
> #
> nothing to commit (working directory clean)
> $
> but `git push` fails with this:
> 
> remote: ERROR: Rejecting update because this commit email is not from ZZZ
> 
> What I need to do is
> - modify the 4 commits with a different e-mail and do `git push` again
> - make sure that all my commits in this repo are done with the correct e-mail
> 
> how do I do this?
> 
> thanks!
> 


Hi Sam,

to modify the last 4 commits you can use git filter-branch (see the
manpage):

$ git checkout master
$ git filter-branch --env-filter \
   'GIT_COMMITTER_EMAIL="sds@gnu.org" \
    GIT_COMMITTER_NAME="Sam Steingold"' \
   HEAD~4..HEAD

It should tell you that it rewrites 4 commits. The original tree is
saved under original/refs/heads/master. If sth. went wrong, reset your
master to that point (easiest with gitk, it's steel blue). If it worked,
you can delete the original/refs/heads/master like so:

$ git for-each-ref --format="%(refname)" \
    refs/original/ | xargs -n 1 git update-ref -d

Note: Whether it worked or not, remove the original refs afterwards,
because a second run of git filter-branch will fail if there's already
an "original" tree.

To change your address for future commits configure it in .gitconfig in
your $HOME (--global) or on a per repo basis in .git/config (--local):

$ git config --global user.email "sds@gnu.org"
$ git config --global user.name "Sam Steingold"

Or use git gui for this step (Edit -> Options).

HTH
    Dirk
