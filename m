From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v7 01/10] Add support for -i/--interactive to git-clean
Date: Fri, 10 May 2013 00:35:37 +0800
Message-ID: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	<7vr4hhflym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 18:35:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaToo-0006Rl-68
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 18:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab3EIQfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 12:35:40 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:44889 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab3EIQfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 12:35:39 -0400
Received: by mail-wg0-f52.google.com with SMTP id k13so3170910wgh.31
        for <git@vger.kernel.org>; Thu, 09 May 2013 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Q21rgGYSvRZkejkmWbtN+3/HHweZf88V8TRGx+VO7bU=;
        b=PPIT19Opwpry7Syw30kcWMAZ17hgvsXaDCZsU1V5w/OloNTd3n94m/KfSm/s+2/aap
         czGrOQqJ4M0XVHS+UgMf6lCYtKNAECk2gpAqqEM+QaD5KyW+2UpUoyH/HvK5GvwmrXmD
         Ez9lgTG8YVJtJU5AE6pM8oXq8xMh32+tStBmQ5pEj796C8fF3otztE2D3T0c1bXuCx96
         3ZIMc4xLvbrS52pMuVffa1S30M4yQmOn2ts5f3gn9XJ2apbo/7qqliHi1k0taJNsX2h9
         mveQ7UdfBjHu/pV1tl13pxPUAJW9OtehLpLMHq/C8mMoajH0L4eW0+76caS4FcBH+c2l
         GaKw==
X-Received: by 10.180.198.49 with SMTP id iz17mr30175658wic.19.1368117337961;
 Thu, 09 May 2013 09:35:37 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Thu, 9 May 2013 09:35:37 -0700 (PDT)
In-Reply-To: <7vr4hhflym.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223747>

2013/5/9 Junio C Hamano <gitster@pobox.com>:
>> @@ -15,9 +15,12 @@
>>  #include "quote.h"
>>
>>  static int force = -1; /* unset */
>> +static int interactive;
>> +static struct string_list del_list = STRING_LIST_INIT_DUP;
>> +static const char **the_prefix;
>
> Ehh, why?

Next reroll will save relative paths in del_list, and eliminate "**the_prefix".


>> +
>> +             printf(_("Input ignore patterns>> "));
>> +             if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
>> +                     strbuf_trim(&confirm);
>> +             } else {
>> +                     putchar('\n');
>> +                     break;
>
> Why break here?  If we got nothing, wouldn't confirm.len be zero?
> If we did get something but the input got flushed without line-end,
> sending '\n' to the terminal may be justified, but in that case you
> would may have something useful, and asking confirm.len if it is
> empty would be the consistent way to check between two cases, no?

Yes, this break is unnecessary, it left from pervious revision.


>
> A few points:
>
>  * Pass prefix as a parameter to this function, just like how
>    remove_dirs() gets called, and get rid of the_prefix.
>
>  * The result of quote_* is designed to avoid ambiguities, by
>    applying C-style quotes like HT => \t and adding "" pair around
>    it as necessary.  I doubt feeding it to is_excluded() makes any
>    sense.  You probably meant path_relative(), but I am not sure.

Appreciated, that is what I need. I write a local version of path_relative,
a combination of path_relative (in quote.c) and relative_path (in path.c),
like this:

        static const char *path_relative(const char *in, const char *prefix)

>> +     for_each_string_list_item(item, &del_list) {
>> +             struct stat st;
>> +
>> +             if (lstat(item->string, &st))
>> +                     continue;
>
> Ignoring errors silently?
>
> With the "interactive" stuff, can you get into a situation where you
> originally propose to remove D and D/F but the user tells you to
> remove D (editing D/F away), or vice versa?

I can not find out such a case, that remove parent directory D,
while left file in it, such as D/F.

> I think this patch should be in at least two parts:
>
>  - Introduce the two-phase "collect in del_list, remove in a
>    separate loop at the end" restructuring.
>
>  - (optional, if you are feeling ambitious) Change the path that is
>    stored in del_list relative to the prefix, so that all functions
>    that operate on the string in the del_list do not have to do
>    *_relative() thing.  Some functions may instead have to prepend
>    prefix but if they are minority compared to the users of
>    *_relative(), it may be an overall win from the readability's
>    point of view.
>
>  - Add the "interactively allow you to reduce the del_list" bit
>    between the two phases.
>

Will send new reroll soon.


-- 
Jiang Xin
