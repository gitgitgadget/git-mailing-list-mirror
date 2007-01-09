From: Andreas Ericsson <ae@op5.se>
Subject: Re: I just pulled and built 'next'...
Date: Tue, 09 Jan 2007 10:39:28 +0100
Message-ID: <45A362D0.7090304@op5.se>
References: <E1H3uc2-0004m1-Ua@think.thunk.org> <7vvejhwa6g.fsf@assigned-by-dhcp.cox.net> <20070108210002.GA15121@thunk.org> <20070109032124.GA1904@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 10:39:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4DSA-0005cd-Sy
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 10:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbXAIJjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 04:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbXAIJjb
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 04:39:31 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41508 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbXAIJjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 04:39:31 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 10AAF6BCD4; Tue,  9 Jan 2007 10:39:29 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070109032124.GA1904@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36335>

Shawn O. Pearce wrote:
> Theodore Tso <tytso@mit.edu> wrote:
>> On Mon, Jan 08, 2007 at 12:11:35PM -0800, Junio C Hamano wrote:
>>> One question is how you would sort the result.  If you sort them
>>> by taggerdate, you would get v1.4.4.4 anyway ;-).
>> I was assuming either lexigraphically, or via some really complicated
>> rpm/dpkg version number comparison scheme.  :-)
>>
>>> If we go with topology, we do not necessarily have to find all
>>> the tags.  When we hit a commit that is tagged, we can stop the
>>> traversal (so after finding v1.5.0-rc0, we do not have to go
>>> back along the 'master' lineage to find v1.4.4 tag).  Traversing
>>> from the tip of 'master' (or 'next') this way we will notice
>>> that v1.5.0-rc0 and v1.4.4.4 are the candidates without going
>>> any further in the past.
>>>
>>> But the question still remains which one between the two to
>>> pick.
>> Yeah, that is the question.  If we're willing to look at the tag name,
>> it's pretty clear that if both v1.5.0-rc0 and v1.4.4.4 is reachable
>> from the head, it should be based on the "newer" version, i.e.,
>> v1.5.0-rc0.  A human can figure this out easily, but algorithimically
>> we end up having to use something like the rpm or dpkg version
>> comparison algorithm, both of which are hueristics that will sometimes
>> get thigns wrong.
> 
>   $ git rev-list v1.5.0-rc0..next | wc -l
>   687
>   $ git rev-list v1.4.4.4..next | wc -l
>   1051
> 

$ git rev-list v1.5.0-rc0..master | wc -l
220
$ git rev-list v1.4.4.4..master | wc -l
584

so that's one more case where it got things right.

> So what about doing Junio's suggestion of going by topology and
> coming up with the possible set of tags (v1.5.0-rc0 and v1.4.4.4
> right now), and if more than one is found compute the number of
> commits between each tag and the requested revision, and take the
> tag that has a smallest number of commits?
> 

Sounds sensible. Without doing this, we'd more or less constantly get 
bitten by it when pulling a maintenance branch with a (as currently 
calculated) more recent tag than the one that actually sits on the 
branch we're tagging.

The only case we'd get it wrong is if tags are close to each other, 
someone tags a feature-branch before it being merged to master, then 
merges it and cuts a release.

In my experience all software projects have a single branch used for 
releases, and that's the one that's checked out when the tag is created.

> I think it would come up right more often than not and avoids
> any sort of tag name parsing algorithm.  It is also somewhat
> explainable to users as it does have some common sense: the tag
> "nearest" to the requested revision is the one that has the most
> number of commits in common with the requested revision.
> 

The only problem I foresee is that v1.4.4.4 *looks* closer when viewed 
in gitk/qgit, but there it also looks like it's on a different branch, 
so we're probably safe from user harrassment there too.

Possibly we'd want to have both, with the old behaviour requiring a 
switch to obtain (--date-order ?).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
