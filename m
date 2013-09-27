From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 27 Sep 2013 19:57:54 +0530
Message-ID: <CALkWK0nFjuPprR3kcrCwJFj6j43HVwVTjHo-=__TfSpbcX912g@mail.gmail.com>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
 <1380283828-25420-4-git-send-email-artagnon@gmail.com> <CABURp0rrMV2Em=acG80KqqByo1nurC5azU5UBWB0L5p3Zcra8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 16:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPZ28-00030x-1R
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 16:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab3I0O2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 10:28:37 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:45103 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab3I0O2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 10:28:35 -0400
Received: by mail-ie0-f170.google.com with SMTP id x13so4193525ief.1
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ale4s0P9EFml3OB98ktWCwQWqYF3+nGzCMnji1q3YLE=;
        b=I714GdnjWmX4W3AHRKX4rHuMtxihvlgtDW4wjnLwuRgYMbtd/RFXdPitYfhcniN9lY
         VQsEuo7uJyTZiwSMw5lX5SBnGULkLvICmU/d6O0kjiDMjm792YfA671iXiq4PfhvBGYo
         FME3m67y1uJVISjabus0z2Ju3pwqT80afbRSRxs1J1Zgu/VoWMqQlv8juzQiLlCsVnPC
         C2NPosY4pH2t13U7R/V1eLQv0+Z9KdX4O6UY0J/IBjOWbWI4BOIR0TgVKYvoCmHlnty/
         wK4xNq9FNvV1t++UQ9pEN5WKoIhJIlfarA9Mi3QkAo4Y6JH9m43AzBy5vfYEplX/sa+u
         1WDA==
X-Received: by 10.42.190.17 with SMTP id dg17mr6815265icb.44.1380292115092;
 Fri, 27 Sep 2013 07:28:35 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Fri, 27 Sep 2013 07:27:54 -0700 (PDT)
In-Reply-To: <CABURp0rrMV2Em=acG80KqqByo1nurC5azU5UBWB0L5p3Zcra8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235463>

Phil Hord wrote:
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -631,6 +631,7 @@ static void populate_value(struct refinfo *ref)
>>         int eaten, i;
>>         unsigned long size;
>>         const unsigned char *tagged;
>> +       int upstream_present = 0;
>
> This flag is out of place.  It should be in the same scope as 'branch'
> since the code which depends on this flag also depends on '!!branch'.

Agreed. Fixed.

> However, I don't think it is even necessary.  The only way to reach
> the places where this flag is tested is when (name="upstream") and
> (upstream exists).  In all other cases, the parser loops before
> reaching the track/trackshort code or else it doesn't enter it.

Yeah, you're right. I was setting upstream_present in this snippet:

  else if (!prefixcmp(name, "upstream")) {
  /* only local branches may have an upstream */
    if (prefixcmp(ref->refname, "refs/heads/"))
      continue;

If the refname doesn't begin with "refs/heads" in the first place
(which is what I was guarding against), the code will loop and never
reach the track[short] code anyway.

upstream_present factored out now.

>> @@ -698,11 +701,48 @@ static void populate_value(struct refinfo *ref)
>>                 formatp = strchr(name, ':');
>>                 /* look for "short" refname format */
>>                 if (formatp) {
>> +                       int num_ours, num_theirs;
>> +
>>                         formatp++;
>>                         if (!strcmp(formatp, "short"))
>>                                 refname = shorten_unambiguous_ref(refname,
>>                                                       warn_ambiguous_refs);
>> -                       else
>> +                       else if (!strcmp(formatp, "track") &&
>> +                               !prefixcmp(name, "upstream")) {
>> +                               char buf[40];
>> +
>> +                               if (!upstream_present)
>> +                                       continue;
>> +                               stat_tracking_info(branch, &num_ours, &num_theirs);
>> +                               if (!num_ours && !num_theirs)
>> +                                       v->s = "";
>
> Is this the same as 'continue'?

I'll leave this as it is for readability reasons.

Thanks for the review.
