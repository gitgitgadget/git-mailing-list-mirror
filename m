From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git's database structure
Date: Wed, 5 Sep 2007 16:54:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
 <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
 <20070904212507.GA24434@thunk.org> <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>
 <46DE5861.4050201@op5.se> <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
 <46DEC26E.7030809@op5.se> <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andreas Ericsson <ae@op5.se>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 17:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISxDY-00007R-Nb
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 17:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720AbXIEPyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 11:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbXIEPyy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 11:54:54 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:40527 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459AbXIEPyx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 11:54:53 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id AB8BB77B3FD
	for <git@vger.kernel.org>; Wed,  5 Sep 2007 16:54:51 +0100 (BST)
Received: (qmail 5058 invoked by uid 103); 5 Sep 2007 16:54:50 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91.2/4156. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.031101 secs); 05 Sep 2007 15:54:50 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 5 Sep 2007 16:54:50 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57717>

On Wed, 5 Sep 2007, Jon Smirl wrote:

> On 9/5/07, Andreas Ericsson <ae@op5.se> wrote:
>> Jon Smirl wrote:
>>>
>>> The path name field needs to be moved back into the blobs to support
>>> alternative indexes. For example I want an index on the Signed-off-by
>>> field. I use this index to give me the SHAs for the blobs
>>> Signed-off-by a particular person. In the current design I have no way
>>> of recovering the path name for these blobs other than a brute force
>>> search following every path looking for the right SHA.
>>>
>>
>> Ah, there we go. A use-case at last :)

But not a brilliant one.  You sign off on commits not blobs.  So you go
from the sign-off to paths, then to blobs.  There is no need to go from
blob to path unless you deliberately introduce such a need.

>>
>> So now we have a concrete problem that we can formulate thus:
>> "How can one create a database listing the relationship between 'signers'
>> and blobs?"
>>
>> So the second question: Do you seriously argue that git should take a
>> huge performance loss on its common operations to accommodate a need that
>> I suspect very few people have?
>
> Why do you keep jumping to a performance loss? Both schemes will have
> an index based on paths. The problem is how those indexes are
> constructed, not the existence of the index. Moving the paths into the
> blobs in no way prevents you from creating an index on that field.

But moving the path into the blob _IS_ the perfomance hit.  You lose the 
ability to tell the two files have the same content _without even looking 
at the blob_.  This is one of the core parts of making git operations 
blindingly fast.  You can't throw that out, and then say that there is no 
performance hit.

You keep talking about abstract database performance - but git is not an 
abstract database.  It has very specific common usage patterns, and is 
optomisied to handle them.

>
> The problem is that the SHAs have been intertwined with the tree
> nodes. This blending has made it impossible to create other indexes on
> the blobs.
>
> The path index in the flat scheme will probably look just like tree
> nodes do today but these new tree nodes won't be intertwined with the
> SHAs.

And you will have to prove that diff/merge etc. don't become very much 
slower before you get buy in.

-- 
Julian

  ---
Many receive advice, few profit by it.
 		-- Publilius Syrus
