From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Possible bug in git-svn
Date: Sat, 12 May 2007 14:40:35 -0700
Message-ID: <20070512214035.GA18560@muzzle>
References: <200705121824.14190.list-receive@mneisen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Eisenhardt <martin.eisenhardt@mneisen.org>
X-From: git-owner@vger.kernel.org Sat May 12 23:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmzKU-0006RA-LC
	for gcvg-git@gmane.org; Sat, 12 May 2007 23:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbXELVki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 17:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbXELVki
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 17:40:38 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53093 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183AbXELVkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 17:40:37 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BDE5A7DC0A1;
	Sat, 12 May 2007 14:40:35 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 12 May 2007 14:40:35 -0700
Content-Disposition: inline
In-Reply-To: <200705121824.14190.list-receive@mneisen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47098>

Martin Eisenhardt <list-receive@mneisen.org> wrote:
> Hello Eric,
> hello list,
> 
> I came across what might just possibly be a bug in git-svn. My apologies if 
> this was already handled somewhere on the list but I was not able to find 
> this exact problem mentioned before.
> 
> Let's say I run a SVN repository at svn+ssh://svn@example.com/repos and have 
> it set up as described at
> 	
> http://svnbook.red-bean.com/nightly/en/svn.serverconfig.svnserve.html#svn.serverconfig.svnserve.sshtricks
> 
> In essence, there is only one user "svn" with access to the repository, and 
> every developer has his/her public key in ~svn/.ssh/authorized_keys with a 
> line like
> 
> command="svnserve -t --tunnel-user=harry -r /svn/" TYPE1 KEY1 
> harry@example.com
> 
> This is desirable to limit the developers access to the repository; no shell, 
> access restricted to svn's home directory.
> 
> Now let's assume that within this repository, there are several projects, so 
> we have f.e. the following structure:
> 
> +-proj1-+-trunk
> |       +-branches
> |       +-tags
> |
> +-proj2-+-trunk
> |       +-branches
> |       +-tags
> +-[more projects]
> 
> I have no problem setting up a local .git tracking such a project using
> 
>     $ git-svn init svn+ssh://svn@example.com/repos/proj1/trunk
>     $ git-svn fetch
> 
> After having made local changes and commited them to git, I want to push them 
> to the remote subversion repository:
> 
>     $ # do some work
>     $ git-commit -a
>     $ git-svn dcommit
> 
> The last command gives me (invariably):
> 
>     Couldn't find a repository: No repository found 
> in 'svn+ssh://example.com/repos/proj1/trunk' at at /home/mneisen/bin/git-svn 
> line 403
> 
> What is odd is that git-svn uses the URL-prefix svn+ssh://example.com/[...] 
> instead of the correct svn+ssh://svn@example.com/[...], i.e., git-svn drops 
> the user name.
> 
> This behavior is surprisingly inconsistent as git-svn uses the correct user 
> name while fetching and stores it correctly in .git/config.

Ouch.  This is laziness on my part exposed by a patch Adam made to
cleanup the git-svn-id lines.  dcommit reads the git-svn-id: line in the
last SVN commit instead of .git/config.

> The server log contains the following lines:
> 
> May 12 18:18:50 [sshd] Accepted keyboard-interactive/pam for mneisen from 
> 217.229.32.249 port 37685 ssh2
> May 12 18:18:50 [sshd(pam_unix)] session opened for user mneisen by (uid=0)
> May 12 18:18:51 [sshd(pam_unix)] session closed for user mneisen
> 
> which supports my suspicion that git-svn drops the user name for dcommit and 
> uses the current account name instead.
> 
> A git repository on the same machine as the subversion repository is able to  
> track the SVN repository, so it seems that my problems are directly related 
> to the combination of git-svn and the svn+ssh transport of subversion.
> 
> If this an error on my part, please advise me how to solve it.

Thanks for the bug report.  I haven't tested the patch below, so
let me know if it works:

>From 58af622c222514dc3da938ce6309e1ac927a9574 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 12 May 2007 14:36:20 -0700
Subject: [PATCH] git-svn: don't drop the username from URLs when dcommit is run

We no longer store usernames in URLs stored in git-svn-id lines
for dcommit, so we shouldn't rely on those URLs when connecting
to the remote repository to commit.
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3c4f490..d74e6d3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -393,7 +393,7 @@ sub cmd_dcommit {
 		} else {
 			my %ed_opts = ( r => $last_rev,
 			                log => get_commit_entry($d)->{log},
-			                ra => Git::SVN::Ra->new($url),
+			                ra => Git::SVN::Ra->new($gs->full_url),
 			                tree_a => "$d~1",
 			                tree_b => $d,
 			                editor_cb => sub {
-- 
Eric Wong
