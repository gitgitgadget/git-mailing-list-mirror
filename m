From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Sat, 16 Jul 2011 07:26:43 +0200
Message-ID: <4E212113.6000906@alum.mit.edu>
References: <4E1E97C3.3030306@alum.mit.edu> <4E1EB5E9.1070902@alum.mit.edu> <4E200611.9010005@alum.mit.edu> <7vlivz1inu.fsf@alter.siamese.dyndns.org> <20110715212059.GA2117@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 16 07:31:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhxSu-0000k1-Us
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 07:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab1GPF0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 01:26:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:49563 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1GPF0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 01:26:52 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED16E.dip.t-dialin.net [84.190.209.110])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p6G5Qi7W017888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Jul 2011 07:26:45 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110715212059.GA2117@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177250>

On 07/15/2011 11:20 PM, Jeff King wrote:
> On Fri, Jul 15, 2011 at 11:51:49AM -0700, Junio C Hamano wrote:
>> But I think the replace-object codepath should be optimized to realize
>> there is no funky replacement (which _is_ a rare configuration) going on
>> much early so that it does not incur that much overhead you observed. IOW,
>> I tend to agree with your 3. below.
>> [...]
>>> 3. Optimize the specific case where there is no refs/replace
>>> directory--if this directory is missing, then defer populating the loose
>>> refs cache in the hope that it will never be needed.
> 
> It already tries to do so. It looks like it calls:
> 
>   for_each_replace_ref(...)
> 
> which calls:
> 
>   do_for_each_ref("refs/replace", ...)
> 
> which reads _every_ loose ref, regardless of the prefix we have given
> it. So the optimization should go into the for_each_ref code, which
> should avoid looking at parts of the hierarchy that are just going to be
> culled, no?

The way to implement the deferral of reading refs if for_each_ref() is
called on an empty subtree (alternative 4 or 5 from my earlier email) is
to change get_loose_refs() to take a base argument, have it check
whether the directory corresponding to base is empty, and if so return
NULL without reading anything into the cache.

Currently, the loose ref cache is stored as a single linked list, so
there is no easy way to populate part of it now and part of it later.
So with the current data structure, the loose refs cache is
all-or-nothing.  It would be possible to avoid filling it if there are
not replace references, but if there is even one loose replace reference
then the whole refs tree would have to be crawled.  Implementing this
variation is alternative 4 from the early email.

More flexible would be to change the way the loose ref cache is stored
from a linked list into a tree (probably mirroring the directory tree).
 If this were done, then it would be possible to populate the cache
lazily, only crawling the part of the refs tree that is needed for a
particular call of for_each_ref() and reusing any part of the cache that
is already in memory.  This (alternative "5") is considerably more
involved because the data structure has to be changed, but also
potentially a much bigger win because the presence of a single reference
in refs/replace would not force all of the refs/heads and refs/tags and
... to be read.

> And then we would see immediately that there is no refs/replace at all,
> and quit early. And as a bonus, things like "for_each_tag_ref" would get
> faster in a repository with many branches, too.

Only if the data structure used to hold the loose refs cache is changed...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
