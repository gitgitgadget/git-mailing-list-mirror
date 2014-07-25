From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v2 3/6] rewrite git_config() to use the config-set API
Date: Fri, 25 Jul 2014 19:37:21 +0530
Message-ID: <53D26499.4040104@gmail.com>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>	<1406293095-15920-4-git-send-email-tanayabh@gmail.com> <vpq38dppmjh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 16:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAg9y-0007sH-A2
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 16:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760650AbaGYOHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 10:07:33 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:52992 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760630AbaGYOH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 10:07:29 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5747994pdj.40
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=b4WlmKWvcWss/tJuvL/LgcqQcXB09tyToYjczgKOe3M=;
        b=GsLlFqhtsaCkEAPA7tp8q7LfAStgIgCTJvslHHiBSok7ZA78C7KsBzO2tvCdAXwKdP
         9J0DqQMXnQqvfVLus+n+PUywVb7Vg5oNYUIimM2c82Y7uAYamdEX4Q1IR9FRdNT4C0IC
         b2J1ocmCAlheN58Ih3IekjcK2VyM8CKiDgO7aubgPDuwJidLWHBmLyI315BLSFSTDpXc
         UXHUz/XTw9wgT0a68DWztEi6ltLZWTJ4oLTEgu6kxOaYzY7knPmdeXhCkD1vZQg/JsQs
         6q+e95JXl6or6YVlFbyp8T1BTLWechCRZLbGhEwXm29ssoyn1CQkdY7Gd/AcemmU2CnV
         FD3Q==
X-Received: by 10.68.94.130 with SMTP id dc2mr18544745pbb.113.1406297248829;
        Fri, 25 Jul 2014 07:07:28 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.246.45])
        by mx.google.com with ESMTPSA id ug1sm33142831pac.9.2014.07.25.07.07.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 07:07:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpq38dppmjh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254224>



On 7/25/2014 7:28 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> +struct config_set_element {
>> +	struct hashmap_entry ent;
>> +	char *key;
>> +	struct string_list value_list;
>> +};
>> +
>> +struct configset_list_item {
>> +	struct config_set_element *e;
>> +	int value_index;
>> +};
> 
> I originally wondered why you had two levels of pointers, but
> config_set_element is not new, just moved. It's OK.
> 
>> +/*
>> + * the contents of the list are ordered according to their
>> + * position in the config files and order of parsing the files.
>> + * (i.e. key-value pair at the last position of .git/config will
>> + * be at the last item of the list)
>> + */
>> +
>> +struct configset_list {
> 
> I wouldn't put a blank line between comment and decl if the comment
> applies to the decl.
>

Noted.

>> -int git_config(config_fn_t fn, void *data)
>> +static int git_config_raw(config_fn_t fn, void *data)
>>  {
>>  	return git_config_with_options(fn, data, NULL, 1);
>>  }
> 
> I would have done this and the new git_config() as a separate patch, but
> I do not mind strongly.
> 
>>  static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
>>  {
>>  	struct config_set_element k;
>> @@ -1268,6 +1295,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>>  {
>>  	struct config_set_element *e;
>>  	struct string_list_item *si;
>> +	struct configset_list_item *l_item;
>>  	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
>>  
>>  	e = configset_find_element(cs, key);
>> @@ -1283,6 +1311,13 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>>  		hashmap_add(&cs->config_hash, e);
>>  	}
>>  	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
>> +
>> +	if (cs->list.nr + 1 > cs->list.alloc)
> 
> The "if" is already in ALLOC_GROW.
> 
>> +		ALLOC_GROW(cs->list.items, cs->list.nr + 20, cs->list.alloc);
> 
> The 20 should be just 1 I guess. You're adding 1 element, and ALLOC_GROW
> will take care of allocating more than 1 for you (see alloc_nr and
> ALLOC_GROW's defs in cache.h).
>

Oh, you are are right, I thought alloc grew by one, not by a factor.

>> @@ -1318,10 +1356,14 @@ void git_configset_clear(struct config_set *cs)
>>  	hashmap_iter_init(&cs->config_hash, &iter);
>>  	while ((entry = hashmap_iter_next(&iter))) {
>>  		free(entry->key);
>> -		string_list_clear(&entry->value_list, 0);
>> +		string_list_clear(&entry->value_list, 1);
> 
> Doesn't this change belong to PATCH 2/6 ?
> 

Yup, you are right again.
Thanks.
