From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 14:57:17 +0100
Message-ID: <CABPQNSbYCrdSP5rWbfLX==u--bJpQo6A6sNE46a1RuU-fMDiWg@mail.gmail.com>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com> <vpqobfr9da7.fsf@grenoble-inp.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 14:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4ttx-0000dJ-AC
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 14:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402Ab3BKN6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 08:58:09 -0500
Received: from mail-ia0-f169.google.com ([209.85.210.169]:36911 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286Ab3BKN6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 08:58:08 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so6446144iaf.14
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=rNCYPeXsZux7Yy/ohJ36q3Y71ItyYI/qmMrJ8GthJ2w=;
        b=ylQXDGKNkT5DNGAZmdoqvk23ctpuHxPeQJD9N9Ul1lj48Zf7JcusFiJ+HKxhkEU2Mg
         A1T7va2KBaKerCyZ8tHpkWcOSJVySHxPBiKUSrCGbJRqBwQnRDi/HMVk1m/4LAxHJKjD
         JHxnC2TBhu3WnanPYIxhA7ZubXsE6bdP3uOcbuVA+6ehHXplIGH6TqZ2Tv8l+K7d6Xkf
         FMO96vOeT2JDMGyjLdGbsMGFL7xS7Ywy6TcI2z/mv+0uBJE2i9ZaGrLVvloh/hp8GErE
         ldl0Hd0Uhb7+Urbk6+UilQWkfbhHZ84FsWZFoVHTQCYxRCkN4YpBEAWXSZFR4xng3fMh
         PsVQ==
X-Received: by 10.50.88.228 with SMTP id bj4mr11730586igb.85.1360591077702;
 Mon, 11 Feb 2013 05:57:57 -0800 (PST)
Received: by 10.64.164.139 with HTTP; Mon, 11 Feb 2013 05:57:17 -0800 (PST)
In-Reply-To: <vpqobfr9da7.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216033>

On Mon, Feb 11, 2013 at 2:43 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
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
>> @@ -462,7 +463,9 @@ int parse_options(int argc, const char **argv, const char *prefix,
>>               if (ctx.argv[0][1] == '-') {
>>                       error("unknown option `%s'", ctx.argv[0] + 2);
>>               } else {
>> -                     error("unknown switch `%c'", *ctx.opt);
>> +                     const char *next = ctx.opt;
>> +                     utf8_width(&next, NULL);
>> +                     error("unknown switch `%.*s'", (int)(next - ctx.opt), ctx.opt);
>>               }
>>               usage_with_options(usagestr, options);
>>       }
>
> You should be careful with the case where the user has a non-UTF8
> environment, and entered a non-ascii sequence. I can see two cases:
>
> 1) The non-ascii sequence is valid UTF-8, then I guess your patch would
>    show two characters instead of one. Not really correct, but not really
>    serious either.

Hm. So we would end up trading some form of corruption for some other.
Not the biggest problem in the world, but perhaps there's a way of
fixing it?

I'm not entirely sure how to correctly know what encoding stdin is
supposed to be. On Windows, that's easy; it's UTF-16, we re-encode it
to UTF-8 on startup in Git for Windows. But on other platforms, I have
no clue.

But isn't UTF-8 constructed to be very unlikely to clash with existing
encodings? If so, I could add a case for non-ascii and non-UTF-8, that
simply writes the byte as a hex-tuple?

> 2) The non-ascii sequence is NOT valid UTF-8, then if I read correctly
>    (I didn't test) utf8_width would set next to NULL, and then you are
>    in big trouble.

Outch. Yeah, you are right; this is not good at all :)

But I guess the solution above should fix this as well, no?
