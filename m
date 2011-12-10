From: "Neal Kreitzinger" <neal@rsss.com>
Subject: git for change control of software deployment updates
Date: Fri, 9 Dec 2011 20:37:53 -0600
Message-ID: <jbugm2$afc$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 03:38:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZCpM-0005rf-DU
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 03:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab1LJCiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 21:38:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:34137 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab1LJCiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 21:38:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZCpD-0005qX-HF
	for git@vger.kernel.org; Sat, 10 Dec 2011 03:38:07 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 03:38:07 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 03:38:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186719>

I am considering using git with submodules to deploy most of our updates to 
our customer linux servers (not including third party rpm updates already 
tracked by linux distro rpm repository).  Has anyone else done this? 
Comments?  (Sanity check.)  (I am new to submodules.)

Here are some rationale and concerns I submit for review:

Reasons:
- (Main Premise)  I maintain dozens of divergent custom versions 
concurrently with each running on its own server (we do merge these versions 
eventually and then immediately start diverging again).  (This is the main 
reason we chose git for scm.)  Hundreds of servers run the 'main generic' 
version.  Git will allow these branches to deploy to their respective 
customers.
- (Main Supporting Premise)  others on the git-newsgroup talk about using 
git submodules to maintain web sites.  Not sure how robust they are.  In 
theory, a website seems no different than any other application server.
- git on the customer server would allow better tracking of what the 
customer is really running (ie, dirty tree).
- Submodules will track everything outside of linux distro rpms that we 
update outside of linux rpms (third party binaries, html, etc.).
- Submodules containing source will be separate and not deployed.
- I already use git to deploy test versions of the core software from 
dev-server to qa-servers (using git-pull --ff-only, git-clone, etc. on the 
qa-server end).
- I can do most of the work using git features/git-scripts with a minimum of 
homegrown bash scripts/tars.
- git with ssh will make it secure (most customer servers are in vpn 
anyway).
- using separate worktree will separate git repos from deployed binaries.
- git will figure out the 'patches' to transfer in order to effect a version 
change.
- versioning of config files (apache, etc.) to aid in troubleshooting.
- trying to do this with rpm's makes no sense when I can do it with git.
- trying to do this with homemade scripts/tars makes no sense when I can do 
this with git.
- gitweb will make semi-technical support personnel use possible on the 
customer server in the absence of gitk (gui portion of linux).
- I can have a development superproject pointing to all submodules, and a 
deployment superproject pointing to same submodules but not including source 
code submodules.
- if fetch/pull are better for this than push I can setup a deployment 
server that customers have access to.  It seems fetch/pull are more 
conducive to monitoring success/failure, but push is more conducive to 
central control.
- having some history of previous versions seems valuable for rapid 
remediation of regressions (git checkout <prev-version> -- mybinary).
- remote tracking of customer server configurations.
- git could track pre/post-conversion/initialization data file states.
- track customer server configuration file customizations and merge them 
with subsequent changes to base version.
- such a git deployment setup would make emulating a prod server on a test 
server a matter of course.

Concerns:
- is there something about git that would make this unsecure during the 
"patch" transfer (push, fetch, etc)?
- can I limit disk use (repo history) using shallow-clone or some disk 
saving tricks?  IOW, repo on customer server only needs sufficient common 
ancestor to accept updates and not the whole history before the common 
ancestor.  (The majority of deployed content will be binaries.)
- customer servers will not have gui portion of linux loaded (minimal VM 
images on an array in most cases).
- automation of the execution of data format conversion/initialization 
programs (receive hook that checks for and executes and waits for completion 
of such programs) as such commits apply on the repo on the customer server 
or as an aggregate after all commits apply.  (I think of the new execute 
option in rebase, but that is different from receiving during a push.)
- upgrading git versions (breaking deployment system).
- size limits in git to versioning large data files (works for most 
customers, but not the huge ones).
- gitweb is getting smarter and is no longer 'view only' like the old days. 
Can it be made 'view only'?
- github (paid version) is too dumbed down to play well with this usage. 
(I've only read about github but may be asked to use it to some extent.)
- one little git command could wreak havoc on a live customer server.  Then 
again, so can one little linux command.  Is there a way to 'sudo' the git 
commands?
- I rely on porcelain and do not recreate my own porcelain from plumbing. 
(I am a porcelain level user.)
- detection of failures allowing for reset to previous version of software 
and data.
- limits to mass deployment (max approx 500 servers in one night). 
Concurrent pushes?  Concurrent fetches from same remote?
- is there something else about git that might make this untenable over 
time?

Thanks in advance.

v/r,
neal
