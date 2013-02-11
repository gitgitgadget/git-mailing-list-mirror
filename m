From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 18:04:32 +0100
Message-ID: <511924A0.8030704@web.de>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com> <51191C33.8070402@web.de> <CABPQNSYXk5_VdGP9QQttZKpcBnmohmNb+AOH=bMkOrXjbq1ZmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 11 18:05:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4woM-00085U-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757628Ab3BKREf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2013 12:04:35 -0500
Received: from mout.web.de ([212.227.17.11]:57375 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756931Ab3BKREf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:04:35 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LnjRP-1UZ5AM0aGl-00hthZ; Mon, 11 Feb 2013 18:04:33
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CABPQNSYXk5_VdGP9QQttZKpcBnmohmNb+AOH=bMkOrXjbq1ZmQ@mail.gmail.com>
X-Provags-ID: V02:K0:QPejMeskiatPJoTAqq6NExOo0oko8FxMlmqGofiW3YL
 EMOBdwH0ebooLvdQgDX2XH66PQwu5UI5q3q/TEgkU9xmZXV21m
 T+g7UJejpJwNJ93SuiBbGY2h44u/oahm3JZChhpg+PsY9ZSKaJ
 NbHmlPlKraJA1zqNAAuMYvG+evkHVJ6vm+oU2RdnJcYfOXMJnS
 bv3eHkr2dMbB55qgXZZZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216054>

On 11.02.13 17:36, Erik Faye-Lund wrote:
> On Mon, Feb 11, 2013 at 5:28 PM, Torsten B=F6gershausen <tboegi@web.d=
e> wrote:
>> On 11.02.13 14:34, Erik Faye-Lund wrote:
>>> Even though parse-options doesn't support UTF-8 switches (which
>>> makes sense; non-ascii switches would be difficult to enter on
>>> some keyboard layouts), it can be useful to report incorrectly
>>> entered UTF-8 switches to make the output somewhat less ugly
>>> for those of us with keyboard layouts with UTF-8 characters on
>>> it.
>>>
>>> Make the reporting code grok UTF-8 in the option sequence, and
>>> write a variable-width output sequence.
>>>
>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>> ---
>>> As being both clumsy and Norwegian, I some times to enter the
>>> Norwegian bizarro-letters ('=E6', '=F8' and '=E5') instead of the
>>> correct ones when entering command-line options.
>>>
>>> However, since git only looks at one byte at the time for
>>> short-options, it ends up reporting a partial UTF-8 sequence
>>> in such cases, leading to corruption of the output.
>>>
>>> The "real fix" would probably be to add proper multi-byte
>>> support to the short-option parser, but this serves little
>>> purpose in Git; we don't internationalize the command-line
>>> switches.
>>>
>>> So perhaps this is a suitable band-aid instead?
>>>
>>>  parse-options.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/parse-options.c b/parse-options.c
>>> index 67e98a6..20dc742 100644
>>> --- a/parse-options.c
>>> +++ b/parse-options.c
>>> @@ -3,6 +3,7 @@
>>>  #include "cache.h"
>>>  #include "commit.h"
>>>  #include "color.h"
>>> +#include "utf8.h"
>>>
>>>  static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>>>                              const char * const *usagestr,
>>> @@ -462,7 +463,9 @@ int parse_options(int argc, const char **argv, =
const char *prefix,
>>>               if (ctx.argv[0][1] =3D=3D '-') {
>>>                       error("unknown option `%s'", ctx.argv[0] + 2)=
;
>>>               } else {
>>> -                     error("unknown switch `%c'", *ctx.opt);
>>> +                     const char *next =3D ctx.opt;
>>> +                     utf8_width(&next, NULL);
>>> +                     error("unknown switch `%.*s'", (int)(next - c=
tx.opt), ctx.opt);
>>>               }
>>>               usage_with_options(usagestr, options);
>>>       }
>>>
>> Would the following do the trick?
>>
>> diff --git a/parse-options.c b/parse-options.c
>> index c1c66bd..f800552 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -471,7 +471,7 @@ int parse_options(int argc, const char **argv, c=
onst char *prefix,
>>                 if (ctx.argv[0][1] =3D=3D '-') {
>>                         error("unknown option `%s'", ctx.argv[0] + 2=
);
>>                 } else {
>> -                       error("unknown switch `%c'", *ctx.opt);
>> +                       error("unknown switch `%s'", ctx.opt);
>>                 }
>>
>>
> Nope; that would print the rest of the option-string, in cases of "gi=
t
> <command> -abcd".
Ok, may be pick_one_utf8_char() is a better choice than simply assuming=
 ASCII.

We can make a guess, if it is utf-8, we use it. If not, assume ASCII.
Just thinking loud (the "if" could be written shorter using the "?" ope=
rator)

                } else {
                       const char *start =3D ctx.opt;
                       unsigned c =3D pick_one_utf8_char(&start, NULL);
                       if (!c)
                         c =3D  *ctx.opt;
                       error("unknown switch `%c'", c);
                }

=20
