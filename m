From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 02/14] pull: pass verbosity, --progress flags to fetch and merge
Date: Thu, 21 May 2015 17:48:46 +0800
Message-ID: <CACRoPnRVcjcegRU8J6a=X6uN=b7fhJyD9=js4LqJ7ORX6gT=jg@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-3-git-send-email-pyokagan@gmail.com>
	<4213f4fa8fb52fb020c2e9b5d78fbf7b@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 21 11:48:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvN5y-0007hl-G2
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 11:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbbEUJsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 05:48:50 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35144 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbbEUJss (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 05:48:48 -0400
Received: by lbbuc2 with SMTP id uc2so13980894lbb.2
        for <git@vger.kernel.org>; Thu, 21 May 2015 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HQbCmZv22m/Td1lPp9q19wh43cBWgvewGO70k2Z+Ezs=;
        b=TbWZbrGIOz86c8DaCIoCAJDA9GcajObyj6pg5Q4q76eJdSuucmc2kReqglzpX5WKql
         oFnbciCS8NcvfGythVGxRAl+leIFl92/n0NpoD6qhP12Xf+3338uNqSqguGWdciNdGbr
         Nwy+fSP4aQOJX4ullCMZDe1a5B+zed7B1Vh4iMNv5ymGFn74TrcqPr1ecCwKTp5E64Uw
         d3QC1NFGCI7A7LsrMa8MhZg4WAOC49G+fpuyVuWNaYiM/1LXFV995PZCFTIOYIKURHk3
         m1m9WeLk/xr1yVnZmx2xVQdeLyv6Mj0aOCSr8Rt1y662UlG+iKvgm2A3kZsFLXbyZuaW
         PaZw==
X-Received: by 10.152.4.72 with SMTP id i8mr1538617lai.32.1432201726555; Thu,
 21 May 2015 02:48:46 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 21 May 2015 02:48:46 -0700 (PDT)
In-Reply-To: <4213f4fa8fb52fb020c2e9b5d78fbf7b@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269574>

Hi,

On Tue, May 19, 2015 at 1:41 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On 2015-05-18 17:05, Paul Tan wrote:
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 0b771b9..a4d9c92 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -11,16 +11,64 @@
>>  #include "argv-array.h"
>>  #include "run-command.h"
>>
>> +/**
>> + * Given an option opt, where opt->value points to a char* and opt->defval is a
>> + * string, sets opt->value to the evaluation of "--$defval=$arg". If `arg` is
>> + * NULL, then opt->value is set to "--$defval". If unset is true, then
>> + * opt->value is set to "--no-$defval".
>> + */
>> +static int parse_opt_passthru(const struct option *opt, const char
>> *arg, int unset)
>
> How about adding this to parse-options-cb.c in a separate patch? I guess the description could say something like:

Yeah, I was also thinking if the callback could be generalized as well.

Specifically, I wonder if we should re-construct just the
last-provided option (the current solution), or all the options (e.g.
something like OPT_STRING_LIST). I'm currently working on the rewrite
for git-am.sh as well, and it turns out it makes heavy use of the
latter, so we probably should support both.

> /**
>  * Given an option opt, recreate the command-line option, as strbuf. This is useful
>  * when a command needs to parse a command-line option in order to pass it to yet
>  * another command. This callback can be used in conjunction with the
>  * PARSE_OPT_(OPTARG|NOARG|NONEG) options, but not with PARSE_OPT_LASTARG_DEFAULT
>  * because it expects `defval` to be the name of the command-line option to
>  * reconstruct.
>  *
>  * The result will be stored in opt->value, which is expected to be a pointer to an
>  * strbuf.
>  */
>

Heh, this docstring reads much better than mine.

> Implied by my suggested description, I also propose to put the re-recreated command-line option into a strbuf instead of a char *, to make memory management easier (read: avoid memory leaks).

Unfortunately, the usage of strbuf means that we lose the ability to
know if an option was not provided at all (the value is NULL). This is
important as some of these options are used to override the default
configured behavior.

> You might also want to verify that arg is `NULL` when `unset != 0`. Something like this:

Hmm, would there be a situation where arg is NULL when `unset != 0`?
At first glance in the source code, it won't unless
PARSE_OPT_LASTARG_DEFAULT is set, I guess. Anyway, there's no harm in
being careful, though I think it's more likely that an invalid pointer
is passed in through "arg", which we can't detect :-(.

> int parse_opt_passthru(const struct option *opt, const char *arg, int unset)
> {
>         struct strbuf *buf = opt->value;
>
>         assert(opt->defval);
>         strbuf_reset(buf);
>         if (unset) {
>                 assert(!arg);
>                 strbuf_addf(buf, "--no-%s", opt->defval);
>         }
>         else {
>                 strbuf_addf(buf, "--%s", opt->defval);
>                 if (arg)
>                         strbuf_addf(buf, "=%s", arg);
>         }
>
>         return 0;
> }
>
>>  static struct option pull_options[] = {
>> +     /* Shared options */
>> +     OPT__VERBOSITY(&opt_verbosity),
>> +     { OPTION_CALLBACK, 0, "progress", &opt_progress, NULL,
>> +       N_("force progress reporting"),
>> +       PARSE_OPT_NOARG, parse_opt_passthru},
>
> I *think* there is a '(intptr_t) "progress"' missing...

Ugh. I think this shows that relying on "defval" is too error-prone.
Anyway, it is only required for the options -n (which maps to
--no-stat), and --summary (which maps to --stat), so we should
probably make it such that if defval is not provided, we fallback to
using long_name or short_name.

>>  /**
>> + * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
>> + */
>> +static void argv_push_verbosity(struct argv_array *arr)
>> +{
>> +     int verbosity;
>> +
>> +     for (verbosity = opt_verbosity; verbosity > 0; verbosity--)
>> +             argv_array_push(arr, "-v");
>> +
>> +     for (verbosity = opt_verbosity; verbosity < 0; verbosity++)
>> +             argv_array_push(arr, "-q");
>> +}
>
> Hmm... I guess this is *really* nit-picky, but I'd rather use "i" instead of "verbosity" because the second loop is about quietness instead of verbosity ;-)

Well, my thinking was that a negative verbosity *is* quietness ;-).

Thanks,
Paul
