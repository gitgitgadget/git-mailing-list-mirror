From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v7 5/8] config: add `git_die_config()` to the config-set
 API
Date: Tue, 05 Aug 2014 00:25:37 +0530
Message-ID: <53DFD729.8090307@gmail.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>	<1406912756-15517-6-git-send-email-tanayabh@gmail.com> <xmqqoaw0ruwf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 20:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XENQB-0002YP-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbaHDSzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:55:43 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:48684 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaHDSzn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:55:43 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so10065959pdb.41
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6862+xdvSiyWKviHKpOHjS9BVraF91IEVieZuHGBFvU=;
        b=Hc0pLBjDaFJijet34b10y7kAJEYq9w8TS69AwlM0TR9fG+mfBONeWDqKq2aRxu7C4+
         vhcTHOii/OLd10gMO7aXBEhzFR80mR6xJklNd0EulTRku2FiVmYMfsGMK53UjrmbakDZ
         jfFwtYiBiO7iOaOBaGwqIaRMfztfSY4/IHylLtabeZtpKH84g3+6TiB3wbK2fkE614Ff
         2wgwGl99RlmTXCeDxh9PeNOt11SxNPHT+UXQajzkD9cm8J7dZ6HDkNbto+wux+2ehlTM
         EyhAFEOnvQux8rR0r1f6RCN6+AoHhWYoG0m/oElJ8A9YkrUWajlNL3Rl0nJgcnPsfHds
         wb2A==
X-Received: by 10.70.45.97 with SMTP id l1mr4030617pdm.148.1407178542621;
        Mon, 04 Aug 2014 11:55:42 -0700 (PDT)
Received: from [127.0.0.1] ([223.226.75.102])
        by mx.google.com with ESMTPSA id qb2sm3666967pbb.0.2014.08.04.11.55.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:55:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqoaw0ruwf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254765>



On 8/4/2014 11:37 PM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> Add `git_die_config` that dies printing the line number and the file name
>> of the highest priority value for the configuration variable `key`.
>>
>> It has usage in non-callback based config value retrieval where we can
>> raise an error and die if there is a semantic error.
>> For example,
>>
>> 	if (!git_config_get_value(key, &value)) {
>> 		/* NULL values not allowed */
>> 		if (!value)
>> 			git_config_die(key);
>> 		else
>> 			/* do work */
>> 	}
> 
> It feels a bit unnatural at the API level that this does not take
> 'value'; I do understand that it is not a big deal in the error code
> path to locate again the value from the configuration using the key,
> but still.
>

But, we don't have a use for "value" as it is not denoted in the error
string, that is why I left it out.

> It feels even more unnatural that the caller cannot say _how_ it
> finds the value offending by not taking any message.  For one
> particular callchain, e.g. git_config_get_string() that eventually
> calls git_config_string() which will show an error message via
> config_error_nonbool(), you may not want any extra message, but for
> new callers that wants to make sure value falls within a supported
> range, this forces it to write
> 
> 	if (!git_config_get_int(key, &num)) {
>         	if (!(0 < num && num < 4)) {
> 			error("'%s' must be between 1 and 3");
>                         git_config_die(key);
> 		}
> 		/* otherwise work */
> 	}
> 
> and then the error message would say something like:
> 
> 	error: 'core.frotz' must be between 1 and 3
> 	fatal: bad config variable 'core.frotz' at file line 15 in .git/config
> 
> which sounds somewhat backwards, at least to me.
>

I was aping the old git_config() system, it also does exactly what you described
above. for example, builtin/gc.c line 91,

		if (!strcmp(var, "gc.pruneexpire")) {
		if (value && strcmp(value, "now")) {
			unsigned long now = approxidate("now");
			if (approxidate(value) >= now)
				return error(_("Invalid %s: '%s'"), var, value);
		}

would print,
 	error: Invalid gc.pruneexpire: 'value'
	fatal: bad config variable 'gc.pruneexpire' at file line 15 in .git/config

or imap-send.c line 1340,

	if (!strcmp("sslverify", key))
		server.ssl_verify = git_config_bool(key, val);
	else if (!strcmp("preformattedhtml", key))
		server.use_html = git_config_bool(key, val);
	else if (!val)
		return config_error_nonbool(key);
again would cause a error & die, message combo as above. There are many examples like that.
We can easily take a custom error message but again I was just aping the old system.

>> +NORETURN
>> +void git_die_config_linenr(const char *key, const char *filename, int linenr)
>> +{
>> +	if (!linenr)
>> +		die(_("unable to parse '%s' from command-line config"), key);
> 
> Do we have existing code that says "we signal that it is from the
> command line by setting linenr to zero" already?  Otherwise I would
> have thought filename == NULL would be a more sensible convention.
> 
> Otherwise OK.
>

Noted. Next reroll will have filename as the convention.

>> +	else
>> +		die(_("bad config variable '%s' at file line %d in %s"),
> 
> At least, quote the last '%s'.
>

Noted. Thanks.
