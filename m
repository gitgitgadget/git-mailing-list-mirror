From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Wed, 14 Sep 2005 11:36:08 -0400
Organization: Network Appliance, Inc.
Message-ID: <43284368.8010004@citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu> <20050912145629.28120.70337.stgit@dexter.citi.umich.edu> <Pine.LNX.4.63.0509121633480.23242@iabervon.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050409050600090706030800"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 17:38:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFZJ0-0003yR-42
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 17:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbVINPgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 11:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbVINPgK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 11:36:10 -0400
Received: from citi.umich.edu ([141.211.133.111]:56427 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S965246AbVINPgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 11:36:09 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 06FD61BACA;
	Wed, 14 Sep 2005 11:36:08 -0400 (EDT)
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509121633480.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8532>

This is a multi-part message in MIME format.
--------------050409050600090706030800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Barkalow wrote:
> On Mon, 12 Sep 2005, Chuck Lever wrote:
> 
> 
>>For now, we simply replace indpos with a cache cursor.  Likely more
>>changes will be needed after we successfully replace the cache array
>>with an abstract data type.
> 
> 
> The right order is probably to add the concept of a cache that isn't the 
> one that normal functions deal with, have read_cache_unmerged return such 
> a thing, call cc_init with that, and rip out all of the removal and 
> position adjustment code. Then read_tree won't care at all about the 
> internal structure of the cache type, and it can be replaced without any 
> problem.

ok, i've done this.  read_cache_unmerged now reads into a separate 
cache, and read-tree.c does the merge by moving the appropriate cache 
entries into the active cache.

the linked list prototype is done, and works correctly.  this validates 
the new cache cursor API.  unfortunately because finding a name is now 
O(n), many things are slower than before (but i expected this would be 
the case for lists).

the next step is to try out more sophisticated data types.  we have 
three on the table so far:

1.  linus' sparse hyperlist implementation.  i suspect this will have 
the same bad performance characteristics as a standard linked list.

2.  self-balancing trees.  a splay tree is a good example.  we can 
reduce the size of the tree by storing all stages of a name in each 
node.  kernel source is about 18K files, which means we can find names 
in about 15 steps, on average.

3.  hash table, hashing on ce->name.  similar to a Python dictionary. 
with an 8 kilobucket hash table and a good hash function, we can store 
the kernel source, finding names in two or three steps on average.

are there others?

--------------050409050600090706030800
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
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------050409050600090706030800--
