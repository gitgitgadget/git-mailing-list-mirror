From: Natanael Copa <natanael.copa@gmail.com>
Subject: possible bug in using local branches
Date: Tue, 09 Oct 2007 12:11:47 +0200
Message-ID: <1191924707.10822.94.camel@nc.nor.wtbts.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 12:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfC4K-0007u5-Jr
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 12:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbXJIKLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 06:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXJIKLy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 06:11:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:55575 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbXJIKLx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 06:11:53 -0400
Received: by ug-out-1314.google.com with SMTP id z38so63385ugc
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 03:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=xz4ZKVEwOMa5BttVGVfZd/8P1jGKouW8lAV40mR+0oU=;
        b=OYLdh43lkDyML2Pv+HfgU+GneS2eCxv1I7cif7jnIuUauy53tsMGl1Q8dBzcVhs1tQFthnli2XQcciCAxn4683+cH//bHU89zS/ewCmTvL6+FyQqX6SyO3CLfQbDpi6qQZXHIfbNKIOxf4lC8mW7svKg8/2nkEL22F9DrA1VD+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Gji9OOGnHzSmCyeXvF8MHffYFsneErr+m7OAP5gmLNv0X/lq7PH7Yd4h1S10uwReBreAGizOkbXe6ngc6XpGUpGIaNio2YLCX6ga5nQ/g7eS6Z0WUYHZ6yecyJxkPBCZ3ktcTKru4ZtPmQam4DJb0vmv26hIDJPCoipGli3KOxU=
Received: by 10.67.196.4 with SMTP id y4mr633821ugp.1191924711162;
        Tue, 09 Oct 2007 03:11:51 -0700 (PDT)
Received: from ?192.168.65.211? ( [213.234.126.134])
        by mx.google.com with ESMTPS id z40sm8934005ikz.2007.10.09.03.11.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 03:11:49 -0700 (PDT)
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60379>

Hi,

I think I might have found a bug in git, but I'm not sure if I am
misunderstanding the way local branches is supposed to work. I will
describe all teh steps I am doing. Please let me know if I'm doing
something wrong.

It seems that when committing changes to one branch, one file is
modified across the branches. (all branches ge the modified file)

The source files used are those:

http://distfiles.gentoo.org/distfiles/linux-2.6.22.tar.bz2
http://distfiles.gentoo.org/distfiles/genpatches-2.6.22-9.base.tar.bz2
http://people.linux-vserver.org/~harry/patch-2.6.22.6-vs2.2.0.3-grsec2.1.11-20070905.diff

First unpack the linux-2.6.22.tar.bz2 archive, genpatches archive and
add linux kernel to a local repository.

$ tar -jxf linux-2.6.22.tar.bz2
$ tar -jxf genpatches-2.6.22-9.base.tar.bz2
$ cd linux-2.6.22
$ git-init
Initialized empty Git repository in .git/
$ git-add .
$ git commit -m 'vanilla 2.6.22'
...
 create mode 100644 usr/Makefile
 create mode 100644 usr/gen_init_cpio.c
 create mode 100644 usr/initramfs_data.S

Apply the genpatches to get kernel up to 2.6.22.9

$ ls ../2.6.22/100*
../2.6.22/1000_linux-2.6.22.1.patch  ../2.6.22/1005_linux-2.6.22.6.patch
../2.6.22/1001_linux-2.6.22.2.patch  ../2.6.22/1006_linux-2.6.22.7.patch
../2.6.22/1002_linux-2.6.22.3.patch  ../2.6.22/1007_linux-2.6.22.8.patch
../2.6.22/1003_linux-2.6.22.4.patch  ../2.6.22/1008_linux-2.6.22.9.patch
../2.6.22/1004_linux-2.6.22.5.patch
$ for i in ../2.6.22/100*; do patch -p1 < $i ; done
...
patching file net/ipv6/raw.c
patching file net/sunrpc/svcsock.c
patching file scripts/kconfig/conf.c

Commit those changes to git repo.

$ git-commit -a -m'vanilla 2.6.22.9'
Created commit a374b11: vanilla 2.6.22.9
 217 files changed, 1748 insertions(+), 863 deletions(-)
 delete mode 100644 arch/i386/kernel/legacy_serial.c

We want merge the gentoo patches with the vserver/grsecurity patch so we
create 2 branches: vsgrsec-orig and genpatches.

$ git-branch vsgrsec-orig
$ git-branch genpatches

We switch to the vsgrsec-orig branch:

$ git-checkout vsgrsec-orig
Switched to branch "vsgrsec-orig"
$ git-branch               
  genpatches
  master
* vsgrsec-orig

Before we commit any patch, we verify that we dont have any gresecurity
related stuff in there, just to be sure. We check the file that I have
had problems with.

$ grep PAX arch/i386/kernel/vmlinux.lds.S

Its verified clean. Just to be sure, verify the other branches as well.

$ git-checkout genpatches
Switched to branch "genpatches"
$ grep PAX arch/i386/kernel/vmlinux.lds.S 
$ git-checkout master    
Switched to branch "master"
$ grep PAX arch/i386/kernel/vmlinux.lds.S 

Ok, its clean (why wouldnt it?), lets switch back to vsgrsec-orig and
apply the vserver/grsec patch.

$ git-checkout vsgrsec-orig
Switched to branch "vsgrsec-orig"
$ patch -p1 < ../patch-2.6.22.6-vs2.2.0.3-grsec2.1.11-20070905.diff 
...
patching file sound/pci/ens1370.c
patching file sound/pci/intel8x0.c
patching file sound/pci/intel8x0m.c

There are one reject (due to the patch was made for 2.6.22.6), lets
merge it manually.

$ find -name '*.rej'
./fs/locks.c.rej
$ cat ./fs/locks.c.rej
***************
*** 787,792 ****
                goto out;
        locks_copy_lock(new_fl, request);
        locks_insert_lock(&inode->i_flock, new_fl);
        new_fl = NULL;
        error = 0;
  
--- 806,812 ----
                goto out;
        locks_copy_lock(new_fl, request);
        locks_insert_lock(&inode->i_flock, new_fl);
+       vx_locks_inc(new_fl);
        new_fl = NULL;
        error = 0;
  
$ vim +809 ./fs/locks.c

Insert the missing "vx_locks_inc(new_fl);", save and exit. Remove the
reject file.

$ rm ./fs/locks.c.rej

Verify that the propblematic file is modified.

$ grep PAX arch/i386/kernel/vmlinux.lds.S
#ifdef CONFIG_PAX_KERNEXEC

Commit all the changes to the vsgrsec-orig branch.

$ git-branch
  genpatches
  master
* vsgrsec-orig
$ git-add .
$ git-commit -a -m'patch-2.6.22.6-vs2.2.0.3-grsec2.1.11-20070905.diff'
...
 create mode 100644 mm/slab_vs.h
 create mode 100644 net/ipv4/devinet.c.orig
 create mode 100644 net/ipv4/netfilter/ipt_stealth.c

Lets diff the commits and check if git has recordend the
arch/i386/kernel/vmlinux.lds.S modification.

$ git-log | cat
commit 9f2718984a6bc32d6ac1eee69ee27811496269d5
Author: Natanael Copa <natanael.copa@gmail.com>
Date:   Tue Oct 9 11:54:33 2007 +0200

    patch-2.6.22.6-vs2.2.0.3-grsec2.1.11-20070905.diff

commit a374b11b6fb93de40c9d3cf0cad4ff1cd7261283
Author: Natanael Copa <natanael.copa@gmail.com>
Date:   Tue Oct 9 11:31:57 2007 +0200

    vanilla 2.6.22.9

commit 2a31a9171d62b1ae8ed41124b61e43f49e4efb0b
Author: Natanael Copa <natanael.copa@gmail.com>
Date:   Tue Oct 9 11:27:55 2007 +0200

    vanilla 2.6.22

$ git-diff -p a374b11b6fb93de40c9d3cf0cad4ff1cd7261283 \
   | grep arch/i386/kernel/vmlinux.lds.S
(empty)

What? shouldn't git detect that? Well something has changed:

$ git-diff -p a374b11b6fb93de40c9d3cf0cad4ff1cd7261283 \
   | wc -l                              
77138

Lets check the file again:

$ grep PAX  arch/i386/kernel/vmlinux.lds.S
#ifdef CONFIG_PAX_KERNEXEC

Well file is modified. Lets checkout the other branches.

$ git-checkout master
Switched to branch "master"
$ grep PAX  arch/i386/kernel/vmlinux.lds.S
#ifdef CONFIG_PAX_KERNEXEC

What? That is not supposed to be there? the
arch/i386/kernel/vmlinux.lds.S file is modified on all branches.

Lets see what the log says about this branch:

$ git log | cat
commit a374b11b6fb93de40c9d3cf0cad4ff1cd7261283
Author: Natanael Copa <natanael.copa@gmail.com>
Date:   Tue Oct 9 11:31:57 2007 +0200

    vanilla 2.6.22.9

commit 2a31a9171d62b1ae8ed41124b61e43f49e4efb0b
Author: Natanael Copa <natanael.copa@gmail.com>
Date:   Tue Oct 9 11:27:55 2007 +0200

    vanilla 2.6.22

Well, nothing about the vserver/grsec patch there.

$ git-status
# On branch master
nothing to commit (working directory clean)

Lets make a diff between branches.

$ git-diff master vsgrsec-orig | wc -l             
77138

Sure, something has changed. But is the vmlinux.lds.S changed?

$ git-diff master vsgrsec-orig | grep  arch/i386/kernel/vmlinux.lds.S
(empty)

nope! Same thing happens in genpatches branch that I created earlier.

$ git checkout genpatches
Switched to branch "genpatches"
$ git-diff master | grep  arch/i386/kernel/vmlinux.lds.S
$ grep PAX  arch/i386/kernel/vmlinux.lds.S
#ifdef CONFIG_PAX_KERNEXEC

What is going on? Did I do something wrong or is this a bug?

I managed to duplicate this on my 64 bit gentoo ox and my 64 bit ubuntu
box.
$ git --version
git version 1.5.3.3

$ git --version
git version 1.5.2.5


-nc
