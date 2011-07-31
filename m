From: Ricky Egeland <rickyegeland@linea.gov.br>
Subject: Cleaning up history with git rebase
Date: Sun, 31 Jul 2011 14:20:37 -0300
Message-ID: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 19:27:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnZna-0002gK-R5
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 19:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab1GaR1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 13:27:31 -0400
Received: from mx1.linea.gov.br ([200.143.212.2]:43076 "EHLO mx1.linea.gov.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab1GaR13 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 13:27:29 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Jul 2011 13:27:29 EDT
Received: (qmail 12961 invoked from network); 31 Jul 2011 17:20:46 -0000
Received: from unknown (HELO [192.168.1.103]) (rickyegeland@[189.36.169.239])
          (envelope-sender <rickyegeland@linea.gov.br>)
          by mx1.linea.gov.br (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 31 Jul 2011 17:20:46 -0000
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178266>

Hi,

I'll put the question here before the long story: is there a way to automatically rebase a repository (i.e. no conflicts that need manual resolution) from root to HEAD such that the final state always ends up the same as the HEAD?

I'm a relative novice at git and I've been faced with the following task: take a large, 5-year old git repository that contains code for several modular components, and break it apart into ~240 separate git repositories, while preserving history.

big-repo.git (1000's of files) -> component-A.git (10's of files)
                               -> component-B.git (10's of files)
                               -> component-C.git (10's of files)
                               ... (~ 240 new sub-repositories)

The reason for this is to mutually decouple the versioning and release of these components into production, something that seems impossible to do from the single huge git repository we have today.

I've succeeded at breaking apart this big repository using `git filter-branch`, but where I am failing is the cleanup of the history of these new sub-repositories.  The original big repository was used for years in a CVS-like fashion, with about 20 or so developers doing a pull/edit/pull/push workflow using a centralized shared repository.  Most developers were working on unrelated components, so merge conflicts were rare, but there are some exceptions to that.  The end result is that there are a lot of merge commits in big-repo.git, and in the case of my split sub-repositories these merge commits still appear in the history, even for merges which did not involve files that end up in a given repository.  In most cases, there are more merge commits in the history than there are commits that
  actually affected the code that is left in these sub-repositires.  I really want to clean this up.

Looking online, it seems that `git rebase` is the way to go for this cleanup.  I use it like this:

git rebase $(git rev-list --reverse HEAD | head -n 1)

Which I take to mean "rebase this repository from the root to the current HEAD".  In many cases it works perfectly, resulting in a short, clean history that only pertains to the files left in the new sub-repository.  But some of the more actively developed components are problematic, as `git rebase` starts runs into conflicts and becomes interactive, and it is simply too tedious to use the interactive mode to resolve these problems.  I've found a recipe for resolving these conflicts:

 - git status
 - # look for files with problems like "both modified", or "both added", set $CONFLICTFILE
 - git checkout --theirs $CONFLICTFILE
 - git add $CONFLICTFILE
 - git commit -m 'Fixing conflict during rebase' $CONFLICTFILE
 - git rebase --continue
 - # look for message like "did you forget to add..." if so, use --skip
 - git rebase --skip
 - # repeat as often as necessary

For some of my sub-repositories this recipe did exactly what I wanted after repeating only a couple times.  However, some of my sub-repositories have been forcing me to repeat this more than 50 times, and I grew tired and started to look for ways to automate this.  In essence, I want a non-interactive `git rebase`.

To that end I upgraded my version of git to 1.7.4 and tried (without really understanding what these were doing):

1. git rebase -s recursive -X theirs $(git rev-list --reverse HEAD | head -n 1)
2. git rebase -s recursive -X ours $(git rev-list --reverse HEAD | head -n 1)
3. git rebase -s ours $(git rev-list --reverse HEAD | head -n 1)

Method 1 and 2 were still interactive and stopped at conflicts.  Method 3 was automatic but left me with the sub-repository at the state of the root commit... the opposite of what I want.

So finally, my question: is there a way to automatically rebase a repository (i.e. no conflicts that need manual resolution) from root to HEAD such that the final state always ends up the same as the HEAD?  I could try to script my recipe above in order to automate that, but the -s and -X options of `git rebase` lead me to believe git developers have really been working to try to automate stuff like this.  I don't know, I'm stuck and looking for suggestions.

Thanks,
Ricky Egeland
