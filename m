From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4 2/5] notes.c: replace `git_config()` with `git_config_get_value_multi()`
Date: Wed, 30 Jul 2014 20:10:32 +0530
Message-ID: <53D903E0.4080209@gmail.com>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>	<1406727549-22334-3-git-send-email-tanayabh@gmail.com> <vpq1tt3q6ic.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:40:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCV3Y-0007KN-6U
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 16:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbaG3Okg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 10:40:36 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:47364 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaG3Okf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 10:40:35 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so1624600pad.24
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bSq/b8X0o1t4tS51xdsd/3rZZM0YfZxawFmaH/hvF48=;
        b=XLbKUSyYS7iqGCF8mW9MhNujLqapivUUOlMA9pJmExnsmNXLQ9IqGg8MLlqjwxYd1U
         HU8SS6Q9G+BRK6zKU7iL8X/CcSQVWvcwTuqP2JpSXWaetD2PhIYVg+6aE03G0swgGb3o
         jmMjN/97EbzHyG5piho670j7OUBFZirue7NGX6A1WywPwex+qNirS1FsmA3U/dBmgXue
         BtZ/gtbprxByfmIB42itiwE4YYBFSOhxtFaEW26RyCyGyEiGSNAxrcia1049PLrcbKme
         qY29qDlDyqWV9w2JQmBbjXDJqN6PcwiepDLoT6s2ZG89H8LKWdsXbqiahk6AycRoNXMD
         0FBA==
X-Received: by 10.68.204.134 with SMTP id ky6mr5294173pbc.61.1406731235101;
        Wed, 30 Jul 2014 07:40:35 -0700 (PDT)
Received: from [127.0.0.1] ([223.184.63.185])
        by mx.google.com with ESMTPSA id dv3sm8654560pac.26.2014.07.30.07.40.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 07:40:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpq1tt3q6ic.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254497>



On 7/30/2014 7:43 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> -	git_config(notes_display_config, &load_config_refs);
>> +	if (load_config_refs) {
>> +		values = git_config_get_value_multi("notes.displayref");
>> +		if (values) {
>> +			for (i = 0; i < values->nr; i++) {
>> +				if (!values->items[i].string)
>> +					config_error_nonbool("notes.displayref");
>> +				else
>> +					string_list_add_refs_by_glob(&display_notes_refs,
>> +								     values->items[i].string);
>> +			}
>> +		}
>> +	}
> 
> It seems to me that you're doing a lot here that should have been done
> once in the config API:
> 
> * if (values) {
>           for (i = 0; i < values->nr
> 
>   => We could avoid the "if" statement if git_config_get_value_multi was
>   always returning a string_list, possibly empty (values->nr == 0
>   instead of values == NULL).
>

or we can do something like,

	if (!git_config_get_value_multi("notes.displayref", &values)) {
		/* return 0 if there is a value_list for the key */

>   Not as obvious as it seems, because you normally return a pointer to
>   the string_list that is already in the hashmap, so you can't just
>   malloc() an empty one if you don't want to leak it.
> 
>   Another option would be to provide an iterator that would call a
>   function on each value of the list, and do nothing when there's no
>   list at all (back to the callback-style API, but you would iterate
>   only through the values for the right key).
>

This is also a good idea, but still we are back to the callback API,
and what we are gaining is fewer loop iterations than git_config().

Which way do you prefer, a reroll is easy but Junio might have been sick
of replacing the patches in pu by now. :)

> * if (!values->items[i].string)
>           config_error_nonbool(
> 
>   => This check could be done once and for all in a function, say
>   git_config_get_value_multi_nonbool, a trivial wrapper around
>   git_config_get_value_multi like
> 
> const struct string_list *git_configset_get_value_multi_nonbool(struct config_set *cs, const char *key)
> {
> 	struct string_list l = git_configset_get_value_multi(cs, key);
>         // possibly if(l) depending on the point above.
> 	for (i = 0; i < values->nr; i++) {
> 		if (!values->items[i].string)
> 			git_config_die(key);
> 	}
> 	return l;
> }
>

Not worth it, most the multi value calls do not die on a nonbool.

> const struct string_list *git_config_get_value_multi_nonbool(const char *key)
> {
> 	git_config_check_init();
> 	return git_configset_get_value_multi_nonbool(&the_config_set, key);
> }
> 
> 
>   (totally untested)
> 
>   BTW, is it intentional that you call config_error_nonbool() without
>   die-ing?
>

Yup, it's intentional, original code didn't die for empty values, and it seemed
logical to me to emulate that over to the rewrite.
