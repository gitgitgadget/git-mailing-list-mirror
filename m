From: Yann Dirson <dirson@bertin.fr>
Subject: [BUG] Cannot push some grafted branches
Date: Tue, 11 Dec 2012 15:39:03 +0100
Organization: Bertin Technologies
Message-ID: <20121211153903.7522d6b0@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:00:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiRKA-00078R-Hn
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 16:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab2LKPA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2012 10:00:29 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:49412 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab2LKPA2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2012 10:00:28 -0500
X-Greylist: delayed 1283 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2012 10:00:28 EST
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 256E9A0F7F
	for <git@vger.kernel.org>; Tue, 11 Dec 2012 15:39:02 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id F3EE3A0F76
	for <git@vger.kernel.org>; Tue, 11 Dec 2012 15:39:01 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MEV00DE5FD1D2B0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 11 Dec 2012 15:39:01 +0100 (CET)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19438.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211289>

There seems to be some bad interactions between git-push and grafts.
The problem seems to occur when a commit that exists in the remote
repo is subject to a graft in the local repo, and we try to push one
of the fake parents.

The problem was first seen on 1.7.12.3 in a private repo, and I could
reproduce it using 1.8.1.rc0, as shown below.  1.7.10.4 seems even
more affected, with something looking like a memory corruption issue.

Here is the test:

$ git clone git.git git-test
Cloning into 'git-test'...
done.
Checking out files: 100% (2518/2518), done.
$ cd git-test/
git-test$ git co maint
Branch maint set up to track remote branch maint from origin.
Switched to a new branch 'maint'
git-test$ echo >> README=20
git-test$ git commit -a -m "test"
[maint 0708279] test
 1 file changed, 1 insertion(+)
git-test$ echo $(git rev-parse origin/master; git rev-parse origin/mast=
er^; git rev-parse HEAD) > .git/info/grafts

git-test$ git version
git version 1.8.1.rc0
git-test$ git push origin maint
Total 0 (delta 0), reused 0 (delta 0)
fatal: bad object 0708279e168b52003234dd23601796b3b12e278b
fatal: bad object 0708279e168b52003234dd23601796b3b12e278b
To /home/localadm/softs/git.git
 ! [remote rejected] maint -> maint (missing necessary objects)
error: failed to push some refs to '/home/localadm/softs/git.git'


$ git version
git version 1.7.10.4

git-test$ git push origin maint
Total 0 (delta 0), reused 0 (delta 0)
fatal: bad object 0708279e168b52003234dd23601796b3b12e278b
fatal: bad object 0708279e168b52003234dd23601796b3b12e278b
Auto packing the repository for optimum performance.
fatal: protocol error: bad line length character: Remo
error: error in sideband demultiplexer
error: =E0=AB=8F        >S=EF=BF=BD=EF=BF=BD=C5=8BJ=EF=BF=BDjB=EF=BF=BD=
;=EF=BF=BDx'=EF=BF=BD=EF=BF=BDR died of signal 13
To /home/localadm/softs/git.git
 ! [remote rejected] maint -> maint (missing necessary objects)
error: failed to push some refs to '/home/localadm/softs/git.git'

--=20
Yann Dirson - Bertin Technologies
