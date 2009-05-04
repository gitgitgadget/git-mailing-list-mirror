From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Editing git-svn metadata
Date: Mon, 04 May 2009 17:39:22 +0200
Message-ID: <49FF0C2A.6050503@drmicha.warpmail.net>
References: <24ACA1E2-9B33-412D-A426-FAF3CF683ADA@orestis.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Orestis Markou <orestis@orestis.gr>
X-From: git-owner@vger.kernel.org Mon May 04 17:40:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M10Gn-00036p-BH
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 17:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268AbZEDPjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 11:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758119AbZEDPjb
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 11:39:31 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54254 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758064AbZEDPja (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 11:39:30 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id D2C49338189;
	Mon,  4 May 2009 11:39:30 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 04 May 2009 11:39:30 -0400
X-Sasl-enc: PlkAdIU09ALBZDfi95uk+JtQs7zfN0mZMCs/ZapynvFM 1241451570
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4661230246;
	Mon,  4 May 2009 11:39:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090504 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <24ACA1E2-9B33-412D-A426-FAF3CF683ADA@orestis.gr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118249>

Orestis Markou venit, vidit, dixit 02.05.2009 03:02:
> Hello,
> 
> I couldn't find anything in the manpages for this, and I don't know  
> where else to look for it.
> 
> As mentioned here: http://article.gmane.org/gmane.comp.version-control.git/116382 
>   , an svn repository I'm working against has a weird layout on which  
> git-svn chokes on. I'm working around that by using grafts to inform  
> git about the history of the branches. It involves some manual work  
> but it's fine.
> 
> Another problem I have (possibly linked) is that branches are only  
> detected after the first commit to them - the commit that creates the  
> branch is not recorded by git-svn at all. This forces me to do a  
> 'dummy' commit from svn in order to even see the branch in git-svn.
> 
> Given that I have all the information I need (branch name, parent id),  
> is there any file I can manually edit to inform git-svn about my  
> branches?
> 
> Alternatively, and more usefully to git in general, perhaps I can have  
> a look at the git-svn code and add some diagnostics to see what's  
> failing, and provide a patch? I looked for a developer guide but  
> couldn't find one (only how to write tests).

It may depend on how you create branches in svn. The usual way is to
copy from trunk (or another branch) in the way the attached script does.
For me, the relevant output is

* master
  remotes/mybranch
  remotes/trunk

which is pretty much what it should be. Do you create (empty) branches
by doing a mkdir in an svn check out of the base dir (below trunk)?

Michael

--- %< ---
#!/bin/bash
rm -Rf svnrepo svnwc gitrepo
svnurl="file://localhost"`pwd`/svnrepo
svnadmin create svnrepo
svn co $svnurl svnwc
(
 cd svnwc
 mkdir trunk branches tags
 svn add trunk branches tags
 svn ci -m init
 (
  cd trunk
  echo a > a
  svn add a
  svn ci -m A
  svn cp -m mybranch $svnurl/trunk $svnurl/branches/mybranch
 )
)
git svn clone -s $svnurl gitrepo
(
 cd gitrepo
 git branch -a
)
