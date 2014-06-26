From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [RFC/PATCH V2] branch.c: replace git_config with git_config_get_string
Date: Thu, 26 Jun 2014 13:39:15 +0530
Message-ID: <53ABD52B.3030502@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-2-git-send-email-tanayabh@gmail.com> <CAPig+cTMWKtAjN931voVs7aY7JdEyaRVZj+-qDUiDk0C_Tq6-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:10:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X04kt-0007pT-6G
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 10:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbaFZIJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 04:09:57 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:46628 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbaFZIJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 04:09:29 -0400
Received: by mail-pb0-f48.google.com with SMTP id rq2so2815132pbb.35
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 01:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9jI/zm8j7UFMTiVF8waEfla20Pqbe92x+6pbI21Ve7o=;
        b=qCgJTMXnGLMYk1ShsMh4ZJr7Cu6/Hzu2PbwzOKMLK3pTdIJTNnUQMS9qVPXuaMGapr
         rDpcHxrwUgr15dJEQdRGXvEKm4AqCpCi8L7AGbvb2IkjdCr6hDexeu0AWj2kAxgqJyc/
         wzkvfB3ibU8pA3RC/E/V/4L8L2QBkc7Mw9P/VZxg77eipSWi5FCiWZ7/bjlQLVfftMWH
         LwGP/w2nQqb+dH0fu7h10dshFBSFJlFleMApGtjJM/DPPDYU9GmgRSxIb3X9rqaaP9ZS
         JqgJjR3s+OwvGJu1ijcjugqZK/h5TAE1Sta3Z3dev8bN9UHPsEhQpJdAeDOOqe4JwZMi
         UZWg==
X-Received: by 10.66.66.166 with SMTP id g6mr19136980pat.108.1403770168596;
        Thu, 26 Jun 2014 01:09:28 -0700 (PDT)
Received: from [127.0.0.1] ([117.251.76.15])
        by mx.google.com with ESMTPSA id z3sm31049845pas.15.2014.06.26.01.09.23
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 01:09:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cTMWKtAjN931voVs7aY7JdEyaRVZj+-qDUiDk0C_Tq6-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252488>


On 6/25/2014 10:15 AM, Eric Sunshine wrote:
> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:

>> diff --git a/branch.c b/branch.c
>> index 660097b..c9a2a0d 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -140,33 +140,25 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
>>         return 0;
>>  }
>>
>> -struct branch_desc_cb {
>> +struct branch_desc {
>>         const char *config_name;
>>         const char *value;
>>  };
> 
> What is the purpose of retaining this structure? Following your
> changes, it is never used outside of read_branch_desc(), and
> 'config_name' and 'value' would be more naturally declared as
> variables local to that function.

Done. :)

> 
>> -static int read_branch_desc_cb(const char *var, const char *value, void *cb)
>> -{
>> -       struct branch_desc_cb *desc = cb;
>> -       if (strcmp(desc->config_name, var))
>> -               return 0;
>> -       free((char *)desc->value);
>> -       return git_config_string(&desc->value, var, value);
>> -}
>> -
>>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>>  {
>> -       struct branch_desc_cb cb;
>> +       const char *value = NULL;
>> +       struct branch_desc desc;
>>         struct strbuf name = STRBUF_INIT;
>>         strbuf_addf(&name, "branch.%s.description", branch_name);
>> -       cb.config_name = name.buf;
>> -       cb.value = NULL;
>> -       if (git_config(read_branch_desc_cb, &cb) < 0) {
>> +       desc.config_name = name.buf;
>> +       desc.value = NULL;
>> +       git_config_get_string(desc.config_name, &value);
>> +       if (git_config_string(&desc.value, desc.config_name, value) < 0) {
> 
> Although it works in this case, it's somewhat ugly that you ignore the
> return value of git_config_get_string(), and a person reading the code
> has to spend extra time digging into git_config_string() to figure out
> why this is safe. If might be clearer for future readers by rephrasing
> like this:
> 
>     if (git_config_get_string(desc.config_name, &value) < 0 ||
>         git_config_string(&desc.value, desc.config_name, value) < 0) {
>

Noted, also didn't the old code leak desc.value as it was xstrduped
by git_config_string()? Thanks for the review.

>>                 strbuf_release(&name);
>>                 return -1;
>>         }
>> -       if (cb.value)
>> -               strbuf_addstr(buf, cb.value);
>> +       strbuf_addstr(buf, desc.value);
>>         strbuf_release(&name);
>>         return 0;
>>  }
>> --
>> 1.9.0.GIT
> 
