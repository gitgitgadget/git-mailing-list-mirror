From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Wed, 25 Jun 2014 22:25:32 +0200
Message-ID: <53AB303C.7010305@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-3-git-send-email-tanayabh@gmail.com> <vpqtx7bn8ln.fsf@anie.imag.fr> <53A969DD.2030201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:25:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WztlE-0002fh-SL
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 22:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbaFYUZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 16:25:34 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:43275 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648AbaFYUZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 16:25:32 -0400
Received: by mail-wg0-f41.google.com with SMTP id a1so2593327wgh.12
        for <git@vger.kernel.org>; Wed, 25 Jun 2014 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=V12K9rohSUeJXOwmwsERNM0DWre3/1vQ0QmokuHzT6I=;
        b=0uvaT0AEhMO3FnhVz6p7kTMcWypx0wxUWLOrXs2/s48/EHpUAAgzwQjHfnGA6g7dpC
         AmAFNa/0NfdHOpfzlTcQZyvp2fIkrx087Q1t0x+boNr3Zc4V1snEyTnK1xKO2OAZ3Y2w
         pqlcSVIU6s5G9L76jAjhRbdswV3PdDgnMUAGle/KMIznlRrWMkPnwo2C4J/TzKOTvCBk
         AN9XAB2K3CgLjl5/4swpIIzNL6GVLuR/ydKgktex5fDU+Cv6Iu8P4bmwo+CTnub/q1vh
         aM4yidU3vasuquly7GkvuUd940CKrz8sH9nTG2zq9DI4ZT8ZkAVGyR/L+Xa0XwtxC7nP
         dUeA==
X-Received: by 10.194.1.242 with SMTP id 18mr12596661wjp.22.1403727931669;
        Wed, 25 Jun 2014 13:25:31 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id pq9sm9592793wjc.35.2014.06.25.13.25.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 13:25:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A969DD.2030201@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252457>

Am 24.06.2014 14:06, schrieb Tanay Abhra:
> On 6/23/2014 5:25 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> +/* for NULL values, 'util' for each `string_list_item` is flagged as 1 */
>>
>> It's a void *, so just saying that it is flagged as 1 does not say how
>> it's encoded. How about "... is an 'int *' pointing to the value 1".
>>
>> And actually, you can save one malloc by encoding the value directly in
>> the util pointer itself like
>>
>> #define NULL_FLAG (void *)1
>>
>>     item->util = NULL_FLAG;
>>
>> I find this a bit ugly, but I think Git already uses this in a few
>> places (git grep 'void \*) *1' for examples).
>>
>> Or you can use a pointer to a single static value:
>>
>> static const int boolean_null_flag = 1; // Or even without = 1.
>>
>> and then
>>
>>     item->util = &boolean_null_flag;
>>
> 
> Thanks for the review. I will change the flag format to what you have
> suggested. Instead of giving the users of the API the headache of
> thinking about the flag, let me give you an alternative,
> 
> +const struct string_list *git_config_get_string_multi(const char *key)
> +{
> +    int i, *flag;
> +    struct string_list *temp = config_cache_get_value(key);
> +    if (!temp)
> +        return NULL;
> +    /* create a NODUP string list which can have NULL values */
> +    struct string_list *l = xcalloc(1, sizeof(*l));
> +    for(i=0; i < temp->nr; i++) {
> +        flag = temp->items[i].util;
> +        if (*flag)
> +            string_list_append(l, NULL);
> +        else
> +            string_list_append(l, temp->items[i].string);
> +    }
> +    return l;
> +}
> 

Returning a list that is 'half-owned' by the caller (i.e. list is, values are not) is kindof strange. Especially weird is that the caller needs to string_list_clear() _and_ free() the list. Why don't you store NULL values in the string_list in the cache instead of doing this flag magic? I.e.

  static int config_cache_add_value(const char *key, const char *value)
  {
  ...
    if (value == NULL)
      string_list_append_nodup(&e->value_list, NULL);
    else
      string_list_append(&e->value_list, value);

or even

    string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
