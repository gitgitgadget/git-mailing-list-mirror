From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v10 22/44] fetch.c: clear errno before calling functions
 that might set it
Date: Tue, 27 May 2014 12:14:48 -0700
Message-ID: <CAL=YDWmoNgJHjUir3_Sh5oT5zmRH3jfi8Cbij8DGD0CuXnmXTw@mail.gmail.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
	<1400261852-31303-23-git-send-email-sahlberg@google.com>
	<53777894.7020408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 27 21:14:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMpp-0003fX-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 21:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbaE0TOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 15:14:50 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:60883 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbaE0TOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 15:14:49 -0400
Received: by mail-ve0-f182.google.com with SMTP id sa20so11197551veb.41
        for <git@vger.kernel.org>; Tue, 27 May 2014 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nPXWmF8W5MWb3hCLLY1ZOEWcwFyHlI8pONvvQp5q1hg=;
        b=e6QaFcwRauV0AqEc170c7XI8q8mjsNLqEGfhBOvyCOxgQWsGfwGmR4JXxwi7D9ihCJ
         tTMNQo0qr2AaO0LLQU2NgP2MbErMnUlE4RswWHm9weBt2hu73EiN/51UgxDtG6O4fotq
         9ylIeDHGzvkjxVc03zU8iKaxg00eCVcahr78kZy8jjbdqwc+jhGP6PdM+xRDTnsNQsT5
         XaXoIp+GrKOoHvk8al0Z/ZEtSrzDpPtbTwZZxvG13WI8nkp7NY+kER7c7LjLFR5aRDwK
         ZtuWUv7Yy76rEqXYwCL47cm3T6qYRVPaxYtl90YzXmbiZhCUh++cmjK6S5a1gkPRj+oQ
         Bojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nPXWmF8W5MWb3hCLLY1ZOEWcwFyHlI8pONvvQp5q1hg=;
        b=AE4Z7i9Q03XPDeIh4l+a4UsAiKDM3I3XAsDJo2FWvz/Yi5zv/Mpvmzv+i/X3nR+ir6
         rd/8K63CRpxOVIVwhORLcT4n7fuX5nvwR0n5mb6lJ3qDv2QPwxK2IqlKBPTMOsY5SLih
         +oDGKMzOsvimcZAMnn5b7GOgUmELiZqA0ZxAqBn3man0YftysJlLQVYDySRFvQ8Xjm7f
         OU/PGLreVSqArbf86BFtHtNZNN4Wg1/L1B6JXR6XNHl48qL57OK3fjv0/xvDe4PNaBNq
         QHDz1Z1dAnaJci9U31EKDEcH7PonpAMgSZuQf8h7umqBzEhtponwmgPywyXtPLuSG58b
         ldSg==
X-Gm-Message-State: ALoCoQlBNBFV3gj/K5blDNFGIeWJdQTO+Ee+hKUa//WFt66ox/09shjevSFf1zfusWTWokN0PGPk
X-Received: by 10.58.46.83 with SMTP id t19mr3150637vem.60.1401218088836; Tue,
 27 May 2014 12:14:48 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Tue, 27 May 2014 12:14:48 -0700 (PDT)
In-Reply-To: <53777894.7020408@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250190>

On Sat, May 17, 2014 at 7:56 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
>> In s_update_ref there are two calls that when they fail we return an error
>> based on the errno value. In particular we want to return a specific error
>> if ENOTDIR happened. Both these functions do have failure modes where they
>> may return an error without updating errno, in which case a previous and
>> unrelated ENOTDIR may cause us to return the wrong error. Clear errno before
>> calling any functions if we check errno afterwards.
>
> If I understand correctly, this is a workaround for some other broken
> functions that don't handle errno correctly.  Long-term, wouldn't it be
> better to fix the other functions?  In other words, they should change
> errno if an only if they return an error status, no?

Yeah,  but this patch is gone now.
Longer term I think we should get rid of passing errno around.
errno is best to only be checked immediately after a failed system
call and never else.
(otherwise you end up with a hairy forest of save_errno variables.)

>
> Of course you are under no obligation to fix the universe, so this
> change may be an expedient workaround anyway.  But if you go this route,
> then I think a comment would be helpful to explain the unusual clearing
> of errno.
>
> Michael
>
>>
>> Also skip initializing a static variable to 0. Statics live in .bss and
>> are all automatically initialized to 0.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/fetch.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 55f457c..a93c893 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -44,7 +44,7 @@ static struct transport *gtransport;
>>  static struct transport *gsecondary;
>>  static const char *submodule_prefix = "";
>>  static const char *recurse_submodules_default;
>> -static int shown_url = 0;
>> +static int shown_url;
>>
>>  static int option_parse_recurse_submodules(const struct option *opt,
>>                                  const char *arg, int unset)
>> @@ -382,6 +382,8 @@ static int s_update_ref(const char *action,
>>       if (!rla)
>>               rla = default_rla.buf;
>>       snprintf(msg, sizeof(msg), "%s: %s", rla, action);
>> +
>> +     errno = 0;
>>       lock = lock_any_ref_for_update(ref->name,
>>                                      check_old ? ref->old_sha1 : NULL,
>>                                      0, NULL);
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
