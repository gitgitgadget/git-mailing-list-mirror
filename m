From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH 2/3] simplify-merges: never remove all TREESAME parents
Date: Sun, 28 Apr 2013 10:10:15 +0300
Message-ID: <517CCB57.3060807@bracey.fi>
References: <517AD304.6020807@bracey.fi> <1367004718-30048-1-git-send-email-kevin@bracey.fi> <1367004718-30048-2-git-send-email-kevin@bracey.fi> <7vli83shk0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 09:10:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWLkm-0005MN-IY
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 09:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197Ab3D1HKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 03:10:19 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:54897 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751061Ab3D1HKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 03:10:18 -0400
Received: from mail431.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 33138DC16D0
	for <git@vger.kernel.org>; Sun, 28 Apr 2013 09:10:17 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 28 Apr 2013 09:12:36 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 28 Apr 2013 09:12:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <7vli83shk0.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 14691586411085336792
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.501484/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222729>

On 28/04/2013 02:02, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> In the event of an odd merge, we may find ourselves TREESAME to
>> apparently redundant parents. Prevent simplify_merges() from removing
>> every TREESAME parent - in the event of such a merge it's useful to see
>> where we came actually from came.

"came from" :)

>>
>> @@ -2106,8 +2106,32 @@ static int remove_marked_parents(struct rev_info *revs, struct commit *commit)
>>   {
>>   	struct treesame_state *ts = lookup_decoration(&revs->treesame, &commit->object);
>>   	struct commit_list **pp, *p;
>> +	struct commit *su = NULL, *sm = NULL;
> What do "su" and "sm" stand for?

"same, unmarked" and "same, marked" were what was in my head.


> Could you explain here a bit more the reason why we do not want to
> remove them and why "-s ours" is so significant that it deserves to
> be singled out?  And why randomly picking one that is redundant
> (because it is an ancestor of some other parent) is an improvement?

I feel it's consistent with the default non-full-history behaviour. The 
parent that we choose not to remove is the  same one that the default 
log with "simplify_history==1" would have followed: the first parent we 
are TREESAME to. Or at least that's the intent. So this parent would 
normally be singled out, and it's not an arbitrary (or "random") choice.

It feels wrong to me that --full-history --simplify-merges could produce 
a disjoint history from the default. I think it should include the 
default simple history. If this code triggered, it should produce 
something quite distinctive in a graphical view, which will help find 
odd/broken merges.


> The "remove-redundant" logic first marks commits that are ancestors
> of other commits in the original set, without taking treesame[] into
> account at all.  If the final objective of the code is to keep paths
> that consists of non-treesame[] commits, perhaps the logic needs to
> be changed to reject non-treesame[] commits that are ancestors of
> other non-treesame[] commits, or something?

Maybe - the main simplify_merges machinery could certainly make use of 
the treesame[] information, and one of the motivations for introducing 
it was to open up the possibility of richer analysis. I'll spend a 
little time to think about whether we want a more fundamental change to 
the original scan.

But this patch as it stands was an "easy" change to make with clearly 
limited scope and relatively little risk - I specifically wanted just to 
include our default "simple" parent.

Kevin
