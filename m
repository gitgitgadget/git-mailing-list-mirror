From: s b <sberder@gmail.com>
Subject: [BUG] git-svn: error importing git repository in svn when first git
 commit was empty
Date: Thu, 11 Aug 2011 17:13:24 +0800
Message-ID: <CAAzBVjAjqr8hDFdMc2s6d=ZXttswSnLiig-aFKsZG5EJjAyAig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 11:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrRKo-00088P-89
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 11:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab1HKJNp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Aug 2011 05:13:45 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54363 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1HKJNo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2011 05:13:44 -0400
Received: by yxj19 with SMTP id 19so1178043yxj.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=1TF2XQ0L2Cif9+bnWXMbuK39OFG63IzN05P4XZoC25w=;
        b=sjPTf9CAvr4Z3/dRsI8Wx3dWC2SgdHQFdqFkaZ/BQDbQtGLqPB7LJ+4zURNGlvnivL
         FGF7JumrQgILDmTmjbqWM6btOWcWPymxQe4dl7Qd6CWkKZxrFuwaBySITlszFxqqMmpT
         e4QHT+tnRWzysXUJ3CoVtuQ5DVX4abR2cs188=
Received: by 10.150.48.38 with SMTP id v38mr376717ybv.317.1313054024084; Thu,
 11 Aug 2011 02:13:44 -0700 (PDT)
Received: by 10.151.99.15 with HTTP; Thu, 11 Aug 2011 02:13:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179093>

Couldn't find any bugtracker for git so I supposed it would be ok to
post the bug here.

# Situation:
I usually start my projects with git as it's quick and simple to track
modifications. If the code grows and is of any interest for my work I
push it to the corporate svn. I usually use this tutorial
(http://eikke.com/importing-a-git-tree-into-a-subversion-repository/)
which makes it a simple thing to do.
Some time ago I started having a first empty commit in my git
repository using 'git commit --allow-empty' as I read (can't remember
where) it could help for some cases. I don't have need for those edge
cases yet but remember thinking I could need them in the future.

# Problem:
When your first git commit is empty, git-svn fails with the following m=
essage :
$ git svn dcommit
Committing to https://svn/repo/trunk ...
No changes
71fb4051d840e27a43b87b071ccc7ea70bd0c5e8~1 =3D=3D
71fb4051d840e27a43b87b071ccc7ea70bd0c5e8
No changes between current HEAD and refs/remotes/trunk
Resetting to the latest refs/remotes/trunk
Unable to extract revision information  from commit
867ee195730507fb769e794eb4abe09d0e2e7c8f~1

At the same time, it also completely breaks the logs.

# How to reproduce: (the svn repository just has one commit for usual
trunk/branches/tags folders)
$ mkdir foobar
$ cd foobar/
$ git init
Initialized empty Git repository in /home/hr/tmp/foobar/.git/
$ git commit --allow-empty -m "Project init"
[master (root-commit) 0f1e71a] Project init
$ echo "foo" > test.txt; git add test.txt; git commit -m "Initial versi=
on"
[master 119fc0a] Initial version
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 test.txt
$ echo "bar" > test.txt; git commit test.txt -m "Second version"
[master 77b2681] Second version
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git svn init -s https://code/svn/foobar/
$ git svn fetch
r1 =3D 8bc83d5d63b4191509d29aa90e35e24edba393c1 (refs/remotes/trunk)
$ git log --pretty=3Doneline master
77b268140a03cbe98215ea160704ba14ce79e096 Second version
119fc0a55d1eb851fcedfe0bdc6de3c1ab047601 Initial version
0f1e71a283d7b4b27d23debaac091b654d495124 Project init
$ git show-ref trunk
8bc83d5d63b4191509d29aa90e35e24edba393c1 refs/remotes/trunk
$ echo "0f1e71a283d7b4b27d23debaac091b654d495124
8bc83d5d63b4191509d29aa90e35e24edba393c1" >> .git/info/grafts
$ git log --pretty=3Doneline
77b268140a03cbe98215ea160704ba14ce79e096 Second version
119fc0a55d1eb851fcedfe0bdc6de3c1ab047601 Initial version
0f1e71a283d7b4b27d23debaac091b654d495124 Project init
8bc83d5d63b4191509d29aa90e35e24edba393c1 * Init project, mkdir trunk br=
anches ta
$ git svn dcommit
Committing to https://code/svn/foobar/trunk ...
No changes
0f1e71a283d7b4b27d23debaac091b654d495124~1 =3D=3D
0f1e71a283d7b4b27d23debaac091b654d495124
No changes between current HEAD and refs/remotes/trunk
Resetting to the latest refs/remotes/trunk
Unable to extract revision information  from commit
119fc0a55d1eb851fcedfe0bdc6de3c1ab047601~1
$ git log
commit 8bc83d5d63b4191509d29aa90e35e24edba393c1
Author: root <root@e969a563-e91d-45ef-9946-abb13e32418c>
Date:   Thu Jul 7 06:40:59 2011 +0000

    * Init project, mkdir trunk branches tags.

    git-svn-id: https://code/svn/foobar/trunk@1 e969a563-e91d-45ef-9946=
-abb13e32

# Solution:
Not really a solution but instead of using the first commit for the
grafts, I use the second one (that is non empty).

Hope this can help getting a better git-svn!!

Stefan
--=20
Stefan Berder=A0 =A0 Mail: sberder#gmail.com
=A0/(bb|[^b]{2})/
