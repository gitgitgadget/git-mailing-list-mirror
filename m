From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: Subprojects
Date: Wed, 11 Jan 2006 12:06:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601111157020.5073@g5.osdl.org>
References: <43C52B1F.8020706@hogyros.de>
 <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
 <43C537C9.4090206@hogyros.de> <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
 <43C55FEF.2090108@hogyros.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 21:07:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwmFG-0004P9-86
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 21:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWAKUGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWAKUGz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 15:06:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3265 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932485AbWAKUGz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 15:06:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0BK6kDZ002126
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Jan 2006 12:06:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0BK6j6M005325;
	Wed, 11 Jan 2006 12:06:45 -0800
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <43C55FEF.2090108@hogyros.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14510>



On Wed, 11 Jan 2006, Simon Richter wrote:
> 
> Exactly. The questions I posed in the last paragraph of the initial mail,
> rewritten for clarity, would be
>  - "should cg-commit automatically create a commit in the master project when
> a change in the subproject is committed?", and

No.

Don't commit in the "parent" thing automatically. The sub-project should 
be as independent as possible, and you should see a commit to that to be 
nothing more than "editing" a regular file in the top-level project.

In many ways, if you decide to look into doing a "gitlink" kind of object, 
that object really _does_ conceptually point to the .git/HEAD file in the 
subproject. So when you do a commit in the subproject, conceptually that 
is no different from editing the .git/HEAD.

Then, when you want to commit the _dependency_ of the top-level project on 
the sub-project, you commit in the top level. That commit probably does 
other things too: it probably also commits the code in the top level that 
now depends on the sub-project changes.

So don't tie the two together any more than necessary. My suggested usage 
case has the big advantage that the sub-project is much less tightly 
coupled, so you can do things like "git pull" _inside_ the subproject, to 
update it, and then do a big compile in the top-level project to reflect 
the changes (and perhaps update stuff at the top level to conform to 
changes in the sub-project), and then commit in the top independently 
(which will now automatically pick up the changes to .git/HEAD that "git 
pull" did on the subproject).

>  - "should cg-commit automatically commit all changes to subprojects when a
> path that has been listed on the command line contains a subproject?".

Again, I'd really suggest not. If you keep the "gitlink" really meaning 
the ".git/HEAD" contents of the subproject (which is a good semantic 
rule), then if there is any dirty state in the sub-project, it is totally 
irrelevant to a "git commit". Because it's dirty, it's not part of of 
.git/HEAD yet.

Now, obviously you should make "git status" _talk_ about the fact that the 
sub-project is dirty, so that the committer sees that the sub-project 
needs committing first (the same way "git status" now informs git commit 
about dirty files that haven't been updated).

(I'm saying "git" here all the time rather than cg-, because not only 
don't I know cogito very well, I think you want to do most of the core at 
the git level, and just teach cg about the new capability).

			Linus
