From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] wincred: fix get credential if username has @
Date: Sun, 25 Jan 2015 22:12:15 +0100
Message-ID: <CABPQNSaNHU=eJtK=s4P=p0hesEB0fxnwRo1zx5sMDo7zXgYM_A@mail.gmail.com>
References: <1415832746-5116-1-git-send-email-margtu-fivt@ya.ru>
 <1416433652-6840-1-git-send-email-margtu-fivt@ya.ru> <xmqq1toyreyh.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Aleksey Vasenev <margtu-fivt@ya.ru>,
	GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Karsten Blees <blees@dcon.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 22:13:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFUUY-0001R0-LT
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 22:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbbAYVM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2015 16:12:58 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:52127 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbbAYVM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 16:12:56 -0500
Received: by mail-ig0-f171.google.com with SMTP id r10so5409323igi.4
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 13:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3MCPmhY1ip3Xv8WC7Dtcns6gcYReLEQMcFeG3e+iY/M=;
        b=BhZZGqzUC9ZwvNHWWPW/WKLGF3KEmNYA2NwMEw+KTdLeno229NTdT2izBKsv8KLJ5m
         rzpwmIEXp9Q0a53tht6JUoiHfDdKOE3sjSXJWxP/SWrPhQBY8yo7r/ApTwV8oHC+PdQY
         i5gfId1TovKrS2dLiRTsZrHlLnrdyyEXDp+sQG3F14P4WE1pzbmxmg2sphmagu7Gd/3g
         YOxVpyrV6wZpwX11AsR2GBk0Qo5je+bcrxsNuD03wrbuckOoR8efAv6OJimtRC9IGb3n
         YWKaudpM1bR4h8f1bfb9XsqPPpDc3lvQf93dzJgOUnJufua/w/RHpTYkv3+UbwUl+j86
         NgRg==
X-Received: by 10.50.43.133 with SMTP id w5mr13144007igl.44.1422220375358;
 Sun, 25 Jan 2015 13:12:55 -0800 (PST)
Received: by 10.64.240.139 with HTTP; Sun, 25 Jan 2015 13:12:15 -0800 (PST)
In-Reply-To: <xmqq1toyreyh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263021>

Sorry for the extremely delayed reply, I had a bug in my mail-filters.
Hopefully fixed now.

On Wed, Nov 19, 2014 at 11:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Aleksey Vasenev <margtu-fivt@ya.ru> writes:
>
>>> To: git@vger.kernel.org
>>> Cc: Junio C Hamano <gitster@pobox.com>, Aleksey Vasenev <margtu-fivt@ya.ru>
>
> Sorry, but I am hardly qualified to review this one, especially
> without any log message that explains what breaks and how it breaks
> with the current code, which may lead the reader to understand how
> the updated code fixes the issue.  Cc'ing me does not help us very
> much.
>
>     $ git shortlog --no-merges -n contrib/credential/wincred/
>
> gives me a few names who may be able to give us some inputs, so I'll
> Cc them.
>
> Thanks.

I noticed the breakage myself around the same time, and posted about it here:

https://groups.google.com/d/msg/msysgit/YVuCqmwwRyY/HULHj5OoE88J

Unfortunately, it stopped there.

>> Signed-off-by: Aleksey Vasenev <margtu-fivt@ya.ru>
>> ---
>>  .../credential/wincred/git-credential-wincred.c    | 25 +++++++++++++++++++---
>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
>> index a1d38f0..0061340 100644
>> --- a/contrib/credential/wincred/git-credential-wincred.c
>> +++ b/contrib/credential/wincred/git-credential-wincred.c
>> @@ -111,14 +111,23 @@ static void write_item(const char *what, LPCWSTR wbuf, int wlen)
>>   * Match an (optional) expected string and a delimiter in the target string,
>>   * consuming the matched text by updating the target pointer.
>>   */
>> -static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
>> +
>> +static LPCWSTR wcsstr_last(LPCWSTR str, LPCWSTR find)
>> +{
>> +     LPCWSTR res = NULL, pos;
>> +     for (pos = wcsstr(str, find); pos; pos = wcsstr(pos + 1, find))
>> +             res = pos;
>> +     return res;
>> +}
>> +

Ugh, there's no wcsrstr? I guess this is a reasonable way to emulate it...

>> +static int match_part_with_last(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim, int last)
>>  {
>>       LPCWSTR delim_pos, start = *ptarget;
>>       int len;
>>
>>       /* find start of delimiter (or end-of-string if delim is empty) */
>>       if (*delim)
>> -             delim_pos = wcsstr(start, delim);
>> +             delim_pos = last ? wcsstr_last(start, delim) : wcsstr(start, delim);
>>       else
>>               delim_pos = start + wcslen(start);
>>
>> @@ -138,6 +147,16 @@ static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
>>       return !want || (!wcsncmp(want, start, len) && !want[len]);
>>  }
>>
>> +static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
>> +{
>> +     return match_part_with_last(ptarget, want, delim, 0);
>> +}
>> +
>> +static int match_part_last(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
>> +{
>> +     return match_part_with_last(ptarget, want, delim, 1);
>> +}
>> +
>>  static int match_cred(const CREDENTIALW *cred)
>>  {
>>       LPCWSTR target = cred->TargetName;
>> @@ -146,7 +165,7 @@ static int match_cred(const CREDENTIALW *cred)
>>
>>       return match_part(&target, L"git", L":") &&
>>               match_part(&target, protocol, L"://") &&
>> -             match_part(&target, wusername, L"@") &&
>> +             match_part_last(&target, wusername, L"@") &&
>>               match_part(&target, host, L"/") &&
>>               match_part(&target, path, L"");
>>  }

Looks reasonable enough to me.

Acked-by: Erik Faye-Lund <kusmabite@gmail.com>
