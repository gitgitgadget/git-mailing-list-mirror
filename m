From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v6 6/7] config: add `git_die_config()` to the config-set
 API
Date: Thu, 31 Jul 2014 23:56:28 +0530
Message-ID: <53DA8A54.6060208@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>	<1406821662-1570-7-git-send-email-tanayabh@gmail.com>	<vpqr411h69h.fsf@anie.imag.fr> <53DA7281.8060403@gmail.com>	<vpqr411bhd5.fsf@anie.imag.fr> <53DA7C23.3090603@gmail.com> <vpqa97p8koq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:26:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCv3m-0003W0-BR
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 20:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbaGaS0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 14:26:33 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:58634 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaGaS0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 14:26:31 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so4180693pad.9
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kXTYtInPv0Lc/KL4L8T2b4dz6LWln9z9egWG1QCeQTI=;
        b=vI1x03gKg3a5xD5NfIqpjG3h1rLDk+2VhbEhevCvMZMpqg0ECbHEWOFtoB7DhX83Vr
         OAADQF2g3KUsYpQpRnSZ029byK9CXiG8UMMbCgR5WkUa9YGU/xMmdDyX08YEOCz+GBFx
         31QzuTsE33kmqZm+PLGT+Dp+lW1ijdYgAXlQFR7dZraGQ1e/YBWYLNJImr3JECwDlMMr
         OOMl5eQIIXZKmwwuNtlW65EaVK1xyXopnyhF07FxccwuoDqqr3eAQcpmI+xHCzm1b2qI
         mRyWnEAE17vnTphdvpDiY/LwfHQUo7ZcZd1y3VFsr1xC3jaeGZ75OsiHdMbegPAtG4xN
         9clg==
X-Received: by 10.70.89.139 with SMTP id bo11mr14508368pdb.50.1406831191095;
        Thu, 31 Jul 2014 11:26:31 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.246.90])
        by mx.google.com with ESMTPSA id ue3sm6235701pbc.49.2014.07.31.11.26.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 11:26:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqa97p8koq.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254596>



On 7/31/2014 11:39 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> On 7/31/2014 10:22 PM, Matthieu Moy wrote:
>>> Tanay Abhra <tanayabh@gmail.com> writes:
>>>
>>>> On 7/31/2014 9:25 PM, Matthieu Moy wrote:
>>>>> Tanay Abhra <tanayabh@gmail.com> writes:
>>>>>
>>>>>> +void git_die_config(const char *key)
>>>>>> +{
>>>>>> +	const struct string_list *values;
>>>>>> +	struct key_value_info *kv_info;
>>>>>> +	values = git_config_get_value_multi(key);
>>>>>> +	kv_info = values->items[values->nr - 1].util;
>>>>>> +	if (!kv_info->linenr)
>>>>>> +		die(_("unable to parse '%s' from command-line config"), key);
>>>>>> +	else
>>>>>> +		die(_("bad config variable '%s' at file line %d in %s"),
>>>>>> +			key,
>>>>>> +			kv_info->linenr,
>>>>>> +			kv_info->filename);
>>>>>> + }
>>>>>
>>>>> Extra whitespace before }.
>>>>>
>>>>> Also, didn't we agree that it was a good thing to factor this
>>>>> if/then/else into a helper function?
>>>>>
>>>>
>>>> I have been thinking about it, wouldn't it be better to give users
>>>> a function like,
>>>>
>>>> git_config_die_exact(key, value);
>>>>
>>>> where user supplies key & value both and it would print the correct message based
>>>> on that.
>>>
>>> I suggested git_config_die_linenr(key, linenr), and I now realize it
>>> should take the value too.
>>>
>>> You're suggesting git_config_die_exact(key, value). Is it a typo that
>>> you forgot the line number, or is it intentional? If intentional, I
>>> don't think it solves your issue:
>>>
>>> [section]
>>>    key
>>>    key
>>>
>>> There are two errors in this file, and you need to provide a line
>>> number. key and value alone do not allow you to know which line the
>>> error is. You can use a convention like "complain on the first value
>>> equal to the argument", but I'm not sure that would always work. And
>>> that seems backward to me to reconstruct the line number since the
>>> function can be called from places where the line number is already
>>> known (while iterating over the string_list for example).
>>
>> Still the user would have to know that the linenr info is there.
>> First hear my argument, then we can go either way.
>>
>> Let's first see the previous code behavior, git_config() would die on the
>> first corrupt value, we wouldn't live to see the future value.
>>
>> for example,
>>
>> [section]
>> 	key	// error(old git_config() would die here)
>> 	key = good_value
>>
>> [section]
>> 	key	//again error
>>
>> Now for the new behavior,
>>
>> single valued callers use git_config_get_value() which will directly
>> supply the last value, so we don't see the first error value.
>> For such cases, git_die_config(key) is enough.
> 
> Yes. And it is better than the old behavior which was dying on the
> erroneous value without giving a chance to the user to override the
> boggus value in a more specific config file (e.g. if your sysadmin
> messed-up /etc/gitconfig).
> 
> But since git_die_config(key) is simpler to use for the caller, it's
> independant from git_die_config_exact()'s parameters.
> 
>> The new git_config() works exactly as the old code, it would die
>> on the first case of erroneous value. Here, git_die_config_exact(key, value)
>> would be enough.
> 
> Yes. But this callsite has the line number information, so it could use
> it.
> 
>> The last case is git_config_get_value_multi(), here we iterate over the keys,
>> and then call git_die_config_exact(key, value) for the erroneous value.
>> (pros and cons: abstracts the error message implementation from the user
>> but there is an extra call to git_config_get_value_multi(), but its cheap and
>> we are dying anyway)
> 
> This is the part I find weird. You're calling git_die_config_exact() on
> the first boggus value, and git_die_config_exact() will notify an error
> at the line of the last boggus value.
>

Hmn, we may have some confusion here. I meant the implementation of
git_config_exact() to look like this,

void git_die_config_exact(const char *key, const char *value)
{
	int i;
	const struct string_list *values;
	struct key_value_info *kv_info;
	values = git_config_get_value_multi(key);
	for (i = 0; i < values.nr; i++) {
		kv_info = values->items[i].util;
		/* A null check will be here also */
		if (!strcmp(value, values->items[i].string)) {
			if (!kv_info->linenr)
				die(_("unable to parse '%s' from command-line config"), key);
			else
				die(_("bad config variable '%s' at file line %d in %s"),
					key,
					kv_info->linenr,
					kv_info->filename);
		}
	}
}

The above code would print the info on first bogus value.
I am only rooting for it because the caller has to think very little to use it.
It's your call, I am open to both ideas.

> I agree it works (if we give only one error message, it can be the first
> or the last, the user doesn't really care), but I find the
> implementation backwards. You have the line number already, as you are
> iterating over the string_list which contain it. So why forget the line
> number, and recompute one, possibly different, right after?
> 
> So, I see only cases where you already have the line number, hence no
> reason to recompute it.
> 
