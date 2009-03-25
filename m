From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Memory of past repositories in git remote?
Date: Wed, 25 Mar 2009 15:22:13 +0100
Message-ID: <49CA3E15.9020107@drmicha.warpmail.net>
References: <784F93DB-2D7C-4F48-88E8-BF56F01CD1E2@dinechin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Christophe de Dinechin <christophe@dinechin.org>,
	=?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Christophe de Dinechin <christophe.de.dinechin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 15:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmU3V-0005Y1-FG
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 15:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760435AbZCYOWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 10:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762771AbZCYOWY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 10:22:24 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59027 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762782AbZCYOWW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 10:22:22 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 542432FC3BB;
	Wed, 25 Mar 2009 10:22:20 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 25 Mar 2009 10:22:20 -0400
X-Sasl-enc: pflPzsuS6AdXH7VP3/J14v2wn5YRXzB6PEwQO4V3qx33 1237990939
Received: from localhost.localdomain (p4FC63420.dip0.t-ipconnect.de [79.198.52.32])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 528432B8FF;
	Wed, 25 Mar 2009 10:22:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090324 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <784F93DB-2D7C-4F48-88E8-BF56F01CD1E2@dinechin.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114603>

Christophe de Dinechin venit, vidit, dixit 25.03.2009 12:47:
> I ran into a peculiar issue running git 1.6.1.2 on HP-UX: it looks  
> like something has remembered an old repository and insists on  
> providing that to "git fetch" instead of the new repository. Appending  
> "/." at the end of the remote repository fixes the problem.
> 
> Here are the details. I created a git repository in /home/ddd/vmm,  
> impored some Subversion history, and started working with that. I  
> created a few branches, e.g. one called "perrier". Then, I realized  
> that there was a better way to track Subversion changes, and so I  
> moved the old repository as /home/ddd/vmm.git, and created a new one  
> that I populated with "git svn clone svn+ssh://path/to/repot -T trunk - 
> b branches -t users". That new repository has no branch named  
> "perrier" in it.
> 
> Now, when I'm on another machine, create a new repository with the  
> same "git svn clone", then do a "git remote add ddd ssh://name@mymachine/home/ddd/vmm 
> ", I would expect to pick up the repository that is actually under / 
> home/ddd/vmm on mymachine. But when I do a "git svn fetch", the output  
> contains:
> 
> warning: no common commits
> remote: Counting objects: 66874, done.
> remote: Compressing objects: 100% (14626/14626), done.
> remote: Total 66874 (delta 51668), reused 66589 (delta 51418)
> Receiving objects: 100% (66874/66874), 96.41 MiB | 187 KiB/s, done
> Resolving deltas: 100% (51668/51668), done.
>  From ssh://name@mymachine/home/ddd/vmm
> * [new branch] perrier -> ddd/perrier
> ...
> 
> as well as all branches from /home/ddd/vmm.git (not /home/ddd/vmm). I  
> tried doing an "ssh name@mymachine ls /home/ddd/vmm" to check that  
> this was indeed the new repository. If instead of "/home/ddd/vmm", I  
> specify "/home/ddd/vmm/.", then I do get the branches in the new  
> repository, e.g in that case I get:
> 
>   * [new branch] tot -> ddd-good/tot
> 
> This is not just a name dependency, though, because if I specify / 
> home/./ddd/vmm, then I get the old repository again. So what seems to  
> matter is the dot at the end of the repository name.
> 
> I'm really puzzled by this behavior, and I have been unable to find  
> anything in the git documentation explaining it. I tried to find  
> references to vmm.git anywhere on either machines, but I couldn't.
> 
> This is easily reproduced, so I'm willing to run experiments to try  
> and debug the problem.

Given %s, git looks for existence of "%s.git/.git",
 * "%s/.git", "%s.git", "%s" in this order. So it's intentional
behavior, not a bug.

The idea is that non-bare repos should be chosen over bare ones, and
bare ones are usually named something.git. One may argue whether %s/.git
should come before %s.git/.git.

Michael
