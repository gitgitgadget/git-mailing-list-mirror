From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] describe: support the syntax "--abbrev=+"
Date: Sun, 14 Sep 2014 04:56:38 -0400
Message-ID: <CAPig+cQJS+fFTLPXBa1a0-TH-FSAJaHX4w49CsxnjRKgsAsiSw@mail.gmail.com>
References: <1410532004-22769-1-git-send-email-jonh.wendell@gmail.com>
	<1410532004-22769-2-git-send-email-jonh.wendell@gmail.com>
	<20140914081847.GA20526@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonh Wendell <jonh.wendell@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 14 10:56:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT5bw-0000Mi-Qj
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbaINI4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:56:41 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35215 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbaINI4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:56:39 -0400
Received: by mail-yk0-f177.google.com with SMTP id 79so1419680ykr.22
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=N76ruEzTj4CQecHVI6OTmNjNy4Iodr7PAw88YNLClhA=;
        b=bDnhW4dsLZEPukKkm+o50Vecs0jGh3qQthCY5JgGoADhLyUKwnuKvp3+CVbvV88wcB
         bgyjxIaas1fH4rUClMKK4SShTinf9D//HjXGVQXiVK8445y0JabJNYOW5LWtP6bh2rz9
         kdizm0tKGHen0/i62a+ui/BqcKoBnn/S7nHntY3/RpKGV9hm2IzDRCcxUC+iKbO5gZhW
         MjSJVHOVy/h9LqJICQuruvFtqL6DTsx418xJhujYDBlYwCiaOOPYPjAS/2xV64CCyd0J
         tIqJWlfJxS2i4ImrvDo2FhbPdFwuBz/HvDgVNxwoVTaVSw5RilKuTUgig0YQ1IiFOmE5
         1S4w==
X-Received: by 10.236.220.136 with SMTP id o8mr24765088yhp.29.1410684998980;
 Sun, 14 Sep 2014 01:56:38 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Sun, 14 Sep 2014 01:56:38 -0700 (PDT)
In-Reply-To: <20140914081847.GA20526@peff.net>
X-Google-Sender-Auth: G0MfqnCHwfjxdPLVOBs10gkM3qY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257011>

On Sun, Sep 14, 2014 at 4:18 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 12, 2014 at 11:26:43AM -0300, Jonh Wendell wrote:
>
>> It will print just a "+" sign appended to the found tag, if there
>> are commits between the tag and the supplied commit.
>>
>> It's useful when you just need a simple output to know if the
>> supplied commit is an exact match or not.
>
> Seems like a reasonable extension of the "--abbrev=0" behavior.

My reaction is opposite: Such overloading of --abbrev= feels abusive,
non-obvious, and is inconsistent with --abbrev accepted by other
commands.

It's also potentially ambiguous. If the tag name ends with a '+' and
there are no commits atop it, then the client can be fooled into
thinking there are. Being able to configure the suffix, rather than
hardcoding '+', might help, but seems ugly.

The justification in the cover letter is that it provides a way to
check if there are commits atop the latest tag. Within a script, it
might be sufficient merely to compare the output of 'git describe' and
'git describe --abbrev=0'. If they differ, then there are commits atop
the latest tag.

Thus, this feature seems somewhat misguided, but perhaps I'm missing
something obvious.

>>  builtin/describe.c | 26 +++++++++++++++++++++-----
>>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> You can probably just squash the related documentation in with this
> patch. Also, maybe some tests in t6120? It doesn't look like we test
> --abbrev=0, either; if you are feeling especially charitable, it might
> be good to add some tests for it, too.
>
>> @@ -378,8 +379,12 @@ static void describe(const char *arg, int last_one)
>>       }
>>
>>       display_name(all_matches[0].name);
>> -     if (abbrev)
>> -             show_suffix(all_matches[0].depth, cmit->object.sha1);
>> +     if (abbrev) {
>> +             if (simple_abbrev)
>> +                     printf("+");
>> +             else
>> +                     show_suffix(all_matches[0].depth, cmit->object.sha1);
>> +     }
>
> This covers the case when we do have a commit to show. The exact-match
> case is handled elsewhere, and I wondered what would happen if you
> passed "--long", but:
>
>> +     if (longformat && (abbrev == 0 || simple_abbrev))
>> +             die(_("--long is incompatible with --abbrev=+ or --abbrev=0"));
>
> You cover that here. Good.
>
>> +static int parse_opt_abbrev_for_describe_cb(const struct option *opt, const char *arg, int unset)
>> +{
>> +     if (arg && !strncmp(arg, "+", 1)) {
>
> Why strncmp here? If I pass "--abbrev=+10", shouldn't that be an error?
>
>> +             simple_abbrev = 1;
>> +             return 0;
>> +     }
>> +
>> +     return parse_opt_abbrev_cb(opt, arg, unset);
>> +}
>
> What happens if you pass the option multiple times? I'd expect later
> ones to override earlier ones. For "--abbrev=0 --abbrev=10" this just
> works, because they both store the value in the abbrev variable. But you
> store simple_abbrev as a separate variable.
>
> What do these do?
>
>   1. --abbrev=10 --abbrev=+
>
>   2. --abbrev=+ --abbrev=10
>
>   3. --abbrev=0 --abbrev=+
>
> The first one will respect simple_abbrev, since it avoids calling
> show_suffix at all. Good. The second one will do the same. We probably
> need to reset simple_abbrev to 0 whenever we see another --abbrev. The
> third one will not respect simple_abbrev, because we never enter the "if
> (abbrev)" conditional. We probably need to reset "abbrev" to something
> non-zero when we set simple_abbrev.
>
> I.e.:
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 3a5c052..532161e 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -397,9 +397,11 @@ static int parse_opt_abbrev_for_describe_cb(const struct option *opt, const char
>  {
>         if (arg && !strncmp(arg, "+", 1)) {
>                 simple_abbrev = 1;
> +               abbrev = 1; /* doesn't matter as long as it is non-zero */
>                 return 0;
>         }
>
> +       simple_abbrev = 0;
>         return parse_opt_abbrev_cb(opt, arg, unset);
>  }
>
>
> Another alternative would be to stuff the simple_abbrev flag into
> an unused value of "abbrev" (say, -2), but that is probably a little
> less obvious than just resetting them together as above.
>
> -Peff
