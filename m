From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Tue, 24 Jun 2014 12:55:30 +0530
Message-ID: <53A927EA.4020106@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>	<53A84077.4010200@ramsay1.demon.co.uk> <xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jun 24 09:25:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzL6s-000364-TA
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 09:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbaFXHZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 03:25:39 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44561 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbaFXHZi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 03:25:38 -0400
Received: by mail-pb0-f44.google.com with SMTP id md12so6893226pbc.31
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mlQHZyEe+UU8WJTYVXsnH9MFx75EkWJYnibG1VCbNO8=;
        b=M4GLmFR8VjLgjeXdNFj0fy158lxKRe3Y9oGceGgy5gGO0mHsSysXJyJG8g8tWUa7ep
         4LVbdUN94PQbFpPcOLBQZdRcw3PLgtNZeIhQApdWE2rQ/U3GxRxw6QFJ4/JshfIYFA1i
         qbQpW2Oq8DpPHjbJf2y1CtkTtAp/wJdwlwSqt4B7Er43qgUocf0L51+uYk7njpJBv1b7
         WC+RhlfD9tMlEJQe7JIrS7V7Jnh4aD8gboKX+Dzky42y+2N388K/lvAqlnqhgXTc1KTo
         oFi5BhIUGJFYbNbETKPzglnOAeA0aYSQacN9tAdPjgXUCJdWIm+HVkMgQvArBSo2IrsT
         q1Jw==
X-Received: by 10.68.95.225 with SMTP id dn1mr35755668pbb.126.1403594737968;
        Tue, 24 Jun 2014 00:25:37 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.220.71])
        by mx.google.com with ESMTPSA id lq6sm106176883pab.48.2014.06.24.00.25.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 00:25:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252388>

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
Sorry for the repost, missed the link.

What changes should I implement in this series? Should I add new
user facing API adding to the singleton callers which are already in
this series.

"submodule lookup API" was intoduced by Heiko Voigt in [1], which is in
"cooking" now. His series already allows looking up local configuration
by passing in the null_sha1 for gitmodule or commit sha1. What else can
I add to my implementation, please suggest.

[1] http://thread.gmane.org/gmane.comp.version-control.git/250811

Thanks,
Tanay Abhra
