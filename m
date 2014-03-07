From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] show_ident_date: fix always-false conditional
Date: Fri, 7 Mar 2014 13:12:58 -0500
Message-ID: <CAPig+cSgW_B9YEYA3GCD=0NRYS=+QG_v-dU8zp5Jt6XqAysCKA@mail.gmail.com>
References: <1394156124-3953-1-git-send-email-sunshine@sunshineco.com>
	<20140307171501.GA23587@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 07 19:13:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLzGa-0007a5-ED
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 19:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaCGSM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 13:12:59 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:56561 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbaCGSM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 13:12:59 -0500
Received: by mail-yk0-f176.google.com with SMTP id 19so11607782ykq.7
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 10:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MRhj5xbn6TuSVB3SY1t2yvBHmP5Xm14gZ5bSiBF6cfA=;
        b=YjhTYxbx5X8UdpPsBEqFDFtCPnp5tIFXT0DEtshqvPZ4813QgI98R2D+hSkrg9PGQ9
         mdTBQmlNElQX8QW1T+131rSvrnGoljuug0Hf0D7kaWZD6eUfIpXBgJzqnMsO7Q16c1n+
         VUKd7YbZjkzBkqNQPg+B34uSSiePJC+FJ1qeKUBERR0WFS578QBrbdb50k4x5R7gHu6p
         BR71rWIOI6u+C/iGm07YQxzwYDXd7I9y0sWalHru/6QKDZLyQzTmjvc3H/kvJwBmMEY+
         kwQQMdobL9B5ub4pUrIWcDsQfR+kjags4/rcIIq416a/9ScHvH6WEb4GzYyN6rEFYDT3
         XEOA==
X-Received: by 10.236.143.148 with SMTP id l20mr24648842yhj.102.1394215978394;
 Fri, 07 Mar 2014 10:12:58 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Fri, 7 Mar 2014 10:12:58 -0800 (PST)
In-Reply-To: <20140307171501.GA23587@sigill.intra.peff.net>
X-Google-Sender-Auth: KEBE9e96Z8OXIMNgOi1L56B9IQM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243620>

On Fri, Mar 7, 2014 at 12:15 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 06, 2014 at 08:35:24PM -0500, Eric Sunshine wrote:
>
>> 1dca155fe3fa (log: handle integer overflow in timestamps, 2014-02-24)
>> assigns the result of strtol() to an 'int' and then checks it against
>> LONG_MIN and LONG_MAX, indicating underflow or overflow, even though
>> 'int' may not be large enough to represent those values.
>>
>> On Mac, the compiler complains:
>>
>>     warning: comparison of constant 9223372036854775807 with
>>       expression of type 'int' is always false
>>       [-Wtautological-constant-out-of-range-compare]
>>       if (<<tz == LONG_MAX>> || tz == LONG_MIN)
>>
>> Similarly for the LONG_MIN case. Fix this.
>
> Yeah, this is definitely a potential bug. When I added the overflow
> check, I blindly assumed that the existing code was at least using a
> sufficiently large type to store the result of strtol, but it's not.
>
> I don't think your fix catches all overflow, though:
>
>> +     else if (ident->tz_begin && ident->tz_end) {
>> +             errno = 0;
>> +             tz = strtol(ident->tz_begin, NULL, 10);
>> +             if (errno)
>
> Errno will trigger if we overflowed a "long", but then we assign the
> result into an int, possibly truncating the result.
>
>> Alternately, the result of strtol() could be assigned temporarily to a
>> 'long', compared against LONG_MIN and LONG_MAX, and then assigned to the
>> 'int' "tz" variable.
>
> That catches overflow from strtol, but we'd then truncate when we pass
> it as an int to show_date.
>
> I think we want this instead:

Makes sense.

Acked-by: Eric Sunshine <sunshine@sunshineco.com>

> -- >8 --
> Subject: show_ident_date: fix tz range check
>
> Commit 1dca155fe3fa (log: handle integer overflow in
> timestamps, 2014-02-24) tried to catch integer overflow
> coming from strtol() on the timezone field by comparing against
> LONG_MIN/LONG_MAX. However, the intermediate "tz" variable
> is an "int", which means it can never be LONG_MAX on LP64
> systems; we would truncate the output from strtol before the
> comparison.
>
> Clang's -Wtautological-constant-out-of-range-compare notices
> this and rightly complains.
>
> Let's instead store the result of strtol in a long, and then
> compare it against INT_MIN/INT_MAX. This will catch overflow
> from strtol, and also overflow when we pass the result as an
> int to show_date.
>
> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pretty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 3b811ed..6e266dd 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -397,7 +397,7 @@ static const char *show_ident_date(const struct ident_split *ident,
>                                    enum date_mode mode)
>  {
>         unsigned long date = 0;
> -       int tz = 0;
> +       long tz = 0;
>
>         if (ident->date_begin && ident->date_end)
>                 date = strtoul(ident->date_begin, NULL, 10);
> @@ -406,7 +406,7 @@ static const char *show_ident_date(const struct ident_split *ident,
>         else {
>                 if (ident->tz_begin && ident->tz_end)
>                         tz = strtol(ident->tz_begin, NULL, 10);
> -               if (tz == LONG_MAX || tz == LONG_MIN)
> +               if (tz >= INT_MAX || tz <= INT_MIN)
>                         tz = 0;
>         }
>         return show_date(date, tz, mode);
> --
> 1.8.5.2.500.g8060133
>
