From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] revision.c: introduce --min-parents and --max-parents
Date: Mon, 21 Mar 2011 08:31:57 +0100
Message-ID: <4D86FEED.2030204@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net> <7f2a7d979cd8f6b9fce577994c82f50421575d58.1300459017.git.git@drmicha.warpmail.net> <20110318193401.GA27825@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 08:32:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Zb9-00068H-Vi
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 08:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab1CUHb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 03:31:59 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53190 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751771Ab1CUHb6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 03:31:58 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7587720A2B;
	Mon, 21 Mar 2011 03:31:57 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 21 Mar 2011 03:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ovGG3K5pbfa02XXDe8NZgEOBV8E=; b=hDAaLnNcq///o9wdesdedB4pH8Cb2tmFXxI8Ti5GWFQHc/gX6cTSaO0RiTX33Lo+XLrC6ROkOq2KGUFk51WaHoaSUc8SuIa+AXn6jFgcaWRAan/Ej3HQEoMzyk0TWOEztp9BI856tekP4wBuuC+Gui+0sfzCd9giAdRtUGYYaTE=
X-Sasl-enc: 9syDksFcfXpGuJZNlSuyAhoYktimzOMc/P3VPAmW8P4T 1300692716
Received: from localhost.localdomain (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 615294409E6;
	Mon, 21 Mar 2011 03:31:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110318193401.GA27825@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169555>

Jeff King venit, vidit, dixit 18.03.2011 20:34:
> On Fri, Mar 18, 2011 at 03:50:23PM +0100, Michael J Gruber wrote:
> 
>> Introduce --min-parents and --max-parents which take values 0,...,7 and
>> limit the revisions to those commits which have at least resp. at most
>> that many commits, where --max-parents=8 denotes --max-parents=infinity
>> (i.e. no upper limit). In fact, 7 (or any negative number) does, but 8
>> is infinity sideways 8-)
> 
> In practice, I don't think anybody is all that interested in
> differentiating octopus merges by their numbers of parents. But the
> choice of "7" as a maximum seems kind of arbitrary. There are commits in
> linux-2.6 with up to 31 parents (once upon a time we had an arbitrary
> limit of 16 parents, but that was lifted in v1.6.0).
> 
> You mention below that this fits in three 3 bits in rev_info. I don't
> think bits are precious in rev_info, though, as they are in other
> revision-related structs. We only have one such struct per walk.
> 
> If it were just an implementation issue, I would say fine, we can tweak
> it later if somebody really cares. But we are cementing "7" as the value
> for infinity in the user-facing interface. Wouldn't a value like "-1" or
> "infinity" be more appropriate?

-1 works and "infinity" is difficult to parse.

We could advocate "-1" only, rather than the max which is infinity.

Regarding using an "unbounded" int: I think it is difficult to
distinguish between an unspecified max (value 0 from the initialisation)
and a specified "unbounded" if I don't do the range inversion, which
obviously needs a bounded range. But I'll recheck.

Regarding the 8: Besides the connotation of being infinity sideways,
there's also the undeniable fact that everything with fewer than 8 isn't
really an octo-puss, so the choice of 3 bits is indeed natural!

>> In particular:
>>
>> --max-parents=1: no merges
>> --min-parents=2: merges only
>> --max-parents=0: only roots
>> --min-parents=3: only octopusses
>>
>> --min-parents=n --max-parents=m with n>m gives you what you ask for
>> (nothing) just like --merges --no-merges does, but at least for an
>> obvious reason.
> 
> I like this. It's much more natural than the list syntax I suggested
> earlier, and it handles ranges in an obvious way. It doesn't allow
> selecting, e.g., root commits and merges, but not regular commits. But I
> really don't see the point in supporting that.
> 
>> @@ -2029,10 +2033,15 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>>  		return commit_ignore;
>>  	if (revs->min_age != -1 && (commit->date > revs->min_age))
>>  		return commit_ignore;
>> -	if (revs->no_merges && commit->parents && commit->parents->next)
>> -		return commit_ignore;
>> -	if (revs->merges_only && !(commit->parents && commit->parents->next))
>> -		return commit_ignore;
>> +	if (revs->min_parents || revs->max_parents) {
>> +		int n = 0;
>> +		struct commit_list *p;
>> +		for (p = commit->parents; p; p = p->next)
>> +			n++;
>> +		if ((MIN_PARENTS(n) < revs->min_parents) ||
>> +		    (MAX_PARENTS(n) < revs->max_parents)) /* max is inv. */
>> +			return commit_ignore;
>> +	}
> 
> You did the obvious optimization not to count parents if we don't care
> about min/max. You could also do something like:
> 
>   switch (revs->max_parents) {
>   case 0:
>           if (commit->parents)
>                   return commit_ignore;
>           break;
>   case 1:
>           if (commit->parents && commit->parents->next)
>                   return commit_ignore;
>           break;
>   default:
>           if (count_parents(commit) > commit->max_parents)
>                   return commit_ignore;
>           break;
>   }
> 
> which more closely matches the original code (you would also need to do
> the same for min_parents, and obviously this code ignores the
> max-parents-is-inverted thing).
> 
> I'm not sure it would buy much in practice, though. Commits with more
> than 2 parents are rare, so unnecessarily counting all of them just to
> find out something is a merge is probably not going to create a
> measurable slowdown.

That was exactly my thinking.

> 
>> +/* limit to used range */
>> +#define MIN_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 0 : (__n > 7) ? 7 : __n; })
>> +/* invert fox MAX so that default = 0 -> infinity */
>> +#define MAX_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 7 : (__n > 7) ? 0 : 7 - __n;})
> 
> Hmm. You assign the input to an unsigned int, and then compare it to 0.
> Won't that always be false?

Yes, sorry. I had an int there first, the unsigned gives the "negative =
infinity" automatically.  I probably couldn't decide what
--min-parents=-1 should mean: should "-1" always denote "infinity", or
should it be equivalent to "0"? Switching from signed to unsigned
changed this.

> The inversion trick is clever to make a bzero'd rev_info work, but I
> think the code would be more obvious without it. And you really have to
> call init_revisions() anyway, so initializing it to a maximum there (or
> -1) would be acceptable (e.g., see how max_age and min_age work).

I think for all users of the code it doesn't make a difference since
they would call the macros anyways (for the range check), so it would be
only that single comparison in the walker (which has a comment) that
would become clearer.

Michael
