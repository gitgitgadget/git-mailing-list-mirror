From: "Yann Droneaud" <yann@droneaud.fr>
Subject: Re: [sshfs] inode problem when using git on a sshfs filesystem
Date: Thu, 17 Feb 2011 19:11:14 +0100
Message-ID: <ac00e83c1b57e2eeda1c6631ec611e75.squirrel@webmail.ocsa-data.net>
References: <1297893854.4097.43.camel@dworkin.quest-ce.net>
    <E1Pq1LW-0005rc-Qy@pomaz-ex.szeredi.hu>
    <7f02c4cb5ca13dae6de7caa1b6f90cfe.squirrel@webmail.ocsa-data.net>
    <E1Pq3aa-0006Nn-Cv@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Yann Droneaud" <yann@droneaud.fr>, miklos@szeredi.hu,
	fuse-sshfs@lists.sourceforge.net, fuse-devel@lists.sourceforge.net,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Miklos Szeredi" <miklos@szeredi.hu>
X-From: linux-kernel-owner@vger.kernel.org Thu Feb 17 19:11:21 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Pq8Jw-0005Ea-BL
	for glk-linux-kernel-3@lo.gmane.org; Thu, 17 Feb 2011 19:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532Ab1BQSLI (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 17 Feb 2011 13:11:08 -0500
Received: from mx-out.ocsa-data.net ([194.36.166.37]:60716 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab1BQSLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2011 13:11:03 -0500
Received: from [192.168.111.12] (helo=webmail.ocsa-data.net)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Pq8Jh-000DQv-7c; Thu, 17 Feb 2011 19:11:03 +0100
Received: from 80.12.80.40
        (SquirrelMail authenticated user meuh@meuh.org)
        by webmail.ocsa-data.net with HTTP;
        Thu, 17 Feb 2011 19:11:14 +0100
In-Reply-To: <E1Pq3aa-0006Nn-Cv@pomaz-ex.szeredi.hu>
User-Agent: SquirrelMail/1.4.21
X-Priority: 3 (Normal)
Importance: Normal
X-abuse-contact: abuse@ocsa-data.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167097>

> On Thu, 17 Feb 2011, Yann Droneaud wrote:
>> > On Wed, 16 Feb 2011, Yann Droneaud wrote:
>> >> Hi,
>> >>
>> >> For some days, my usage of git is not as seamless as before.
>> >>
>> >> I'm using git along sshfs/fuse (don't blame me for that), and
>> >> each time I try to rebase one of my branch, I have a conflict when
>> >> applying
>> >> the third commit. Doing the same operation on a local filesystem
>> works
>> >> without any problem.
>> >
>> > Yann, thanks for looking into this.
>> >
>> > Your findings are not surprising: unlike NFS, sshfs doesn't provide
>> > inode numbers and the fuse library also doesn't guarantee stable inode
>> > numbers by default.
>> >
>>
>> But why does it have such behavior when trying to rmdir() a non empty
>> directory ?
>
> The VFS (part of the linux kernel that implements the generic
> filesystem logic) clears the directory entry from the cache prior to
> actually trying to remove the directory.  This has the effect that any
> children of the directory are also cleared from the cache, hence the
> behavior you see in rmdir.
>

I tried to check that behavor: if the VFS is dropping dentry before doing
a rmdir(), them lookup files under this directory should be slower than
before rmdir().

On a ext4 filesystem, directory with 338 sub directories and 1992 files, 
i've tried the following commands:

/* drop all */
# echo 3 > /proc/sys/vm/drop_caches
# time ls -alR directory > /dev/null
real	0m0.140s
user	0m0.000s
sys	0m0.080s

/* drop cache */
# echo 1 > /proc/sys/vm/drop_caches
# time ls -alR directory > /dev/null
real	0m0.119s
user	0m0.000s
sys	0m0.072s

/* drop dentry and inode */
# echo 2 > /proc/sys/vm/drop_caches
# time ls -alR directory > /dev/null
real	0m0.089s
user	0m0.016s
sys	0m0.040s

/* read from cache */
# time ls -alR directory > /dev/null
real	0m0.063s
user	0m0.004s
sys	0m0.036s

$ rmdir directory
rmdir: failed to remove `directory': Directory not empty

/* re read from cache */
$ time ls -alR directory > /dev/null
real	0m0.065s
user	0m0.012s
sys	0m0.036s

As you can see, after doing rmdir(), the time taken to walk trough the
directories is the same than before calling it, so the dentry seems not
flushed out of the cache after the rmdir().

I really prefer this behavior. The one you explained would be a real pain:
if one user call rmdir on / inside a loop, the full dentry cache will be
dropped each time: this would affect performance for the whole system.

But perhaps I doesn't understand how the VFS is working, which is the most
probable solution. Please correct me.

Regards.

-- 
Yann Droneaud
