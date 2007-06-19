From: Jack Stone <jack@hawkeye.stone.uk.eu.org>
Subject: Re: Versioning file system
Date: Tue, 19 Jun 2007 08:49:14 +0100
Message-ID: <46778A7A.1080403@hawkeye.stone.uk.eu.org>
References: <OF7FA807A1.64C0D5AF-ON882572FE.0061B34C-882572FE.00628322@us.ibm.com> <6E9A6F9E-8948-40F2-9129-1F1491D49D83@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bryan Henderson <hbryan@us.ibm.com>, akpm@linux-foundation.org,
	alan <alan@clueserver.org>, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, git@vger.kernel.org
To: Kyle Moffett <mrmacman_g4@mac.com>
X-From: linux-fsdevel-owner@vger.kernel.org Tue Jun 19 09:55:47 2007
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Envelope-to: lnx-linux-fsdevel@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0YZ0-0007jZ-Nx
	for lnx-linux-fsdevel@gmane.org; Tue, 19 Jun 2007 09:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbXFSHzL (ORCPT <rfc822;lnx-linux-fsdevel@m.gmane.org>);
	Tue, 19 Jun 2007 03:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbXFSHzK
	(ORCPT <rfc822;linux-fsdevel-outgoing>);
	Tue, 19 Jun 2007 03:55:10 -0400
Received: from host86-137-96-215.range86-137.btcentralplus.com ([86.137.96.215]:47723
	"EHLO hawkeye.stone.uk.eu.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752431AbXFSHzI (ORCPT
	<rfc822;linux-fsdevel@vger.kernel.org>);
	Tue, 19 Jun 2007 03:55:08 -0400
Received: from [127.0.0.1] ([192.168.0.2])
	(authenticated bits=0)
	by hawkeye.stone.uk.eu.org (8.13.8/8.13.8) with ESMTP id l5J7rVgq022420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Jun 2007 08:53:32 +0100
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <6E9A6F9E-8948-40F2-9129-1F1491D49D83@mac.com>
X-Enigmail-Version: 0.95.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50453>

Kyle Moffett wrote:
> On Jun 18, 2007, at 13:56:05, Bryan Henderson wrote:
>>> The question remains is where to implement versioning: directly in
>>> individual filesystems or in the vfs code so all filesystems can use it?
>>
>> Or not in the kernel at all.  I've been doing versioning of the types
>> I described for years with user space code and I don't remember
>> feeling that I compromised in order not to involve the kernel.
>>
>> Of course, if you want to do it with snapshots and COW, you'll have to
>> ask where in the kernel to put that, but that's not a file versioning
>> question; it's the larger snapshot question.
> 
> What I think would be particularly interesting in this domain is
> something similar in concept to GIT, except in a file-system:
>   1) Redundancy is easy, you just ensure that you have at least "N"
> distributed copies of each object, where "N" is some function of the
> object itself.
>   2) Network replication is easy, you look up objects based on the SHA-1
> stored in the parent directory entry and cache them where needed (IE:
> make the "N" function above dynamic based on frequency of access on a
> given computer).
>   3) Snapshots are easy and cheap; an RO snapshot is a tag and an RW
> snapshot is a branch.  These can be easily converted between.
>   4) Compression is easy; you can compress objects based on any
> arbitrary configurable criteria and the filesystem will record whether
> or not an object is compressed.  You can also compress differently when
> archiving objects to secondary storage.
>   5) Streaming fsck-like verification is easy; ensure the hash name
> field matches the actual hash of the object.
>   6) Fsck is easy since rollback is trivial, you can always revert to an
> older tree to boot and start up services before attempting resurrection
> of lost objects and trees in the background.
>   7) Multiple-drive or multiple-host storage pools are easy:  Think the
> git "alternates" file.
>   8) Network filesystem load-balancing is easy; SHA-1s are essentially
> random so you can just assign SHA-1 prefixes to different systems for
> data storage and your data is automatically split up.
> 
> 
> Other issues:
> 
> Q. How do you deal with block allocation?
> A. Same way other filesystems deal with block allocation. 
> Reference-counting gets tricky, especially across a network, but it's
> easy to play it safe with simple cross-network refcount-journalling. 
> Since the _only_ thing that needs journalling is the refcounts and
> block-free data, you need at most a megabyte or two of journal.  If in
> doubt, it's easy to play it safe and keep an extra refcount around for
> an in-the-background consistency check later on.  When networked-gitfs
> systems crash, you just assume they still have all the refcounts they
> had at the moment they died, and compare notes when they start back up
> again.  If a node has a cached copy of data on its local disk then it
> can just nonatomically increment the refcount for that object in its own
> RAM (ordered with respect to disk-flushes, of course) and tell its peers
> at some point.  A node should probably cache most of its working set on
> local disk for efficiency; it's trivially verified against updates from
> other nodes and provides an easy way to keep refcounts for such data. 
> If a node increments the refcount on such data and dies before getting
> that info out to its peers, then when it starts up again its peers will
> just be told that it has a "new" node with insufficient replication and
> they will clone it out again properly.  For networked
> refcount-increments you can do one of 2 things: (1) Tell at least X many
> peers and wait for them to sync the update out to disk, or (2) Get the
> object from any peer (at least one of whom hopefully has it in RAM) and
> save it to local disk with an increased refcount.
> 
> Q. How do you actually delete things?
> A. Just replace all the to-be-erased tree and commit objects before a
> specified point with "History erased" objects with their SHA-1's
> magically set to that of the erased objects.  If you want you may delete
> only the "tree" objects and leave the commits intact.  If you delete a
> whole linear segment of history then you can just use a single "History
> erased" commit object with its parent pointed to the object before the
> erased segment.  Probably needs some form of back-reference storage to
> make it efficient; not sure how expensive that would be.  This would
> allow making a bunch of snapshots and purging them logarithmically based
> on passage of time.  For instance, you might have snapshots of every 5
> minutes for the last hour, every 30 minutes for the last day, every 4
> hours for the last week, every day for the last month, once per week for
> the last year, once per month for the last 5 years, and once per year
> beyond that.
> 
> That's pretty impressive data-recovery resolution, and it accounts for
> only 200 unique commits after it's been running for 10 years.
> 
> Q. How do you archive data?
> A. Same as deleting, except instead of a "History erased" object you
> would use a "History archived" object with a little bit of string data
> to indicate which volume it's stored on (and where on the volume).  When
> you stick that volume into the system you could easily tell the kernel
> to use it as an alternate for the given storage group.
> 
> Q. What enforces data integrity?
> A. Ensure that a new tree object and its associated sub objects are on
> disk before you delete the old one.  Doesn't need any actual full syncs
> at all, just barriers.  If you replace the tree object before write-out
> is complete then just skip writing the old one and write the new one in
> its place.
> 
> Q. What consists of a "commit"?
> A. Anything the administrator wants to define it as.  Useful algorithms
> include: "Once per x Mbyte of page dirtying", "Once per 5 min", "Only
> when sync() or fsync() are called", "Only when gitfs-commit is called". 
> You could even combine them:  "Every x Mbyte of page dirtying or every 5
> minutes, whichever is shorter (or longer, depending on admin
> requirements)".  There would also be appropriate syscalls to trigger
> appropriate git-like behavior.  Network-accessible gitfs would want to
> have mechanisms to trigger commits based on activity on other systems
> (needs more thought).
> 
> Q. How do you access old versions?
> A. Mount another instance of the filesystem with an SHA-1 ID, a
> tag-name, or a branch-name in a special mount option.  Should be user
> accessible with some restrictions (needs more thought).
> 
> Q. How do you deal with conflicts on networked filesystems.
> A. Once again, however the administrator wants to deal with them.  Options:
>    1)  Forcibly create a new branch for the conflicted tree.
>    2)  Attempt to merge changes using the standard git-merge semantics
>    3)  Merge independent changes to different files and pick one for
> changes to the same file
>    4)  Your Algorithm Here(TM).  GIT makes it easy to extend
> conflict-resolution.
> 
> Q. How do you deal with little scattered changes in big (or sparse) files?
> A. Two questions, two answers:  For sparse files, git would need
> extending to understand (and hash) the nature of the sparse-ness.  For
> big files, you should be able to introduce a "compound-file" datatype
> and configure git to deal with specific X-Mbyte chunks of it
> independently.  This might not be a bad idea for native git as well. 
> Would need system-specific configuration.
> 
> Q. How do you prevent massive data consumption by spurious tiny changes
> A. You have a few options:
>    1)  Configure your commit algorithm as above to not commit so often
>    2)  Configure a stepped commit-discard algorithm as described above
> in the "How do you delete things" question
>    3)  Archive unused data to secondary storage more often
> 
> Q. What about all the unanswered questions?
> A. These are all the ones I could think of off the top of my head but
> there are at least a hundred more.  I'm pretty sure these are some of
> the most significant ones.
> 
> Q. That's a great idea and I'll implement it right away!
> A. Yay!  (but that's not a question :-D)  Good luck and happy hacking.
> 
> Q. That's a stupid idea and would never ever work!
> A. Thanks for your useful input! (but that's not a question either)  I'm
> sure anybody who takes up a project like this will consider such opinions.
> 
> Q. *flamage*
> A. I'm glad you have such strong opinions, feel free to to continue to
> spam my /dev/null device (and that's also not a question).
> 
> All opinions and comments welcomed.
> 
> Cheers,
> Kyle Moffett
> 
> 

It sounds brilliant and I'd love to have a got at implementing it but I
don't know enough (yet :-D) about how git works, a little research is
called for I think.

Jack
