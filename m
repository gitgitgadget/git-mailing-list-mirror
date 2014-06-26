From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Thu, 26 Jun 2014 13:54:10 +0530
Message-ID: <53ABD8AA.10909@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-6-git-send-email-tanayabh@gmail.com> <CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:24:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X04yo-0002RI-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 10:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbaFZIYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 04:24:21 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:64701 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaFZIYT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 04:24:19 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so2847524pbc.16
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=v16oiBlHwTKFKpwatQB1pH8OXBWMyaJfkLDF2c7G2YM=;
        b=AB+uJuyWAywmV5ZJn3aUQ+4E8I7uUW9e2So7YBAqX1meX4UF+pg66wrG2gRnjs+MXw
         eZOoOzfKVbCbqOOX4Gi8rwjhBEn20l43PUzf8UyfpkC4f/OrZWHEaLOgvhIKCqipZ1D6
         /nY3TCj/9knJtCLAbBahFXk2EJH4bX1YVdgS2UOk5ySxXwm9CG1q8mbqd9cR+mBqa60B
         fuhiaMfyF9aAuGDNKdtZ7SwfEEaLLlF+SnxX8vG+dHViRp2fSiAW3S2ZPriWiT92H05I
         ToApdTiuRcCS5jxSMo2ZFNPqztVpBUtyaETh9/Bghvpmeh5jYv8dVG6wV4Kzl/+D7NoE
         gejg==
X-Received: by 10.66.66.199 with SMTP id h7mr19587645pat.30.1403771059184;
        Thu, 26 Jun 2014 01:24:19 -0700 (PDT)
Received: from [127.0.0.1] ([117.251.76.15])
        by mx.google.com with ESMTPSA id g6sm31277848pat.2.2014.06.26.01.24.15
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 01:24:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252492>



On 6/25/2014 9:29 AM, Eric Sunshine wrote:
> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>> Use git_config_get_string instead of git_config to take advantage of
>> the config hash-table api which provides a cleaner control flow.
>>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  pager.c | 44 +++++++++++++++-----------------------------
>>  1 file changed, 15 insertions(+), 29 deletions(-)
>>
>> diff --git a/pager.c b/pager.c
>> index 8b5cbc5..96abe6d 100644
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -6,12 +6,6 @@
>>  #define DEFAULT_PAGER "less"
>>  #endif
>>
>> -struct pager_config {
>> -       const char *cmd;
>> -       int want;
>> -       char *value;
>> -};
>> -
>>  /*
>>   * This is split up from the rest of git so that we can do
>>   * something different on Windows.
>> @@ -155,30 +149,22 @@ int decimal_width(int number)
>>         return width;
>>  }
>>
>> -static int pager_command_config(const char *var, const char *value, void *data)
>> -{
>> -       struct pager_config *c = data;
>> -       if (starts_with(var, "pager.") && !strcmp(var + 6, c->cmd)) {
>> -               int b = git_config_maybe_bool(var, value);
>> -               if (b >= 0)
>> -                       c->want = b;
>> -               else {
>> -                       c->want = 1;
>> -                       c->value = xstrdup(value);
>> -               }
>> -       }
>> -       return 0;
>> -}
>> -
>>  /* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
>>  int check_pager_config(const char *cmd)
>>  {
>> -       struct pager_config c;
>> -       c.cmd = cmd;
>> -       c.want = -1;
>> -       c.value = NULL;
>> -       git_config(pager_command_config, &c);
>> -       if (c.value)
>> -               pager_program = c.value;
>> -       return c.want;
>> +       struct strbuf key = STRBUF_INIT;
>> +       int want = -1;
>> +       const char *value = NULL;
>> +       strbuf_addf(&key, "pager.%s", cmd);
>> +       if (!git_config_get_string(key.buf, &value)) {
>> +               int b = git_config_maybe_bool(key.buf, value);
>> +               if (b >= 0)
>> +                       want = b;
>> +               else
>> +                       want = 1;
>> +       }
>> +       if (value)
>> +               pager_program = value;
> 
> Two issues:
> 
> First, why is 'if(value)' standing by itself? Although this works, it
> seems to imply that 'value' might be able to become non-NULL by some
> mechanism other than the get_config_maybe_bool() call, which means
> that people reading this code have to spend extra time trying to
> understand the overall logic. If you follow the example of the
> original code, where 'value' is only ever set when 'b < 0', then it is
> obvious even to the most casual reader that 'pager_program' is
> assigned only for that one condition.
> 

Noted.

> Second, don't you want to xstrdup(value) when assigning to
> 'pager_program'? If you don't, then 'pager_program' will become a
> dangling pointer when config_cache_free() is invoked.
> 

Noted. Thanks.

>> +       strbuf_release(&key);
>> +       return want;
>>  }
>> --
>> 1.9.0.GIT
> 
