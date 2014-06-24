From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Tue, 24 Jun 2014 16:57:31 +0100
Message-ID: <53A99FEB.5040808@ramsay1.demon.co.uk>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>	<53A84077.4010200@ramsay1.demon.co.uk> <xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 17:57:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzT6Y-0001al-IQ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 17:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbaFXP5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 11:57:36 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:35335 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932224AbaFXP5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 11:57:35 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id E0BCAA64FAE;
	Tue, 24 Jun 2014 15:51:35 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 684D5A64FA7;
	Tue, 24 Jun 2014 15:51:35 +0100 (BST)
Received: from [192.168.254.12] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Tue, 24 Jun 2014 15:51:34 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252411>

On 24/06/14 00:25, Junio C Hamano wrote:
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

I had expected to see one hash table per file/blob, with the three
standard config hash tables linked together to implement the scope/
priority rules. (Well, these could be merged into one, as the current
code does, since that makes handling "multi" keys slightly easier).

ie when looking up a symbol in the .git/config, if not found then
follow the link to parent scope (~/.gitconfig) and search there ...

Of course, other uses (I think) represent only a single scope, so they
would not have any parent scopes to link to.

> When we are operating across repositories (think "recursive
> checkout"), we somehow have to deal with multiple sets of
> configuration, one that applies to the top-level superproject and
> others that apply to individual submodule repositories.
> 

Here, you could push the new .git/config onto a stack while linking
to the parent (~/.gitconfig) scope. So, the lookup code starts from
the stack top, etc, ...

> Even there is currently one caller, the "git config" command
> implementation, if one is designing the new API, the design
> shouldn't be tied to a singleton limitation, I would have to say, so
> that future callers do not have to throw away everything done in
> this series and start from scratch.
> .

I would like to stress that, despite the above, I have not given
any great thought to this project. So please take my comments with
a big pinch of salt. I was just scrolling through the patch in my
email client and was surprised to see the singleton ...

ATB,
Ramsay Jones
