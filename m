From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v7 5/8] config: add `git_die_config()` to the config-set
 API
Date: Tue, 05 Aug 2014 20:25:19 +0530
Message-ID: <53E0F057.1040706@gmail.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>	<1406912756-15517-6-git-send-email-tanayabh@gmail.com>	<xmqqoaw0ruwf.fsf@gitster.dls.corp.google.com>	<53DFD729.8090307@gmail.com> <vpqegwwauo2.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 05 16:55:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEg9J-0007vI-Od
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 16:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688AbaHEOza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 10:55:30 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35306 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678AbaHEOz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 10:55:26 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so1491440pdb.27
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EiL1k8LATqvZ8P/U6fTPGy6ga7ygo7iguDgMpHUd5Xo=;
        b=B59fIJ9tf2W5IBYawbU2o2gLJAZU5RBSp1Ili68kV9wniQPi9SILfWQRpHxtwPh7S2
         JBhQ/trhP5gjoBecPcej3otUoPVSBhiw88L3eY47lfFD2aFvZcn3KBPaxn8Cu/WtyJId
         z2Rir4K1Pwq9rGlXhrOS/Z0Rk+NMA9buM3sfyB4XBz3+okULvpwX0f6Xn5l+6HwnssKK
         mQHtYiJQLv1mxKdSds5S8LOAwpZbQ4MUk+fGE0mc/ITAj0+FEAViCo6hON0YCRnZmSip
         0TBhTcJMv1qD/QSR6OJ7rJS3zdnJCQVQyoZ88fjF8TEzlXz1+iPEnrjNPZKPdsuPBu+O
         5kcw==
X-Received: by 10.68.242.103 with SMTP id wp7mr4785092pbc.131.1407250524197;
        Tue, 05 Aug 2014 07:55:24 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.236.62])
        by mx.google.com with ESMTPSA id g6sm7171061pat.2.2014.08.05.07.55.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 05 Aug 2014 07:55:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqegwwauo2.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254806>

On 8/5/2014 1:34 AM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> I was aping the old git_config() system, it also does exactly what you described
>> above. for example, builtin/gc.c line 91,
>>
>> 		if (!strcmp(var, "gc.pruneexpire")) {
>> 		if (value && strcmp(value, "now")) {
>> 			unsigned long now = approxidate("now");
>> 			if (approxidate(value) >= now)
>> 				return error(_("Invalid %s: '%s'"), var, value);
>> 		}
>>
>> would print,
>>  	error: Invalid gc.pruneexpire: 'value'
>> 	fatal: bad config variable 'gc.pruneexpire' at file line 15 in .git/config
> 
> It's good to do at least as well as the old system, but I agree with
> Junio that it's suboptimal.
> 
> Having a single API call to replace
> 
>         error("'%s' must be between 1 and 3");
>         git_config_die(key);
> 
> with stg like:
> 
>         git_config_die(key, "'%s' must be between 1 and 3");
>

Matthieu, I have finished the new version, but instead of flooding the mailing list with
a series again, I wanted to confirm if the new git_config_die() is alright.

	NORETURN __attribute__((format(printf, 2, 3)))
	void git_die_config(const char *key, const char *err, ...)
	{
		const struct string_list *values;
		struct key_value_info *kv_info;

		if (err) {
			va_list params;
			va_start(params, err);
			vreportf("error: ", err, params);
			va_end(params);
		}
		values = git_config_get_value_multi(key);
		kv_info = values->items[values->nr - 1].util;
		git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
	}

Currently works like the old git_config() error reporting path. If err is set to "NULL",
it would print no error message and just the die message. If given something like,

	 git_config_die(key, "value '%s' is not allowed", value);

it would print,

	error: value '3' is not allowed
	fatal: bad config variable 'core.frotz' at file line 15 in .git/config

Cheers,
Tanay Abhra.

> in Junio's example would allow git_config_die to format the error
> message the way it likes (i.e. it can be the same as before when you
> introduce it, and improve afterwards).
> 
> I've never been disturbed by the quality of Git's error messages wrt
> config files (it's not a compiler!), so having good quality messages is
> not a high priority IMHO, but having a good API that as a side effect
> can produce good error messages is important. If changing the error
> messages requires rewritting all callers later, then we've missed the
> point doing the refactoring now.
> 
