From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4 2/5] notes.c: replace `git_config()` with `git_config_get_value_multi()`
Date: Thu, 31 Jul 2014 17:43:31 +0530
Message-ID: <53DA32EB.70504@gmail.com>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>	<1406727549-22334-3-git-send-email-tanayabh@gmail.com>	<vpq1tt3q6ic.fsf@anie.imag.fr> <53D903E0.4080209@gmail.com>	<vpqsiliol1o.fsf@anie.imag.fr> <vpqmwbpdagf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 31 14:13:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCpEw-0001uI-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbaGaMNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:13:42 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:55706 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbaGaMNl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:13:41 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so3353255pde.23
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2mdjW8gP8H4HAKjwxGc/4d3kDUKAJi9KKH6DvbsdskI=;
        b=uvAHJf1BsuER2Hpx/CCcEST4VtH+kQXgLeKqJWdVol+KdVspAIBSxAfhTvUztwbC3+
         vQyi11wzZSXqeefHDqJH0q1iLwZXyGfku0Nv0Ek/Jy8aNFpPNcy/uWEA6usyY8ETN2nM
         UKJKZMwZEdPWktJTaEzceg8kKOQ5xJ8BGmR22Ua0YHowbP7/pBUtkGpOy0T9aPhIh0xz
         Rnvd6qBazTCU8GKe43gXGiUaBC8/Povt1PyOpncBJ06xQjOO/5vwD7pE9t0HlXQRkecC
         bCE/9F8L/hE/qY9ENTu1J9wc0I0iFmf0IVc6CGUwz0rEvikwT8RCAQWSRZ7Tk1kjOHHe
         YBIA==
X-Received: by 10.70.131.199 with SMTP id oo7mr3055493pdb.95.1406808816237;
        Thu, 31 Jul 2014 05:13:36 -0700 (PDT)
Received: from [127.0.0.1] ([223.229.21.143])
        by mx.google.com with ESMTPSA id am2sm5359444pbc.59.2014.07.31.05.13.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 05:13:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqmwbpdagf.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254561>



On 7/31/2014 5:08 PM, Matthieu Moy wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> On 7/30/2014 7:43 PM, Matthieu Moy wrote:
>>>> * if (!values->items[i].string)
>>>>           config_error_nonbool(
>>>>
>>>>   => This check could be done once and for all in a function, say
>>>>   git_config_get_value_multi_nonbool, a trivial wrapper around
>>>>   git_config_get_value_multi like
>>>>
>>>> const struct string_list *git_configset_get_value_multi_nonbool(struct config_set *cs, const char *key)
>>>> {
>>>> 	struct string_list l = git_configset_get_value_multi(cs, key);
>>>>         // possibly if(l) depending on the point above.
>>>> 	for (i = 0; i < values->nr; i++) {
>>>> 		if (!values->items[i].string)
>>>> 			git_config_die(key);
>>>> 	}
>>>> 	return l;
>>>> }
>>>>
>>>
>>> Not worth it, most the multi value calls do not die on a nonbool.
>>
>> Can you cite some multi-value variables that can be nonbool? I can't
>> find many multi-valued variables, and I can't find any which would allow
>> bool and nonbool.
> 
> Thinking a bit more about it: we actually need more than your patch and
> my code example above to give accurate error messages. Your code gives
> no error message, and mine uses git_config_die(key); which gives the
> line of the _last_ entry, but not necessarily the right line.
> 
> The right line number should be extracted from the info field of the
> string_list. It's not completely trivial, hence I'd rather have a helper
> doing it well in config.c than letting callers re-do the check and
> possibly give wrong line in their error message as I did in my first
> attempt.
> 
> I think you can introduce a helper git_config_die_linenr(key, linenr)
> that displays the right error message. Then git_config_die becomes a
> wrapper around it that does the lookup to find linenr from the hash.
> 
> You already have a duplicate piece of code in your other series:
> 
> 			if (!kv_info->linenr)
> 				die("unable to parse '%s' from command-line config", entry->key);
> 			else
> 				die("bad config variable '%s' at file line %d in %s",
> 					entry->key,
> 					kv_info->linenr,
> 					kv_info->filename);
> 
> That would be the content of git_config_die_linenr().
> 

Thanks. I will add it in the next reroll.
