From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/15] read-cache: fix memleak
Date: Mon, 23 Mar 2015 09:24:16 -0700
Message-ID: <CAGZ79kY=b3=ppmB+eJOAgcUec7hq+ycJiCvBzkTc7U78Mgog_g@mail.gmail.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-2-git-send-email-sbeller@google.com>
	<xmqq619vc9pl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:24:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya59L-0004Um-He
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 17:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbbCWQYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 12:24:18 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38024 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbbCWQYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 12:24:17 -0400
Received: by igbqf9 with SMTP id qf9so43166348igb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0oKAMvahjVvjJ4WX46pHPD13ZY//EUqThDxRyOQlkS0=;
        b=HR3iBuLk7Q766xUVhTcLD6TbveH8NtNL7TM0qPtonSEeFIzWWkEPzDOYAUTYUSomlf
         e0Zy0wFSXaHZBNZ3v4khNZtaaYd/Ezl36IOWtqZSqpyRfVd6ZGPTLbfyXtQnGeSuiW1d
         FA7zw/nS8/iSQr8kioZwXuQeW5dGeNs+EmUc8BKZOM1gvlNjk98884TVtqoEALQ9Vxt1
         gc/SBGvQxwSj7mH6hFVoEgFgoOT/WsUz7UBe5wuRlMN7LJHuniQMMUZFe4pUcJ7pXChW
         DD6NnJyzTs/0a2t3zqXwPG71jHsO/LkuT5X8kaJdtLqQR9kU69PF71mNVPKAVn3s62tx
         juog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0oKAMvahjVvjJ4WX46pHPD13ZY//EUqThDxRyOQlkS0=;
        b=mLd6MU3Co0k49iE6tVxwA+awEbJTa+TwZWUwamWMRCWQMAkKjpdmMf3zOsJGqC8ZLe
         vWdrNQgxDerNAzHYJwL9j2YKJCBgKkqq/UueIUSdr8cf+32z8UINuLpjCM6DtbmyhP2B
         OU1KixM7u77Q627Jr28JqIEiqoKluFaiqISbG0QS8uBg4R8BopszOXPZcozjKaKL3gSJ
         7ODzbjKefI/DWzimQb0sQ12WVuptwWd4+e4zwmLX6CKa6+iMdkflaOZmqQhiFrUH9mvp
         YLH8hbn5WmVary0r0dzl9bOua/uJWNrvShIYpF6chZuA72fFCTfcaLjdL2kIFvO6k0Zr
         1iTg==
X-Gm-Message-State: ALoCoQnoIhQ31SS0fgi3LwICksjgq2nv+ul1waIJqN6x79ui7zEv9tNn6x7LSQ62WD+BSONAuMaX
X-Received: by 10.50.107.36 with SMTP id gz4mr15750048igb.25.1427127856549;
 Mon, 23 Mar 2015 09:24:16 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Mon, 23 Mar 2015 09:24:16 -0700 (PDT)
In-Reply-To: <xmqq619vc9pl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266146>

On Fri, Mar 20, 2015 at 8:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> `ce` is allocated in make_cache_entry and should be freed if it is not
>> used any more. refresh_cache_entry as a wrapper around refresh_cache_ent
>> will either return `ce` or a new updated cache entry which is allocated
>> to new memory. In that case we need to free `ce` ourselfs.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  read-cache.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 8d71860..f72ea9f 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -747,6 +747,8 @@ struct cache_entry *make_cache_entry(unsigned int mode,
>>               free(ce);
>>               return NULL;
>>       } else {
>> +             if (ret != ce)
>> +                     free(ce);
>>               return ret;
>>       }
>>  }
>
> Good, I vaguely recall that we did something similar in another
> codepath that forgot the fact that refresh_cache_entry() may make
> the incoming ce unnecessary.
>
> As the rule is "if ret is different from ce, then ce must be freed"
> in this codepath, I wonder if this is easier to read:
>
>         ret = refresh_cache_entry(ce, ...);
>         if (ret != ce)
>                 free(ce);
>         return ret;
>

Indeed it is. Thanks for pointing out!

I'll send this as part of another series
applying on top of sb/leaks soon.
