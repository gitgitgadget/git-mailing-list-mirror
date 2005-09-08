From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 08 Sep 2005 14:58:32 -0400
Organization: Network Appliance, Inc.
Message-ID: <432089D8.4060507@citi.umich.edu>
References: <20050907164734.GA20198@c165.ib.student.liu.se> <7v1x407min.fsf@assigned-by-dhcp.cox.net> <431F34FF.5050301@citi.umich.edu> <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net> <4320536D.2010706@citi.umich.edu> <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org> <43207FE6.2030108@citi.umich.edu> <Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080407020900020001000706"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 21:00:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDRbo-0005KV-Ab
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 20:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVIHS6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 14:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVIHS6f
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 14:58:35 -0400
Received: from citi.umich.edu ([141.211.133.111]:33973 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964925AbVIHS6f (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 14:58:35 -0400
Received: from [10.58.48.252] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id BFC921BAA9;
	Thu,  8 Sep 2005 14:58:33 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8212>

This is a multi-part message in MIME format.
--------------080407020900020001000706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Thu, 8 Sep 2005, Chuck Lever wrote:
> 
>>in my case the merges were taking significantly longer than a half 
>>second.  making this change is certainly not worth it if merges are 
>>running fast...
> 
> 
> Note that in cold-cache cases, all the expense of read-tree is in actually
> reading the tree objects themselves (a kernel tree has more than a
> thousand subdirectories). Also, a full "git pull" will do the diffstat 
> etc, and then the expense ends up being in the actual "git diff" part.
> 
> So read-tree itself may be half a second, but a merge ends up having other 
> parts.

i measured this using the following test...

i have a linux kernel git repository under control of stgit and it has 
about 70 patches in it.  i did an "stg status" to heat the page cache. 
i popped all the patches, then did an "stg pull origin".

i started oprofile, and did an "stg push -a".  it took about 9 minutes.

i stopped oprofile and looked at the results.  roughly 65% of the total 
CPU time was spent in libc:memmove.  after instrumenting git, i 
determined that in the "stg push" case the critical memmove was the one 
in add_cache_entry.

note that i'm not saying that the 9 minutes of wall clock time was 
entirely due to CPU... catalin has been steadily improving "stg push" so 
this time has shortened by more than half, recently.  but i do notice 
that working in a kernel repository is significantly slower than working 
in my git or stgit source repositories, which are smaller by far.  the 
small repositories behave just as i expect, the tools respond quite 
snappily.

>>they are still read-only with my linked list implementation.
> 
> Btw, in the sparse project, we have this really smart "pointer list" data
> structure, which is extremely space- and time-efficient. It ends up
> _looking_ like a linked list, but it batches things up in hunks of 29
> entries (29 pointers plus overhead gives you blocks of 32 longwords, which
> is the allocation size) and thus gives basically a cache-friendly
> doubly-linked list. It knows how to do insertions, traversals etc very 
> efficiently.
> 
> Any interest?

i'm not married to splay trees.  i think we should explore several 
different data structures before picking one, and this one sounds 
reasonable to try.

--------------080407020900020001000706
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------080407020900020001000706--
