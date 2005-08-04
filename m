From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Experiences with git-clone-pack and rsync
Date: Thu, 4 Aug 2005 23:06:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508042230150.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Thu Aug 04 23:12:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0myh-0005k0-TN
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 23:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVHDVJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 17:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVHDVGv
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 17:06:51 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13286 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262699AbVHDVGG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 17:06:06 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id D6098E23CF
	for <git@vger.kernel.org>; Thu,  4 Aug 2005 23:06:05 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id BB8B39C6F3
	for <git@vger.kernel.org>; Thu,  4 Aug 2005 23:06:05 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id A4C1893E22
	for <git@vger.kernel.org>; Thu,  4 Aug 2005 23:06:05 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 89019E23CF
	for <git@vger.kernel.org>; Thu,  4 Aug 2005 23:06:05 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I just tried to clone a relatively big repository from a slow machine to a 
slow machine. I'm talking about a 1.2 gigabyte repository, packed down to 
120 megabyte, containing more than 21000 commits. When git-clone-script 
did not show anything for over 15 minutes, I decided to find out what's 
happening. The server sat, partly swapping, partly git-rev-list'ing, 
git-pack-objects dozing.

Now, I know some internals of git, so I went in and did an rsync, which is 
perfectly reasonable, given that I do not need the server to unpack the 
objects, pack them again, and then - after a while - sending them as they 
were: packed. It took 60 seconds with -- evidently -- almost no load for 
the server.

BTW, I am not quite sure why the machine started swapping. Maybe it was 
some other process on that server, but it could have been git-rev-list 
also, keeping those 21000 commits in memory in order to sort them. Or, it 
could have been something worse: git holding lots and lots of objects in 
memory.

So, I don't know if git-daemon, which basically does the same thing as 
git-clone-pack on the server side, would not be a pretty good way to bring 
git.kernel.org (once it exists) to a halt.

Maybe there should be some kind of heuristics in git-daemon, i.e. 
git-count-objects in reverse, to decide if it is not better to (at least 
optionally) just send the pack as is, even if it contains more objects 
than the user actually asked for. Or, for big projects like the kernel, 
just send the pack if at least one needed object is contained in it. Hey, 
git-http-pull already does that :-)

But maybe I just cried "wolf"...

Ciao,
Dscho

P.S.: There is a serious flaw in git-fetch-pack, though, which probably 
persists when using git-daemon as server: If interrupted, it does not kill 
the remote git-rev-list and git-pack-objects. I can bring down my poor 
server pretty easily by issuing "git pull", interrupting that, 
and repeating that several times. Not sure how to fix that.
