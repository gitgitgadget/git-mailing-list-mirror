From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] diff-delta.c: pack the index structure
Date: Sat, 08 Sep 2007 10:36:05 +0200
Message-ID: <854pi5zh8q.fsf@lola.goethe.zz>
References: <85fy1q11xv.fsf@lola.goethe.zz>
	<alpine.LFD.0.9999.0709072215420.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 10:36:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITvnl-0002uF-Dz
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 10:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbXIHIgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 04:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbXIHIgS
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 04:36:18 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:50857 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751345AbXIHIgR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 04:36:17 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 263852CAF36;
	Sat,  8 Sep 2007 10:36:16 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 153B61B8DFE;
	Sat,  8 Sep 2007 10:36:16 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-010.pools.arcor-ip.net [84.61.13.10])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id B743335E710;
	Sat,  8 Sep 2007 10:36:07 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 46D461CAD71D; Sat,  8 Sep 2007 10:36:05 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.9999.0709072215420.21186@xanadu.home> (Nicolas Pitre's message of "Fri\, 07 Sep 2007 22\:34\:47 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4194/Sat Sep  8 06:33:29 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58109>


I answered this post already, but the answer seems to have disappeared
into a black hole.  What a nuisance.

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 8 Sep 2007, David Kastrup wrote:
>
>> In normal use cases, the performance wins are not overly impressive:
>> we get something like 5-10% due to the slightly better locality of
>> memory accesses using the packed structure.
>
> The gain is probably counterbalanced by the fact that you're copying
> the whole index when packing it, which is unfortunate.

The alternative would be packing in-place.  That's actually a rather
contorted operation, and the gains from packing would then have to be
claimed by "realloc".  I think that realloc is more likely to leave a
fragmented address space (giving the reclaimed memory to the heap
rather than back to the system), but I'd have to check glibc for
details at least on GNU/Linux.

Another option avoiding the realloc would be not to use linked lists
at all but just collect all entries sequentually in "packed" form, and
sort them into order afterwards.  That's an O(n lg n) operation with a
large n.  Even if one has a sorting algorithm with good memory
locality, I doubt that the locality would compensate for the lg n
factor, even when taking into account that we save ourselves the
copying.  And that is not even taken the possibility of having to cull
some buckets into account, another O(n) operation (which amounts to
copying everything once, too).

> Also, could you provide actual test results backing your performance 
> claim?  5-10% is still not negligible.


dak@lola:/usr/local/tmp/git$ for i in .git/objects/[0-9a-f][0-9a-f]/[0-9a-f]*;do echo $i;done|sed 's+.*ts/\(..\)/+\1+' > /tmp/objlist
dak@lola:/usr/local/tmp/git$ time ./git-pack-objects </tmp/objlist --stdout|dd of=/dev/null
4099+2 records in
4100+1 records out
2099205 bytes (2.1 MB) copied, 4.01225 seconds, 523 kB/s

real	0m4.043s
user	0m3.836s
sys	0m0.164s
dak@lola:/usr/local/tmp/git$ time git-pack-objects </tmp/objlist --stdout|dd of=/dev/null
4099+2 records in
4100+1 records out
2099205 bytes (2.1 MB) copied, 4.34936 seconds, 483 kB/s

real	0m4.381s
user	0m4.056s
sys	0m0.176s
dak@lola:/usr/local/tmp/git$ 

Of course, on a warm file system.

>> -	struct index_entry *entry, **hash;
>> +	struct unpacked_index_entry *entry, **hash;
>> +	struct index_entry *aentry, **ahash;
>
> What does the "a" stand for?

array (rather than linked list).  Should I rather rename entry and
hash to uentry and uhash (for unpacked)?

>> +	mem = index+1;
> [...]
>> +	for (i=0; i<hsize; i++) {
> [...]
>> +		for (entry=hash[i]; entry; entry=entry->next)
>
> Minor style nit: please add spaces around "+", "=", "<", etc. for 
> consistency.

Will do.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
