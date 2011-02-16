From: Yann Droneaud <yann@droneaud.fr>
Subject: inode problem when using git on a sshfs filesystem
Date: Wed, 16 Feb 2011 23:04:14 +0100
Organization: Yann Droneaud
Message-ID: <1297893854.4097.43.camel@dworkin.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: fuse-sshfs@lists.sourceforge.net, fuse-devel@lists.sourceforge.net
X-From: fuse-sshfs-bounces@lists.sourceforge.net Wed Feb 16 23:30:40 2011
Return-path: <fuse-sshfs-bounces@lists.sourceforge.net>
Envelope-to: gcffs-fuse-sshfs@m.gmane.org
Received: from lists.sourceforge.net ([216.34.181.88])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <fuse-sshfs-bounces@lists.sourceforge.net>)
	id 1PpptP-0001q7-Mc
	for gcffs-fuse-sshfs@m.gmane.org; Wed, 16 Feb 2011 23:30:40 +0100
Received: from localhost ([127.0.0.1] helo=sfs-ml-1.v29.ch3.sourceforge.com)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <fuse-sshfs-bounces@lists.sourceforge.net>)
	id 1Pppt8-0007qP-0Z; Wed, 16 Feb 2011 22:30:22 +0000
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yann@droneaud.fr>)
	id 1Pppt6-0007q3-PY; Wed, 16 Feb 2011 22:30:20 +0000
X-ACL-Warn: 
Received: from mx-out.ocsa-data.net ([194.36.166.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1Pppt5-0004Pl-0R; Wed, 16 Feb 2011 22:30:20 +0000
Received: from [127.0.0.1] (helo=localhost)
	by mx-out.ocsa-data.net with esmtp (Exim - FreeBSD Rulez)
	id 1PppTs-000AQn-Bu; Wed, 16 Feb 2011 23:04:16 +0100
Received: from mx-out.ocsa-data.net ([127.0.0.1])
	by localhost (node2-3.ouvaton.local [127.0.0.1]) (amavisd-new,
	port 10028)
	with ESMTP id U8KyCZnyquaN; Wed, 16 Feb 2011 23:04:16 +0100 (CET)
Received: from [88.161.129.79] (helo=[192.168.0.10])
	by mx-out.ocsa-data.net with esmtpsa (Exim - FreeBSD Rulez)
	id 1PppTr-000AQa-CO; Wed, 16 Feb 2011 23:04:16 +0100
X-Priority: 1
X-Mailer: Evolution 2.32.1 (2.32.1-1.fc14) 
X-Spam-Score: -1.363
X-Spam-Level: 
X-Spam-Status: No, score=-1.363 tagged_above=-20 required=2
	tests=[ALL_TRUSTED=-1.44, TW_VT=0.077]
X-abuse-contact: abuse@ocsa-data.net
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
X-Headers-End: 1Pppt5-0004Pl-0R
X-BeenThere: fuse-sshfs@lists.sourceforge.net
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: <fuse-sshfs.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/fuse-sshfs>,
	<mailto:fuse-sshfs-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=fuse-sshfs>
List-Post: <mailto:fuse-sshfs@lists.sourceforge.net>
List-Help: <mailto:fuse-sshfs-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/fuse-sshfs>,
	<mailto:fuse-sshfs-request@lists.sourceforge.net?subject=subscribe>
Errors-To: fuse-sshfs-bounces@lists.sourceforge.net
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167013>

Hi,

For some days, my usage of git is not as seamless as before.

I'm using git along sshfs/fuse (don't blame me for that), and 
each time I try to rebase one of my branch, I have a conflict when applying
the third commit. Doing the same operation on a local filesystem works without any problem.

===== Part one: git =====

When I try to rebase one specific branch, git rebase failed when applying the third commit,
telling me about uncommited 

I've tried to do it from scratch, using git format-patch / git am
but git am also abort on the third patch with the error message:

error: <path>/<filename>: does not match index

So I've tried to diagnose the problem using :

 - git diff / git status : doesn't return anything.

 - git ls-tree HEAD -l <path>/<filename> : returns the correct mode and file size.

 - git log --raw --all --full-history -- <path>/<filename> : 
   returns valid information matching the one retrieved above.

 - git hash-object <path>/<filename> :
   gives the correct sha1 for the file, as recorded in the patch extracted using git format-patch 
   and reported by git ls-tree or git log (see before)

 - git diff-files : it shows a lot a file, all of them in same directory

   :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename0>
   :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename1>
   :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename2>
   :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename3>
   :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename>

BTW, there's no conflict when applying the patch manually with patch: the patch itself is fine
Using git apply --index also work, but only if it's applied alone:
apply each patches in series and git apply fails in the same third patch.

After diving into git source code and some debugging session, I've found
that the inode number recorded in the active_cache doesn't match the one
on the filesystem for <pach>/<filename> : that's why git apply --index refuse to apply the patch.

Then I tried to monitor stat() information for the file in <path> during
git operations.
1) After applying the first patch, files in <path> were affected different inode number
2) Using strace, I checked that git apply didn't make anything specials to thoses files.
The only thing strange git did, was trying to unlink(<path>), but this failed since the <path>
directory wasn't empty.

Note: the first patch remove, change and add some files in <path> directory, while 
the third patch changes another file in <path> directory

As a workaround: running git diff / git diff --cached / git status between each
git apply --index command seems to update the cache and allows me to apply all the patches
without problem. But it's not an easy path to follow when rebasing branches.

Surprisingly, when looking at strace output, it seems that git apply, once work done, is calling lstat() 
for all the files under <path>, and it sees the new inodes allocated to those files, but I don't know what 
it is doing with those information, if it's not stored in the index.

To conclude, it was a bit hard to diagnose from git point of view.

====== Part two: sshfs / fuse ======

At this time sshfs seems to be guilty of bad behavior, breaking somes POSIX rules.

So I tried the following testcase on another computer to reproduce the
problem outside of git.

Here the results:

$ mkdir dir
$ touch dir/a dir/b
$ stat -t dir/*
dir/a 0 0 81b4 500 500 15 3 1 0 0 1297882724 1297882724 1297882724 4096
dir/b 0 0 81b4 500 500 15 4 1 0 0 1297882726 1297882726 1297882726 4096
$ rmdir dir
rmdir: failed to remove `dir1': Operation not permitted
$ stat -t dir/*
dir/a 0 0 81b4 500 500 15 6 1 0 0 1297882724 1297882724 1297882724 4096
dir/b 0 0 81b4 500 500 15 7 1 0 0 1297882726 1297882726 1297882726 4096

One can see that inode 3 became inode 6 and inode 4 became inode 7 after the failed
unlink operation on dir. Which seems to be a bit uncommon for me.

Note: on a local filesystem, rmdir failed with message rmdir: failed to remove `dir1': Directory not empty

I try to add some debug support to fuse / sshfs in order to locate more precisely the problem:
(lines beginning by -/+ where added by me in libfuse, line beginning with --/++ in sshfs)

$ sshfs localhost:<export> <mount> -o sshfs_debug,debug,cache=no -d -f -s

unique: 22, opcode: FORGET (2), nodeid: 4, insize: 48, pid: 0
- forget 4
FORGET 4/1
DELETE: 4
+ forget 4
unique: 23, opcode: FORGET (2), nodeid: 3, insize: 48, pid: 0
- forget 3
FORGET 3/1
DELETE: 3
+ forget 3
unique: 24, opcode: RMDIR (11), nodeid: 1, insize: 44, pid: 9044
- rmdir 1 dir
rmdir /dir
-- rmdir(/dir)
[00020] RMDIR
  [00020]         STATUS       28bytes (0ms)
++ rmdir(/dir) = -1
   unique: 24, error: -1 (Operation not permitted), outsize: 16
+ rmdir 1 dir
unique: 25, opcode: FORGET (2), nodeid: 2, insize: 48, pid: 0
- forget 2
FORGET 2/1
DELETE: 2
+ forget 2

One can see that the reference to files under the directory are asked by
the kernel to be forgotten, even if the directory is not yet removed.

This seems a bit illogical since a directory with files under it can't
be removed (but FORGET could apply to file deleted but still referenced
by a process).

Note: if the file is opened, the inode associated to the file name
didn't change. Hopefully.

I've tried to reproduce the problem with other virtual filesystem like
shm / tmpfs / devtmpfs / ramfs : no problem.

I've also tried with NFS (local), and there's no problem too (the inode
numbers reported from NFS client side are the same than the server
side).

So it seems this a FUSE only problem, and I haven't found exactly why.

Regards.

-- 
Yann Droneaud



------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
