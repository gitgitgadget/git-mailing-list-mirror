From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 17:36:52 +0100
Message-ID: <CABPQNSYXk5_VdGP9QQttZKpcBnmohmNb+AOH=bMkOrXjbq1ZmQ@mail.gmail.com>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com> <51191C33.8070402@web.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wOI-0003oc-C0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758083Ab3BKQhf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2013 11:37:35 -0500
Received: from mail-ia0-f171.google.com ([209.85.210.171]:56326 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab3BKQhd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2013 11:37:33 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so6595468iaz.2
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 08:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=3+26rzKXwXpS0w/5Y26jEbCqaBxTIOydqD+mZl1uiTE=;
        b=ta9/GM7ryAOkSyITvg1Hav0p6QOOnGDvBCURyJJysZOVIONWA0FYbT8WNMzd1eVnJb
         D1vzZ/NeV5d2+/vsgp9RmRszA8kBwBn5t2jTO/AokynuQeJmw2y6b4hhduGbLcDVUaXE
         kA/l38k/H2fElQy0Wr09SJG9I6OvBdJ9ar+7vV2fIojfItRM+on4Z9nRbFfHWqVzWyqT
         wJDpO5G9TQkpI1j7pSgPGw8UltEq34zUKFscfFntV0b2Xiw9SmNq/S/0MlLsUKPDi0pO
         OrQv7EfLEgOlwPBZW53Ny0HBdiWlyEaK6j/wX+ww5KUXgKpS4ZiqLXP7Co66MWFqRBKb
         ecPw==
X-Received: by 10.50.178.106 with SMTP id cx10mr12741901igc.53.1360600653011;
 Mon, 11 Feb 2013 08:37:33 -0800 (PST)
Received: by 10.64.164.139 with HTTP; Mon, 11 Feb 2013 08:36:52 -0800 (PST)
In-Reply-To: <51191C33.8070402@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216049>

On Mon, Feb 11, 2013 at 5:28 PM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:
> On 11.02.13 14:34, Erik Faye-Lund wrote:
>> Even though parse-options doesn't support UTF-8 switches (which
>> makes sense; non-ascii switches would be difficult to enter on
>> some keyboard layouts), it can be useful to report incorrectly
>> entered UTF-8 switches to make the output somewhat less ugly
>> for those of us with keyboard layouts with UTF-8 characters on
>> it.
>>
>> Make the reporting code grok UTF-8 in the option sequence, and
>> write a variable-width output sequence.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>> As being both clumsy and Norwegian, I some times to enter the
>> Norwegian bizarro-letters ('=E6', '=F8' and '=E5') instead of the
>> correct ones when entering command-line options.
>>
>> However, since git only looks at one byte at the time for
>> short-options, it ends up reporting a partial UTF-8 sequence
>> in such cases, leading to corruption of the output.
>>
>> The "real fix" would probably be to add proper multi-byte
>> support to the short-option parser, but this serves little
>> purpose in Git; we don't internationalize the command-line
>> switches.
>>
>> So perhaps this is a suitable band-aid instead?
>>
>>  parse-options.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/parse-options.c b/parse-options.c
>> index 67e98a6..20dc742 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -3,6 +3,7 @@
>>  #include "cache.h"
>>  #include "commit.h"
>>  #include "color.h"
>> +#include "utf8.h"
>>
>>  static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>>                              const char * const *usagestr,
>> @@ -462,7 +463,9 @@ int parse_options(int argc, const char **argv, c=
onst char *prefix,
>>               if (ctx.argv[0][1] =3D=3D '-') {
>>                       error("unknown option `%s'", ctx.argv[0] + 2);
>>               } else {
>> -                     error("unknown switch `%c'", *ctx.opt);
>> +                     const char *next =3D ctx.opt;
>> +                     utf8_width(&next, NULL);
>> +                     error("unknown switch `%.*s'", (int)(next - ct=
x.opt), ctx.opt);
>>               }
>>               usage_with_options(usagestr, options);
>>       }
>>
> Would the following do the trick?
>
> diff --git a/parse-options.c b/parse-options.c
> index c1c66bd..f800552 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -471,7 +471,7 @@ int parse_options(int argc, const char **argv, co=
nst char *prefix,
>                 if (ctx.argv[0][1] =3D=3D '-') {
>                         error("unknown option `%s'", ctx.argv[0] + 2)=
;
>                 } else {
> -                       error("unknown switch `%c'", *ctx.opt);
> +                       error("unknown switch `%s'", ctx.opt);
>                 }
>
>

Nope; that would print the rest of the option-string, in cases of "git
<command> -abcd".
