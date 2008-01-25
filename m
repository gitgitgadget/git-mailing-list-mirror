From: Chris Mason <chris.mason@oracle.com>
Subject: Re: [Btrfs-devel] btrfs and git-reflog
Date: Fri, 25 Jan 2008 10:50:16 -0500
Message-ID: <200801251050.16697.chris.mason@oracle.com>
References: <873asmcodd.fsf@burly.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Collins <paul@burly.ondioline.org>, git@vger.kernel.org
To: btrfs-devel@oss.oracle.com
X-From: git-owner@vger.kernel.org Fri Jan 25 16:51:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIQpj-0008AM-CC
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 16:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134AbYAYPum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 10:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757093AbYAYPum
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 10:50:42 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:44888 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757105AbYAYPuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 10:50:40 -0500
Received: from agmgw1.us.oracle.com (agmgw1.us.oracle.com [152.68.180.212])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id m0PFoTQD015854;
	Fri, 25 Jan 2008 08:50:29 -0700
Received: from acsmt353.oracle.com (acsmt353.oracle.com [141.146.40.153])
	by agmgw1.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id m0OKQXuM018564;
	Fri, 25 Jan 2008 08:50:29 -0700
Received: from cpe-72-225-43-119.rochester.res.rr.com by acsmt359.oracle.com
	with ESMTP id 7020369921201276226; Fri, 25 Jan 2008 09:50:26 -0600
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <873asmcodd.fsf@burly.wgtn.ondioline.org>
Content-Disposition: inline
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71715>

On Friday 25 January 2008, Paul Collins wrote:
> I was just playing with git 1.5.3.8 and btrfs 0.11, and I noticed
> something odd.
>
> If I prepare a very simple repository:
>
>   $ mkdir foo
>   $ cd foo
>   $ git init
>   Initialized empty Git repository in .git/
>   $ echo hi > blort
>   $ git add .
>   $ git commit -m create
>   Created initial commit 4ae9415: create
>    1 files changed, 1 insertions(+), 0 deletions(-)
>    create mode 100644 blort
>
> and then attempt to expire the reflogs
>
>   $ git-reflog expire --all
>
> on ext3, git-reflog completes its work and exits immediately;
>
> and on btrfs, it gets stuck in some sort of loop that causes it to
> allocate more and more memory until I kill it or it pushes the
> machine into OOM.
>
It works something like this:

readdir(.git/logs/refs/heads)
# this returns .git/logs/refs/heads/master
# <do some work>

open(.git/logs/refs/heads/master.lock, O_CREAT);
# <do more work>, write to master.lock

rename(master.lock, master)

readdir(.git/logs/refs/heads)

readdir again returns .git/logs/refs/heads/master, which is arguably
correct.  It is a new file that just happens to have a name
that git already saw.  So, git loops over this file infinitely because
it doesn't realize it has already processed it.

This happens because btrfs doesn't return the hash of the
file name as the offset to readdir.  It returns the inode number,
and since master is a new file, btrfs considers it a non-duplicate
entry.

The btrfs patch below changes my readdir code to force the
directory f_pos field to the max offset allowed when we've
seen all the directory entries.  This prevents the readdir
call from looping forever in the face of newly added files.

But, git might want to add some checks to see if it has
already processed things.

diff -r 21e9b461f802 inode.c
--- a/inode.c	Thu Jan 24 16:13:14 2008 -0500
+++ b/inode.c	Fri Jan 25 10:28:49 2008 -0500
@@ -1430,7 +1431,7 @@ read_dir_items:
 			di = (struct btrfs_dir_item *)((char *)di + di_len);
 		}
 	}
-	filp->f_pos++;
+	filp->f_pos = INT_LIMIT(typeof(filp->f_pos));
 nopos:
 	ret = 0;
 err:
