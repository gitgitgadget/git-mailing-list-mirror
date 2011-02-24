From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 4/6] Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule'
 option
Date: Thu, 24 Feb 2011 21:44:30 +0100
Message-ID: <4D66C32E.5090103@web.de>
References: <4D656F25.5090007@web.de> <4D656FB0.7040904@web.de> <7vei6y5ol6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 21:45:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psi4F-0004Ug-5X
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 21:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab1BXUpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 15:45:38 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:60041 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab1BXUph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 15:45:37 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id C9F431998113B;
	Thu, 24 Feb 2011 21:44:33 +0100 (CET)
Received: from [93.240.123.207] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Psi37-0005tn-00; Thu, 24 Feb 2011 21:44:33 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vei6y5ol6.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX188rk1zsu2uJImiLtnoVOa92iRM4bmgLg2DbWpT
	sdTwuPFt0wtfORttH7jHOl+nrYnef2IxU9yMXLkuuxBukWAA4p
	62plkwsbbixJDmnBsBvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167859>

Am 24.02.2011 00:16, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> diff --git a/submodule.c b/submodule.c
>> index cccd728..b477c3c 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -113,7 +113,7 @@ int parse_submodule_config_option(const char *var, const char *value)
>>  		if (!config)
>>  			config = string_list_append(&config_fetch_recurse_submodules_for_name,
>>  						    strbuf_detach(&submodname, NULL));
>> -		config->util = git_config_bool(var, value) ? (void *)1 : NULL;
>> +		config->util = (void *)(size_t)parse_fetch_recurse_submodules_arg(value);
> 
> What is this double-cast about?

64bit gcc warns when I drop either of them because a 32bit integer
is assigned to a 64bit wide pointer here.

>> @@ -376,8 +376,13 @@ int fetch_populated_submodules(int num_options, const char **options,
>> ...
>> +				if ((size_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_OFF)
>>  					continue;
>> +				if ((size_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_ON_DEMAND) {
> 
> Likewise here; size_t feels a strange type to cast to in this comparison
> between (void *) and an enum, no?

I get a warning here if I drop the second cast. gcc doesn't warn if
I drop the first one, but that is just because the enum value happens
to be 0 there. So I added that cast there too to be on the safe side
in case the value changes in the future and to be consistent to other
readers of this code.
