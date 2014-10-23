From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 06/15] copy.c: make copy_fd preserve meaningful errno
Date: Thu, 23 Oct 2014 10:54:17 -0700
Message-ID: <CAL=YDWkatPumEM7p5Pvh6dxFgO59T-YBbjqS5nWnNpH-azzxBg@mail.gmail.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-7-git-send-email-sahlberg@google.com>
	<xmqqlho6smi8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 19:54:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhMac-00009a-VV
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 19:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbaJWRyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 13:54:19 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:42280 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbaJWRyS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 13:54:18 -0400
Received: by mail-qg0-f41.google.com with SMTP id a108so1263541qge.0
        for <git@vger.kernel.org>; Thu, 23 Oct 2014 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XVNRWkndammZL0RpebAQXt8/+/KK0qkRvEun+gfPcAA=;
        b=diZrk9jGe7Qlk7m6fHtRGKpuxML2aS0blStdlauY75MQKOwrV9pwcp7JQFEHRYd+A3
         GmmU805RpX7J9crF/wUTw1BjGz1e6h8VJ09QkPP8J2PMWFu+erVGkGTksoj/Sakqwp7T
         BgMSCFRe+qj1X8b9+vlX3l9aS1Ew2tSHfoBiezNDXZfJVPqRnI47ksDPd5jNH9D95a7N
         sX81b3gfsO5QxuSkM/hbp720oHzs2j71/rt282gnfwg3lSfLNyguW990dfvQstQZxnJF
         TM/WBv6Ig9vXrzogLQlkxUB1YfEbE/gEnul2TwkmjO7KAorOdEyVB6/l650orRjHNQan
         8diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XVNRWkndammZL0RpebAQXt8/+/KK0qkRvEun+gfPcAA=;
        b=COJVKtJ8AhIERYJsL9QIhc1xto4SFRqU9PTnYalX4YcQHsl8ev1Vst0zbOys2YTB7/
         CPp2ODYglMOE4kXTx12NeY2fL3NpAOCLVmlsLiJI7PlOpYHpHi+hAfQisRcgVOSeWxxo
         W1FWcqhobiPM03tKeuK4fQvCrkjDXyOZxte4vRkPGnDYUVUz9/HIxtctKKAyU3HHwGrV
         jKqlSDFCxIitYc4nXDQu8MM/hVAP4YubSBYKXrPOgMBdh9D7ZY8IwewhykjAsTCODQbf
         CYiTq99ycyoGwMo2fT1ks9Eccrg6ssiGImyPSzKQhUEXCvwlEs6wp7j07jcwi9Fc5aYk
         hMtA==
X-Gm-Message-State: ALoCoQmVhYFr6znqfcHMg3DWhNGGQvnuSxAKjrzWIjLUmwVjzn3CuMHjLQNmbCmzPqbeJ5Ew6G0k
X-Received: by 10.140.28.10 with SMTP id 10mr9469315qgy.15.1414086857300; Thu,
 23 Oct 2014 10:54:17 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Thu, 23 Oct 2014 10:54:17 -0700 (PDT)
In-Reply-To: <xmqqlho6smi8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 23, 2014 at 10:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> commit 306805ccd147bfdf160b288a8d51fdf9b77ae0fa upstream.
>>
>> Update copy_fd to return a meaningful errno on failure.
>
> These two are good changes, but makes me wonder if more places
> benefit from having error_errno() that does the "save away errno,
> use strerror(errno) to give an error message and restore errno"
> for us.
>
> Not meant as a suggestion for further changes in this series, but as
> a future discussion item.
>

That sounds like a good idea.

As a separate series once these are done, I can volunteer to go
through all the errno handling in git
and look into that.


>>
>> Change-Id: I771f9703acc816902affcf35ff2a56d9426315ac
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>>  copy.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/copy.c b/copy.c
>> index f2970ec..a8d366e 100644
>> --- a/copy.c
>> +++ b/copy.c
>> @@ -8,12 +8,17 @@ int copy_fd(int ifd, int ofd)
>>               if (!len)
>>                       break;
>>               if (len < 0) {
>> -                     return error("copy-fd: read returned %s",
>> -                                  strerror(errno));
>> +                     int save_errno = errno;
>> +                     error("copy-fd: read returned %s", strerror(errno));
>> +                     errno = save_errno;
>> +                     return -1;
>> +             }
>> +             if (write_in_full(ofd, buffer, len) < 0) {
>> +                     int save_errno = errno;
>> +                     error("copy-fd: write returned %s", strerror(errno));
>> +                     errno = save_errno;
>> +                     return -1;
>>               }
>> -             if (write_in_full(ofd, buffer, len) < 0)
>> -                     return error("copy-fd: write returned %s",
>> -                                  strerror(errno));
>>       }
>>       return 0;
>>  }
