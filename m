From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Tue, 24 Jun 2014 12:53:25 +0530
Message-ID: <53A9276D.3020503@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>	<53A84077.4010200@ramsay1.demon.co.uk> <xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 09:23:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzL53-00020Y-H0
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 09:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbaFXHXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 03:23:45 -0400
Received: from plane.gmane.org ([80.91.229.3]:46881 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbaFXHXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 03:23:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WzL4x-0001wZ-7a
	for git@vger.kernel.org; Tue, 24 Jun 2014 09:23:43 +0200
Received: from 117.254.220.71 ([117.254.220.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 09:23:43 +0200
Received: from tanayabh by 117.254.220.71 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 09:23:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 117.254.220.71
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252387>

On 6/24/2014 4:55 AM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>>> +static struct hashmap *get_config_cache(void)
>>> +{
>>> +	static struct hashmap config_cache;
>>> +	if (!hashmap_initialized) {
>>> +		config_cache_init(&config_cache);
>>> +		hashmap_initialized = 1;
>>> +		git_config(config_cache_callback, NULL);
>>> +	}
>>> +	return &config_cache;
>>> +}
>>
>> [I have not been following this series at all (sorry I haven't had
>> the time to spare), so take these comments with a very big pinch of
>> salt! ie just ignore me if it's already been discussed etc. ;-) ]
>>
>> The 'git config' command can be used to read arbitrary files (so long
>> as they conform to the config syntax). For example, see the --file and
>> --blob options to git-config. At present, I think only scripted commands
>> use this facility (eg git-submodule). Noting the singleton config_cache,
>> what happens when git-submodule becomes a C builtin, or indeed any other
>> C builtin wants to take advantage of the new code when processing a non-
>> standard config file?
>
> Yup, that is a very good point.  There needs an infrastructure to
> tie a set of files (i.e. the standard one being the chain of
> system-global /etc/gitconfig to repo-specific .git/config, and any
> custom one that can be specified by the caller like submodule code)
> to a separate hashmap; a future built-in submodule code would use
> two hashmaps aka "config-caches", one to manage the usual
> "configuration" and the other to manage the contents of the
> .gitmodules file.
>
> When we are operating across repositories (think "recursive
> checkout"), we somehow have to deal with multiple sets of
> configuration, one that applies to the top-level superproject and
> others that apply to individual submodule repositories.
>
> Even there is currently one caller, the "git config" command
> implementation, if one is designing the new API, the design
> shouldn't be tied to a singleton limitation, I would have to say, so
> that future callers do not have to throw away everything done in
> this series and start from scratch.
>

What changes should I implement in this series? Should I add new
user facing API adding to the singleton callers which are already in
this series.

"submodule lookup API" was intoduced by Heiko Voigt in [1], which is in
"cooking" now. His series already allows looking up local configuration
by passing in the null_sha1 for gitmodule or commit sha1. What else can
I add to my implementation, please suggest.

Thanks,
Tanay Abhra
