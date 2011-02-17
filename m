From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [sshfs] inode problem when using git on a sshfs filesystem
Date: Thu, 17 Feb 2011 20:59:59 +0100
Message-ID: <E1PqA19-00080P-Dy@pomaz-ex.szeredi.hu>
References: <1297893854.4097.43.camel@dworkin.quest-ce.net>
	<E1Pq1LW-0005rc-Qy@pomaz-ex.szeredi.hu>
	<7f02c4cb5ca13dae6de7caa1b6f90cfe.squirrel@webmail.ocsa-data.net>
	<E1Pq3aa-0006Nn-Cv@pomaz-ex.szeredi.hu> <ac00e83c1b57e2eeda1c6631ec611e75.squirrel@webmail.ocsa-data.net>
Cc: miklos@szeredi.hu, miklos@szeredi.hu,
	fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	fuse-sshfs@lists.sourceforge.net, git@vger.kernel.org
To: "Yann Droneaud" <yann@droneaud.fr>
X-From: linux-kernel-owner@vger.kernel.org Thu Feb 17 21:00:18 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1PqA1O-0004RN-Nj
	for glk-linux-kernel-3@lo.gmane.org; Thu, 17 Feb 2011 21:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914Ab1BQUAG (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 17 Feb 2011 15:00:06 -0500
Received: from fxip-0047f.externet.hu ([88.209.222.127]:58256 "EHLO
	pomaz-ex.szeredi.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1BQUAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2011 15:00:03 -0500
Received: from miko by pomaz-ex.szeredi.hu with local (Exim 4.69)
	(envelope-from <miklos@szeredi.hu>)
	id 1PqA19-00080P-Dy; Thu, 17 Feb 2011 20:59:59 +0100
In-reply-to: <ac00e83c1b57e2eeda1c6631ec611e75.squirrel@webmail.ocsa-data.net>
	(yann@droneaud.fr)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167108>

On Thu, 17 Feb 2011, Yann Droneaud wrote:
> > The VFS (part of the linux kernel that implements the generic
> > filesystem logic) clears the directory entry from the cache prior to
> > actually trying to remove the directory.  This has the effect that any
> > children of the directory are also cleared from the cache, hence the
> > behavior you see in rmdir.
> >
> 
> I tried to check that behavor: if the VFS is dropping dentry before doing
> a rmdir(), them lookup files under this directory should be slower than
> before rmdir().
> 
> On a ext4 filesystem, directory with 338 sub directories and 1992 files, 
> i've tried the following commands:
> 
> /* drop all */
> # echo 3 > /proc/sys/vm/drop_caches
> # time ls -alR directory > /dev/null
> real	0m0.140s
> user	0m0.000s
> sys	0m0.080s
> 
> /* drop cache */
> # echo 1 > /proc/sys/vm/drop_caches
> # time ls -alR directory > /dev/null
> real	0m0.119s
> user	0m0.000s
> sys	0m0.072s
> 
> /* drop dentry and inode */
> # echo 2 > /proc/sys/vm/drop_caches
> # time ls -alR directory > /dev/null
> real	0m0.089s
> user	0m0.016s
> sys	0m0.040s
> 
> /* read from cache */
> # time ls -alR directory > /dev/null
> real	0m0.063s
> user	0m0.004s
> sys	0m0.036s
> 
> $ rmdir directory
> rmdir: failed to remove `directory': Directory not empty
> 
> /* re read from cache */
> $ time ls -alR directory > /dev/null
> real	0m0.065s
> user	0m0.012s
> sys	0m0.036s
> 
> As you can see, after doing rmdir(), the time taken to walk trough the
> directories is the same than before calling it, so the dentry seems not
> flushed out of the cache after the rmdir().

tucsk:~ # time find /usr -ls > /dev/null

real    0m1.922s
user    0m1.104s
sys     0m0.800s
tucsk:~ # rmdir /usr
rmdir: failed to remove `/usr': Directory not empty
tucsk:~ # time find /usr -ls > /dev/null

real    0m2.637s
user    0m1.172s
sys     0m1.448s
tucsk:~ # time find /usr -ls > /dev/null

real    0m1.943s
user    0m1.068s
sys     0m0.848s
tucsk:~ # 

As you can see it does get significantly slower after the rmdir.

> I really prefer this behavior. The one you explained would be a real pain:
> if one user call rmdir on / inside a loop, the full dentry cache will be
> dropped each time: this would affect performance for the whole system.

Yes.  But in practice this doesn't really matter, removing non-empty
directories happens rarely.

Thanks,
Miklos
