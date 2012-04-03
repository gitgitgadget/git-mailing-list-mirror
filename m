From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [GSoC] Designing a faster index format
Date: Tue, 03 Apr 2012 10:51:37 +0200
Message-ID: <4F7ABA19.7040408@alum.mit.edu>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com> <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com> <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com> <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Thomas Gummerer <italyhockeyfeed@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 10:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEzSz-0000ws-PU
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 10:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab2DCIvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 04:51:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:42572 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab2DCIvr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 04:51:47 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q338pbgR008988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Apr 2012 10:51:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Lightning/1.0b2 Thunderbird/3.1.20
In-Reply-To: <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194606>

On 04/02/2012 11:02 PM, Thomas Gummerer wrote:
> And here is the proposal:
> Designing a faster index format
> 
> -- Problem --
> The current git index is pretty slow when working with large git repositories,
> because the whole index has to be rewritten for nearly every operation. For
> example for adding a single file with git add, even though logically only one 
> single blob sha-1 is changed in the index, git has to recompute the hash over 
> the whole index and rewrite the index file. In addition to that the speed up 
> for writing the index can not come to the expense of the read operation, since 
> it is executed more often throughout a normal developers day compared to
> writing the index. The current index also doesn't allow simple partial reading,
> which could help speed up some commands, like git status and git diff, which 
> often don't need the whole index.
> 
> -- Proposed solution --
> The proposed solution is to redesign the index to a B-tree based format. This
> allows changes to the index in O(log(n)) time, with n being the number of
> entries in the index. 

I thought that the index lock currently only blocks writers, not readers
(am I wrong?).  So given that you want to be able to mutate the index
file without rewriting the whole file, it seems to me that you have to
pick from one of these alternatives:

1. Change the locking semantics so that readers also block when the file
is locked.  This choice would have some important consequences: (a)
readers will also have to obtain a lock before starting to read.  (b) to
avoid deadlock, it will become crucial that the lock is never held
across the execution of any other git (sub-)commands that might want to
read the index.

2. Implement a file format that can be read even while it is being
mutated.  If so, please explain the data file format in more detail; in
particular, how do you plan to mutate the file in a way that does not
disturb readers?  How do you plan to read the whole index efficiently (I
imagine that reading the whole index will remain a frequent operation)?

I encourage you to include an analysis of the number of disk seeks when
you are analyzing the cost of read/write operations on the index.  This
will have a strong effect on the time for working with the index when
the disk cache is cold.  The current index requires O(1) seeks for
reading and writing, which I believe is a big part of the reason that
the current read-the-whole-index/write-the-whole-index design performs
excellently despite the amount of data that it is touching.

> [...]
> - Append-only data structure
> An append-only data structure will allow for changes to the index in O(k) time, 
> with k being the number of files that changed. To reach this goal, the first 
> part of the index will be sorted and changes will always be written to the end, 
> in the order in which the changes occured. This last part of the index will be 
> merged with the rest using a heuristic, which will be the execution of git 
> commit and git status.
> 
> To make sure the index isn't corrupted, without calculating the sha1 hash for
> the whole index file every time something is changed, the hash is always
> calculated for the whole index when merging, but when only a single entry is 
> changed the sha-1 hash is only calculated for the last change. This will 
> increase the cost for reading the index to log(n) + k * log(k) where n is the 
> number of entries in the sorted part of the index and k is the number of entries
> in the unsorted part of the index, which will have to be merged with the rest 
> of the index.

I don't understand this analysis of the reading time.  I suppose you are
assuming that you want to read the status of a single file.  But in that
case, it is enough to find the entry in the old index (O(log(n))
assuming some sort of tree structure) plus do a linear scan through the
unsorted entries (i.e., O(k), not O(k log(k))).

> [...]
> This [append-only] idea was dropped, because as mentioned in the problem description reads
> are more common then writes and therefore trading write speed for read speed
> is not a good tradeoff.

The amount of read speed that would have to be sacrificed depends on the
size of k and n.  Under the assumption that k << n, the read speed of an
append-only index file format (with periodic compaction) would be close
to optimal.  For the append-only format, k is the number of files that
have been changed since the index was last rewritten (including
duplicates if a file has been changed more than once).  Supposing that
the index is compacted on branch changes and "occasionally" when k grows
too large, I have the feeling that k will typically be quite small in
comparison to n, especially in the huge repositories that need this
optimization.

Remember that a full index rewrite/compaction will only take as long as
it currently takes for *any* change to the index (which is not *that*
terrible).  It would also be easy to estimate the size of k and n on
every operation.  Therefore, if an operation is expected to force a
large fraction of index file entries to be invalidated, it is OK for it
to force an index compaction to keep subsequent read operations fast.
And even if, once in a blue moon, somebody changes *all* of the files in
his huge repository while somehow evading compaction, the time to read
the full index would still only be a factor of two slower than the
current design.  (Granted, the time to read a single entry in this
scenario would be much longer than the log(n) that would be possible
given a pure-tree-based design.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
