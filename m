From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 6/7] config: add `git_die_config()` to the config-set API
Date: Thu, 31 Jul 2014 18:52:38 +0200
Message-ID: <vpqr411bhd5.fsf@anie.imag.fr>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
	<1406821662-1570-7-git-send-email-tanayabh@gmail.com>
	<vpqr411h69h.fsf@anie.imag.fr> <53DA7281.8060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 18:52:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCtaw-0003Tk-LF
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 18:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbaGaQwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 12:52:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59163 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbaGaQwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 12:52:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VGqaIZ011568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 18:52:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VGqcLq028515;
	Thu, 31 Jul 2014 18:52:38 +0200
In-Reply-To: <53DA7281.8060403@gmail.com> (Tanay Abhra's message of "Thu, 31
	Jul 2014 22:14:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 Jul 2014 18:52:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VGqaIZ011568
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407430357.67719@vvL2jYrPc3h0Y4I9SOVDfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254591>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/31/2014 9:25 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> +void git_die_config(const char *key)
>>> +{
>>> +	const struct string_list *values;
>>> +	struct key_value_info *kv_info;
>>> +	values = git_config_get_value_multi(key);
>>> +	kv_info = values->items[values->nr - 1].util;
>>> +	if (!kv_info->linenr)
>>> +		die(_("unable to parse '%s' from command-line config"), key);
>>> +	else
>>> +		die(_("bad config variable '%s' at file line %d in %s"),
>>> +			key,
>>> +			kv_info->linenr,
>>> +			kv_info->filename);
>>> + }
>> 
>> Extra whitespace before }.
>> 
>> Also, didn't we agree that it was a good thing to factor this
>> if/then/else into a helper function?
>> 
>
> I have been thinking about it, wouldn't it be better to give users
> a function like,
>
> git_config_die_exact(key, value);
>
> where user supplies key & value both and it would print the correct message based
> on that.

I suggested git_config_die_linenr(key, linenr), and I now realize it
should take the value too.

You're suggesting git_config_die_exact(key, value). Is it a typo that
you forgot the line number, or is it intentional? If intentional, I
don't think it solves your issue:

[section]
   key
   key

There are two errors in this file, and you need to provide a line
number. key and value alone do not allow you to know which line the
error is. You can use a convention like "complain on the first value
equal to the argument", but I'm not sure that would always work. And
that seems backward to me to reconstruct the line number since the
function can be called from places where the line number is already
known (while iterating over the string_list for example).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
