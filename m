From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4 3/6] rewrite git_config() to use the config-set API
Date: Tue, 29 Jul 2014 19:02:48 +0530
Message-ID: <53D7A280.6080201@gmail.com>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>	<1406633302-23144-4-git-send-email-tanayabh@gmail.com> <vpqlhrc8hif.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:33:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7WX-0005Mc-KU
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbaG2Nc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 09:32:58 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:54368 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaG2Nc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:32:57 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so11664967pdj.40
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NEoMNbo7gDt3VZMaP+HwtUR7E54cXinpL/RhEpBFnb4=;
        b=V4ycrNkkvne0y4eR+U9R56IMchH/6Iewbm8SFaUXrIl8TE6eUo2NT8zU1UN468a/1G
         or14txLGZWeSyTM9n2dtXVslzZGoSCiNSo9gr51JLrVCnPPlrDxcfzJ7WDHv83oLacB1
         6hU4hpyeCyD/oL2onfZn1cnAPAyq8zDv3BdaQxZRZePD89Rp5n2UbnSiGqX1UJuVkWbH
         mJW+AcnGcAlPXbrbk1/tmo8HH5DDh549SA9KwSc3BmgZ+sV7atOONwpjo8j+JPkGjBUK
         EVkGIhcADb6iWIk/tVdaKGoMYJyPvXxO0dyV8ufOholoUcfCJ4WGHSJ6nn26fD6/oGp3
         DBAw==
X-Received: by 10.70.123.163 with SMTP id mb3mr1856593pdb.37.1406640777017;
        Tue, 29 Jul 2014 06:32:57 -0700 (PDT)
Received: from [127.0.0.1] ([223.184.138.24])
        by mx.google.com with ESMTPSA id oy12sm20792101pbb.27.2014.07.29.06.32.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 06:32:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqlhrc8hif.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254433>



On 7/29/2014 6:10 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
> configset_iter unconditionnally returns 0 (or it dies). Since it is more
> or less the equivalent of the old git_config(), I understand why we
> never encounter the situation where git_config() would return -1 (syntax
> error, weird permission issue => cannot happen when reading from
> memory).
> 
> But then, do we really want this return value, and not just return void?
>

Sounds sane to me.

>> +static void git_config_check_init(void);
>> +
>> +int git_config(config_fn_t fn, void *data)
>> +{
>> +	git_config_check_init();
>> +	return configset_iter(&the_config_set, fn, data);
>> +}
> 
> Here too, git_config now unconditionnally returns 0.
> 
> Most callers of git_config already ignore the return value. Actually,
> there's only one exception in branch.c, but git still compiles with
> this:
>

branch.c is in my git_config() rewrite patch so it should not be a problem
in the future even if it was the case.

> 
> So, I think it's time to make it official that git_config() does not
> return an error code, and make it return void. I would do that in a
> patch before the git_config() -> git_config_raw() rewrite.
> 
> My preference would be to get the return value from
> git_config_with_options and die() if it's negative, but I can also live

Doesn't git_config_with_options() only return positive values, we checked it
pretty intensively last time.

> with a solution where the return value from git_config_with_options() is
> ignored. It's the same discussion we already had about the call to
> git_config() in git_config_check_init() actually, but I now think a
> die() statement should be within git_config(), not after, so that every
> callers benefit from it.

The above patch works like that, doesn't it?

> 
> In any case, doing this in a separate patch means the commit message
> (and possibly a comment next to the git_config() call) should explain
> the situation clearly and justify the choice.
>

The choice being not to return a error code for git_config()?
I am pretty much confused by now.

> The current situation looks like someone tried to get good error
> recovery, but the error code is lost in the way between
> git_config_with_options() and the caller of git_config(), without a
> clear justification of why an error code was once returned, nor a
> justification of why it was later ignored.
> 
> So, in summary, my advice (but not the only option) would be: take my
> patch above, add a die() statement and a comment, write a good commit

Where can the die() statement be inserted? Again, I am confused.
Only thing which sounds reasonable to me is to rewrite existing git_config()
as void first. Other than that, it went over my head.

> message and insert this before this patch.
> 
>>  static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
>>  {
>>  	struct config_set_element k;
>> @@ -1268,6 +1296,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>>  {
>>  	struct config_set_element *e;
>>  	struct string_list_item *si;
>> +	struct configset_list_item *l_item;
>>  	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
>>  
>>  	e = configset_find_element(cs, key);
>> @@ -1283,6 +1312,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>>  		hashmap_add(&cs->config_hash, e);
>>  	}
>>  	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
>> +
>> +	ALLOC_GROW(cs->list.items, cs->list.nr + 1, cs->list.alloc);
>> +	l_item = &cs->list.items[cs->list.nr++];
>> +	l_item->e = e;
>> +	l_item->value_index = e->value_list.nr - 1;
> 
> I would spell this
> 
> 	l_item = &cs->list.items[cs->list.nr];
> 	l_item->e = e;
> 	l_item->value_index = e->value_list.nr;
> 	cs->list.nr++;
> 
> to avoid having to wonder why the "- 1" is needed. But I'm OK with the
> current code.
> 

Yup, you are right. Thanks.
