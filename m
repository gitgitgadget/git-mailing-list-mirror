From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Thu, 12 Jul 2012 21:34:25 +0200
Message-ID: <vpq1ukgai4e.fsf@bauges.imag.fr>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
	<1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtxxcc36v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:34:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpP9y-0001AA-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 21:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab2GLTej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 15:34:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50656 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310Ab2GLTeh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 15:34:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6CJWp4Q014187
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Jul 2012 21:32:51 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SpP9e-00063W-Jd; Thu, 12 Jul 2012 21:34:26 +0200
In-Reply-To: <7vtxxcc36v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 12 Jul 2012 10:14:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 12 Jul 2012 21:32:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6CJWp4Q014187
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342726374.35424@f0XOnN+d4E/fNwkpC70MnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201375>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> When $HOME is unset, home_config_paths fails and returns NULL pointers
>> for user_config and xdg_config. Valgrind complains with Syscall param
>> access(pathname) points to unaddressable byte(s).
>>
>> Don't call blindly access() on these variables, but test them for
>> NULL-ness before.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>> This patch causes valgrind warnings in t1300.81 (get --path copes with
>>> unset $HOME) about passing NULL to access():
>>
>> Indeed. The following patch should fix it.
>>
>>  builtin/config.c | 3 ++-
>>  config.c         | 4 ++--
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/config.c b/builtin/config.c
>> index e8e1c0a..67945b2 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -387,7 +387,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>>  
>>  		home_config_paths(&user_config, &xdg_config, "config");
>>  
>> -		if (access(user_config, R_OK) && !access(xdg_config, R_OK))
>> +		if (user_config && access(user_config, R_OK) &&
>> +		    xdg_config && !access(xdg_config, R_OK))
>>  			given_config_file = xdg_config;
>
> Shouldn't we be using xdg_config, if user_config is NULL and
> xdg_config is defined and accessible?

I don't think so. If user_config is NULL, it means something went wrong,
because $HOME is unset. In this case, I'd rather die than using some
other configuration file silently (which would be possible if
$XDG_CONFIG_HOME is set), and this is what the code does:

		if (user_config && access(user_config, R_OK) &&
		    xdg_config && !access(xdg_config, R_OK))
			given_config_file = xdg_config;
		else if (user_config)
			given_config_file = user_config;
		else
			die("$HOME not set");

Perhaps it could actually be made even clearer with

		if (!user_config)
			die("$HOME not set");
		else if (access(user_config, R_OK) &&
			 xdg_config && !access(xdg_config, R_OK))
			given_config_file = xdg_config;
		else
			given_config_file = user_config;

That said, I don't care very strongly about it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
