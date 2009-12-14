From: Eric Paris <eparis@redhat.com>
Subject: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 15:28:04 -0500
Message-ID: <1260822484.9379.53.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 21:28:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKHWs-0001J0-F5
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 21:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758264AbZLNU2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 15:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758263AbZLNU2I
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 15:28:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758236AbZLNU2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 15:28:05 -0500
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBEKS5c6012554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Mon, 14 Dec 2009 15:28:05 -0500
Received: from [10.11.9.84] (vpn-9-84.rdu.redhat.com [10.11.9.84])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBEKS4uQ017010
	for <git@vger.kernel.org>; Mon, 14 Dec 2009 15:28:04 -0500
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135233>

So I have no idea what is interesting or relevant what I can collect,
what you want to know or anything like that, so this is a bit of a dump
of info and I'm sorry to whoever tries to pick anything useful out of
it.  Somone who understands git might glean some interesting information
(or tell me what a fool I am)  I'm going to lay out my whole working
process here and maybe people will even point out how to improve what I
do....

git-1.5.5.6-4.el5 (git in extras for RHEL5)

I have about 5 local trees that way I can work on different things
without having to rebuild quite a much especially as I go back and
change history so often with stgit.  Each local tree has a .git/config
file that has about 5 different kernel trees set up as remotes.  They
look something like this.

[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[remote "linus"]
	url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	fetch = +refs/heads/master:refs/remotes/linus/master
[remote "linux-next"]
	url = git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
	fetch = +refs/heads/*:refs/remotes/linux-next/*
{snipped}

Each of these trees also has a .git/objects/info/alternatives file which
looks like so (am I using alternatives right?)

/export/kernel/kernel-1/.git/objects
/storage/kernel/kernel-1/.git/objects

On this particular machine (a very beefy dual quad core
Nehalem) /storage is a bind mount of /export.  On other machines I will
mount these using NFS in which case /export doesn't exist and /storage
is the mount point.  Typically (but not always) the only thing I do over
the NFS mount point is 'make install'.  

In this particular tree I use stgit and on a daily basis will update my
remotes and rebase my stgit patch series on top of linux-next.  I don't
know the details of the git commands going on under the covers, I just
do git remote update; stg rebase remotes/linux-next/master;  I don't
know if that's relevant, but it might leave me lots of crap in the tree?

Today I decided to make a clean branch to ask Linus to pull.  I exported
a patch series (about 80 patches) to an mbox file from one of my other 5
trees and I did the following

git remote update 
git checkout -b working remotes/linus/master
git-am -3 -k mbox.file

all 80 or so patches in the mbox file applied and then I got

Auto packing your repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.

I waited for a while, but it still hasn't come back.

#ps -ef | grep git
paris    24134 22057  0 14:09 pts/12   00:00:00 /bin/sh /usr/bin/git-am -3 -k /tmp/fanotify.mbox
paris    25638 24134  0 14:09 pts/12   00:00:00 git gc --auto
paris    25640 25638 99 14:09 pts/12   00:58:07 git-reflog expire --all

#top
25640 paris     25   0  920m 211m 149m R 99.8  2.1  69:09.55 git-reflog

#ls -ld /proc/pid/cwd
lrwxrwxrwx 1 paris paris 0 Dec 14 15:02 /proc/25640/cwd -> /storage/kernel/kernel-2

#strace -p -T -ttt
1260821793.751746 stat(".git/objects/b2/ad3c1470e751c53bf7a4d3d53514e0debab1fc", {st_mode=S_IFREG|0444, st_size=291, ...}) = 0 <0.000043>
1260821793.751917 open(".git/objects/b2/ad3c1470e751c53bf7a4d3d53514e0debab1fc", O_RDONLY|O_NOATIME) = 40 <0.000041>
1260821793.752032 mmap(NULL, 291, PROT_READ, MAP_PRIVATE, 40, 0) = 0x2b4d6a90e000 <0.000041>
1260821793.752148 close(40)             = 0 <0.000026>
1260821793.752286 munmap(0x2b4d6a90e000, 291) = 0 <0.000035>
1260821793.752538 stat(".git/objects/85/7d99d3a4f9780402fbff3d59b6b3de8d614cc7", {st_mode=S_IFREG|0444, st_size=330, ...}) = 0 <0.000138>
1260821793.752743 open(".git/objects/85/7d99d3a4f9780402fbff3d59b6b3de8d614cc7", O_RDONLY|O_NOATIME) = 40 <0.000027>
1260821793.752942 mmap(NULL, 330, PROT_READ, MAP_PRIVATE, 40, 0) = 0x2b4d6a90e000 <0.000024>
1260821793.753018 close(40)             = 0 <0.000038>
1260821793.753289 munmap(0x2b4d6a90e000, 330) = 0 <0.000040>
1260821796.796243 stat(".git/objects/85/7d99d3a4f9780402fbff3d59b6b3de8d614cc7", {st_mode=S_IFREG|0444, st_size=330, ...}) = 0 <0.000076>
1260821796.796440 open(".git/objects/85/7d99d3a4f9780402fbff3d59b6b3de8d614cc7", O_RDONLY|O_NOATIME) = 40 <0.000036>
1260821796.796553 mmap(NULL, 330, PROT_READ, MAP_PRIVATE, 40, 0) = 0x2b4d6a90e000 <0.000031>
1260821796.796624 close(40)             = 0 <0.000017>
1260821796.796828 munmap(0x2b4d6a90e000, 330) = 0 <0.000042>
1260821796.797124 stat(".git/objects/40/c92d2149426ea7fd8c70bf7c7727af15eed75d", {st_mode=S_IFREG|0444, st_size=293, ...}) = 0 <0.008584>
1260821796.805844 open(".git/objects/40/c92d2149426ea7fd8c70bf7c7727af15eed75d", O_RDONLY|O_NOATIME) = 40 <0.000114>
1260821796.806062 mmap(NULL, 293, PROT_READ, MAP_PRIVATE, 40, 0) = 0x2b4d6a90e000 <0.000041>
1260821796.806144 close(40)             = 0 <0.000018>
1260821796.806341 munmap(0x2b4d6a90e000, 293) = 0 <0.000023>
1260821799.863480 stat(".git/objects/40/c92d2149426ea7fd8c70bf7c7727af15eed75d", {st_mode=S_IFREG|0444, st_size=293, ...}) = 0 <0.000118>
1260821799.863737 open(".git/objects/40/c92d2149426ea7fd8c70bf7c7727af15eed75d", O_RDONLY|O_NOATIME) = 40 <0.000042>
1260821799.863855 mmap(NULL, 293, PROT_READ, MAP_PRIVATE, 40, 0) = 0x2b4d6a90e000 <0.000075>
1260821799.863973 close(40)             = 0 <0.000021>
1260821799.864101 munmap(0x2b4d6a90e000, 293) = 0 <0.000033>
1260821799.864306 stat(".git/objects/43/77e6fe8ac62e7b3a1b65a83665f172550440b6", {st_mode=S_IFREG|0444, st_size=272, ...}) = 0 <0.000177>
1260821799.864551 open(".git/objects/43/77e6fe8ac62e7b3a1b65a83665f172550440b6", O_RDONLY|O_NOATIME) = 40 <0.000025>
1260821799.864635 mmap(NULL, 272, PROT_READ, MAP_PRIVATE, 40, 0) = 0x2b4d6a90e000 <0.000041>
1260821799.864729 close(40)             = 0 <0.000058>
1260821799.865064 munmap(0x2b4d6a90e000, 272) = 0 <0.000031>

First things I notice in the strace is that git is opening the same
objects multiple times, and there are seconds between the munmap of the
last object and the second stat of that same object....

What can I collect, do, whatever?

-Eric
