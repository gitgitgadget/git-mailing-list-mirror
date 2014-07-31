From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 2/5] notes.c: replace `git_config()` with `git_config_get_value_multi()`
Date: Thu, 31 Jul 2014 13:38:56 +0200
Message-ID: <vpqmwbpdagf.fsf@anie.imag.fr>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
	<1406727549-22334-3-git-send-email-tanayabh@gmail.com>
	<vpq1tt3q6ic.fsf@anie.imag.fr> <53D903E0.4080209@gmail.com>
	<vpqsiliol1o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:39:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCohY-0002lF-Ch
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 13:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbaGaLjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 07:39:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59510 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbaGaLjM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 07:39:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBctcT029493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 13:38:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBcuYQ024972;
	Thu, 31 Jul 2014 13:38:56 +0200
In-Reply-To: <vpqsiliol1o.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	30 Jul 2014 18:42:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 Jul 2014 13:38:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VBctcT029493
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407411538.13803@dR0DOIgvoSY9eYqOPannxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254557>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> On 7/30/2014 7:43 PM, Matthieu Moy wrote:
>>> * if (!values->items[i].string)
>>>           config_error_nonbool(
>>> 
>>>   => This check could be done once and for all in a function, say
>>>   git_config_get_value_multi_nonbool, a trivial wrapper around
>>>   git_config_get_value_multi like
>>> 
>>> const struct string_list *git_configset_get_value_multi_nonbool(struct config_set *cs, const char *key)
>>> {
>>> 	struct string_list l = git_configset_get_value_multi(cs, key);
>>>         // possibly if(l) depending on the point above.
>>> 	for (i = 0; i < values->nr; i++) {
>>> 		if (!values->items[i].string)
>>> 			git_config_die(key);
>>> 	}
>>> 	return l;
>>> }
>>>
>>
>> Not worth it, most the multi value calls do not die on a nonbool.
>
> Can you cite some multi-value variables that can be nonbool? I can't
> find many multi-valued variables, and I can't find any which would allow
> bool and nonbool.

Thinking a bit more about it: we actually need more than your patch and
my code example above to give accurate error messages. Your code gives
no error message, and mine uses git_config_die(key); which gives the
line of the _last_ entry, but not necessarily the right line.

The right line number should be extracted from the info field of the
string_list. It's not completely trivial, hence I'd rather have a helper
doing it well in config.c than letting callers re-do the check and
possibly give wrong line in their error message as I did in my first
attempt.

I think you can introduce a helper git_config_die_linenr(key, linenr)
that displays the right error message. Then git_config_die becomes a
wrapper around it that does the lookup to find linenr from the hash.

You already have a duplicate piece of code in your other series:

			if (!kv_info->linenr)
				die("unable to parse '%s' from command-line config", entry->key);
			else
				die("bad config variable '%s' at file line %d in %s",
					entry->key,
					kv_info->linenr,
					kv_info->filename);

That would be the content of git_config_die_linenr().

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
