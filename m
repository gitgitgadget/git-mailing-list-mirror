From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v5 2/4] Change GIT_ALLOC_LIMIT check to use git_parse_ulong()
Date: Mon, 25 Aug 2014 17:06:22 +0200
Message-ID: <7D29D002-6357-4060-90DF-3993D259C475@zib.de>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de> <1408896466-23149-3-git-send-email-prohaska@zib.de> <20140825113856.GA17288@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 17:06:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLvr7-0005Ws-Jg
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 17:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbaHYPGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 11:06:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:56442 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652AbaHYPGp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2014 11:06:45 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7PF6T4i023788;
	Mon, 25 Aug 2014 17:06:29 +0200 (CEST)
Received: from [192.168.1.200] (ip5f5bd082.dynamic.kabel-deutschland.de [95.91.208.130] (may be forged))
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7PF6Rxn012781
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 25 Aug 2014 17:06:28 +0200 (CEST)
In-Reply-To: <20140825113856.GA17288@peff.net>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53FB50F5.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FB50F5.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FB50F5.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255830>


On Aug 25, 2014, at 1:38 PM, Jeff King <peff@peff.net> wrote:

> On Sun, Aug 24, 2014 at 06:07:44PM +0200, Steffen Prohaska wrote:
> 
>> diff --git a/wrapper.c b/wrapper.c
>> index bc1bfb8..69d1c9b 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -11,14 +11,18 @@ static void (*try_to_free_routine)(size_t size) = do_nothing;
>> 
>> static void memory_limit_check(size_t size)
>> {
>> -	static int limit = -1;
>> -	if (limit == -1) {
>> -		const char *env = getenv("GIT_ALLOC_LIMIT");
>> -		limit = env ? atoi(env) * 1024 : 0;
>> +	static size_t limit = SIZE_MAX;
>> +	if (limit == SIZE_MAX) {
> 
> You use SIZE_MAX as the sentinel for "not set", and 0 as the sentinel
> for "no limit". That seems kind of backwards.
> 
> I guess you are inheriting this from the existing code, which lets
> GIT_ALLOC_LIMIT=0 mean "no limit". I'm not sure if we want to keep that
> or not (it would be backwards incompatible to change it, but we are
> already breaking compatibility here by assuming bytes rather than
> kilobytes; I think that's OK because this is not a documented feature,
> or one intended to be used externally).

I think it's reasonable that GIT_ALLOC_LIMIT=0 means "no limit", so that
the limit can easily be disabled temporarily.

But I could change the sentinel and handle 0 like:

    if (git_parse_ulong(env, &val)) {
	if (!val) {
		val = SIZE_MAX;
	}
    }

Maybe we should do this.



>> +		const char *var = "GIT_ALLOC_LIMIT";
>> +		unsigned long val = 0;
>> +		const char *env = getenv(var);
>> +		if (env && !git_parse_ulong(env, &val))
>> +			die("Failed to parse %s", var);
>> +		limit = val;
>> 	}
> 
> This and the next patch both look OK to me, but I notice this part is
> largely duplicated between the two. We already have git_env_bool to do a
> similar thing for boolean environment variables. Should we do something
> similar like:
> 
> diff --git a/config.c b/config.c
> index 058505c..11919eb 100644
> --- a/config.c
> +++ b/config.c
> @@ -1122,6 +1122,14 @@ int git_env_bool(const char *k, int def)
> 	return v ? git_config_bool(k, v) : def;
> }
> 
> +unsigned long git_env_ulong(const char *k, unsigned long val)
> +{
> +	const char *v = getenv(k);
> +	if (v && !git_parse_ulong(k, &val))
> +		die("failed to parse %s", k);
> +	return val;
> +}
> +
> int git_config_system(void)
> {
> 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
> 
> It's not a lot of code, but I think the callers end up being much easier
> to read:
> 
>  if (limit == SIZE_MAX)
> 	limit = git_env_ulong("GIT_ALLOC_LIMIT", 0);

I think you're right.  I'll change it.


	Steffen