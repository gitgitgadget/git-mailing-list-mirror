From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Slow git pushes: sitting 1 minute in pack-objects
Date: Thu, 5 Mar 2015 16:03:07 -0500
Message-ID: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 22:03:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTcvJ-0003wt-Km
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 22:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbbCEVDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 16:03:10 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:46445 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbCEVDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 16:03:08 -0500
Received: by wggy19 with SMTP id y19so55966582wgg.13
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 13:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Pz3dYORMWzGP/kBtHJ5Lh8uvNp07g+7C84TzQFMffxQ=;
        b=ArEEvmZhfeNhqiUAmYg9dupEJT8I4MZmZ2Nz1lemYYzBVThPVXsk/uhHm8iw8lECKR
         CRtoP0ZHZsfqj4vTscp3kQWRxpH8/M46kTKRgJEslbVvwqGYKU1fKM6N1N66qRoE5M4E
         3eBXIpA2vwyRQ/KH5V7ssBg0Y8hXo1fEw7xGBWzGtciYPK5CLPASS3Gs4JGu3v6rGfeM
         w8dRXXfTNicYkK0NBN0bjWlWqbcq9hqwoZwcRbm4K8EI3MM/mU9Im7SbljlUrQuSzzvz
         SwIwdmXIWstP5tosH4XKBwgLi3TkZH2+so3xXRHS71uvVdSIfUyzfDQ81T5HGubgAOvL
         4O6A==
X-Received: by 10.194.236.200 with SMTP id uw8mr21969122wjc.10.1425589387058;
 Thu, 05 Mar 2015 13:03:07 -0800 (PST)
Received: by 10.194.159.98 with HTTP; Thu, 5 Mar 2015 13:03:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264867>

(Apologies, after a day I'm cross-posting from git.users. I think the question
is maybe too technical for that group.)

I'm experiencing very slow git pushes. On the order of 1 minute to push a
trivial one-line change. When I set GIT_TRACE=1, I see that it seems to be
taking a lot of time in the pack-objects phase.

Others are not seeing this with the same repo, but I'm the only one working
in a VM.

```
~/ws/git/repo.1/repo > date; git push mortons; date
Wed Mar  4 15:03:11 EST 2015
15:03:11.086758 git.c:349               trace: built-in: git 'push' 'mortons'
15:03:11.126665 run-command.c:341       trace: run_command: 'ssh' '-p'
'7999' 'git@privacy.privacy' 'git-receive-pack
'\''~mortons/repo.git'\'''
15:03:20.383341 run-command.c:341       trace: run_command:
'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress'
15:03:20.383945 exec_cmd.c:134          trace: exec: 'git'
'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress'
15:03:20.385168 git.c:349               trace: built-in: git
'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress'
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 20.86 KiB | 0 bytes/s, done.
Total 4 (delta 0), reused 0 (delta 0)
To ssh://git@privacy.privacy:7999/~mortons/repo.git
   5fe662f..a137bda  my_branch -> my_branch
Wed Mar  4 15:04:22 EST 2015

```

After it was slow at first, I tried setting these which did not help

repack.writebitmaps=true
pack.windowmemory=100m



Details:
git version 2.1.4
OS: CentOS 6.6 64-bit in a VM.
repo size: huge. 6 GB .git directory, around 800 MB working tree.
VM has 8 MB RAM and 8 cores.
CPU: i7, 8 core (4 cores hyperthreaded)

It is an ext4 filesystem on the guest linux drive.
    On the host side, it is a .vmdk file and the virtualization software used is
virtualbox. While the drive is dynamically allocated, after I ran into
this issue,
    I used fallocate to create a 50GB dummy file and then delete it to
ensure that
there was headroom in the drive and that dynamic allocation slowness was not the
issue, and subsequent pushes were still slow.
    I have not experienced any filesystem slowness issues in the
months I've been using this vm.


Any ideas? I'm evaluating a move to git and this is the kind of thing
that could derail it.
Thanks,

Stephen
