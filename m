From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 2/5] notes.c: replace `git_config()` with `git_config_get_value_multi()`
Date: Wed, 30 Jul 2014 18:42:27 +0200
Message-ID: <vpqsiliol1o.fsf@anie.imag.fr>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
	<1406727549-22334-3-git-send-email-tanayabh@gmail.com>
	<vpq1tt3q6ic.fsf@anie.imag.fr> <53D903E0.4080209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 18:42:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCWxq-0001QD-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 18:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974AbaG3Qmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 12:42:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57434 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754424AbaG3Qmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 12:42:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6UGgQG3008002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2014 18:42:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6UGgR3o015350;
	Wed, 30 Jul 2014 18:42:27 +0200
In-Reply-To: <53D903E0.4080209@gmail.com> (Tanay Abhra's message of "Wed, 30
	Jul 2014 20:10:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 Jul 2014 18:42:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6UGgQG3008002
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407343351.72971@zQUGkd2PEuftwIRCIRSKCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254499>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/30/2014 7:43 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> -	git_config(notes_display_config, &load_config_refs);
>>> +	if (load_config_refs) {
>>> +		values = git_config_get_value_multi("notes.displayref");
>>> +		if (values) {
>>> +			for (i = 0; i < values->nr; i++) {
>>> +				if (!values->items[i].string)
>>> +					config_error_nonbool("notes.displayref");
>>> +				else
>>> +					string_list_add_refs_by_glob(&display_notes_refs,
>>> +								     values->items[i].string);
>>> +			}
>>> +		}
>>> +	}
>> 
>> It seems to me that you're doing a lot here that should have been done
>> once in the config API:
>> 
>> * if (values) {
>>           for (i = 0; i < values->nr
>> 
>>   => We could avoid the "if" statement if git_config_get_value_multi was
>>   always returning a string_list, possibly empty (values->nr == 0
>>   instead of values == NULL).
>>
>
> or we can do something like,
>
> 	if (!git_config_get_value_multi("notes.displayref", &values)) {
> 		/* return 0 if there is a value_list for the key */
>
>>   Not as obvious as it seems, because you normally return a pointer to
>>   the string_list that is already in the hashmap, so you can't just
>>   malloc() an empty one if you don't want to leak it.
>> 
>>   Another option would be to provide an iterator that would call a
>>   function on each value of the list, and do nothing when there's no
>>   list at all (back to the callback-style API, but you would iterate
>>   only through the values for the right key).
>>
>
> This is also a good idea, but still we are back to the callback API,
> and what we are gaining is fewer loop iterations than git_config().

Regardless of performance, the code would also be a bit shorter, since
the callback just gets the values for the right key, so it doesn't need
to re-test that the key is the right one.

Here, the callback would basically be the body of the for loop above.

> Which way do you prefer, a reroll is easy but Junio might have been sick
> of replacing the patches in pu by now. :)

No need to replace anything, you can add new helpers on top of the
existing.

Do it the way you feel is better, I'm just giving ideas.

>> * if (!values->items[i].string)
>>           config_error_nonbool(
>> 
>>   => This check could be done once and for all in a function, say
>>   git_config_get_value_multi_nonbool, a trivial wrapper around
>>   git_config_get_value_multi like
>> 
>> const struct string_list *git_configset_get_value_multi_nonbool(struct config_set *cs, const char *key)
>> {
>> 	struct string_list l = git_configset_get_value_multi(cs, key);
>>         // possibly if(l) depending on the point above.
>> 	for (i = 0; i < values->nr; i++) {
>> 		if (!values->items[i].string)
>> 			git_config_die(key);
>> 	}
>> 	return l;
>> }
>>
>
> Not worth it, most the multi value calls do not die on a nonbool.

Can you cite some multi-value variables that can be nonbool? I can't
find many multi-valued variables, and I can't find any which would allow
bool and nonbool.

>> const struct string_list *git_config_get_value_multi_nonbool(const char *key)
>> {
>> 	git_config_check_init();
>> 	return git_configset_get_value_multi_nonbool(&the_config_set, key);
>> }
>> 
>> 
>>   (totally untested)
>> 
>>   BTW, is it intentional that you call config_error_nonbool() without
>>   die-ing?
>>
>
> Yup, it's intentional, original code didn't die for empty values, and it seemed
> logical to me to emulate that over to the rewrite.

The old code was doing

	if (*load_refs && !strcmp(k, "notes.displayref")) {
		if (!v)
			config_error_nonbool(k);
		string_list_add_refs_by_glob(&display_notes_refs, v);

It seems that the intent of the programmer was

	if (*load_refs && !strcmp(k, "notes.displayref")) {
		if (!v)
			return config_error_nonbool(k); // <---------------
		string_list_add_refs_by_glob(&display_notes_refs, v);

At least, that would explain why the code uses v even after testing that
it is a NULL pointer.

You're already fixing a bug in your patch by not using NULL values, but
then I don't see any reason to keep the old weird behavior (display an
error but do not die).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
