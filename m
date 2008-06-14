From: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
Subject: Re: Document clone of clone ... bug??
Date: Sat, 14 Jun 2008 22:48:40 +0200 (CEST)
Message-ID: <20080614.224840.41641579.hanzl@noel.feld.cvut.cz>
References: <20080614143117.GA8640@sigill.intra.peff.net>
	<20080614.221511.74741328.hanzl@noel.feld.cvut.cz>
	<m3skvfpxgp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org
To: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 14 22:54:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7clu-0001SJ-7L
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 22:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbYFNUxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 16:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbYFNUxz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 16:53:55 -0400
Received: from magi4.feld.cvut.cz ([147.32.198.214]:49395 "EHLO mepi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754548AbYFNUxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 16:53:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mepi (Postfix) with ESMTP id 34F36FD806;
	Sat, 14 Jun 2008 22:48:40 +0200 (CEST)
In-Reply-To: <m3skvfpxgp.fsf@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85042>

> _Local_ clone?  This is result of optimization; in cloning over local
> filesystem case git-clone simply hardlinks object database (if
> possible) instead of transferring objects.  This was only on request
> in earlier versions of git.
>
> You can use filr:// protocol to force generating of pack-file and
> actual transfer of objects.


Still dangling even with 'file:', using (in my case) this:

 pwd
 rm -rf A B C
 mkdir A B C
 (cd A; mkdir X; cd X; git init; echo x>x; git add x; git commit -m xxx;
  git checkout -b y; echo y>y; git add y; git commit -m yyy;
  git checkout master)
 (cd B; git clone file:///home/kroupa/tmp/gittest/A/X; cd X; git branch -a)
 (cd C; git clone file:///home/kroupa/tmp/gittest/B/X; cd X; git branch -a; git fsck --full)


The actual result of pasting this to shell is:

~/tmp/gittest>pwd
/home/kroupa/tmp/gittest
~/tmp/gittest>rm -rf A B C
~/tmp/gittest>mkdir A B C
~/tmp/gittest>(cd A; mkdir X; cd X; git init; echo x>x; git add x; git commit -m xxx;
>  git checkout -b y; echo y>y; git add y; git commit -m yyy;
>  git checkout master)
Initialized empty Git repository in .git/
Created initial commit ec59a7e: xxx
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 x
Switched to a new branch "y"
Created commit 2be193d: yyy
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 y
Switched to branch "master"
~/tmp/gittest>(cd B; git clone file:///home/kroupa/tmp/gittest/A/X; cd X; git branch -a)
Initialized empty Git repository in /home/kroupa/tmp/gittest/B/X/.git/
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 6 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (6/6), done.
* master
  origin/HEAD
  origin/master
  origin/y
~/tmp/gittest>(cd C; git clone file:///home/kroupa/tmp/gittest/B/X; cd X; git branch -a; git fsck --full)
Initialized empty Git repository in /home/kroupa/tmp/gittest/C/X/.git/
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 6 (delta 0), reused 6 (delta 0)
Receiving objects: 100% (6/6), done.
* master
  origin/HEAD
  origin/master
dangling commit 2be193dc7dc3e1051dcf5af9d03f7587b61f9fc3


And the dangling object is:


~/tmp/gittest>cd C/X; git show 2be193d
commit 2be193dc7dc3e1051dcf5af9d03f7587b61f9fc3
Author: kroupa <kroupa@noli.localdomain>
Date:   Sat Jun 14 22:47:46 2008 +0200

    yyy

diff --git a/y b/y
new file mode 100644
index 0000000..975fbec
--- /dev/null
+++ b/y
@@ -0,0 +1 @@
+y



Any thoughts?

Vaclav
