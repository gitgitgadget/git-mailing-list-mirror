From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] parse-options: detect attempt to add a duplicate short
 option name
Date: Wed, 03 Sep 2014 23:46:20 +0200
Message-ID: <54078C2C.5020503@web.de>
References: <1409753034-9459-1-git-send-email-johan@herland.net>	<1409753034-9459-3-git-send-email-johan@herland.net>	<xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>	<xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>	<54077A3E.20703@web.de> <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPIO5-00029b-7d
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 23:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbaICVqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2014 17:46:35 -0400
Received: from mout.web.de ([212.227.17.12]:55234 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932693AbaICVqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 17:46:35 -0400
Received: from [192.168.178.27] ([79.253.169.244]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MHXxg-1XQNmX2HaW-003Osl; Wed, 03 Sep 2014 23:46:25
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:/AWtvZMTZ0iJ3PTZzTfprj2Yc3fg5Az6/190FC7QhoKqlpxzbpz
 D2UG7y7lJxLUBaAzrh6HHl2tokc0gcdzaYi/y2zFjDWxpiekGEUyuqc8SV1dYbYy9bJ/28W
 B2d7Bs+tDCzRqFPeLCjYgKm94HJvP3VmMReH85MzM7I0bqnWAclL9CQq/2kXNcg/e/b+acW
 nxNbsNujgyoUazuDly15A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256420>

Am 03.09.2014 um 23:05 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Compact and useful, I like it.
>>
>> You might want to squash in something like this, though.  Without it
>> t1502 fails because -b is defined twice there.
>
> Thanks.  I like it to see that the check automatically propagates
> even to scripts ;-)
>
> It bugged me enough that we didn't identify which short option
> letter we were complaining about

The old code did report the short option.  E.g. for t1502 it said:

	error: BUG: switch 'b' short name already used

You can leave that to optbug(), no need for the strbuf.

> and that opts->short_name is
> defined as an "int", which may cause us to overstep char[128],
> I ended up doing it this way instead, though.   It no longer is so
> compact, even though it may still have the same usefulness.

A range check is an additional feature (increased usefulness).  I guess=
=20
using invalid characters is not that common a mistake, though.

Space is allowed as a short option by the code; intentionally?

>
> We might want to tighten the type of the short_name member to
> unsigned char, but I didn't go that far yet, at least in this step.
>
> -- >8 --
> Subject: [PATCH] parse-options: detect attempt to add a duplicate sho=
rt option name
>
> It is easy to overlook an already assigned single-letter option name
> and try to use it for a new one.  Help the developer to catch it
> before such a mistake escapes the lab.
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   parse-options.c               | 15 +++++++++++++++
>   t/t1502-rev-parse-parseopt.sh |  4 ++--
>   2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index b536896..70227e9 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -345,12 +345,27 @@ static void check_typos(const char *arg, const =
struct option *options)
>   static void parse_options_check(const struct option *opts)
>   {
>   	int err =3D 0;
> +	char short_opts[128];
> +
> +	memset(short_opts, '\0', sizeof(short_opts));
>
>   	for (; opts->type !=3D OPTION_END; opts++) {
>   		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
>   		    (opts->flags & PARSE_OPT_OPTARG))
>   			err |=3D optbug(opts, "uses incompatible flags "
>   					"LASTARG_DEFAULT and OPTARG");
> +		if (opts->short_name) {
> +			struct strbuf errmsg =3D STRBUF_INIT;
> +			if (opts->short_name < ' ' || 0x7F <=3D opts->short_name)
> +				strbuf_addf(&errmsg, "invalid short name (0x%02x)",
> +					    opts->short_name);
> +			else if (short_opts[opts->short_name]++)
> +				strbuf_addf(&errmsg, "short name %c already used",
> +					    opts->short_name);
> +			if (errmsg.len)
> +				err |=3D optbug(opts, errmsg.buf);
> +			strbuf_release(&errmsg);
> +		}
>   		if (opts->flags & PARSE_OPT_NODASH &&
>   		    ((opts->flags & PARSE_OPT_OPTARG) ||
>   		     !(opts->flags & PARSE_OPT_NOARG) ||
> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseo=
pt.sh
> index 922423e..ebe7c3b 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -19,7 +19,7 @@ sed -e 's/^|//' >expect <<\END_EXPECT
>   |    -d, --data[=3D...]      short and long option with an optional=
 argument
>   |
>   |Argument hints
> -|    -b <arg>              short option required argument
> +|    -B <arg>              short option required argument
>   |    --bar2 <arg>          long option required argument
>   |    -e, --fuz <with-space>
>   |                          short and long option required argument
> @@ -51,7 +51,7 @@ sed -e 's/^|//' >optionspec <<\EOF
>   |d,data?   short and long option with an optional argument
>   |
>   | Argument hints
> -|b=3Darg     short option required argument
> +|B=3Darg     short option required argument
>   |bar2=3Darg  long option required argument
>   |e,fuz=3Dwith-space  short and long option required argument
>   |s?some    short option optional argument
>
