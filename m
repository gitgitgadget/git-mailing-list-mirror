From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 6/9] fetching submodules: respect `submodule.fetchJobs` config option
Date: Fri, 05 Feb 2016 11:59:08 -0800
Message-ID: <xmqqegcrc4j7.fsf@gitster.mtv.corp.google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
	<1454623776-3347-7-git-send-email-sbeller@google.com>
	<xmqqa8nfeswj.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaamt=7mLv23JyJiWL9cJ8deV4JWH_Kv0Csovvqs5SBcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:59:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmXK-0003Tr-LA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbcBET7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:59:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756482AbcBET7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:59:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8160C40AB7;
	Fri,  5 Feb 2016 14:59:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ByscPycrp3QaHkTEcxC22t6ng+s=; b=m/Jrzr
	eHZcCn93TUnRuBbCMW9XdDGZu1gU2nZSas92RX11vHwT6M29UVqMqpMyH0DNFnNg
	MLDDHJbKBhwDZdft6rkbitZPvSr3cGWC5S09glgkiFF6l/DvcsEp4Wt6S1U482Rl
	RETOIrUAkLCA+ZbMUZoy0u23vqRAgVgZGv1r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gxjDpf+kFpBnF7oBiXXm6M8cSRNmw6XG
	5jwmqoLLyupndhJ0l3tbzUTvfQwoRBCBcFEebcDzZRP1VUzVuoZVeNZ/DgliEG2V
	XXDqVyc900YVRPD88FtvERSARivzdY7zMGT7AKxx1qzWeWfd4bsE1noUjleJkijQ
	a1s4VS8+5GM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 798F040AB6;
	Fri,  5 Feb 2016 14:59:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EEBD040AB5;
	Fri,  5 Feb 2016 14:59:09 -0500 (EST)
In-Reply-To: <CAGZ79kaamt=7mLv23JyJiWL9cJ8deV4JWH_Kv0Csovvqs5SBcg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 5 Feb 2016 10:50:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EBC1F656-CC42-11E5-8402-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285624>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Feb 4, 2016 at 7:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>> ...
>>> +static unsigned long parallel_jobs = -1;
>>
>> ... but I do not think this does....
>
> So if we don't get the config option from builtin/fetch, we ask for
> config_parallel_submodules(), which is what you were seeing above
> initialized as -1, too.  And if that is still -1, we default to 1 there.

But that is not really -1, but -1 casted to unsigned long that is
casted back to int.  

> So from a design perspective, you're rather saying we want to move part of
> this logic into submodule-config.c, such that
> config_parallel_submodules never returns -1,
> but either 1 as the default or the actual configuration?

That is not my design but yours ;-)

Expecting config_parallel_submodules() to return -1 when there is no
variable defined contradicts what you wrote in the documentation, I
think, where it says "this variable defaults to 1 when not set".

> Then the code in fetch_populated_submodules, would be as simple as
>
>     if (max_parallel_jobs < 0)
>         max_parallel_jobs = config_parallel_submodules();

Yup.

>>> @@ -233,6 +234,13 @@ static int parse_generic_submodule_config(const char *key,
>>>                                         const char *value,
>>>                                         struct parse_config_parameter *me)
>>>  {
>>> +     if (!strcmp(key, "fetchjobs")) {
>>> +             if (!git_parse_ulong(value, &parallel_jobs)) {
>>> +                     warning(_("Error parsing submodule.fetchJobs; Defaulting to 1."));
>>> +                     parallel_jobs = 1;
>>
>> Hmph, this is not a die() because...?  Not a rhetorical question.
>
> Because this config option doesn't alter the state of the repository.
> After the fact you should not be able to tell how much parallel operations
> were going on.
>
> (As opposed to other options which alter the state of the repository)
>
> I'll change it to die(...), though it sounds overly strict to me in this case.
> But I guess consistency beats overstrictness here.

I do not see it as being overly strict, though.

If I were a user of this feature, I'd rather see a problem pointed
out to me (e.g "you spelled 'true' but that fetchJobs expects a
positive integer") to help me fix it, rather than having to see this
warning every time I try to run submodule commands.

What benefit does a user get by being loose here?  Probably I am
not considering some valid use cases...

>>> +unsigned long config_parallel_submodules(void)
>>> +{
>>> +     return parallel_jobs;
>>> +}
>>
>> It is not a crime to make this return "int", as the code that
>> eventually uses it will assign it to a variable that will be
>> passed to run_processes_parallel() that takes an "int".
>
> ok
>
>>
>> In fact, returning "int" would be preferrable.  You are causing
>> truncation somewhere in the callchain anyway.  If the truncation
>> bothers you, this function or immediately after calling
>> git_parse_ulong() would be a good place to do a range check.  The
>> variable parallel_jobs has to stay "unsigned long" in any case as
>> you are calling git_parse_ulong().
>
> ok, that should be the best place.

Alternatively (I haven't weighed pros and cons myself), you can make
parallel_jobs an "int", call git_parse_ulong() using a temporary
"unsigned long" and after doing range check assign it to
parallel_jobs.  That would make this function really trivial ;-)
