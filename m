From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [BUG] Submodules problem with subdirectories and pushing
Date: Thu, 13 Aug 2009 12:32:31 +0200
Message-ID: <20090813103231.GY14475@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 13:00:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbY2s-00073b-Mr
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 13:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbZHMLAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 07:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbZHMLAB
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 07:00:01 -0400
Received: from pauli.djpig.de ([78.46.38.139]:54394 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485AbZHMLAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 07:00:00 -0400
X-Greylist: delayed 1638 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2009 07:00:00 EDT
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 227EC9007F
	for <git@vger.kernel.org>; Thu, 13 Aug 2009 12:32:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RwREJrMQV9uC for <git@vger.kernel.org>;
	Thu, 13 Aug 2009 12:32:32 +0200 (CEST)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 894ED9007D
	for <git@vger.kernel.org>; Thu, 13 Aug 2009 12:32:32 +0200 (CEST)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.69)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1MbXbk-00011B-0k
	for git@vger.kernel.org; Thu, 13 Aug 2009 12:32:32 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125801>

Hi.

I have a git repository where I include several submodules. This seemed to
work fine until the server I push to got (finally) updated from 1.5.something
to 1.6.4. Now I get an error if I try to push.

The issue is easily reproducible with a minimal repository for me:

Creating an empty repository on server:

flichtenheld@git-test:~$ git version
git version 1.6.4    <---- Directly compiled from git
flichtenheld@git-test:~$ mkdir test.git
flichtenheld@git-test:~$ cd test.git/
flichtenheld@git-test:~/test.git$ git init --bare
Initialized empty Git repository in /home/flichtenheld/test.git/

Creating repository on client:

frl@dhcp-rnd-054:~/tmp$ git version
git version 1.6.3.3   <--- From Debian Package
frl@dhcp-rnd-054:~/tmp$ mkdir test
frl@dhcp-rnd-054:~/tmp$ cd test/
frl@dhcp-rnd-054:~/tmp/test$ git init
Initialized empty Git repository in /home/frl/tmp/test/.git/

Add a random submodule:

frl@dhcp-rnd-054:~/tmp/test$ git submodule add git://repo.or.cz/git-browser.git subdir/git-browser
Initialized empty Git repository in /home/frl/tmp/test/subdir/git-browser/.git/
remote: Counting objects: 131, done.
remote: Compressing objects: 100% (67/67), done.
remote: Total 131 (delta 63), reused 131 (delta 63)
Receiving objects: 100% (131/131), 105.98 KiB, done.
Resolving deltas: 100% (63/63), done.
frl@dhcp-rnd-054:~/tmp/test$ git commit -a
[master (root-commit) 388b975] Add submodule
 2 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 subdir/git-browser

Try to push:

frl@dhcp-rnd-054:~/tmp/test$ git remote add origin ssh://gitadm/home/flichtenheld/test.git
frl@dhcp-rnd-054:~/tmp/test$ git push origin master
Counting objects: 4, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (4/4), 372 bytes, done.
Total 4 (delta 0), reused 0 (delta 0)
fatal: Error on reachable objects of 9664402120f411181d05a2f51ee06a475fb73d9b
error: unpack-objects exited with error code 128
error: unpack failed: unpack-objects abnormal exit
To ssh://gitadm/home/flichtenheld/test.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'ssh://gitadm/home/flichtenheld/test.git'
frl@dhcp-rnd-054:~/tmp/test$ git show 9664402120f411181d05a2f51ee06a475fb73d9b
tree 9664402120f411181d05a2f51ee06a475fb73d9b

git-browser

All seems to work fine if I add the submodule as git-browser instead of as subdir/git-browser.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
