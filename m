From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Documentation/git-filter-branch.txt: Fix description of --commit-filter
Date: Fri, 30 May 2008 17:33:02 -0700
Message-ID: <AF9CB160-FFC9-4372-BE86-5FAC6B59A050@sb.org>
References: <1212183820-40712-1-git-send-email-kevin@sb.org> <7vlk1rh0av.fsf@gitster.siamese.dyndns.org> <98EEBDF4-9964-4CA6-ABBD-DB72C4F6CAD3@sb.org> <7v63svgy0q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 31 02:34:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2F39-0000zJ-6f
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 02:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbYEaAdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 20:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbYEaAdH
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 20:33:07 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:60900 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751446AbYEaAdG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 20:33:06 -0400
Received: from [10.100.18.156] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id F2D48AF936;
	Fri, 30 May 2008 17:33:02 -0700 (PDT)
In-Reply-To: <7v63svgy0q.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83361>

On May 30, 2008, at 4:41 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
>
>>> But I am also confused by the new description:
>>>
>>>       In that history, we will make sure that rewritten D (original
>>>       commit being C) have A as parent.  IOW, we will have
>>>
>>>               --A'--C'  D'
>>>                        /
>>>                       A
>>>
>>> which is not what happens.  What it does is that the commits in the
>>> output
>>> from the filter (i.e. A) are first mapped to the corresponding
>>> commits in
>>> the rewritten history (i.e. A'), and they will be used as the
>>> parents of
>>> the rewritten commit, to form this history:
>>>
>>>               --A'--C'
>>>
>>> isn't it?
>>
>> So basically, you think it's missing the fact that the emitted id is
>> mapped to rewritten commits? From reading the git-filter-branch code,
>> I don't think that's correct. When each commit is created, its
>> original parents get mapped to new values, but the results of the
>> commit-filter are dumped straight into the map.
>
> Ah, I misread this part of the code:
>
> 	parentstr=
> 	for parent in $parents; do
> 		for reparent in $(map "$parent"); do
> 			parentstr="$parentstr -p $reparent"
> 		done
> 	done
> 	if [ "$filter_parent" ]; then
> 		parentstr="$(echo "$parentstr" | eval "$filter_parent")" ||
> 				die "parent filter failed: $filter_parent"
> 	fi
>
> You get the commit object names from the new history, and you are  
> supposed
> to give back names from the new history from the filter.
>
> So "the rewritten commit will have the output from parent-filter as  
> its
> parents" is what happens, right?
>
> IOW, in the history in the previous message, when rewriting C (to  
> create
> C'), the filter will get A' and B' (i.e. from the new history), and  
> can
> choose to return A', and that is recorded when creating C'.  "the
> rewritten children of the commit" in your:
>
>    +commit ids; in that case, the rewritten children of the original
>    +commit will have all of them as parents.
>
> sounded as if you are talking about D' not C', and that was what I was
> confused about.

I was talking about D'. You've switched from talking about the commit- 
filter to talking about the parent-filter.

If a parent-filter is specified, it will be run on the parents that  
are handed to the commit-filter (before the commit-filter is invoked),  
but that's not relevant right now.

When using the commit-filter to rewrite C (to create C'), when A is  
returned, that's dumped into the map so in the future, $(map C) will  
return A. This means that when D is processed, it's handed A as the  
parent.

>> To give an example, let's examine your tree. A will be processed
>> first, and A' gets put into the map for A. B gets processed next (or
>> maybe before A, but that's irrelevant) and B' gets put into the map
>> for B. C gets processed, and it emits A, so A goes into the map for  
>> C.
>
> Hmm?  I meant C is rewritten to become C' but when it does so filter  
> can
> remove B from its parent set (iow, the filter is told that unless it
> intervenes C' will have A' and B' as its parents, but the filter can
> choose to return only A').  So I do not quite get "it emits A"  
> part.  Do
> you mean "the filter outputs A'"?  Also do you mean by "map" the  
> mapping
> from <A, B, C> to <A', B', C'> commit namespace?  If so, even when the
> filter "emits A'", I do not think it "goes into the map for C".   
> When the
> filter "emits A'", it is used as _the_ single parent to create C',  
> and it
> is C' that "goes into the map for C".  Am I still confused?
>
> Now, I admit that I did not look at the implementation of the "map"  
> in the
> code quoted above.  Perhaps that thing is busted, I dunno.


You're still talking about the parent-filter here. I think you're  
quite confused.

Given this history to start:

             B
              \
           A---C---D

Also given that we're specifying a commit-filter but *not* a parent- 
filter.

When that commit-filter is given A and B, it returns A' and B' without  
doing any changes (A' and B' in this case come from git-commit-tree).  
When given C, the commit-filter returns A. When given D, it returns D'  
again with no changes.

The resulting history will look like this:

            B'

          A'   A---D'

As you can see, there is no C' commit (as the commit-filter simply  
returned A), and the A' and B' commits are left dangling.

Here is a shell script which will generate this exact repo:

http://pastie.textmate.org/206265

If you inspect the result, you'll see HEAD points to D' with a parent  
of A, and that there are two dangling commits A' and B'.

What I was talking about with the map can be demonstrated here. If you  
edit the commit-filter to print out some debug info while writing D',  
you can see that $(map $(git rev-parse C)) will output $(git rev-parse  
A).

-Kevin

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
