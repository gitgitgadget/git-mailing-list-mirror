From: Chris Packham <judge.packham@gmail.com>
Subject: [BUG] Hang when I did something a bit weird with submodules
Date: Tue, 19 Aug 2014 16:33:22 +1200
Message-ID: <CAFOYHZAHWu5Vd5-J7mmEXMmMKMwT_ahbR=wS7kif5wOzzUkc3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 19 06:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJb6y-0003tg-Lc
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 06:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbaHSEd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 00:33:28 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39692 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbaHSEd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 00:33:27 -0400
Received: by mail-pd0-f172.google.com with SMTP id y13so8734779pdi.31
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 21:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Jt6MMqGwy11zmfch/1N0PcFRVJkJnF8c6YKA9jgh2gs=;
        b=ROajq4ypb79K1knOCTwFdAXdBH75WnRyTyBUfBjDH9k2SmLQnnaUAEQXjyqigDyHcH
         YdGlc487NhifvYej5P40LtlB7xN6erUewjj4f0aMabXVGqiYXTewMG6FGH/wOV9vjiZE
         7ncg/oev5PvWCQMFm049vTHwd6f86CzhomzzQdKaFbD3NopHCgffrMwhXXKxD7UaXdmA
         iTs42Jlu7i4JEUOS+pDDFm0fHjG2fL1kmIqNFgdK2/5+mhJTxj1McB4Ym24Vmnn3LHKG
         1pAtSA+wUJ/bzC6sMpBphR9wHGF8ZMcMmak/5xsTgTJhYsovIKyBAESGX3T6p8srsKFb
         vjgw==
X-Received: by 10.66.165.34 with SMTP id yv2mr40891966pab.27.1408422802866;
 Mon, 18 Aug 2014 21:33:22 -0700 (PDT)
Received: by 10.70.98.140 with HTTP; Mon, 18 Aug 2014 21:33:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255438>

Hi,

I was just setting up a new project using submodules and have run into
what appears to be a hang when git status is invoked. I haven't tried
to reproduce this but this is basically what I did (edited highlights
from my bash_history).

 $ git --version
 git version 2.0.3
 $ mkdir proj
 $ cd proj
 $ git init
 $ git submodule add <internal-repo-with-build-scripts> build
 $ git submodule add --reference ~/src/linux/.git
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux
 # I'm not sure if the --reference is relevant but I was just wanting
to cut down on my network transfer
 $ git submodule add <internal-repo-with-skeleton-fs> rootfs

Oops I really wanted linux-stable to get the same version my board
vendor is using

 $ vim .gitmodules
 # change to linux-stable
 $ git submodule sync

I'm not sure if this is a valid use-case but nothing complained that I
was changing the URL. In theory linux-stable should be a super-set of
linus' tree so the repositories are basically equivalent.

 $ cd linux/
 $ git remote show origin
 * remote origin
   Fetch URL: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
 # Seems to have done the trick
 $ git reset --hard v3.4.69

I suspect this is where the problem starts. When I did the git
submodule add it was pointing at the tip of linus' tree. Now I have
rewound considerably.

 $ git status
 [hang]

For what it's worth here's the output when I run with GIT_TRACE=1 git status

trace: built-in: git 'status'
trace: run_command: 'status' '--porcelain'
trace: exec: 'git' 'status' '--porcelain'
trace: built-in: git 'status' '--porcelain'
trace: run_command: 'status' '--porcelain'
trace: exec: 'git' 'status' '--porcelain'
trace: built-in: git 'status' '--porcelain'
trace: run_command: 'status' '--porcelain'
trace: exec: 'git' 'status' '--porcelain'
trace: built-in: git 'status' '--porcelain'
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   .gitmodules
        new file:   rootfs
        new file:   build
        new file:   linux

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   .gitmodules
        modified:   linux (new commits)

trace: run_command: 'submodule' 'summary' '--cached' '--for-status'
'--summary-limit' '-1' 'HEAD'
trace: exec: 'git' 'submodule' 'summary' '--cached' '--for-status'
'--summary-limit' '-1' 'HEAD'
trace: exec: 'git-submodule' 'summary' '--cached' '--for-status'
'--summary-limit' '-1' 'HEAD'
trace: run_command: 'git-submodule' 'summary' '--cached'
'--for-status' '--summary-limit' '-1' 'HEAD'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '-q' '--git-dir'
trace: built-in: git 'rev-parse' '--show-prefix'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'rev-parse' '-q' '--verify' '--default' 'HEAD' 'HEAD'
trace: built-in: git 'hash-object' '-w' '-t' 'tree' '--stdin'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'rev-parse' '--sq' '--prefix' '' '--'
trace: built-in: git 'diff-index' '--cached'
'--ignore-submodules=dirty' '--raw'
'4b825dc642cb6eb9a060e54bf8d69288fbee4904' '--'
trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp'
'^submodule\..*\.path$'
trace: built-in: git 'config' 'submodule.rootfs.ignore'
trace: built-in: git 'config' '-f' '.gitmodules' 'submodule.rootfs.ignore'
trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp'
'^submodule\..*\.path$'
trace: built-in: git 'config' 'submodule.build.ignore'
trace: built-in: git 'config' '-f' '.gitmodules' 'submodule.build.ignore'
trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp'
'^submodule\..*\.path$'
trace: built-in: git 'config' 'submodule.linux.ignore'
trace: built-in: git 'config' '-f' '.gitmodules' 'submodule.linux.ignore'
trace: built-in: git 'diff-index' '--cached'
'--ignore-submodules=dirty' '--raw'
'4b825dc642cb6eb9a060e54bf8d69288fbee4904' '--' 'rootfs' 'build'
'linux'
trace: built-in: git 'rev-parse' '-q' '--verify'
'e4bbdf3b45828a2e9ca37ef329b8e708e324dfb1^0'
trace: built-in: git 'rev-list' '--first-parent'
'e4bbdf3b45828a2e9ca37ef329b8e708e324dfb1' '--'
trace: built-in: git 'log' '--pretty=format:  > %s' '-1'
'e4bbdf3b45828a2e9ca37ef329b8e708e324dfb1'
trace: built-in: git 'rev-parse' '-q' '--verify'
'9f2d1659df78ea51eaa9ad5e7af9271996ac2a4c^0'
trace: built-in: git 'rev-list' '--first-parent'
'9f2d1659df78ea51eaa9ad5e7af9271996ac2a4c' '--'
trace: built-in: git 'log' '--pretty=format:  > %s' '-1'
'9f2d1659df78ea51eaa9ad5e7af9271996ac2a4c'
trace: built-in: git 'rev-parse' '-q' '--verify'
'7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9^0'
trace: built-in: git 'rev-list' '--first-parent'
'7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9' '--'
trace: built-in: git 'log' '--pretty=format:  > %s' '-1'
'7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9'
Submodule changes to be committed:

* rootfs 0000000...e4bbdf3 (249):
  > Merge remote-tracking branch 'tomahawk/delivery_545_icmp'

* build 0000000...9f2d165 (771):
  > Merge remote-tracking branch 'plusplus/3rdparty'

* linux 0000000...7d1311b (46122):
  > Linux 3.17-rc1

trace: run_command: 'submodule' 'summary' '--files' '--for-status'
'--summary-limit' '-1'
trace: exec: 'git' 'submodule' 'summary' '--files' '--for-status'
'--summary-limit' '-1'
trace: exec: 'git-submodule' 'summary' '--files' '--for-status'
'--summary-limit' '-1'
trace: run_command: 'git-submodule' 'summary' '--files' '--for-status'
'--summary-limit' '-1'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '-q' '--git-dir'
trace: built-in: git 'rev-parse' '--show-prefix'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'rev-parse' '-q' '--verify' '--default' 'HEAD'
trace: built-in: git 'hash-object' '-w' '-t' 'tree' '--stdin'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'rev-parse' '--sq' '--prefix' '' '--'
trace: built-in: git 'diff-files' '--ignore-submodules=dirty' '--raw' '--'
trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp'
'^submodule\..*\.path$'
trace: built-in: git 'config' 'submodule.linux.ignore'
trace: built-in: git 'config' '-f' '.gitmodules' 'submodule.linux.ignore'
trace: built-in: git 'diff-files' '--ignore-submodules=dirty' '--raw'
'--' 'linux'
trace: built-in: git 'rev-parse' 'HEAD'
trace: built-in: git 'rev-parse' '-q' '--verify'
'7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9^0'
trace: built-in: git 'rev-parse' '-q' '--verify'
'14aa272fcd1cdbe7173073250c767bc7a37278ce^0'
trace: built-in: git 'rev-list' '--first-parent'
'7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9...14aa272fcd1cdbe7173073250c767bc7a37278ce'
'--'
trace: built-in: git 'log' '--pretty=format:  %m %s' '--first-parent'
'7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9...14aa272fcd1cdbe7173073250c767bc7a37278ce'
^C
