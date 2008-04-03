From: Roman Shaposhnik <rvs@Sun.COM>
Subject: Achieving efficient storage of weirdly structured repos
Date: Thu, 03 Apr 2008 12:42:39 -0700
Message-ID: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 22:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhVrp-0001TA-1u
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 22:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbYDCUQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 16:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbYDCUQP
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 16:16:15 -0400
Received: from brmea-mail-2.Sun.COM ([192.18.98.43]:61693 "EHLO
	brmea-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYDCUQP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 16:16:15 -0400
X-Greylist: delayed 1978 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Apr 2008 16:16:15 EDT
Received: from fe-amer-10.sun.com ([192.18.109.80])
	by brmea-mail-2.sun.com (8.13.6+Sun/8.12.9) with ESMTP id m33JhGUa009102
	for <git@vger.kernel.org>; Thu, 3 Apr 2008 19:43:16 GMT
Received: from conversion-daemon.mail-amer.sun.com by mail-amer.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JYR00L01HX73X00@mail-amer.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Thu, 03 Apr 2008 13:43:16 -0600 (MDT)
Received: from [192.168.0.100] ([129.150.66.3])
 by mail-amer.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JYR00KEPLF4DSE0@mail-amer.sun.com> for
 git@vger.kernel.org; Thu, 03 Apr 2008 13:42:42 -0600 (MDT)
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78774>

Hi Guys!

First of all, I must admit that I got seriously hooked up on Git when  
I started to
use it internally for FFmpeg development and my life as far as non  
company
related projects are concerned hasn't been the same ever since. The way
Git addresses issues like branches (both local and remote), merges and
content tracking are, in my opinion, quite superior to the  
alternative SCMs
such as Mercurial. In fact, that's why when I saw my coworkers  
struggling
with exactly the same issues around NetBeans Mercurial repository my
natural instinct was to introduce them to Git and show them that life  
doesn't
have to be that complicated or troublesome.

But before I can do that, there's a little issue that I either need  
to address or
at least understand better. It seems that the storage requirements  
for the
repository that a friend of mine and I created from: http:// 
hg.netbeans.org/main/
got doubled under Git:
     $  du -sh Mercurial- nb-main
     491M   Mercurial- nb-main
     $ du -sh Git-nb-main
     1.1G     Git-nb-main

The repository was created using hg2git (the one based on git-fast- 
import)
and it was GC'ed and REPACK'ed just in case. I spent some time trying
to understand the issue and here's some statistics on the kind of  
objects
that this repository consists of:
     75053 commit
   334572 blob
   750003 tree

The last item (trees) also seem to take the most space and the most  
reasonable
explanation that I can offer is that NetBeans repository has a really  
weird
structure where they have approximately 700 (yes, seven hundred!) top- 
level
subdirectories there. They are clearly Submodules-shy, but that's  
another
issue that I will need to address with them.

So based on my preliminary analysis the biggest culprit seems to be
that for every commit at least one pretty hefty tree object needs to  
be created
(remember 700 top level subdirectories). These objects are all in 18-20K
range but they are almost identical to each other except for one or two
trees that they refer to.

So here's my question: is there anything in Git that I can use to  
accommodate
a repository like http://hg.netbeans.org/main in an efficient manner?  
Any
kind of ideas (like particular command line options for repack, etc.)  
would be
greatly appreciated!

Thanks,
Roman.
