From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v2 2/2] config: Add hashtable for config parsing & retrieval
Date: Mon, 16 Jun 2014 10:28:29 -0700
Message-ID: <539F293D.9000602@gmail.com>
References: <1402907232-24629-1-git-send-email-tanayabh@gmail.com> <1402907232-24629-3-git-send-email-tanayabh@gmail.com> <vpqy4ww230l.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 16 19:28:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwai1-0002xC-3g
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 19:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbaFPR2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 13:28:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49297 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbaFPR2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 13:28:36 -0400
Received: by mail-pb0-f46.google.com with SMTP id md12so3843033pbc.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 10:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XDeL0mVVWiuaLkDPsQmB2G/tWj96HVXmoQaCAxb/VjU=;
        b=zd1G5EZvasg1V3VTSYovKH/WZSwEHQSwcWbYXsgFmhZJi1PaWZd8ueHk7TjheHU9wP
         uCNNZos8fCTSRIHVtPDtv2Cg54arMuIjSTbKsU+qKN/QGjYKpuopoUnDR7FzhNBEqzv0
         ZdXxaB9QmsErk5lAzFVoScU7+2DUA8xnQQ+fpXSV+HeOc+rRnhSH0SgNKiekCXHvH6NI
         tD8hYyYdtpAvUU3iUdUuoG/VhLe+quxCxCEMeHxhNiEaV0cWoVaUMgjyhiVYxyXgVjhb
         +sXQIM+6CkUmsCrFatHpYSDUyzPkYXvkWlX4NNN06wEkXtdorT81TFnqPYsdt4LtiM5i
         r1Uw==
X-Received: by 10.66.66.202 with SMTP id h10mr25935107pat.70.1402939716285;
        Mon, 16 Jun 2014 10:28:36 -0700 (PDT)
Received: from [192.168.52.163] ([117.254.222.96])
        by mx.google.com with ESMTPSA id hb10sm19790324pbd.75.2014.06.16.10.28.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 10:28:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <vpqy4ww230l.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251736>

On 06/16/2014 10:11 AM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> Add a hash table to cache all key-value pairs read from config files
>> (repo specific .git/config, user wide ~/.gitconfig and the global
>> /etc/gitconfig). Add two external functions `git_config_get_string` and
>> `git_config_get_string_multi` for querying in a non-callback manner from the
>> hash table.
> 
> This describes rather well _what_ your patch does, but the most
> important part of a commit message is to justify _why_ the change is
> good, and why the way you implemented it is good.
> 
> Think of it as an way to convince reviewers to accept your patch.

Okay, but isn't the content of the cover letter is doing that for now.
Should I put some part of it in here?

>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  Documentation/technical/api-config.txt |  17 +++++
>>  cache.h                                |   2 +
>>  config.c                               | 123 +++++++++++++++++++++++++++++++++
>>  3 files changed, 142 insertions(+)
> 
> I'm still concerned about the fact that there is no test. At this point,
> git_config_get_string_multi and git_config_get_string are basically dead
> code.
> 
> I'm sure you did experiments to test these functions, run them through
> valgrind, ... Now, you need to let other people reproduce these
> experiments. "other people" can be reviewers, now, or anyone looking for
> bugs or regressions in the future.
>

Yeah, I have run the experiments. I will add a test file for it. I should have
appended it to this series only, my fault. :) A stray observation, Git has very less
unit tests, compared to the comprehensive test directory for commands.

>> +static struct config_cache_entry *config_cache_find_entry(const char *key)
>> +{
>> +	struct hashmap *config_cache;
>> +	struct config_cache_entry k;
>> +	struct config_cache_entry *found_entry;
>> +	char *normalized_key;
>> +	int ret;
>> +	config_cache = get_config_cache();
>> +	ret = git_config_parse_key(key, &normalized_key, NULL);
>> +
>> +	if (ret)
>> +		return NULL;
>> +
>> +	hashmap_entry_init(&k, strhash(normalized_key));
>> +	k.key = (char *)normalized_key;
> 
> No need to cast.
> 

Noted.

>> +static int config_cache_set_value(const char *key, const char *value)
>> +{
>> +	struct hashmap *config_cache;
>> +	struct config_cache_entry *e;
>> +
>> +	config_cache = get_config_cache();
>> +	e = config_cache_find_entry(key);
>> +	if (!e) {
>> +		e = xmalloc(sizeof(*e));
>> +		hashmap_entry_init(e, strhash(key));
>> +		e->key = xstrdup(key);
>> +		string_list_init_dup(&e->value_list);
>> +		string_list_append(&e->value_list, value);
>> +		hashmap_add(config_cache, e);
>> +	} else {
>> +		string_list_append(&e->value_list, value);
>> +	}
>> +	return 0;
>> +}
> 
> I find the function name a bit confusing, as it does not "set" in the
> sense "override any previous value". Wouldn't this be better named
> config_cache_add_value? Or perhaps a comment would help.
>

Noted.

>> @@ -1714,6 +1830,13 @@ int git_config_set_multivar_in_file(const char *config_filename,
>>  	lock = NULL;
>>  	ret = 0;
>>  
>> +	/*
>> +	 *contents of config file has changed, so invalidate the
>> +	 *config cache used by non-callback based query functions.
>> +	 */
> 
> Spaces after stars:
> 
> /*
>  * Contents of config file has changed, so invalidate the
>  * config cache used by non-callback based query functions.
>  */
> 
> (I think the "s" of "contents" should be dropped too).
> 

Noted. Thanks for the review.
