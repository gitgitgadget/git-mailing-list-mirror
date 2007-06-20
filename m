From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Versioning file system
Date: Tue, 19 Jun 2007 22:43:01 -0400
Message-ID: <91F471D5-DFDB-4C4B-8374-292B2DF35F10@mac.com>
References: <OF7FA807A1.64C0D5AF-ON882572FE.0061B34C-882572FE.00628322@us.ibm.com> <6E9A6F9E-8948-40F2-9129-1F1491D49D83@mac.com> <20070619075857.GA2944@brong.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bryan Henderson <hbryan@us.ibm.com>,
	Jack Stone <jack@hawkeye.stone.uk.eu.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	alan <alan@clueserver.org>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-fsdevel@vger.kernel.org,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, git@vger.kernel.org
To: Bron Gondwana <brong@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Jun 20 04:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0qB2-0006kK-9w
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 04:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759511AbXFTCnx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 22:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759133AbXFTCnx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 22:43:53 -0400
Received: from smtpout.mac.com ([17.250.248.184]:56567 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758033AbXFTCnv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 22:43:51 -0400
Received: from mac.com (smtpin05-en2 [10.13.10.150])
	by smtpout.mac.com (Xserve/smtpout14/MantshX 4.0) with ESMTP id l5K2hLn5005851;
	Tue, 19 Jun 2007 19:43:21 -0700 (PDT)
Received: from [10.0.2.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin05/MantshX 4.0) with ESMTP id l5K2h2aN022346
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 19 Jun 2007 19:43:08 -0700 (PDT)
In-Reply-To: <20070619075857.GA2944@brong.net>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50523>

On Jun 19, 2007, at 03:58:57, Bron Gondwana wrote:
> On Mon, Jun 18, 2007 at 11:10:42PM -0400, Kyle Moffett wrote:
>> On Jun 18, 2007, at 13:56:05, Bryan Henderson wrote:
>>>> The question remains is where to implement versioning: directly  
>>>> in individual filesystems or in the vfs code so all filesystems  
>>>> can use it?
>>>
>>> Or not in the kernel at all.  I've been doing versioning of the  
>>> types I described for years with user space code and I don't  
>>> remember feeling that I compromised in order not to involve the  
>>> kernel.
>>
>> What I think would be particularly interesting in this domain is  
>> something similar in concept to GIT, except in a file-system:
>
> [...snip...]
>
> It can work, but there's one big pain at the file level: no mmap.

IMHO it's actually not that bad.  The "gitfs" would divide larger  
files up into manageable chunks (say 4MB) which could be quickly  
SHA-1ed.  When a file is mmapped and partially modified, the SHA-1  
would be marked as locally invalid, but since mmap() loses most  
consistency guarantees that's OK.  A time or writeout based "commit"  
scheme might still freeze, SHA-1, and write-out the page at regular  
intervals without the program's knowledge, but since you only have to  
SHA-1 the relatively-small 4MB chunk (which is about to hit disk  
anyways), it's not a significant time penalty.  Even if under memory  
pressure and swapping data out to disk you don't have to update the  
SHA-1 and create a new commit as long as you keep a reference to the  
object stored in the volume header somewhere and maintain the "SHA-1  
out-of-date" bit.

A program which carefully uses msync() would be fine, of course (with  
proper configuration) as that would create a new commit as appropriate.

Since mmap() is poorly defined on network filesystems in the absence  
of msync(), I don't see that such behaviour would be a problem.  And  
it certainly would be fine on local filesystems as there you can just  
stuff the "SHA-1 out-of-date" bit and a reference to the parent  
commit and path in the object itself.  Then you just need to keep a  
useful reference to that object in a table somewhere in the volume  
and you're set.

> If you don't want to support mmap it can work reasonably happily,  
> though you may want to keep your sha1 (or other digest) state as  
> well as the final digest so you can cheaply calculate the digest  
> for a small append without walking the entire file.  You may also  
> want to keep state checkpoints every so often along a big file so  
> that truncates don't cost too much to recalculate.

That may be worth it even if the file is divided into 4MB chunks (or  
other configurable value), but it would need benchmarking.

> Luckily in a userspace VFS that's only accessed via FTP and DAV we  
> can support a limited set of operations (basically create, append,  
> read, delete)  You don't get that luxury for a general purpose  
> filesystem, and that's the problem.  There will always be  
> particular usage patterns (especially something that mmaps or seeks  
> and touches all over the place like a loopback mounted filesystem  
> or a database file) that just dodn't work for file-level sha1s.

I'd think that loopback-mounted filesystems wouldn't be that difficult
   1)  Set the SHA-1 block size appropriately to divide the big file  
into a bunch of little manageable files.  Could conceivably be multi- 
layered like directories, depending on the size of the file.
   2)  Mark the file as exempt from normal commits (IE: without  
special syscalls or fsync/msync() on the file itself, it is never  
updated in the tree objects.
   3)  Set up the loopback device to call the gitfs commit code when  
it receives barriers or flushes from the parent filesystem.

And database files aren't a big issue.  I have yet to see a networked  
filesystem which you could stick a MySQL database on it from one node  
and expect to get useful/recent read results from other nodes.  If  
you really wanted something like that for such a "gitfs", you could  
just add code to MySQL to create a gitfs commit every N transactions  
and not otherwise.  The best part is: that would make online MySQL  
backups from another node trivial!  Just pick any arbitrary  
appropriate commit object and mount that object, then "cp -a  
mysql_db_dir mysql_backup_dir".  That's not to say it wouldn't have a  
performance penalty, but for some people the performance penalty  
might be worth it.

Oh, and for those programs which want multi-master replication, this  
makes it ten times easier:
   1)  Put each master-server on a different gitfs branch
   2)  Write your program as gitfs aware.  Make it create gitfs  
commits at appropriate times (so the data is accessible from other  
nodes).
   3)  Come up with a useful non-interactive database-file merge  
algorithm.  Useful examples of different kinds of merge engines may  
be found in the git project.  This should take $BASE_VERSION,  
$NEWVERSION1, $NEWVERSION2, and produce a $MERGEDVERSION.  A good  
algorithm should probably pick a safe default and save a "conflict"  
entry in the face of conflicting changes.
   4)  Hook your merge algorithm into the gitfs mechanics using some  
to-be-defined API.
   5)  Whenever your software does a database-file commit it sends  
out a little notification to the other nodes (maybe using a gitfs API?)
   6)  Run a periodic (as defined by the admin yet again) thread on  
each node which does branch merging.  When two or more branches have  
different SHA-1 sums the servers will rotate the merging task between  
them.  The thus-selected server will merge changes from the other  
server(s) into its current working copy.  With 2 servers this means  
that the maximum delay between one server making a change and the  
other server seeing it will be 2 times the merge interval.
   7)  For small pools of servers a simple rotated-merge-master  
algorithm would work.  For larger pools you would need to come up  
with some logarithmic rotating-merge-node algorithm to evenly divide  
the work of propagating changes across all nodes.

> It does have some lovely properties though.  I'd enjoy working in  
> an envionment that didn't look much like POSIX but had the strong  
> guarantees and auditability that addressing by sha1 buys you.

I'd like to think we can have our cake and eat it too :-D.  POSIX  
requirements should be doable on the local system and can be mimiced  
well enough on networked filesystems (albeit with update latency)  
that most programs won't care.  If you're the only person modifying  
files on gitfs, regardless of what node they are stored on, it should  
have the same behavior as local files (since with gitfs caching they  
would *become* local files too :-D).  The few programs that do care  
about POSIX atomicity across networked filesystems (which is already  
mostly implementation defined) could probably be updated to map gitfs  
commits and merges into their own internal transactions and do just  
fine.

Cheers,
Kyle Moffett
