From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [RFC/PATCH V2] alias.c: replace git_config with git_config_get_string
Date: Thu, 26 Jun 2014 13:54:32 +0530
Message-ID: <53ABD8C0.1000308@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com> <CAPig+cQ3hzFFRRhbDTddArBC0nB9gZ7yMXuh35GHe73x-1JDng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:25:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X04zK-0002sf-OH
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 10:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbaFZIYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 04:24:54 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:45653 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbaFZIYw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 04:24:52 -0400
Received: by mail-pa0-f54.google.com with SMTP id et14so2891833pad.27
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tAo5g2KWTrOU5xWQohd1JtWwG5rKMNFnis34fCCC+dU=;
        b=VfEjQz+Jk3XOGo4zixUkia0icGoPetchf0UhkpZOJ2ZVbeyEOXBEGYDv2STeCspTBX
         leXKJ6kuk30FGxMNk+LpvK0DaGD+lunpL4n4UlC+2tWtVMsIP575PpTSwzv3tBWzK8Ga
         a1bjSecQtf9qua/0kPsoWzvepGdw3wjFAjOOwkv7trCNlGrtZawaua0HII4O0U/fX/3c
         KG88j/BIBw8wFejOzJCXc4zjoFEKfIlVADLh8R6U1an44lVpDvypT0PtgoLxSaKwxU9a
         Z3jbPreJNQlnRZQbiS6XGHAwzyuqu2AfqMtk8uPAxYx4kCpJ2Wovz9Vtr+3oIqoz/szl
         Dgxg==
X-Received: by 10.68.161.101 with SMTP id xr5mr19044050pbb.168.1403771092437;
        Thu, 26 Jun 2014 01:24:52 -0700 (PDT)
Received: from [127.0.0.1] ([117.251.76.15])
        by mx.google.com with ESMTPSA id xk1sm31223553pac.21.2014.06.26.01.24.33
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 01:24:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cQ3hzFFRRhbDTddArBC0nB9gZ7yMXuh35GHe73x-1JDng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252493>



On 6/25/2014 7:42 AM, Eric Sunshine wrote:
> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>> Use git_config_get_string instead of git_config to take advantage of
>> the config hash-table api which provides a cleaner control flow.
>>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  alias.c | 28 ++++++++++------------------
>>  1 file changed, 10 insertions(+), 18 deletions(-)
>>
>> diff --git a/alias.c b/alias.c
>> index 5efc3d6..0fe32bc 100644
>> --- a/alias.c
>> +++ b/alias.c
>> @@ -1,25 +1,17 @@
>>  #include "cache.h"
>>
>> -static const char *alias_key;
>> -static char *alias_val;
>> -
>> -static int alias_lookup_cb(const char *k, const char *v, void *cb)
>> -{
>> -       if (starts_with(k, "alias.") && !strcmp(k + 6, alias_key)) {
>> -               if (!v)
>> -                       return config_error_nonbool(k);
>> -               alias_val = xstrdup(v);
>> -               return 0;
>> -       }
>> -       return 0;
>> -}
>> -
>>  char *alias_lookup(const char *alias)
>>  {
>> -       alias_key = alias;
>> -       alias_val = NULL;
>> -       git_config(alias_lookup_cb, NULL);
>> -       return alias_val;
>> +       const char *v;
>> +       char *value;
>> +       struct strbuf key = STRBUF_INIT;
>> +       strbuf_addf(&key, "alias.%s", alias);
>> +       git_config_get_string(key.buf, &v);
>> +       if (!v)
>> +               config_error_nonbool(key.buf);
> 
> If 'v' is NULL, you correctly report an error, but then fall through
> and invoke xstrdup() with NULL, which invites undefined behavior [1].
> 
> [1]: http://pubs.opengroup.org/onlinepubs/009695399/functions/strdup.html
> 
>> +       value = xstrdup(v);
>> +       strbuf_release(&key);
>> +       return value;
> 
> You could release the strbuf earlier, which would allow you to 'return
> xstrdup(v)' and drop the 'value' variable. Perhaps you want something
> like this:
> 
>     const char *v;
>     struct strbuf key = STRBUF_INIT;
>     strbuf_addf(&key, "alias.%s", alias);
>     git_config_get_string(key.buf, &v);
>     if (v)
>         config_error_nonbool(key.buf);
>     strbuf_release(&key);
>     return v ? xstrdup(v) : NULL;
> 

Done. Thanks.

>>  }
>>
>>  #define SPLIT_CMDLINE_BAD_ENDING 1
>> --
>> 1.9.0.GIT
> 
