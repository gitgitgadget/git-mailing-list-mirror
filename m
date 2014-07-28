From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 5/6] config: add `git_die_config()` to the config-set
 API
Date: Mon, 28 Jul 2014 16:32:21 +0530
Message-ID: <53D62DBD.9@gmail.com>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com> <1406543635-19281-6-git-send-email-tanayabh@gmail.com> <53D62C1A.5000203@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 13:02:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBihM-0001fa-0e
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 13:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbaG1LC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 07:02:28 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:54071 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaG1LC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 07:02:27 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so10286029pab.16
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=c+PpISNZHO4n8dKuoeRxeDaSt0iaUMQPNsk5PVVVSbY=;
        b=j0tXRtYq1AeGcdvG49Vn5vamWjMrU6LvEg6GCVJH4CZ1oppMscF+c8PXu7sio7a7cU
         igKZ+BfqEzkQt2z2WkvxhoElq83NVk0u82uC881CeIX2M2Dgu0IQ10mAMg8j5jmAOdUf
         T1HdVm/L63ECqdbmswItnouuneboRuj7Ogwim8nVUbNgOBf91a5UBK8S6FeJatYeqAWb
         US/wH6E9QXLamMH1vWewvLFWuiC20rT5vWrm72oPJYrfLf/h0Im416Horhvrjmc0eBf2
         lcB20LEjGtin3lIyUskSgklDYJKqNNt6uni+b+vs2mIlIBL0YKEZUG6w3PBQXS03t2KS
         feNQ==
X-Received: by 10.67.30.45 with SMTP id kb13mr29144505pad.16.1406545346900;
        Mon, 28 Jul 2014 04:02:26 -0700 (PDT)
Received: from [127.0.0.1] ([106.211.56.253])
        by mx.google.com with ESMTPSA id cj17sm23740148pdb.75.2014.07.28.04.02.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 04:02:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53D62C1A.5000203@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254304>

On 7/28/2014 4:25 PM, Ramsay Jones wrote:
> On 28/07/14 11:33, Tanay Abhra wrote:
>> Add `git_die_config` that dies printing the line number and the file name
>> of the highest priority value for the configuration variable `key`.
>>
>> It has usage in non-callback based config value retrieval where we can
>> raise an error and die if there is a semantic error.
>> For example,
>>
>> 	if (!git_config_get_value(key, &value)) {
>> 		/* NULL values not allowed */
>> 		if (!value)
>> 			git_config_die(key);
>> 		else
>> 			/* do work */
>> 	}
>>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>> Note: git_config_get_string() calls git_config_get_string_const(),
>> so no need to check for whether to die or not, as it is done by
>> git_config_get_string_const().
>>
>>  Documentation/technical/api-config.txt |  5 +++++
>>  cache.h                                |  1 +
>>  config.c                               | 24 ++++++++++++++++++++++--
>>  3 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
>> index 815c1ee..e7ec7cc 100644
>> --- a/Documentation/technical/api-config.txt
>> +++ b/Documentation/technical/api-config.txt
>> @@ -155,6 +155,11 @@ as well as retrieval for the queried variable, including:
>>  	Similar to `git_config_get_string`, but expands `~` or `~user` into
>>  	the user's home directory when found at the beginning of the path.
>>  
>> +`void git_die_config(const char *key)`::
>> +
>> +	Dies printing the line number and the file name of the highest
>> +	priority value for the configuration variable `key`.
>> +
>>  See test-config.c for usage examples.
>>  
>>  Value Parsing Helpers
>> diff --git a/cache.h b/cache.h
>> index 93bdbab..8512225 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1406,6 +1406,7 @@ extern int git_config_get_bool(const char *key, int *dest);
>>  extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
>>  extern int git_config_get_maybe_bool(const char *key, int *dest);
>>  extern int git_config_get_pathname(const char *key, const char **dest);
>> +extern void git_die_config(const char *key);
>>  
>>  extern int committer_ident_sufficiently_given(void);
>>  extern int author_ident_sufficiently_given(void);
>> diff --git a/config.c b/config.c
>> index 2ce3318..136ee9c 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1505,8 +1505,12 @@ const struct string_list *git_config_get_value_multi(const char *key)
>>  
>>  int git_config_get_string_const(const char *key, const char **dest)
>>  {
>> +	int ret;
>>  	git_config_check_init();
>> -	return git_configset_get_string_const(&the_config_set, key, dest);
>> +	ret = git_configset_get_string_const(&the_config_set, key, dest);
>> +	if (ret < 0)
>> +		git_die_config(key);
>> +	return ret;
>>  }
>>  
>>  int git_config_get_string(const char *key, char **dest)
>> @@ -1547,10 +1551,26 @@ int git_config_get_maybe_bool(const char *key, int *dest)
>>  
>>  int git_config_get_pathname(const char *key, const char **dest)
>>  {
>> +	int ret;
>>  	git_config_check_init();
>> -	return git_configset_get_pathname(&the_config_set, key, dest);
>> +	ret = git_configset_get_pathname(&the_config_set, key, dest);
>> +	if (ret < 0)
>> +		git_die_config(key);
>> +	return ret;
>>  }
>>  
>> +void git_die_config(const char *key)
>> +{
>> +	const struct string_list *values;
>> +	struct key_value_info *kv_info;
>> +	values = git_config_get_value_multi(key);
>> +	kv_info = values->items[values->nr - 1].util;
>> +	if (!kv_info->linenr)
>> +		die("unable to parse command-line config");
>> +	else
>> +		die("bad config file line %d in %s",kv_info->linenr, kv_info->filename);
> 
> How about including the 'key' string in the error message?
> Similar comment applies to an earlier patch in this series.
>

git_config_get_string & pathname() are already raising a
config_error_nonbool() with the error message,
"Missing value for 'key'".

For other cases, I was just following the previous error message,
but it can be done for the new git_config().

Thanks.

>> + }
>> +
>>  /*
>>   * Find all the stuff for git_config_set() below.
>>   */
>>
> 
> ATB,
> Ramsay Jones
> 
> 
> 
