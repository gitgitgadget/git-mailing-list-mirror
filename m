From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] credential: let empty credential specs reset helper list
Date: Fri, 26 Feb 2016 11:34:12 -0800
Message-ID: <xmqqk2lrjmff.fsf@gitster.mtv.corp.google.com>
References: <20160226105135.GA30215@sigill.intra.peff.net>
	<xmqqa8mnl71v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Guilherme <guibufolo@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 20:34:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZO9f-0006au-Jc
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 20:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422839AbcBZTeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 14:34:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422673AbcBZTeR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 14:34:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 159DD4473D;
	Fri, 26 Feb 2016 14:34:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qvfd3UOY/ggUQKUo4ac6VcPiiTM=; b=RYrbKA
	BVS7SqbXQKruD7lNU17iL6WedE07Rj9mk/OgiyVs7m/1lbw+egTTTcSXdeWUZU05
	lCoFhcIllP9fgB2kHIyTnZHxFTJFxohQxnknKbzteWnq8rlZjX4lqmLKDO1BRQzr
	auKDop9RMrmiJ970ZlreFpeUpbtDjh62v58d0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NK+pcDoFG8J4m575KiHIuZx+sS51C0vz
	GI55xmSsRLUCOk7pWOfre8Oc2QKbdV/T6xYL2u/o/FRLv6JYfeKOPMhUbBLwKpCo
	WglPqJ/gOxX1lGD05NXZtM1IYL1uHHNgH3Apd/iyzceYtC+uII4hMQ2TCWicSoga
	yBYiEvIVvL4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04F3C4473B;
	Fri, 26 Feb 2016 14:34:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4623144723;
	Fri, 26 Feb 2016 14:34:14 -0500 (EST)
In-Reply-To: <xmqqa8mnl71v.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 26 Feb 2016 09:23:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EAEE84A0-DCBF-11E5-9CA6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287612>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Sine the credential.helper key is a multi-valued config
>
> s/Sine/Since/;
>
>> diff --git a/credential.c b/credential.c
>> index 7d6501d..aa99666 100644
>> --- a/credential.c
>> +++ b/credential.c
>> @@ -63,9 +63,12 @@ static int credential_config_callback(const char *var, const char *value,
>>  		key = dot + 1;
>>  	}
>>  
>> -	if (!strcmp(key, "helper"))
>> -		string_list_append(&c->helpers, value);
>> -	else if (!strcmp(key, "username")) {
>> +	if (!strcmp(key, "helper")) {
>> +		if (*value)
>> +			string_list_append(&c->helpers, value);
>> +		else
>> +			string_list_clear(&c->helpers, 0);
>> +	} else if (!strcmp(key, "username")) {
>
> I wondered why neither the existing code nor the updated one has a
> check for !value, but this callback assumes no credential
> configuration variable will ever be a boolean and rejects it
> upfront, so this code before or after the change is safe.
>
> Not pointing out anything that needs to be changed; demonstrating
> that I did read this sufficiently well to say that I have reviewed
> it ;-)

This reminds me of one thing.  The only reason why we are hesitant
to introduce a new syntax like

	[credential]
        	!helper ;# clear
                helper = ...

to allow explicit clearing of accumulated values so far IIRC is
because such a _file_ will not be readable by existing versions of
Git.  Am I correct?

If that is the case, then that reasoning will still not prevent us
from adding corresponding support for a command-line overide, i.e.
either one or both of these:

	$ git -c credential.!helper cmd
	$ git -c !credential.helper cmd

no?

Of course, the code in the configuration subsystem for updated
version of Git needs to become aware of the new syntax, and those
that deal with the multi-value variables need custom code, which is
similar to the way you special cased an empty value in the above
patch, so I am not sure how much this would help.
