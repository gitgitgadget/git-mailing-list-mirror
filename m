From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] config: add `git_die_config()` to the config-set API
Date: Fri, 25 Jul 2014 10:29:02 -0700
Message-ID: <xmqqmwbx73fl.fsf@gitster.dls.corp.google.com>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
	<1406293095-15920-6-git-send-email-tanayabh@gmail.com>
	<vpqvbqlo7s0.fsf@anie.imag.fr> <53D265DA.8070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:29:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjIw-0004wY-PO
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934278AbaGYR3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:29:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55526 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932839AbaGYR3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:29:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8613A2A653;
	Fri, 25 Jul 2014 13:29:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QrcIdYRU6NrQx2GHLfYpfG6HDsM=; b=a4Wt1E
	3pTcP657CBmyIQ+Q1JJoz3kVMXgePk55dAHdiW1pXfVHPfhPTr2k6gsAKDr//67f
	4G45d62hzdSLXsuIfquSu8xvQ1F6ViWI2LM7I6rxfAw9an/KB96ShEGYhPDcapx9
	cHr8ZAMuU7VlkXTKbecyD9msD8axvwEUVpszw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OSwXgcPzOvd+ttTq/i1nvyPIBolay5F5
	ib5GEqoDdQU4A0yzoUhac+nlJ8TxADtw7Gk9CqgeeNfsjJaABC7zC8mvMGq3n3jv
	FcF/bcMqZ6fpmw+Rbu4lsljVwdk3KEsi5/vmP8mqqsSf0JU9+/BzHBvh8IhGyZoV
	C2m5KoEfts8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 710472A652;
	Fri, 25 Jul 2014 13:29:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E1DE62A648;
	Fri, 25 Jul 2014 13:29:03 -0400 (EDT)
In-Reply-To: <53D265DA.8070702@gmail.com> (Tanay Abhra's message of "Fri, 25
	Jul 2014 19:42:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2C6704D4-1421-11E4-9B2C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254239>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/25/2014 7:33 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> --- a/config.c
>>> +++ b/config.c
>>> @@ -1403,11 +1403,12 @@ const struct string_list *git_configset_get_value_multi(struct config_set *cs, c
>>>  
>>>  int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
>>>  {
>>> -	const char *value;
>>> -	if (!git_configset_get_value(cs, key, &value))
>>> -		return git_config_string(dest, key, value);
>>> -	else
>>> -		return 1;
>>> +	int ret;
>>> +	char *value;
>>> +	ret = git_configset_get_string(cs, key, &value);
>>> +	if (ret <= 0)
>>> +		*dest = (const char*)value;
>>> +	return ret;
>>>  }
>> 
>> Isn't this a fixup meant for another series?
>>
>
> Though v12 is in pu, Junio commented that git_configset_get_string_const() &
> git_configset_get_string() can be done more concisely, I was trying to do
> that but I failed.

My comment on that version was not about conciseness.  You had one
that called git_config_string() to let the callee do the nonbool
error handling and xstrdup() of the non-error return value, and the
other one that did exactly what a call to git_config_string() would
have done.  That is being redundant, not just failing to be concise.

I was actually hoping that we would see just

int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
{
	return git_configset_get_string_const(cs, key, (const char **)dest);
}

with the implementation of _const() variant be the one from v12.
