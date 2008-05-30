From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Documentation/git-filter-branch.txt: Fix description of --commit-filter
Date: Fri, 30 May 2008 16:07:38 -0700
Message-ID: <98EEBDF4-9964-4CA6-ABBD-DB72C4F6CAD3@sb.org>
References: <1212183820-40712-1-git-send-email-kevin@sb.org> <7vlk1rh0av.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 31 01:08:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Di6-00074m-FS
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 01:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbYE3XHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 19:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYE3XHm
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 19:07:42 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:56311 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752488AbYE3XHl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 19:07:41 -0400
Received: from [10.100.18.156] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id CA9BD109EB5;
	Fri, 30 May 2008 16:07:39 -0700 (PDT)
In-Reply-To: <7vlk1rh0av.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83355>

On May 30, 2008, at 3:52 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
>
>> The old description was misleading and logically impossible. It  
>> claimed that
>> the ancestors of the original commit would be re-written to have  
>> the multiple
>> emitted ids as parents. Not only would this modify existing  
>> objects, but it
>> would create a cycle. What this actually does is pass the multiple  
>> emitted ids
>> to the newly-created children to use as parents.
>>
>> Signed-off-by: Kevin Ballard <kevin@sb.org>
>> ---
>> Documentation/git-filter-branch.txt |    4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-filter-branch.txt b/Documentation/ 
>> git-filter-branch.txt
>> index 506c37a..541bf23 100644
>> --- a/Documentation/git-filter-branch.txt
>> +++ b/Documentation/git-filter-branch.txt
>> @@ -113,8 +113,8 @@ OPTIONS
>> 	stdin.  The commit id is expected on stdout.
>> +
>> As a special extension, the commit filter may emit multiple
>> -commit ids; in that case, ancestors of the original commit will
>> -have all of them as parents.
>> +commit ids; in that case, the rewritten children of the original  
>> commit will
>> +have all of them as parents. You probably don't want to do this.
>> +
>
> Now I am _very_ confused.
>
> The original description sounds as if:
>
>        In this history, when rewriting commit C, if we emit A from the
>        filter:
>
>                     B
>                      \
>                ---A---C---D
>
>        We will somehow make 'A' and 'B' have A as their parents.
>
> which is wrong as you pointed out.
>
> But I am also confused by the new description:
>
>        In that history, we will make sure that rewritten D (original
>        commit being C) have A as parent.  IOW, we will have
>
>                --A'--C'  D'
>                         /
>                        A
>
> which is not what happens.  What it does is that the commits in the  
> output
> from the filter (i.e. A) are first mapped to the corresponding  
> commits in
> the rewritten history (i.e. A'), and they will be used as the  
> parents of
> the rewritten commit, to form this history:
>
>                --A'--C'
>
> isn't it?

So basically, you think it's missing the fact that the emitted id is  
mapped to rewritten commits? From reading the git-filter-branch code,  
I don't think that's correct. When each commit is created, its  
original parents get mapped to new values, but the results of the  
commit-filter are dumped straight into the map.

To give an example, let's examine your tree. A will be processed  
first, and A' gets put into the map for A. B gets processed next (or  
maybe before A, but that's irrelevant) and B' gets put into the map  
for B. C gets processed, and it emits A, so A goes into the map for C.  
Then D is processed, and its original parent C is looked up in the map  
and A is returned. So, as near as I can tell, that "broken" history is  
exactly what you'll get if the commit-filter returns A for C. This  
means that when you're writing a commit-filter for this, you probably  
want to emit $(map A), not A.

Perhaps the description should be significantly expanded to include  
the diagrams and explanations?

> Also you did not defend why you added "You probably don't want to do  
> this"
> to the description.


Because when the commit-filter emits multiple ids, it's converting the  
child commits into merges without even knowing what the child commits  
will be. I was just trying to warn people away from using this feature  
unless they know exactly what they're doing. Usually you want to use a  
parent-filter if you're converting commits into merges, because that  
way you know exactly what commits you're modifying.

-Kevin

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
