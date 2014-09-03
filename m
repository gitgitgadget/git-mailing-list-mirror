From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] parse-options: detect attempt to add a duplicate short
 option name
Date: Wed, 03 Sep 2014 22:29:50 +0200
Message-ID: <54077A3E.20703@web.de>
References: <1409753034-9459-1-git-send-email-johan@herland.net>	<1409753034-9459-3-git-send-email-johan@herland.net>	<xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com> <xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 22:30:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPHBr-0008EU-1b
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 22:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbaICU36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 16:29:58 -0400
Received: from mout.web.de ([212.227.15.14]:53213 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447AbaICU35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 16:29:57 -0400
Received: from [192.168.178.27] ([79.253.169.244]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lm4jx-1XyL1X1vyT-00ZeU2; Wed, 03 Sep 2014 22:29:54
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:XN7rpZCIMGQ1+PncPruNEH8R4+qxFnw3PwrqnGH9u4q1/sr7t+M
 mtTMGvCxFJhbhm8tQzO2TAEm4Mk/7YdW/t7dJRVQjeb8sKeZ2z1CNZ3vv26dTkalRY6QHQW
 LhlhB8UGQhA7UfE2vZ1O67wGWxOVqKc77zQLuNR+YWp1bv4AZwJyHAwphSGsfAZoHM7UkCH
 DioXydw1ILOzfDuCP3uBQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256410>

Am 03.09.2014 um 21:42 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> diff --git a/builtin/revert.c b/builtin/revert.c
>>> index f9ed5bd..831c2cd 100644
>>> --- a/builtin/revert.c
>>> +++ b/builtin/revert.c
>>> @@ -91,6 +91,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>>>   			N_("option for merge strategy"), option_parse_x),
>>>   		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>>>   		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>>> +		OPT_BOOL('n', "no-verify", &opts->no_verify, N_("bypass pre-commit hook")),
>>
>> I doubt we want this option to squat on '-n'; besides, it is already
>> taken by a more often used "--no-commit".
>>
>> I thought that we added sanity checker for the options[] array to parse-options
>> API.  I wonder why it did not kick in...
> 
> ... because we didn't, not quite.
> 
> Perhaps like this?
> 
> -- >8 --
> It is easy to overlook an already assigned single-letter option name
> and try to use it for a new one.  Help the developer to catch it
> before such a mistake escapes the lab.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/parse-options.c b/parse-options.c
> index e7dafa8..b7925c5 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -347,12 +347,17 @@ static void check_typos(const char *arg, const struct option *options)
>   static void parse_options_check(const struct option *opts)
>   {
>   	int err = 0;
> +	char short_opts[128];
> +
> +	memset(short_opts, '\0', sizeof(short_opts));
>   
>   	for (; opts->type != OPTION_END; opts++) {
>   		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
>   		    (opts->flags & PARSE_OPT_OPTARG))
>   			err |= optbug(opts, "uses incompatible flags "
>   					"LASTARG_DEFAULT and OPTARG");
> +		if (opts->short_name && short_opts[opts->short_name]++)
> +			err |= optbug(opts, "short name already used");
>   		if (opts->flags & PARSE_OPT_NODASH &&
>   		    ((opts->flags & PARSE_OPT_OPTARG) ||
>   		     !(opts->flags & PARSE_OPT_NOARG) ||
> 

Compact and useful, I like it.

You might want to squash in something like this, though.  Without it
t1502 fails because -b is defined twice there.

---
 t/t1502-rev-parse-parseopt.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 922423e..ebe7c3b 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -19,7 +19,7 @@ sed -e 's/^|//' >expect <<\END_EXPECT
 |    -d, --data[=...]      short and long option with an optional argument
 |
 |Argument hints
-|    -b <arg>              short option required argument
+|    -B <arg>              short option required argument
 |    --bar2 <arg>          long option required argument
 |    -e, --fuz <with-space>
 |                          short and long option required argument
@@ -51,7 +51,7 @@ sed -e 's/^|//' >optionspec <<\EOF
 |d,data?   short and long option with an optional argument
 |
 | Argument hints
-|b=arg     short option required argument
+|B=arg     short option required argument
 |bar2=arg  long option required argument
 |e,fuz=with-space  short and long option required argument
 |s?some    short option optional argument
-- 
2.1.0
