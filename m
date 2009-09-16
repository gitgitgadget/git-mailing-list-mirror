From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH 0/2] Speed up fetch with large number of tags
Date: Wed, 16 Sep 2009 23:32:52 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk> <7vbplb2pi7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:36:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo36m-0004Bi-Qb
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 00:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760245AbZIPWeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 18:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757558AbZIPWeB
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 18:34:01 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:40749 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760164AbZIPWd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 18:33:57 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 59DA6E1218
	for <git@vger.kernel.org>; Wed, 16 Sep 2009 23:33:51 +0100 (BST)
Received: (qmail 14014 invoked by uid 103); 16 Sep 2009 23:32:52 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9808. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.070364 secs); 16 Sep 2009 22:32:52 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 16 Sep 2009 23:32:52 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vbplb2pi7.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128686>

On Wed, 16 Sep 2009, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> I have a repository at $dayjob where fetch was taking ~30s to tell me
>> that there were no updates.
>>
>> It turns out that I appear to have added a nasty linear search of all
>> remote refs for every commit (i.e. tag^{}) tag ref way back in the
>> original C implementation of fetch.  This doesn't scale well to large
>> numbers of refs, so this replaces it with a hash table based lookup
>> instead, which brings the time down to a few seconds even for very large
>> ref counts.
>>
>> I haven't tested it with non-native transports, but there is no reason
>> to believe that the code should be transport specific.
>
> Very interesting.
>
> A few questions (not criticisms).
>
> * 1m50s to 4.5s is quite impressive, even if it is only in a repository
>   with unusual refs-vs-commits ratio, but I personally think 10 refs per
>   every commit is already on the borderline of being insane, and the
>   normal ratio would be more like 1 refs per every 10-20 commits.

I noticed the problem with a real repository at $dayjob, and did enough 
anaylsis to identiy the problem.  I deliberately created a repository that 
should emphasise the problem so that it was easy to get a handle on.

Having applied the ref-dict patches fetch on my $dayjob repo has gone from 
~30s to ~4.5s, which may not be as impressive - but is much easier to live 
with.

>   What are possible downsides with the new code in repositories with more
>   reasonable refs-vs-commits ratio?  A hash table (with a sensible hash
>   function) would almost always outperform linear search in an randomly
>   ordered collection, so my gut tells me that there won't be performance
>   downsides, but are there other potential issues we should worry about?

I guess that main thing would be the extra memory usage.

> * In an insanely large refs-vs-commits case, perhaps not 50000:1 but more
>   like 100:1, but with a history with far more than one commit, what is
>   the memory consumption?  Judging from a cursory view, I think the way
>   ref-dict re-uses struct ref might be quite suboptimal, as you are using
>   only next (for hash-bucket link), old_sha1[] and its name field, and
>   also your ref_dict_add() calls alloc_ref() which calls one calloc() per
>   requested ref, instead of attempting any bulk allocation.

Yeah, I just reused struct for speed and convience of developing, to 
veryify that ref-dict would give me the speed I wanted.  A final patch 
would want a more optimised version.  Except that I've thrown the whole 
hash table thing away anyway.

> * The outer loop is walking the list of refs from a transport, and the
>   inner loop is walking a copy of the same list of refs from the same
>   transport, looking for each refs/tags/X^{} what record, if any, existed
>   for refs/tags/X.
>
>   Would it make sense to further specialize your optimization?  For
>   example, something like...

I actually arrived at somthing similar to this myself, after realising 
that I could use string_list as a basis.

> * It is tempting to use a hash table when you have to deal with an
>   unordered collection, but in this case, wouldn't the refs obtained from
>   the transport (it's essentially a ls-remote output, isn't it?) be
>   sorted?  Can't you take advantage of that fact to optimize the loop,
>   without adding a specialized hash table implementation?

I wasn't sure if we could rely on the refs list being sorted.  But I've 
got a new version that uses an extra string_list instead that is actually 
slightly faster.  I'll post that shortly.

>   We find refs/tags/v0.99 immediately followed by refs/tags/v0.99^{} in
>   the ls-remote output.  And the inefficient loop is about finding
>   refs/tags/v0.99 when we see refs/tags/v0.99^{}, so if we remember the
>   tag ref we saw in the previous round, we can check with that first to
>   make sure our "sorted" assumption holds true, and optimize the loop out
>   that way, no?

-- 
Julian

  ---
Bilbo's First Law:
 	You cannot count friends that are all packed up in barrels.
