From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] parse_date_basic(): let the system handle DST conversion
Date: Wed, 15 Apr 2015 13:23:51 -0400
Message-ID: <CAPig+cSC8RZJ-+uP=ZExVH2ZyexfQmLjzdjoBA7yuWkdYE4EGQ@mail.gmail.com>
References: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
	<xmqqzj6ayp3p.fsf@gitster.dls.corp.google.com>
	<20150415072223.GA1389@flurp.local>
	<xmqqk2xdmp0e.fsf@gitster.dls.corp.google.com>
	<xmqq618xmka9.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:23:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiR2b-00039C-U8
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbbDORXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 13:23:55 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35545 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188AbbDORXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 13:23:53 -0400
Received: by lbbuc2 with SMTP id uc2so39466623lbb.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Cj/27zFuy15ql3tfiXgUuPqwQbtbILo73lwIQPWPVI4=;
        b=OhVZQYmsjS6FWRUvm4j+UWKnYlig/CvcV8laUmFFnLSBj3KtOx06vctLhRjHdngI1O
         Ydiuc9zWee7O6TTotg2WEMY1uP7ByTIGiqYjr6Wg6S5a9Z1xKd/XxZ5nRulKQmzPYvVy
         3K55BnhDUPrS7R81asNMVnzX8hpGszMvqwoYh2YJoRbuAsSOMlhWqThWL9T1I9y/S+6Q
         dFeENNQmk3k71p+Y990IP/CD2PyxiR5mpxQOwIj5zrbeJgH4d22VUnJaQgWwOT3LjrOU
         YX6N2PxONFGjhVLwgYbPxivaBOrkzluJYk7eQ5+CJeG4gAcA1cwwczz4u1kA1ZMRwmLO
         LTjA==
X-Received: by 10.112.57.197 with SMTP id k5mr25485979lbq.102.1429118631341;
 Wed, 15 Apr 2015 10:23:51 -0700 (PDT)
Received: by 10.114.25.193 with HTTP; Wed, 15 Apr 2015 10:23:51 -0700 (PDT)
In-Reply-To: <xmqq618xmka9.fsf_-_@gitster.dls.corp.google.com>
X-Google-Sender-Auth: itAS5M6rRwSEjORWMgZic579rlo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267222>

On Wed, Apr 15, 2015 at 12:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The function parses the input to compute the broken-down time in
> "struct tm", and the GMT timezone offset.  If the timezone offset
> does not exist in the input, the broken-down time is turned into the
> number of seconds since epoch both in the current timezone and in
> GMT and the offset is computed as their difference.
>
> However, we forgot to make sure tm.tm_isdst is set to -1 (i.e. let
> the system figure out if DST is in effect in the current timezone
> when turning the broken-down time to the number of seconds since
> epoch); it is done so at the beginning of the function, but a call
> to match_digit() in the function can lead to a call to gmtime_r() to
> clobber the field.

Thanks for composing the commit message and turning this into a proper patch.

> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Diagnosed-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

For what it's worth:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> ---
>  date.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/date.c b/date.c
> index 01fd73f..8ad6cef 100644
> --- a/date.c
> +++ b/date.c
> @@ -700,7 +700,11 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
>                 return -1;
>
>         if (*offset == -1) {
> -               time_t temp_time = mktime(&tm);
> +               time_t temp_time;
> +
> +               /* gmtime_r() in match_digit() may have clobbered it */
> +               tm.tm_isdst = -1;
> +               temp_time = mktime(&tm);
>                 if ((time_t)*timestamp > temp_time) {
>                         *offset = ((time_t)*timestamp - temp_time) / 60;
>                 } else {
> --
> 2.4.0-rc2-165-g862640d
