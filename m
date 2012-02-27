From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] parse-options: remove PARSE_OPT_NEGHELP
Date: Mon, 27 Feb 2012 23:26:16 +0100
Message-ID: <4F4C0308.2050804@lsrfire.ath.cx>
References: <4F49317A.3080809@lsrfire.ath.cx> <4F49336C.3000303@lsrfire.ath.cx> <20120227182504.GA1600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 27 23:26:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S291c-0002Uw-GF
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab2B0W01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 17:26:27 -0500
Received: from india601.server4you.de ([85.25.151.105]:38218 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab2B0W00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 17:26:26 -0500
Received: from [192.168.2.105] (p579BEC29.dip.t-dialin.net [87.155.236.41])
	by india601.server4you.de (Postfix) with ESMTPSA id DBAB82F804A;
	Mon, 27 Feb 2012 23:26:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120227182504.GA1600@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191685>

Am 27.02.2012 19:25, schrieb Jeff King:
> On Sat, Feb 25, 2012 at 08:15:56PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index e4ea900..b151467 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -671,7 +671,7 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
>>   	struct string_list path_list =3D STRING_LIST_INIT_NODUP;
>>   	int i;
>>   	int dummy;
>> -	int use_index =3D 1;
>> +	int no_index =3D 0;
>>   	enum {
>>   		pattern_type_unspecified =3D 0,
>>   		pattern_type_bre,
>> @@ -684,9 +684,8 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
>>   	struct option options[] =3D {
>>   		OPT_BOOLEAN(0, "cached",&cached,
>>   			"search in index instead of in the work tree"),
>> -		{ OPTION_BOOLEAN, 0, "index",&use_index, NULL,
>> -			"finds in contents not managed by git",
>> -			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP },
>> +		OPT_BOOL(0, "no-index",&no_index,
>> +			 "finds in contents not managed by git"),
>>   		OPT_BOOLEAN(0, "untracked",&untracked,
>>   			"search in both tracked and untracked files"),
>>   		OPT_SET_INT(0, "exclude-standard",&opt_exclude,
>> @@ -851,7 +850,7 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
>>   		break; /* nothing */
>>   	}
>>
>> -	if (use_index&&  !startup_info->have_repository)
>> +	if (!no_index&&  !startup_info->have_repository)

[Unrelated: The whitespace in the two lines above and before ampersands=
=20
in general was damaged by Thunderbird.  First time I noticed.]

> Hmm. We usually try to avoid these sorts of double negations in the
> code, as they can often make the logic hard to read. In this case, it=
 is
> not _so_ bad, because out of the 4 uses of use_index/no_index, only o=
ne
> is "!no_index", and it is in a relatively simple conditional.

The variable could be named "unmanaged", "external" or similar instead=20
of "no_index".  The latter just matches the option name and thus was th=
e=20
obvious first choice to me.

> But I do feel like the original was slightly easier to read, and that
> getting rid of NEGHELP is restricting how the developer can express t=
he
> options.
>
> I think your original motivation was that NEGHELP lead to confusion
> where the name of the option does not match its description. Would it=
 be
> better to simply be explicit that an option is a reversed boolean (i.=
e.,
> what the user specifies on the command line and what is in the code a=
re
> naturally opposites). Like:
>
>   OPT_REVERSE_BOOL(0, "no-index",&use_index,
>               "finds in contents not managed by git"),

It's better than NEGHELP, but I find your use of two negations (REVERSE=
=20
and "no-") confusing.  We don't need to invent new OPT_ types for this,=
=20
by the way, we can just do this:

	OPT_NEGBIT(0, "no-index", &use_index,
	           "finds in contents not managed by git", 1),

It certainly shortens the patch.

> Using NEGHELP, the "reverse" is between the option name and the
> description, which is very subtle. Here it is between the option name
> and the variable, which is hopefully a little more explicit (especial=
ly
> with the big REVERSE in the macro name).

We have precedence for OPT_NEGBIT in grep, although the double negation=
s=20
for -h and --full-name are required because both turn off bits that=20
other options turn on, while for --no-index it wouldn't be strictly=20
needed, as there is no option that overrules it except --index.

I don't care too much either way, though.  The changes from patch 2 (th=
e=20
no no-no one) are not restricted to OPT_BOOL.

> I dunno. Given that there are only two uses of NEGHELP, and that they
> don't come out too badly, I don't care _too_ much. But I have seen so=
me
> really tortured logic with double-negations like this, and I'm concer=
ned
> that a few months down the road somebody is going to want NEGHELP (or
> something similar) in a case where it actually does really impact
> readability.

I'm curious to see a case that can be solved better using NEGHELP, but=20
we can always add it back if we find such a beast.  I'd much rather see=
=20
it go until then because of it's non-obvious semantics.

Ren=C3=A9
