From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v2 5/6] config: add `git_die_config()` to the config-set
 API
Date: Fri, 25 Jul 2014 19:42:42 +0530
Message-ID: <53D265DA.8070702@gmail.com>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>	<1406293095-15920-6-git-send-email-tanayabh@gmail.com> <vpqvbqlo7s0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 16:12:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAgEw-0003YS-9b
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 16:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbaGYOMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 10:12:48 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:46263 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbaGYOMs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 10:12:48 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5754863pdj.40
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=05lq0mhzsKFZkWW+d5bkGl2ZFARLIu0bqiPsNDkTAx0=;
        b=ldFXqUc0ab44RW4GJA+ZEka9jnKSeATPig2/ds6a/PyhebsswCqS5oZuVynUgtjzQ1
         ktazfcJR9QYhIa2qsjCVHk1hS55OHmn1HDCh3B4Lr7Z3T8MltX/1Uq7RIGs8bQBTvMJT
         x6ZDZehLao08JU80uos/cZJdmMKNYSiSCYJNl3gKcDB1ll0RwPHFRiHdLAVRigl3Gqva
         jAnWacS54dfO6shKLS+J/OWyqefSehZvg3xWgU83/H8bfi1r/Ni7Uwu/yoV619Ci/iaV
         n3FCHDUE4dLOz3RZFVeQP5Tz09Bmr33rukNlTvbp2EJDVgzFr1sQ8cvOu9mqjkem49cR
         4JNA==
X-Received: by 10.66.251.233 with SMTP id zn9mr19335877pac.67.1406297567814;
        Fri, 25 Jul 2014 07:12:47 -0700 (PDT)
Received: from [127.0.0.1] ([106.203.190.184])
        by mx.google.com with ESMTPSA id fj2sm11861110pdb.66.2014.07.25.07.12.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 07:12:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqvbqlo7s0.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254225>



On 7/25/2014 7:33 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> --- a/config.c
>> +++ b/config.c
>> @@ -1403,11 +1403,12 @@ const struct string_list *git_configset_get_value_multi(struct config_set *cs, c
>>  
>>  int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
>>  {
>> -	const char *value;
>> -	if (!git_configset_get_value(cs, key, &value))
>> -		return git_config_string(dest, key, value);
>> -	else
>> -		return 1;
>> +	int ret;
>> +	char *value;
>> +	ret = git_configset_get_string(cs, key, &value);
>> +	if (ret <= 0)
>> +		*dest = (const char*)value;
>> +	return ret;
>>  }
> 
> Isn't this a fixup meant for another series?
>

Though v12 is in pu, Junio commented that git_configset_get_string_const() &
git_configset_get_string() can be done more concisely, I was trying to do
that but I failed.

>>  int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
>> @@ -1418,8 +1419,7 @@ int git_configset_get_string(struct config_set *cs, const char *key, char **dest
>>  			return config_error_nonbool(key);
>>  		*dest = xstrdup(value);
>>  		return 0;
>> -	}
>> -	else
>> +	} else
>>  		return 1;
> 
> Useless churn.
> 
