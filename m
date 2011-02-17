From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: inode problem when using git on a sshfs filesystem
Date: Thu, 17 Feb 2011 09:37:44 +0100
Message-ID: <4D5CDE58.5000905@drmicha.warpmail.net>
References: <1297893854.4097.43.camel@dworkin.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Thu Feb 17 09:41:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpzQD-0002DF-0L
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 09:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab1BQIkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 03:40:53 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43143 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751351Ab1BQIkv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 03:40:51 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4F0CD20AA0;
	Thu, 17 Feb 2011 03:40:51 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 17 Feb 2011 03:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=QZULwXkcPlSZqoW6YJMq0fEAWJM=; b=MsdfcZuARXL/WogQIPoj0UMEbz+xjwyE2MQ6lBEh7UV/BCKWGZgDqZlnNraRRLyJecq24Hk6vtt0rKWyvPR/SFZJ1eu1S7C8V+nB388TAbQ59U2c+TJY+aUVND4IMfc5LLqm4gFtm3RMEG0uQFO6FEs0IOi0+cwJ1w/5I32MU1c=
X-Sasl-enc: Iv+rp4z9A1pVWapoISk2vJJQpFwFllI1GMpDiGdBpZrm 1297932050
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ABB4544D7A7;
	Thu, 17 Feb 2011 03:40:50 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <1297893854.4097.43.camel@dworkin.quest-ce.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167056>

Yann Droneaud venit, vidit, dixit 16.02.2011 23:04:
> Hi,
> 
> For some days, my usage of git is not as seamless as before.
> 
> I'm using git along sshfs/fuse (don't blame me for that), and 
> each time I try to rebase one of my branch, I have a conflict when applying
> the third commit. Doing the same operation on a local filesystem works without any problem.
> 
> ===== Part one: git =====
> 
> When I try to rebase one specific branch, git rebase failed when applying the third commit,
> telling me about uncommited 
> 
> I've tried to do it from scratch, using git format-patch / git am
> but git am also abort on the third patch with the error message:
> 
> error: <path>/<filename>: does not match index
> 
> So I've tried to diagnose the problem using :
> 
>  - git diff / git status : doesn't return anything.
> 
>  - git ls-tree HEAD -l <path>/<filename> : returns the correct mode and file size.
> 
>  - git log --raw --all --full-history -- <path>/<filename> : 
>    returns valid information matching the one retrieved above.
> 
>  - git hash-object <path>/<filename> :
>    gives the correct sha1 for the file, as recorded in the patch extracted using git format-patch 
>    and reported by git ls-tree or git log (see before)
> 
>  - git diff-files : it shows a lot a file, all of them in same directory
> 
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename0>
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename1>
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename2>
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename3>
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename>
> 
> BTW, there's no conflict when applying the patch manually with patch: the patch itself is fine
> Using git apply --index also work, but only if it's applied alone:
> apply each patches in series and git apply fails in the same third patch.
> 
> After diving into git source code and some debugging session, I've found
> that the inode number recorded in the active_cache doesn't match the one
> on the filesystem for <pach>/<filename> : that's why git apply --index refuse to apply the patch.
> 
> Then I tried to monitor stat() information for the file in <path> during
> git operations.
> 1) After applying the first patch, files in <path> were affected different inode number
> 2) Using strace, I checked that git apply didn't make anything specials to thoses files.
> The only thing strange git did, was trying to unlink(<path>), but this failed since the <path>
> directory wasn't empty.
> 
> Note: the first patch remove, change and add some files in <path> directory, while 
> the third patch changes another file in <path> directory
> 
> As a workaround: running git diff / git diff --cached / git status between each
> git apply --index command seems to update the cache and allows me to apply all the patches
> without problem. But it's not an easy path to follow when rebasing branches.
> 
> Surprisingly, when looking at strace output, it seems that git apply, once work done, is calling lstat() 
> for all the files under <path>, and it sees the new inodes allocated to those files, but I don't know what 
> it is doing with those information, if it's not stored in the index.
> 
> To conclude, it was a bit hard to diagnose from git point of view.
> 
> ====== Part two: sshfs / fuse ======
> 
> At this time sshfs seems to be guilty of bad behavior, breaking somes POSIX rules.
> 
> So I tried the following testcase on another computer to reproduce the
> problem outside of git.
> 
> Here the results:
> 
> $ mkdir dir
> $ touch dir/a dir/b
> $ stat -t dir/*
> dir/a 0 0 81b4 500 500 15 3 1 0 0 1297882724 1297882724 1297882724 4096
> dir/b 0 0 81b4 500 500 15 4 1 0 0 1297882726 1297882726 1297882726 4096
> $ rmdir dir
> rmdir: failed to remove `dir1': Operation not permitted
> $ stat -t dir/*
> dir/a 0 0 81b4 500 500 15 6 1 0 0 1297882724 1297882724 1297882724 4096
> dir/b 0 0 81b4 500 500 15 7 1 0 0 1297882726 1297882726 1297882726 4096
> 
> One can see that inode 3 became inode 6 and inode 4 became inode 7 after the failed
> unlink operation on dir. Which seems to be a bit uncommon for me.
> 
> Note: on a local filesystem, rmdir failed with message rmdir: failed to remove `dir1': Directory not empty
> 
> I try to add some debug support to fuse / sshfs in order to locate more precisely the problem:
> (lines beginning by -/+ where added by me in libfuse, line beginning with --/++ in sshfs)
> 
> $ sshfs localhost:<export> <mount> -o sshfs_debug,debug,cache=no -d -f -s
> 
> unique: 22, opcode: FORGET (2), nodeid: 4, insize: 48, pid: 0
> - forget 4
> FORGET 4/1
> DELETE: 4
> + forget 4
> unique: 23, opcode: FORGET (2), nodeid: 3, insize: 48, pid: 0
> - forget 3
> FORGET 3/1
> DELETE: 3
> + forget 3
> unique: 24, opcode: RMDIR (11), nodeid: 1, insize: 44, pid: 9044
> - rmdir 1 dir
> rmdir /dir
> -- rmdir(/dir)
> [00020] RMDIR
>   [00020]         STATUS       28bytes (0ms)
> ++ rmdir(/dir) = -1
>    unique: 24, error: -1 (Operation not permitted), outsize: 16
> + rmdir 1 dir
> unique: 25, opcode: FORGET (2), nodeid: 2, insize: 48, pid: 0
> - forget 2
> FORGET 2/1
> DELETE: 2
> + forget 2
> 
> One can see that the reference to files under the directory are asked by
> the kernel to be forgotten, even if the directory is not yet removed.
> 
> This seems a bit illogical since a directory with files under it can't
> be removed (but FORGET could apply to file deleted but still referenced
> by a process).
> 
> Note: if the file is opened, the inode associated to the file name
> didn't change. Hopefully.
> 
> I've tried to reproduce the problem with other virtual filesystem like
> shm / tmpfs / devtmpfs / ramfs : no problem.
> 
> I've also tried with NFS (local), and there's no problem too (the inode
> numbers reported from NFS client side are the same than the server
> side).
> 
> So it seems this a FUSE only problem, and I haven't found exactly why.
> 
> Regards.
> 

fuse-sshfs is a bit of a pita whenever you try to treat it like a "real"
file-system... OTOH, git makes assumptions on stability of device ids,
e.g. On such a (non)-fs, I'd suggest to try in this order of preference:

- Work from a local clone :) Pushing over ssh is fine.

- Have your workdir on a local file system, gitdir on sshfs.

- Try whether core.fsyncobjectfiles helps (shot in the dark).

- Try whether core.ignoreStat works for you. (This impacts your workflow!)

Michael
