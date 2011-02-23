From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/6] fetch/pull: recurse into submodules when necessary
Date: Thu, 24 Feb 2011 00:28:24 +0100
Message-ID: <4D659818.4070107@web.de>
References: <4D656F25.5090007@web.de> <4D656F4D.6080401@web.de> <7vipwa5phh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:29:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsO95-0006Cf-AT
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab1BWX3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:29:18 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:52573 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab1BWX3R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:29:17 -0500
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3122318935015;
	Thu, 24 Feb 2011 00:28:25 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsO89-0004m7-00; Thu, 24 Feb 2011 00:28:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vipwa5phh.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX181P+fJAoog1Pmsj/3rjbT/6VOBQmcc/efV2csp
	hID7AktRnb1VfcE19blNkQOSG8seiM3ALuHEgO9rLqyQSjLiK+
	lWpxoOl5HVLuLgXg1NGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167743>

Am 23.02.2011 23:56, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> diff --git a/submodule.c b/submodule.c
>> index 6f1c107..c8c3a99 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -152,6 +153,20 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
>> ...
>> +int parse_fetch_recurse_submodules_arg(const char *arg)
>> +{
>> +	switch (git_config_maybe_bool("", arg)) {
> 
> It's a bit unusual to see "" as the variable name; doesn't config-maybe-bool
> barf when arg is not what it likes, with the name as part of its message?

git_config_*maybe*_bool() itself calls git_config_maybe_bool_text() and
git_parse_long() which all don't die() on anything (while git_config_bool()
can do that in git_config_int() via git_config_bool_or_int()). But you are
right, using something more descriptive than "" is much better here.

>> @@ -248,11 +263,73 @@ void set_config_fetch_recurse_submodules(int value)
>> ...
>> +static void submodule_collect_changed_cb(struct diff_queue_struct *q,
>> +					 struct diff_options *options,
>> +					 void *data)
>> +{
>> +	int i;
>> +	for (i = 0; i < q->nr; i++) {
>> +		struct diff_filepair *p = q->queue[i];
>> +		if (!S_ISGITLINK(p->two->mode))
>> +			continue;
>> +
>> +		if (S_ISGITLINK(p->one->mode)) {
>> +			/* NEEDSWORK: We should honor the name configured in
>> +			 * the .gitmodules file of the commit we are examining
>> +			 * here to be able to correctly follow submodules
>> +			 * being moved around. */
>> +			struct string_list_item *path;
>> +			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
>> +			if (!path)
>> +				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
> 
> I wondered why there is no mention of "data" in the implementation of this
> function; changed_submodule_paths global is used instead here.
> 
> I do not see anywhere the global string_list is initialized, freed, nor
> re-initialized for reuse.  Are you guaranteeing that the caller only calls
> the check_for_new_submodule_commits() function once, and if so how?  The
> function is called from update_local_ref() in builtin/fetch.c, which in
> turn gets called number of times during a fetch.  IOW, does the code do
> the right thing when you are fetching more than one refs?

I assume that a string_list initialized with 0 is initialized properly.
The idea is to let check_for_new_submodule_commits() be called as often
as needed and for each ref to collect all submodule changes recorded in
any ref and afterwards only once call fetch_populated_submodules() to
collect all submodules touched by any commits on any ref. But maybe
fetch_populated_submodules() should empty the string_list it just
worked through?
