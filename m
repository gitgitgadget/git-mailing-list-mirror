From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 1/9] submodule: prepare for recursive checkout of
 submodules
Date: Fri, 07 Feb 2014 22:06:59 +0100
Message-ID: <52F54AF3.3050209@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de>	<xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>	<52EFF25E.6080306@web.de> <52EFF290.5090501@web.de> <xmqqha8fdeek.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:07:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBsdi-00069y-BR
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbaBGVHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:07:03 -0500
Received: from mout.web.de ([212.227.17.12]:55235 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbaBGVHB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:07:01 -0500
Received: from [192.168.178.41] ([84.132.186.180]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MZlZK-1Vvr7l1odS-00LX7s for <git@vger.kernel.org>;
 Fri, 07 Feb 2014 22:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqha8fdeek.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:gWK38xjBstSC42VtEMJfbyCXlTGf9I6Sm7Tvii6efKPdqK+Ziau
 8qzBU7Y581fepG8IfL+OKjHEO+EdIR/joyCyPh0NRHzWHRKt2kP5D4Hz3klcVyhFIwy6gIW
 OKHLmal++Ksm2MhRVRZJZQLcRWqHeKGZYT1ykmJ/11CDhti5ZIEaEX6kZPtl504R3/Qrynj
 0wu1eH9uE5gIkFse9ZkAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241798>

Am 03.02.2014 23:23, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> This commit adds the functions and files needed for configuration,
> 
> Please just say "Add the functions and files needed for ...".

Roger that.

>> +++ b/Documentation/recurse-submodules-update.txt
>> @@ -0,0 +1,8 @@
>> +--[no-]recurse-submodules::
>> +	Using --recurse-submodules will update the work tree of all
>> +	initialized submodules according to the commit recorded in the
>> +	superproject if their update configuration is set to checkout'. If
> 
> That single quote does not seem to be closing any matching quote.
> 
> The phrase "according to" feels a bit too fuzzy.  Merging the commit
> to what is checked out is one possible implementation of "according to".
> Applying the diff between the commit and what is checked out to work
> tree is another.  Resetting the work tree files to exactly match the
> commit would be yet another.
> 
> I think "update the work trees to the commit" (i.e. lose the
> "according") would be the closest to what you are trying to say
> here.
> 
>> +	local modifications in a submodule would be overwritten the checkout
>> +	will fail unless forced. Without this option or with
>> +	--no-recurse-submodules is, the work trees of submodules will not be
>> +	updated, only the hash recorded in the superproject will be updated.
> 
> It is unclear what happens if their update configuration is set to
> something other than 'checkout'.

Jonathan already proposed a better description, will use that in the next
round.

>> diff --git a/submodule.c b/submodule.c
>> index 613857e..b3eb28d 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -382,6 +384,48 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
>> ...
>> +int option_parse_update_submodules(const struct option *opt,
>> +				   const char *arg, int unset)
>> +{
>> +	if (unset) {
>> +		*(int *)opt->value = RECURSE_SUBMODULES_OFF;
>> +	} else {
>> +		if (arg)
>> +			*(int *)opt->value = parse_update_recurse_submodules_arg(opt->long_name, arg);
>> +		else
>> +			*(int *)opt->value = RECURSE_SUBMODULES_ON;
>> +	}
> 
> You can easily unnest to lose {}
> 
>     if (unset)
>             value = off;
>     else if (arg)
>             value = parse...;
>     else
>             value = on;

Yeah, that's better.

> Also I suspect that git_config_maybe_bool() natively knows how to
> handle arg==NULL, so
> 
>     if (unset)
> 	value = off;
>     else
> 	value = parse...;
> 
> is sufficient?

Will try.
