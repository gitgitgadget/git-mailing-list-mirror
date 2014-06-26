From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [RFC/PATCH] imap-send.c: replace git_config with git_config_get_string
Date: Thu, 26 Jun 2014 13:44:47 +0530
Message-ID: <53ABD677.4040808@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-3-git-send-email-tanayabh@gmail.com> <CAPig+cTStpB09Fh3bAF2NcdWR9W_UMaL5qutvUuQNfEL4=GwNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:15:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X04pg-0003VH-PC
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 10:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbaFZIO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 04:14:56 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36034 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbaFZIOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 04:14:53 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so2856576pab.17
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Lo2MrT+CD+FiNnKG/z7iepqwpF1cWELe6HIjbRobC1Y=;
        b=JoVt9S6mqmKRpQX3WUvX2ji33Gyq3iW7c7YzWozvASy+AmlXOgFeHqFW9rB/yH1Hnq
         er8Dz7nVWEP8NlRtCKAN7XGRLF/WdnwLCumsI7oSSQ2iHsNSNy2NlO+PHIc5FwqtorJS
         gMbcGhj8sPktB0UjStCpkSa/7GVfLzp2gGI07H3ooHuqGNW37uj3LLEAexYbTJemgjec
         ljczRCgfKAI68ld43uo+G4ppIx8Mozc1Pcct2qd8Rx3Tq9hyA6i/S1e14uGbpg/6hTTL
         HzAE94aVaeL4ydppixJc23EIiBbt7Z6c26aRheuR3LcVUR/nvzJ+hwqy7zZjZ9+450ie
         +lmA==
X-Received: by 10.66.153.80 with SMTP id ve16mr19154266pab.143.1403770492854;
        Thu, 26 Jun 2014 01:14:52 -0700 (PDT)
Received: from [127.0.0.1] ([117.251.76.15])
        by mx.google.com with ESMTPSA id xk3sm8715981pbb.65.2014.06.26.01.14.47
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 01:14:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cTStpB09Fh3bAF2NcdWR9W_UMaL5qutvUuQNfEL4=GwNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252489>



On 6/25/2014 12:39 PM, Eric Sunshine wrote:
> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>> Use git_config_get_string instead of git_config to take advantage of
>> the config hash-table api which provides a cleaner control flow.
> 
> You may want to mention as a side-note the slight behavior change
> introduced by this patch. The original code complained about any
> unknown boolean "imap.*" key, whereas the new code does not.
> 

Also, my code is error prone. Previous one had all NULL values returned
as config_non_boolean. But, now I have to add a NULL check to every strdup
in the code.

More below,

> 
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  imap-send.c | 68 ++++++++++++++++++++++++++-----------------------------------
>>  1 file changed, 29 insertions(+), 39 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 83a6ed2..87bd418 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -1326,47 +1326,37 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
>>
>>  static char *imap_folder;
>>
>> -static int git_imap_config(const char *key, const char *val, void *cb)
>> +static void git_imap_config(void)
>>  {
>> -       char imap_key[] = "imap.";
>> -
>> -       if (strncmp(key, imap_key, sizeof imap_key - 1))
>> -               return 0;
>> -
>> -       key += sizeof imap_key - 1;
>> -
>> -       /* check booleans first, and barf on others */
>> -       if (!strcmp("sslverify", key))
>> -               server.ssl_verify = git_config_bool(key, val);
>> -       else if (!strcmp("preformattedhtml", key))
>> -               server.use_html = git_config_bool(key, val);
>> -       else if (!val)
>> -               return config_error_nonbool(key);
>> -
>> -       if (!strcmp("folder", key)) {
>> -               imap_folder = xstrdup(val);
>> -       } else if (!strcmp("host", key)) {
>> -               if (starts_with(val, "imap:"))
>> -                       val += 5;
>> -               else if (starts_with(val, "imaps:")) {
>> -                       val += 6;
>> +       const char *value;
> 
> Observation: If you name this variable 'val', which is the name of the
> argument to the function in the original code, you will get a slightly
> smaller and more readable diff. 

Noted.

> 
>> +       if (!git_config_get_string("imap.sslverify", &value))
>> +               server.ssl_verify = git_config_bool("sslverify", value);
> 
> I realize that you are just replicating the behavior of the original
> code, but the error message emitted here for a non-bool value is less
> than desirable since it throws away context (namely, the "imap."
> prefix). You can improve the message, and help the user resolve the
> error more quickly, by presenting the full configuration key (namely,
> "imap.sslverify"). Such a change would deserve mention in the commit
> message. Alternately, it could be fixed in a follow-up patch.
> 

Yes, I thought so also when writing the patch. Will change it in the next
iteration.

Thanks.
Tanay Abhra.

>> +       if (!git_config_get_string("imap.preformattedhtml", &value))
>> +               server.use_html = git_config_bool("preformattedhtml", value);
> 
> Ditto regarding error message: "imap.preformattedhtml"
> 
>> +       if (!git_config_get_string("imap.folder", &value))
>> +               imap_folder = xstrdup(value);
>> +       if (!git_config_get_string("imap.host", &value)) {
>> +               if (starts_with(value, "imap:"))
>> +                       value += 5;
>> +               else if (starts_with(value, "imaps:")) {
>> +                       value += 6;
>>                         server.use_ssl = 1;
>>                 }
>> -               if (starts_with(val, "//"))
>> -                       val += 2;
>> -               server.host = xstrdup(val);
>> -       } else if (!strcmp("user", key))
>> -               server.user = xstrdup(val);
>> -       else if (!strcmp("pass", key))
>> -               server.pass = xstrdup(val);
>> -       else if (!strcmp("port", key))
>> -               server.port = git_config_int(key, val);
>> -       else if (!strcmp("tunnel", key))
>> -               server.tunnel = xstrdup(val);
>> -       else if (!strcmp("authmethod", key))
>> -               server.auth_method = xstrdup(val);
>> -
>> -       return 0;
>> +               if (starts_with(value, "//"))
>> +                       value += 2;
>> +               server.host = xstrdup(value);
>> +       }
>> +       if (!git_config_get_string("imap.user", &value))
>> +               server.user = xstrdup(value);
>> +       if (!git_config_get_string("imap.pass", &value))
>> +               server.pass = xstrdup(value);
>> +       if (!git_config_get_string("imap.port", &value))
>> +               server.port = git_config_int("port", value);
> 
> Same regarding diagnostic: "imap.port"
> 
>> +       if (!git_config_get_string("imap.tunnel", &value))
>> +               server.tunnel = xstrdup(value);
>> +       if (!git_config_get_string("imap.authmethod", &value))
>> +               server.auth_method = xstrdup(value);
>>  }
>>
>>  int main(int argc, char **argv)
>> @@ -1387,7 +1377,7 @@ int main(int argc, char **argv)
>>                 usage(imap_send_usage);
>>
>>         setup_git_directory_gently(&nongit_ok);
>> -       git_config(git_imap_config, NULL);
>> +       git_imap_config();
>>
>>         if (!server.port)
>>                 server.port = server.use_ssl ? 993 : 143;
>> --
>> 1.9.0.GIT
> 
