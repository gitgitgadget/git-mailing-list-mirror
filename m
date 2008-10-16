From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Working with remotes; cloning remote references
Date: Thu, 16 Oct 2008 14:17:19 -0400
Message-ID: <48F7852F.109@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 20:55:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqY0e-00050m-Nm
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 20:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbYJPSy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 14:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbYJPSy1
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 14:54:27 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:42272 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbYJPSy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 14:54:26 -0400
X-Greylist: delayed 2311 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Oct 2008 14:54:26 EDT
Received: from relay5.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay5.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 85A6471E9FB;
	Thu, 16 Oct 2008 14:15:51 -0400 (EDT)
Received: by relay5.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id 672FC71ED3A;
	Thu, 16 Oct 2008 14:15:51 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98403>

Hi all,

We're a Subversion shop moving to git, and our git-fu is still pretty 
weak.  So I'd appreciate feedback on the setup I'm going to describe, in 
addition to the specific issue I'm going to raise.

Our products involve extensive customization of various 
externally-maintained code bases (mainly in FreeBSD, but also in a few 
other projects too).  We'd like to track the various external 
repositories, to be able to bring their updates into our code base.  We 
don't normally push our own customizations back upstream (yes, not The 
Way Things Should Be, please turn down the flamethrowers).

So we want our main code tree to be composed of our own code and an 
assortment of modified external code:

main/
   external1/
   external2/
   ourstuffA/
   ourstuffB/

Our general approach for supporting this (remember, git novices here) is 
to keep a local git mirror of each external code repository (say, with 
git-svn for the FreeBSD tree).  Then we incorporate the local mirrors 
into our main repo, each under its own directory.

I've looked at two ways to do this: submodules and subtree merges, and 
the latter looks better to me.  The main complication with submodules is 
branching and tagging.  We need to branch or tag the entire main code 
tree, including all the external code bases.  With submodules that seems 
like it would involve several steps to touch all the external mirror 
repos as well as the main repo.  Another complication is that we do a 
lot of our work (50% or more) in the external code trees, and having to 
update the main repo's submodule references as that code changes seems 
rather fragile.

OTOH, a subtree merge nicely puts the external code into a specific spot 
in our main tree, lets that spot get updated with a single command (git 
pull -s subtree External2 master), and still let us branch and tag with 
single commands in the main repo.  Also, the changes we make to 
externally-based code are plain old git pushes to the main repo.  Clean 
and simple.  (BTW, what does braid add beyond just doing subtree merges 
directly?)

So, first the general question: Anything braindead about the above?  Any 
better ways to do this?

Now for the specific issue, which has to do with managing the remotes 
defined in the main repository.  The subtree-merge approach calls for 
the mirrored external repos to be "git remote add"-ed to the main repo. 
  But clones of that repo don't include the remote references (using git 
1.5.4.3 for my testing here).

I think that makes sense in most cases:  Usually a developer will only 
want to clone the main repo and work with what's in there, ad not want 
to bother with the external references.  But when it comes time to pull 
in updates from the external mirror repos the only place where that can 
be done is on the main repo where the original "git remote add" commands 
were issued.

That means merge work has to be done on the main repository's shared 
host (not good) and that testing merged code has to involve committing 
changes on the main shared repo (also not good, even in a branch) and 
testing them on a different host (still no goodness here).

 From this point of view (and please correct me if I'm wrong), it would 
be good if "git clone" had an option to include a repo's remote 
references in the clone.  The clone's origin reference would point to 
the original repo as usual, but all the other remotes would be in the clone.

Pushing and pulling would then also update (non-origin) the remote 
references.

Does this make sense?  Am I missing something here?  (And thanks for 
reading this far!)

		Marc
