From: Tomas Pospisek <tpo_deb@sourcepole.ch>
Subject: Bug? file at the same time being deleted and not registered
Date: Sun, 23 May 2010 23:09:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1005232245220.18372@tpo-laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1893121892-1274648993=:18372"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 23 23:51:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGJ4u-0000Fa-27
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 23:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab0EWVvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 17:51:19 -0400
Received: from pizol.sourcepole.ch ([80.74.153.203]:55884 "EHLO
	pizol.sourcepole.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab0EWVvS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 17:51:18 -0400
X-Greylist: delayed 2468 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 May 2010 17:51:18 EDT
Received: from cable-dynamic-87-245-106-94.shinternet.ch ([87.245.106.94] helo=localhost)
	by mail.sp-metanet with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <tpo_hp@sourcepole.ch>)
	id 1OGIQp-0006Uf-IY
	for git@vger.kernel.org; Sun, 23 May 2010 23:10:06 +0200
X-X-Sender: tpo@tpo-laptop
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-SA-Score: -3.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147595>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1893121892-1274648993=:18372
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

(I'm not subscribed, so please in case do Cc: me)

Short version:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  $ # we're on a mhddfs backed filesystem here, that doesn't support hardli=
nks
  $ mkdir bar
  $ cd bar/
  $ git init
  Initialized empty Git repository in /mnt/mhddfs/tmp/bar/.git/

  $ touch a_file
  $ git add a_file
  $ git commit a_file -m bla
  [master (root-commit) ca0ce50] bla
   0 files changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 a_file

  $ git status
  # On branch master
  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unstage)
  #
  #       deleted:    a_file
  #
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #       a_file

So we have a file that was committed, that git thinks it's scheduled to be
deleted and at the same time is untracked. Doesn't make any sense, does=20
it?

This happens only on the mhddfs backed filesystem. The same procedure=20
works well in /tmp or on plain ext3.

Here's the strace of the commit step (from a identical try):

    http://pastebin.com/htUmWYGh

Jan 'jast' Kr=FCger from the git IRC channel spotted in that strace the fac=
t=20
that the 'link' call is failing.

In that case IMHO git should complain and let the user know, that=20
something went wrong and it can't proceed meaningfully.


Long version:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  $ mkdir bar
  $ cd bar/
  $ ls -la
  total 8
  drwxr-xr-x 2 foo foo 4096 2010-05-23 22:51 .
  drwxr-xr-x 2 tpo tpo 4096 2010-05-13 19:27 ..

  $ git init
  Initialized empty Git repository in /mnt/mhddfs/tmp/bar/.git/

  $ git status
  # On branch master
  #
  # Initial commit
  #
  nothing to commit (create/copy files and use "git add" to track)

  $ touch a_file
  $ git status
  # On branch master
  #
  # Initial commit
  #
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #       a_file
  nothing added to commit but untracked files present (use "git add" to
  track)

  $ git add a_file
  $ git status
  # On branch master
  #
  # Initial commit
  #
  # Changes to be committed:
  #   (use "git rm --cached <file>..." to unstage)
  #
  #       new file:   a_file
  #

  $ git commit a_file -m bla
  [master (root-commit) ca0ce50] bla
   0 files changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 a_file

  $ git status
  # On branch master
  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unstage)
  #
  #       deleted:    a_file
  #
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #       a_file

--8323329-1893121892-1274648993=:18372--
