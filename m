From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Fri, 11 Jul 2014 18:05:56 +0900
Message-ID: <CAFT+Tg8Z5z=vTcCTbwKMQeTAaqpTYzr5OzdfedV0q8J5KzG-Yg@mail.gmail.com>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
	<alpine.DEB.2.00.1407091127490.22132@ds9.cixit.se>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Yi EungJun <eungjun.yi@navercorp.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jul 11 11:06:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5WmJ-00063G-0Q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 11:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbaGKJF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 05:05:58 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:52783 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbaGKJF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 05:05:56 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so758180igb.17
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0gXncsOWJHfGDX3iaj4JSNZBFg0L8Dp0iOBDHGYmQNQ=;
        b=fnmMPSLDgaEQrfj54GwHn3qio+FKcmhFI8kTim/OE+2Bl7B6plTD1w9lkb94jgktBE
         dHH7vchCVqguw79zVeMCXFjciQITqBbZjbOK415gVRNIMb3+KjnB78qxqvwGhonmrB0W
         YxXaCxewd1JQJLPqqgG0gXHfuTVJpgXmlCgEcmbvziD8g0FOEPu0BkZ8sYNALyXGon36
         m90a7Qf4AbqmlU0zc7gzSzEuuGtkNKXs8UZ/DNnm74Nr+5N2NiL7ParcdK2ypIRFlpof
         Pisg6wYLCsKGC1YVr7H7lCEmtKQbcGnIl2+ZQpAasNlOHpVT8dVr9fKS6JNCxYrhUKs8
         I09A==
X-Received: by 10.42.38.137 with SMTP id c9mr1228580ice.94.1405069556164; Fri,
 11 Jul 2014 02:05:56 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Fri, 11 Jul 2014 02:05:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407091127490.22132@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253264>

2014-07-09 19:40 GMT+09:00 Peter Krefting <peter@softwolves.pp.se>:
> Yi EungJun:
>
>
>> Example:
>>  LANGUAGE= -> ""
>>  LANGUAGE=ko -> "Accept-Language: ko; q=1.000, *; q=0.001"
>>  LANGUAGE=ko:en -> "Accept-Language: ko; q=1.000, en; q=0.999, *; q=0.001"
>
>
> Avoid adding "q=1.000". It is redundant (the default for any unqualified
> language names is 1.0, and additionally there has historically been some
> buggy servers that failed if it was included.

Ok, I'll fix it.

>
>
>> +       p1 = getenv("LANGUAGE");
>
>
> You need a fallback mechanism here to parse all the possible language
> variables. I would use the first one I find of these:
>
>  1. LANGUAGE
>  2. LC_ALL
>  3. LC_MESSAGES
>  4. LANG
>
> Only "LANGUAGE" holds a colon-separated list, but the same code can parse
> all of them, just yielding a single entry for the others.

I'll use setlocale(LC_MESSAGES, NULL) as well as getenv("LANGUAGE").

>
>
>> +                               strbuf_add(buf, p1, p2 - p1);
>
>
> The tokens are on the form language_COUNTRY.encoding@identifier, whereas
> Accept-Language wants language-COUNTRY, so you need to a) replace "_" with
> "-", and b) chop off anything following a "." or "@".
>
>
>> +                               strbuf_addf(buf, "; q=%.3f", q);
>> +                               q -= 0.001;
>
>
> Three decimals seems a bit overkill, but some experimentation might be
> necessary.

I'll use three decimals only if there are 100 or more preferred languages.

>
>
>> +               strbuf_addstr(buf, "*; q=0.001\r\n");
>
>
> You should probably also add an explicit "en" here, if none was already
> included. I've seen some servers break horribly if "en" isn't included.

I'll send Accept-Language only if there is at least one preferred
language. Is it enough?

Thanks for your review.
