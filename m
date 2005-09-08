From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 08 Sep 2005 11:06:21 -0400
Organization: Network Appliance, Inc.
Message-ID: <4320536D.2010706@citi.umich.edu>
References: <20050907164734.GA20198@c165.ib.student.liu.se>	<7v1x407min.fsf@assigned-by-dhcp.cox.net>	<431F34FF.5050301@citi.umich.edu> <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070401040001040402030802"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 17:09:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDNyu-0002Sr-N0
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 17:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbVIHPGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 11:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbVIHPGZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 11:06:25 -0400
Received: from citi.umich.edu ([141.211.133.111]:22840 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932610AbVIHPGX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 11:06:23 -0400
Received: from [10.58.52.58] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 49E741BBAE;
	Thu,  8 Sep 2005 11:06:22 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8200>

This is a multi-part message in MIME format.
--------------070401040001040402030802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Chuck Lever <cel@citi.umich.edu> writes:
> 
> 
>>for the past two weeks i've been attempting to replace the active_cache 
>>array with an abstract data type (linked list just as a prototype) in 
>>order to eliminate the need to use memmove() during insertions and 
>>deletions.
>>
>>one big win is that the merge algorithm no longer needs to overwrite the 
>>active_cache.  you can keep two lists and simply move elements from one 
>>to the other as you do the merge, and then hook the new, merged list 
>>back to the cache head when you're done.
>>
>>anyway, i'm at a point where i could use some help and advice if this is 
>>something you think could be useful in the long run.
> 
> 
> This is interesting.
> 
> For something like a kernel tree that has around 18k entries, a
> single memmove will at the worst case move that many pointers,
> so naturally a list based implementation would perform well for
> many insertions and deletions.   On the other hand, the list
> based implementation would make it very expensive to find an
> entry read-only, I suspect, unlike the array based
> implementation which lets us do binary search.

using a list was an easy prototype to see what issues there are when 
converting from an array into an abstract data type.  i've created a few 
helpers that allow me to limit the list implementation changes to 
cache.h, read-cache.c, and read-tree.c; but having these helpers means 
it should be fairly simple to switch to any reasonable data structure. 
(the helper parts are already working and i can post them to the list if 
folks are interested).

once the list implementation is working well, i plan to go back and 
replace it with something more sophisticated which can perform 
insertion, deletion, and searching efficiently.

in the long run, i see using a balanced tree.  that would make 
insertions and searches quick, and prevent the tree from degenerating 
into a linked list due to a series of in-order insertions.  a splay tree 
might be even more entertaining, as it always remains balanced, and a 
search operation places the found node or insertion point right at the 
root of the tree.

each node in the tree would represent a unique path, and have references 
to the entries of all four stages, contained in an array.  that would 
simplify several routines in read-cache.c and probably make the merge 
logic even easier to understand and more efficient.

> I haven't timed it like you did, but my gut feeling is that the
> most wastage during the merge is coming from having to move
> entries because we "insert into" or "remove from" the same
> active-cache array.

the merge actually replaces entries in place, so it is already fairly 
efficient.  the wastage in the merge case arises from the many list 
insertions done by read_cache, all of which involve moving some of the 
active cache array.

> If we allocate a new array and populate it
> from scratch as we iterate through the paths being merged and
> replace the active_cache pointer at the very end, we would do
> much better without going to a linked list implementation, which
> would penalize the normal read-only case.

i can already tell you that using a separate source and destination data 
structure during the merge simplifies the logic and makes it easier to 
understand.  i imagine it will also be easier to maintain and enhance in 
the long run.

> I think what Daniel
> did to read-tree recently, still in the proposed updates branch,
> would make this kind of change far easier to implement.

as i'm new to git development, i wasn't aware of the proposed branch.  i 
will see if i can take a look (or send me a pointer to the list archives 
if he has posted them here).

> I wanted to cc this message to Daniel but your message to me was
> somehow private so I did not.  Please feel free to bring this
> issue up either with him directly or on the list.

i wanted to assess whether this was a reasonable idea or if there was 
already work in progress in this area.  thanks for your response!

--------------070401040001040402030802
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


--------------070401040001040402030802--
