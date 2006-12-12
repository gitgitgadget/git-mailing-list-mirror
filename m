X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Tue, 12 Dec 2006 08:49:26 -0500
Message-ID: <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <Pine.LNX.4.64.0612111837210.20138@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 13:49:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612111837210.20138@iabervon.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-12_03:2006-12-12,2006-12-10,2006-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0612050001 definitions=main-0612120009
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34099>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu80s-0003Bo-2m for gcvg-git@gmane.org; Tue, 12 Dec
 2006 14:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751349AbWLLNte (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 08:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWLLNte
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 08:49:34 -0500
Received: from smtpout.mac.com ([17.250.248.183]:52093 "EHLO smtpout.mac.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751349AbWLLNtd
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 08:49:33 -0500
Received: from mac.com (smtpin01-en2 [10.13.10.146]) by smtpout.mac.com
 (Xserve/8.12.11/smtpout13/MantshX 4.0) with ESMTP id kBCDnW0d007068; Tue, 12
 Dec 2006 05:49:32 -0800 (PST)
Received: from [10.0.7.253] (hc6524e82.dhcp.vt.edu [198.82.78.130])
 (authenticated bits=0) by mac.com (Xserve/smtpin01/MantshX 4.0) with ESMTP id
 kBCDnRpp008973 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
 Tue, 12 Dec 2006 05:49:29 -0800 (PST)
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

On Dec 11, 2006, at 22:45:25, Daniel Barkalow wrote:
> The first thing you'd want to do is correct the fact that the index  
> doesn't keep full permissions. We decided long ago that we don't  
> want to track more than 0100, but we're discarding the rest between  
> the filesystem and the index, rather than between the index and the  
> tree. (This is weird of us, since we keep gid and uid in the index,  
> as changedness heuristics, but don't keep permissions; of course,  
> we'd have to apply umask to the index when we check it out to sync  
> what we expect to be there with what has actually been created.)
>
> I think that would be the only change needed to the index and index/ 
> working directory connection, although it might be necessary to  
> support longer values for uid/gid/etc, since they'd be important  
> data now.

Hmm, ok.  It would seem to be a reasonable requirement that if you  
want to change any of the "preserve_*_attributes" config options you  
need to blow away and recreate your index, no?  I would probably  
change the underlying index format pretty completely and stick a new  
version tag inside it.

> Note that git only stores content, not incidental information. But  
> a lot of information which is incidental in a source tree is  
> content in /etc. This implies that /etc and working/linux-2.6 are  
> fundamentally different sorts of things, because different aspects  
> of them are content.

Ahh, I hadn't thought of it that way before but that makes a lot of  
sense.  Thanks!

> I'd suggest a new object type for a directory with permissions,  
> ACLs, and so forth. It should probably use symbolic owner and  
> group, too. My guess is that you'll want to use "commit"s, the new  
> object type, and "blob"s. Everything that uses trees would need to  
> have a version that uses the new type. But I think that you  
> generally want different behavior anyway, so that's not a major issue.

Ok, seems straightforward enough.  One other thing that crossed my  
mind was figuring out how to handle hardlinks.  The simplest solution  
would be to add an extra layer of indirection between the "file  
inode" and the "file data".  Instead of your directory pointing to a  
"file-data" blob and "file-attributes" object, it would point to an  
"file-inode" object with embedded attribute data and a pointer to the  
file contents blob.

I remember reading some discussions from the early days of GIT about  
how that was considered and discarded because the extra overhead  
wouldn't give any real tangible benefit.  On the other hand for  
something like /etc the added benefits of tracking extended  
attributes and hardlinks might outweigh the cost of a bunch of extra  
objects in the database.  A bit of care with the construction of the  
index file should make it sufficiently efficient for day-to-day usage.

If you're interested in some random musings about using GIT concepts  
to version whole filesystems (think checkpointing your disk drive and  
instantly restoring when you screw up), read on below, otherwise  
don't bother.

Cheers,
Kyle Moffett

<Random Tangential Off-the-Wall Thought Experiment>

NOTE: This probably belongs in it's own thread but it's such a  
random, undeveloped, and off-the-wall concept that I threw it in here  
just for kicks.

Combining extensions like those described above with something like  
the Ext3 block-allocation, inode-management and journalling code to  
produce a "versioned filesystem".  With the exponential growth of  
storage density over the last several years we've gotten to the point  
where we can many many hours of extremely realistic video and audio  
on your average small-computer drive.  Versioning your home  
directory, or even your entire computer, even with fairly steady  
modifications to multimedia files, installation of software programs,  
etc, doesn't seem like such an impossible undertaking anymore.

One predefined inode would contain a list of tags/heads and their  
current hashes.  Mount the filesystem with a "tag=$TAG" option to  
specify the initial tree object used for the root directory (with  
syscalls to navigate the history).  Allocate an inode per-mount to  
represent any changes from the last commit.

For efficiency purposes (no need to revision the entire system when I  
commit a change in my home directory) add a "subtree" object type  
which can specify either a particular hash or a symbolic tag/head  
name as a pseudo sub-mountpoint.  Trap traversal of the sub- 
mountpoint node to mount the filesystem with "tag=$SUBTAG" on the sub- 
mountpoint, expiring it some time after the last traversal.

The only remaining issue would be properly navigating through the  
history, preserving or discarding changes.  Since the kernel could  
easily manage copy-on-write semantics for underlying disk blocks you  
wouldn't need a separate "working copy" except where it's modified  
from the original, and discarding changes is as simple as unlinking  
any files referenced by the per-mount delta inode.

Committing changes would get tricky, you would need to hot-remap  
memory-mapped pages read-only while you checksum and store them.  The  
next write attempt would then separate the page from the freshly- 
committed on-disk version.  Would need a mechanism for applications  
to "trap" the commit so they could make databases consistent, with  
the ability for root or the mountpoint owner to commit without  
waiting for synchronization.  Only needs to synchronize files  
belonging to the new commit.  Merges would be managed from userspace,  
as long as there is a way to browse through objects by hash given  
sufficient permissions.

Make sure it's really easy to make a new atomic commit and/or reset  
to a known state every time the computer is rebooted (whether soft- 
rebooted or via crash/powerkill).  With journalling and the write- 
once nature of GIT it would be trivial to never require an fsck run.   
Also needs a way to move data between filesystems.  Makes LVM largely  
irrelevant; it doesn't matter how many disks you have if they're all  
treated as a shared storage pool for your GITfs data.  Make sure it's  
possible to archive data onto slower disks/media and purge older  
commits from the archive (missing parent commit references are  
tolerable in many situations).  Needs a way to notice hash collisions  
and take action to avoid them.

</Random Tangential Off-the-Wall Thought Experiment>

Cheers,
Kyle Moffett
