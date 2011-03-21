From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] revision.c: introduce --min-parents and --max-parents
Date: Mon, 21 Mar 2011 10:26:31 +0100
Message-ID: <4D8719C7.7020905@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net> <7f2a7d979cd8f6b9fce577994c82f50421575d58.1300459017.git.git@drmicha.warpmail.net> <20110318204854.GA23331@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 10:26:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1bNm-0004Jm-8z
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab1CUJ0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 05:26:34 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33515 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751056Ab1CUJ0c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 05:26:32 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 18F68205ED;
	Mon, 21 Mar 2011 05:26:32 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 21 Mar 2011 05:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4uVtgRzgkBwGJxHV2fCQWetSLHI=; b=scxouGLjlJRnHKB0WJ0QZ7x+wXFtCQ8S9C+UzIl1DQXj6H6ZXcLHvOsqem6H+y03nBONPdoUlLyYkF0Ux6ilMwOEqEOiqFX6I3wNryCVpgakYgXwrNQMTT7JaVleUzUKzIkSToW5XYub8cf926lGNDXR+DvclgdAnfMrZ7nmUxw=
X-Sasl-enc: bBLj78p/xtxEW6+Og0nVp7mI6pBnYmEj0vq5PlyfHVKJ 1300699591
Received: from localhost.localdomain (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D4FEC446D69;
	Mon, 21 Mar 2011 05:26:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110318204854.GA23331@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169564>

Jonathan Nieder venit, vidit, dixit 18.03.2011 21:48:
> Hi,
> 
> Michael J Gruber wrote:
> 
>> --max-parents=1: no merges
>> --min-parents=2: merges only
>> --max-parents=0: only roots
>> --min-parents=3: only octopusses
> 
> This is growing on me.  Thanks for inventing it.

Thanks for teaching me a new collocation (to grow on sb) ;)

> 
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -1061,7 +1061,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>  	rev.commit_format = CMIT_FMT_EMAIL;
>>  	rev.verbose_header = 1;
>>  	rev.diff = 1;
>> -	rev.no_merges = 1;
>> +	rev.max_parents = MAX_PARENTS(1);
> 
> Is there a reason not to choose a convention for which
> 
> 	rev.max_parents = 1;
> 
> works?

Yes.

Oh, you also want to know what it is? I was somehow fixed on using a
limited number of bits (probably because of no_merges etc. and the
mentioning of tri-state), therefore using a bounded range.

Also, I was keen of having "8" be infinity. (My fingers are trained to
enter "`8" to get "\infty".) But I've come to realise I'm the only one.

> 
> What does --no-merges --merges do?  I would find it most intuitive to
> error out (since some people would want the last choice to win and
> others want --merges-only --nonmerges-only to select the empty set),
> but this patch does the backward-compatible thing, which is to show

Yes, a true case of being "backward(!)-compatible"...

> zero commits.  Maybe it deserves a test case?
> 
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1277,9 +1277,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>>  	} else if (!strcmp(arg, "--remove-empty")) {
>>  		revs->remove_empty_trees = 1;
>>  	} else if (!strcmp(arg, "--merges")) {
>> -		revs->merges_only = 1;
>> +		revs->min_parents = MIN_PARENTS(2);
> 
> Why not "revs->min_parents = 2;"?

For consistency.

> 
>>  	} else if (!strcmp(arg, "--no-merges")) {
>> -		revs->no_merges = 1;
>> +		revs->max_parents = MAX_PARENTS(1);
>> +	} else if (!prefixcmp(arg, "--min-parents=")) {
>> +		revs->min_parents = MIN_PARENTS(atoi(arg+14));
>> +	} else if (!prefixcmp(arg, "--max-parents=")) {
>> +		revs->max_parents = MAX_PARENTS(atoi(arg+14));
> 
> It would be nicer to error out for malformed numbers.  That's
> a separate topic, though --- you have plenty of company.

min_age etc., yes.

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
> 
> Sane.  If we feared enormous parent lists we could do
> 
> 	for (p = commit->parents; p && n <= 7 - revs->max_parents; p = p->next)
> 		n++;
> 
> but I suspect that's slower.
> 
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -20,6 +20,11 @@
>>  #define DECORATE_SHORT_REFS	1
>>  #define DECORATE_FULL_REFS	2
>>  
>> +/* limit to used range */
>> +#define MIN_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 0 : (__n > 7) ? 7 : __n; })
>> +/* invert fox MAX so that default = 0 -> infinity */
>> +#define MAX_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 7 : (__n > 7) ? 0 : 7 - __n;})
> 
> Statement expressions don't work in most non-gcc compilers (but
> inline functions do).
> 
> Hope that helps,
> Jonathan

Yes, that would have helped, although I'm going for simple "unbounded"
int's in v2 without the need for those range enforcing macros/inlines.

Am I allowed to do

unsigned max_parent = -1;

to get "infinity for practical purposes" on all compilers?

Michael
