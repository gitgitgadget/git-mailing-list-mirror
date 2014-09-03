From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [BUG] Hang when I did something a bit weird with submodules
Date: Wed, 3 Sep 2014 14:26:21 +1200
Message-ID: <CAFOYHZAAc1ajsqNa8QXwJ=6naB4q9kD86u1dzD420p3sijvtYQ@mail.gmail.com>
References: <CAFOYHZAHWu5Vd5-J7mmEXMmMKMwT_ahbR=wS7kif5wOzzUkc3g@mail.gmail.com>
	<CAFOYHZCX5XDQLLP+YfLnFyELip1Df0uFTHkbmujV3W5NHO-XHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 03 04:26:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP0HD-00053Q-01
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 04:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbaICC0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 22:26:23 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33202 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbaICC0W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 22:26:22 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so10077051pdj.3
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 19:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=4Ry8g7u6yUJ3IxE0JatfCBbWyZ/73HA2/AChSnHsOWc=;
        b=KK6jhI5QRB8jJcFnSVlnn9+C17pHlYoFkutE1SHPzi/uuvfIHNFbaij0LC4eGorBD6
         ZEkdnr0K2iMK79UPhuHAhWtRhsFmx05dj3/k7f10qBpSgvjG3fy7ZGjLrf3tlsWkdUzV
         iaQXn08jPCt9PILpZfBaB4zM2sqxMEeIOLmhpUeqxEG1mJLCuKDl2DWMYFKNwVarSoEw
         5RUW/dLWddxuiBJPVy2eAw3cWHEjIfhhIAQBpdNVVqgoh9LaHAskhhLBxFp1ScQVys6E
         fTBYIpB7NYnEBAS8g04Vms+daKVEvucVyuKKXnmY2vXABarKIgd/djxUyV/tbTw5TMyK
         mbeQ==
X-Received: by 10.70.35.207 with SMTP id k15mr48197010pdj.5.1409711181728;
 Tue, 02 Sep 2014 19:26:21 -0700 (PDT)
Received: by 10.70.36.6 with HTTP; Tue, 2 Sep 2014 19:26:21 -0700 (PDT)
In-Reply-To: <CAFOYHZCX5XDQLLP+YfLnFyELip1Df0uFTHkbmujV3W5NHO-XHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256375>

On Tue, Aug 19, 2014 at 4:35 PM, Chris Packham <judge.packham@gmail.com> wrote:
> On Tue, Aug 19, 2014 at 4:33 PM, Chris Packham <judge.packham@gmail.com> wrote:
>> Hi,
>>
>> I was just setting up a new project using submodules and have run into
>> what appears to be a hang when git status is invoked. I haven't tried
>> to reproduce this but this is basically what I did (edited highlights
>> from my bash_history).
>>
>>  $ git --version
>>  git version 2.0.3
>>  $ mkdir proj
>>  $ cd proj
>>  $ git init
>>  $ git submodule add <internal-repo-with-build-scripts> build
>>  $ git submodule add --reference ~/src/linux/.git
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux
>>  # I'm not sure if the --reference is relevant but I was just wanting
>> to cut down on my network transfer
>>  $ git submodule add <internal-repo-with-skeleton-fs> rootfs
>>
>> Oops I really wanted linux-stable to get the same version my board
>> vendor is using
>>
>>  $ vim .gitmodules
>>  # change to linux-stable
>>  $ git submodule sync
>>
>> I'm not sure if this is a valid use-case but nothing complained that I
>> was changing the URL. In theory linux-stable should be a super-set of
>> linus' tree so the repositories are basically equivalent.
>>
>>  $ cd linux/
>>  $ git remote show origin
>>  * remote origin
>>    Fetch URL: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>>  # Seems to have done the trick
>>  $ git reset --hard v3.4.69
>>
>> I suspect this is where the problem starts. When I did the git
>> submodule add it was pointing at the tip of linus' tree. Now I have
>> rewound considerably.
>>
>>  $ git status
>>  [hang]
>>
>> For what it's worth here's the output when I run with GIT_TRACE=1 git status
>>
>> trace: built-in: git 'status'
>> trace: run_command: 'status' '--porcelain'
>> trace: exec: 'git' 'status' '--porcelain'
>> trace: built-in: git 'status' '--porcelain'
>> trace: run_command: 'status' '--porcelain'
>> trace: exec: 'git' 'status' '--porcelain'
>> trace: built-in: git 'status' '--porcelain'
>> trace: run_command: 'status' '--porcelain'
>> trace: exec: 'git' 'status' '--porcelain'
>> trace: built-in: git 'status' '--porcelain'
>> On branch master
>>
>> Initial commit
>>
>> Changes to be committed:
>>   (use "git rm --cached <file>..." to unstage)
>>
>>         new file:   .gitmodules
>>         new file:   rootfs
>>         new file:   build
>>         new file:   linux
>>
>> Changes not staged for commit:
>>   (use "git add <file>..." to update what will be committed)
>>   (use "git checkout -- <file>..." to discard changes in working directory)
>>
>>         modified:   .gitmodules
>>         modified:   linux (new commits)
>>
>> trace: run_command: 'submodule' 'summary' '--cached' '--for-status'
>> '--summary-limit' '-1' 'HEAD'
>> trace: exec: 'git' 'submodule' 'summary' '--cached' '--for-status'
>> '--summary-limit' '-1' 'HEAD'
>> trace: exec: 'git-submodule' 'summary' '--cached' '--for-status'
>> '--summary-limit' '-1' 'HEAD'
>> trace: run_command: 'git-submodule' 'summary' '--cached'
>> '--for-status' '--summary-limit' '-1' 'HEAD'
>> trace: built-in: git 'rev-parse' '--git-dir'
>> trace: built-in: git 'rev-parse' '-q' '--git-dir'
>> trace: built-in: git 'rev-parse' '--show-prefix'
>> trace: built-in: git 'rev-parse' '--show-toplevel'
>> trace: built-in: git 'rev-parse' '-q' '--verify' '--default' 'HEAD' 'HEAD'
>> trace: built-in: git 'hash-object' '-w' '-t' 'tree' '--stdin'
>> trace: built-in: git 'rev-parse' '--show-toplevel'
>> trace: built-in: git 'rev-parse' '--sq' '--prefix' '' '--'
>> trace: built-in: git 'diff-index' '--cached'
>> '--ignore-submodules=dirty' '--raw'
>> '4b825dc642cb6eb9a060e54bf8d69288fbee4904' '--'
>> trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp'
>> '^submodule\..*\.path$'
>> trace: built-in: git 'config' 'submodule.rootfs.ignore'
>> trace: built-in: git 'config' '-f' '.gitmodules' 'submodule.rootfs.ignore'
>> trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp'
>> '^submodule\..*\.path$'
>> trace: built-in: git 'config' 'submodule.build.ignore'
>> trace: built-in: git 'config' '-f' '.gitmodules' 'submodule.build.ignore'
>> trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp'
>> '^submodule\..*\.path$'
>> trace: built-in: git 'config' 'submodule.linux.ignore'
>> trace: built-in: git 'config' '-f' '.gitmodules' 'submodule.linux.ignore'
>> trace: built-in: git 'diff-index' '--cached'
>> '--ignore-submodules=dirty' '--raw'
>> '4b825dc642cb6eb9a060e54bf8d69288fbee4904' '--' 'rootfs' 'build'
>> 'linux'
>> trace: built-in: git 'rev-parse' '-q' '--verify'
>> 'e4bbdf3b45828a2e9ca37ef329b8e708e324dfb1^0'
>> trace: built-in: git 'rev-list' '--first-parent'
>> 'e4bbdf3b45828a2e9ca37ef329b8e708e324dfb1' '--'
>> trace: built-in: git 'log' '--pretty=format:  > %s' '-1'
>> 'e4bbdf3b45828a2e9ca37ef329b8e708e324dfb1'
>> trace: built-in: git 'rev-parse' '-q' '--verify'
>> '9f2d1659df78ea51eaa9ad5e7af9271996ac2a4c^0'
>> trace: built-in: git 'rev-list' '--first-parent'
>> '9f2d1659df78ea51eaa9ad5e7af9271996ac2a4c' '--'
>> trace: built-in: git 'log' '--pretty=format:  > %s' '-1'
>> '9f2d1659df78ea51eaa9ad5e7af9271996ac2a4c'
>> trace: built-in: git 'rev-parse' '-q' '--verify'
>> '7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9^0'
>> trace: built-in: git 'rev-list' '--first-parent'
>> '7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9' '--'
>> trace: built-in: git 'log' '--pretty=format:  > %s' '-1'
>> '7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9'
>> Submodule changes to be committed:
>>
>> * rootfs 0000000...e4bbdf3 (249):
>>   > Merge remote-tracking branch 'tomahawk/delivery_545_icmp'
>>
>> * build 0000000...9f2d165 (771):
>>   > Merge remote-tracking branch 'plusplus/3rdparty'
>>
>> * linux 0000000...7d1311b (46122):
>>   > Linux 3.17-rc1
>>
>> trace: run_command: 'submodule' 'summary' '--files' '--for-status'
>> '--summary-limit' '-1'
>> trace: exec: 'git' 'submodule' 'summary' '--files' '--for-status'
>> '--summary-limit' '-1'
>> trace: exec: 'git-submodule' 'summary' '--files' '--for-status'
>> '--summary-limit' '-1'
>> trace: run_command: 'git-submodule' 'summary' '--files' '--for-status'
>> '--summary-limit' '-1'
>> trace: built-in: git 'rev-parse' '--git-dir'
>> trace: built-in: git 'rev-parse' '-q' '--git-dir'
>> trace: built-in: git 'rev-parse' '--show-prefix'
>> trace: built-in: git 'rev-parse' '--show-toplevel'
>> trace: built-in: git 'rev-parse' '-q' '--verify' '--default' 'HEAD'
>> trace: built-in: git 'hash-object' '-w' '-t' 'tree' '--stdin'
>> trace: built-in: git 'rev-parse' '--show-toplevel'
>> trace: built-in: git 'rev-parse' '--sq' '--prefix' '' '--'
>> trace: built-in: git 'diff-files' '--ignore-submodules=dirty' '--raw' '--'
>> trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp'
>> '^submodule\..*\.path$'
>> trace: built-in: git 'config' 'submodule.linux.ignore'
>> trace: built-in: git 'config' '-f' '.gitmodules' 'submodule.linux.ignore'
>> trace: built-in: git 'diff-files' '--ignore-submodules=dirty' '--raw'
>> '--' 'linux'
>> trace: built-in: git 'rev-parse' 'HEAD'
>> trace: built-in: git 'rev-parse' '-q' '--verify'
>> '7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9^0'
>> trace: built-in: git 'rev-parse' '-q' '--verify'
>> '14aa272fcd1cdbe7173073250c767bc7a37278ce^0'
>> trace: built-in: git 'rev-list' '--first-parent'
>> '7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9...14aa272fcd1cdbe7173073250c767bc7a37278ce'
>> '--'
>> trace: built-in: git 'log' '--pretty=format:  %m %s' '--first-parent'
>> '7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9...14aa272fcd1cdbe7173073250c767bc7a37278ce'
>> ^C
>
> Update: I've managed to restore normal operation with 'git add -u' in
> the super project. Which gets me back to a working state.


OK I've got a (relatively) simple way of reproducing this.

  git --version
  git version 2.0.3

  mkdir temp
  cd temp/
  git init
  git submodule add git://git.denx.de/u-boot.git u-boot
  cd u-boot/
  git reset --hard v2013.01
  cd ../
  git status
  <hang>

It seems to depend on how far I go back. I tried v2014.07 (~600
commits), v2014.01 (~2500 commits) and v2013.10 (~3600 commits). It
wasn't until I went to v2013.07 (~4300 commits) that I struck the
hang.

Doing some further digging If I reset to commit
25634210af785e36cf73a5e9a103c8cac5d84a26 there is no hang. But if I
reset to commit 012a2c15d781d327c9de8734f2b2b3f793a58724 there is a
hang. These 2 commits are adjacent and as far as I can tell there's
nothing special about them (they're just normal commits, not merges).
