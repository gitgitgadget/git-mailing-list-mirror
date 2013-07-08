From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] name-ref: factor out name shortening logic from name_ref()
Date: Mon, 08 Jul 2013 08:04:51 -0700
Message-ID: <7v7gh12iuk.fsf@alter.siamese.dyndns.org>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
	<1373236424-25617-2-git-send-email-gitster@pobox.com>
	<51DA7DBD.7070405@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:05:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwCzq-0006S8-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab3GHPEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 11:04:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab3GHPEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 11:04:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A94302D096;
	Mon,  8 Jul 2013 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZspAF1xsTn7VWS29Fb/XSl07XIk=; b=XUT2FB
	akfEs+cX+apqByHHBNQojmq+q0keLj6Zo4/3/WgfzStlF1TmsMCCqMcwcGqrVa+3
	tQJSkRYrALv+6VpES93l/zQWcTr3bz7ixla3HCFqViL140mZB8uEZf/z5SqC42oV
	OcypKBA4P+Tz6h2k60K/2usC6bSgWgXJRY7yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dJKP6PVrkcOhM79urRTtY9MBY7pGbM3K
	D6HYiNoE6dJ/J5GuK+pzGwbii2MTh535l7LCrOnRoMjniIepERe5uz4g3ppIkZrP
	jTywIY+GBppy1icfz0acC5bNYc2v2HVxzmaTZtYHcHRE1IQAQATJTEugpAmX3SGP
	qdWTVilJk4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D78D2D095;
	Mon,  8 Jul 2013 15:04:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C39E12D090;
	Mon,  8 Jul 2013 15:04:52 +0000 (UTC)
In-Reply-To: <51DA7DBD.7070405@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 08 Jul 2013 10:52:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE215358-E7DF-11E2-B0DF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229861>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 07/08/2013 12:33 AM, Junio C Hamano wrote:
>> The logic will be used in a new codepath for showing exact matches.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/name-rev.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>> 
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index 87d4854..1234ebb 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -96,6 +96,17 @@ static int subpath_matches(const char *path, const char *filter)
>>  	return -1;
>>  }
>>  
>> +static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
>> +{
>> +	if (shorten_unambiguous)
>> +		refname = shorten_unambiguous_ref(refname, 0);
>> +	else if (!prefixcmp(refname, "refs/heads/"))
>> +		refname = refname + 11;
>> +	else if (!prefixcmp(refname, "refs/"))
>> +		refname = refname + 5;
>> +	return refname;
>> +}
>> +
>
> In my opinion this would be a tad clearer if each of the branches of the
> "if" returned the value directly rather than setting refname and relying
> on the "return" statement that follows.  But it's probably a matter of
> taste.

I tend to agree; this is a straight-forward code movement (with the
variable name changed to conform to your recent refs.c update to
call these things "refname"), and that was the primary reason I kept
them like so.

>
>>  struct name_ref_data {
>>  	int tags_only;
>>  	int name_only;
>> @@ -134,13 +145,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
>>  	if (o && o->type == OBJ_COMMIT) {
>>  		struct commit *commit = (struct commit *)o;
>>  
>> -		if (can_abbreviate_output)
>> -			path = shorten_unambiguous_ref(path, 0);
>> -		else if (!prefixcmp(path, "refs/heads/"))
>> -			path = path + 11;
>> -		else if (!prefixcmp(path, "refs/"))
>> -			path = path + 5;
>> -
>> +		path = name_ref_abbrev(path, can_abbreviate_output);
>>  		name_rev(commit, xstrdup(path), 0, 0, deref);
>>  	}
>>  	return 0;
>> 
>
> Michael
