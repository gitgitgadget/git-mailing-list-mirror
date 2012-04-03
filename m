From: Thomas Gummerer <italyhockeyfeed@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Tue, 3 Apr 2012 21:07:35 +0200
Message-ID: <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com> <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com> <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com> <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:08:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF95M-0004Uy-9w
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 21:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab2DCTH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 15:07:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39060 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab2DCTH4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 15:07:56 -0400
Received: by ghrr11 with SMTP id r11so27403ghr.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=nYt+JtooXonGtiVaMt03fBxEw29MMNoshlUOnwE3fgg=;
        b=FWgRkukAsZEG17PQj/8vQdIPWgrclxgAuuxg2osrLUye7wb5SMIfv3IVFxXgnj61+A
         r/jOz/Cnb4NgmOHo7t+B3f7M9HLB9kKtYrPm6viK0kdqs9wzZ+sx2YQv1tb3foaDWBoI
         BXMXe4iqgxkXZYHlvk4BfGUqozdvbppnvIYEdNvraY7UhzAc0aVB8kSGD2KvssUNEPUi
         eMgq79nWdirOy8Gx2InY43nBQtMMVUl5JcLyn9Hhi8n3Mkzp4Fl8ju9Mx37GrU4utaEW
         HRbCjz3GPtC0T9QJ7/dKMchxDeL/mMgR/jumqdzbIcGmLqFaJ65y8w18CxrJ5HZUHNs6
         MkOQ==
Received: by 10.60.169.174 with SMTP id af14mr20240806oec.13.1333480075615;
        Tue, 03 Apr 2012 12:07:55 -0700 (PDT)
Received: from [10.9.26.196] ([216.18.212.218])
        by mx.google.com with ESMTPS id t4sm778508obv.9.2012.04.03.12.07.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 12:07:55 -0700 (PDT)
In-Reply-To: <4F7ABA19.7040408@alum.mit.edu>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194639>


On Apr 3, 2012, at 10:51 AM, Michael Haggerty wrote:

> On 04/02/2012 11:02 PM, Thomas Gummerer wrote:
>> And here is the proposal:
>> Designing a faster index format
>> 
>> -- Problem --
>> The current git index is pretty slow when working with large git repositories,
>> because the whole index has to be rewritten for nearly every operation. For
>> example for adding a single file with git add, even though logically only one 
>> single blob sha-1 is changed in the index, git has to recompute the hash over 
>> the whole index and rewrite the index file. In addition to that the speed up 
>> for writing the index can not come to the expense of the read operation, since 
>> it is executed more often throughout a normal developers day compared to
>> writing the index. The current index also doesn't allow simple partial reading,
>> which could help speed up some commands, like git status and git diff, which 
>> often don't need the whole index.
>> 
>> -- Proposed solution --
>> The proposed solution is to redesign the index to a B-tree based format. This
>> allows changes to the index in O(log(n)) time, with n being the number of
>> entries in the index. 
> 
> I thought that the index lock currently only blocks writers, not readers
> (am I wrong?).  So given that you want to be able to mutate the index
> file without rewriting the whole file, it seems to me that you have to
> pick from one of these alternatives:
> 
> 1. Change the locking semantics so that readers also block when the file
> is locked.  This choice would have some important consequences: (a)
> readers will also have to obtain a lock before starting to read.  (b) to
> avoid deadlock, it will become crucial that the lock is never held
> across the execution of any other git (sub-)commands that might want to
> read the index.
> 
> 2. Implement a file format that can be read even while it is being
> mutated.  If so, please explain the data file format in more detail; in
> particular, how do you plan to mutate the file in a way that does not
> disturb readers?  How do you plan to read the whole index efficiently (I
> imagine that reading the whole index will remain a frequent operation)?

Did not think about this first, but I will use the first alternative. The most
important thing about this project is the speed and it will be best kept with
the first alternative. I am thinking about two different kind of locks, the read
lock, which blocks writing, but not other reading processes and a write lock,
which will block both other processes to read and write.

> I encourage you to include an analysis of the number of disk seeks when
> you are analyzing the cost of read/write operations on the index.  This
> will have a strong effect on the time for working with the index when
> the disk cache is cold.  The current index requires O(1) seeks for
> reading and writing, which I believe is a big part of the reason that
> the current read-the-whole-index/write-the-whole-index design performs
> excellently despite the amount of data that it is touching.

Seeking took: 429430 (cold)
Reading took: 581 (hot)

Reading took: 1031357 (cold)
Reading took: 53850 (hot)

Writing took: 524909

This is just from a short test program I wrote. Just reads the index, and seeks
over it (obviously not directly one after another but in different scripts). The
writing time is for writing the index that was read back to disk. And this is with
a highly exaggerated number of seeks (1000). 

Also to take into consideration is that the disk cache will (nearly) never be 
cold since git always reads the index first.

> 
>> [...]
>> - Append-only data structure
>> An append-only data structure will allow for changes to the index in O(k) time, 
>> with k being the number of files that changed. To reach this goal, the first 
>> part of the index will be sorted and changes will always be written to the end, 
>> in the order in which the changes occured. This last part of the index will be 
>> merged with the rest using a heuristic, which will be the execution of git 
>> commit and git status.
>> 
>> To make sure the index isn't corrupted, without calculating the sha1 hash for
>> the whole index file every time something is changed, the hash is always
>> calculated for the whole index when merging, but when only a single entry is 
>> changed the sha-1 hash is only calculated for the last change. This will 
>> increase the cost for reading the index to log(n) + k * log(k) where n is the 
>> number of entries in the sorted part of the index and k is the number of entries
>> in the unsorted part of the index, which will have to be merged with the rest 
>> of the index.
> 
> I don't understand this analysis of the reading time.  I suppose you are
> assuming that you want to read the status of a single file.  But in that
> case, it is enough to find the entry in the old index (O(log(n))
> assuming some sort of tree structure) plus do a linear scan through the
> unsorted entries (i.e., O(k), not O(k log(k))).

The current way git operates it always reads the whole index, making it necessary
to merge the unsorted entries with the sorted part. Thinking about it it would even
be O(k log(n)), because the appended part is unsorted.
O(log(n)) + O(k) would be the complexity for loading only a single entry from the
index.

> 
>> [...]
>> This [append-only] idea was dropped, because as mentioned in the problem description reads
>> are more common then writes and therefore trading write speed for read speed
>> is not a good tradeoff.
> 
> The amount of read speed that would have to be sacrificed depends on the
> size of k and n.  Under the assumption that k << n, the read speed of an
> append-only index file format (with periodic compaction) would be close
> to optimal.  For the append-only format, k is the number of files that
> have been changed since the index was last rewritten (including
> duplicates if a file has been changed more than once).  Supposing that
> the index is compacted on branch changes and "occasionally" when k grows
> too large, I have the feeling that k will typically be quite small in
> comparison to n, especially in the huge repositories that need this
> optimization.
> 
> Remember that a full index rewrite/compaction will only take as long as
> it currently takes for *any* change to the index (which is not *that*
> terrible).  It would also be easy to estimate the size of k and n on
> every operation.  Therefore, if an operation is expected to force a
> large fraction of index file entries to be invalidated, it is OK for it
> to force an index compaction to keep subsequent read operations fast.
> And even if, once in a blue moon, somebody changes *all* of the files in
> his huge repository while somehow evading compaction, the time to read
> the full index would still only be a factor of two slower than the
> current design.  (Granted, the time to read a single entry in this
> scenario would be much longer than the log(n) that would be possible
> given a pure-tree-based design.)

Lets take another scenario. Someone changes a lot of files and then executes
some commands which would usually only read the index. In that case either you
would need the load time (O(n)) plus the time for merging (O(k*log(n)), as
described above plus the time for writing the index (O(n)) which usually wouldn't
be necessary.

In addition to that it would also be more complicated and slower to realize
the partial loading, which would be beneficial to a lot of commands. Taking that
into account the tree-based structure will be more future proof, and faster (if 
there are enough changes in a repository) then the append-only structure.