From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] diff-delta.c: pack the index structure
Date: Sat, 08 Sep 2007 08:48:41 +0200
Message-ID: <85vealzm7q.fsf@lola.goethe.zz>
References: <85fy1q11xv.fsf@lola.goethe.zz>
	<alpine.LFD.0.9999.0709072215420.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 11:00:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITwAY-0006fP-Ak
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 10:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbXIHI7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 04:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbXIHI7x
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 04:59:53 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:54966 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751789AbXIHI7w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 04:59:52 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id A7E6F27B4A3;
	Sat,  8 Sep 2007 08:48:48 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 9825F2D378F;
	Sat,  8 Sep 2007 08:48:48 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-010.pools.arcor-ip.net [84.61.13.10])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 796733226E2;
	Sat,  8 Sep 2007 08:48:44 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E9DFC1CAD71D; Sat,  8 Sep 2007 08:48:41 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.9999.0709072215420.21186@xanadu.home> (Nicolas Pitre's message of "Fri\, 07 Sep 2007 22\:34\:47 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4194/Sat Sep  8 06:33:29 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58110>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 8 Sep 2007, David Kastrup wrote:
>
>> In normal use cases, the performance wins are not overly impressive:
>> we get something like 5-10% due to the slightly better locality of
>> memory accesses using the packed structure.
>
> The gain is probably counterbalanced by the fact that you're copying
> the whole index when packing it, which is unfortunate.

It was a design choice (I don't particularly like it myself).  An
index is created once, used a dozen times.  Doing the packing in-place
implies using realloc on the finished index.  I consider the
likelihood of permanent memory fragmentation higher when doing that
rather than when allocating a fresh area of the same size.

Also a repack in-place is going to cost more operations and have quite
more complicated code.

> Also, could you provide actual test results backing your performance 
> claim?  5-10% is still not negligible.

I did in my git repository

for i in .git/objects/[0-9a-f][0-9a-f]/[0-9a-f]*;do echo $i;done|sed 's+.*ts/\(..\)/+\1+' > /tmp/objlist

and then something like

dak@lola:/usr/local/tmp/git$ time ./git-pack-objects </tmp/objlist --stdout|dd of=/dev/null
4099+2 records in
4100+1 records out
2099205 bytes (2.1 MB) copied, 3.99295 seconds, 526 kB/s

real	0m4.023s
user	0m3.812s
sys	0m0.168s
dak@lola:/usr/local/tmp/git$ time git-pack-objects </tmp/objlist --stdout|dd of=/dev/null
4099+2 records in
4100+1 records out
2099205 bytes (2.1 MB) copied, 4.18734 seconds, 501 kB/s

real	0m4.218s
user	0m4.012s
sys	0m0.160s
dak@lola:/usr/local/tmp/git$ 

repeatedly on a warm cache.  Results were pretty much comparable:
consistently my version was faster, but never more than 10%.

>> -	struct index_entry *entry, **hash;
>> +	struct unpacked_index_entry *entry, **hash;
>> +	struct index_entry *aentry, **ahash;
>
> What does the "a" stand for?

array (as opposed to linked list).  Was the first thing coming into my
mind.  Maybe I should have gone for "p" for packed, but I shied from
it because it often is meant to imply "pointer".

Alternatively I could replace "entry" with "uentry", but that affects
more lines.

What do you propose?

>> +	mem = index+1;
> [...]
>> +	for (i=0; i<hsize; i++) {
> [...]
>> +		for (entry=hash[i]; entry; entry=entry->next)
>
> Minor style nit: please add spaces around "+", "=", "<", etc. for 
> consistency.

Can do.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
