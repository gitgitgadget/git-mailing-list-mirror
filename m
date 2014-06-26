From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [RFC/PATCH] notes-util.c: replace git_config with git_config_get_string
Date: Thu, 26 Jun 2014 13:49:26 +0530
Message-ID: <53ABD78E.3050800@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-4-git-send-email-tanayabh@gmail.com> <CAPig+cRcbamkpeaoCMQ9yXtYeMEEL-ve--VWKg4MAWeS08Lqyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:19:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X04uM-0007Aj-4P
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 10:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbaFZITp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 04:19:45 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51882 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbaFZITn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 04:19:43 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so2871805pab.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=RPdCCDwOqcjMtvMh2Jwp+62Z+wOg6eDnCoRUxqvPHKY=;
        b=AIL/MSPQK6afK5FJXjbSkWO04RLElShMSfbCyZbbqTe8ROyakVoNJZ41T/9Ro+rHcH
         Qb+v2bXmvwbgaryTLDfOHmMxxnR/YM/6IJZLXZwK0vyazub+JrRU2vqwKJjICdeEI3Pb
         HT7hloXcO23ZXmavgxMbnDwTnJjChyeC+4Cb18yERi2EvadGEAYHGlLgSTeKED5yXwMH
         qL6NTzbE5XDHydu7zFQSbhPqHJTcYagqk+BXbUBbbhZ6xMRw7Ud1Ulcl8dTwlVpce5Yi
         IVNV9MZFqGAm8Oc98gYpD9HpTo7iC12pX28g/eGxugcv6HvSTMECZ0feW0MaNwQWTie0
         B++w==
X-Received: by 10.66.142.42 with SMTP id rt10mr19245038pab.1.1403770782807;
        Thu, 26 Jun 2014 01:19:42 -0700 (PDT)
Received: from [127.0.0.1] ([117.251.76.15])
        by mx.google.com with ESMTPSA id mj9sm5739488pab.20.2014.06.26.01.19.33
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 01:19:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cRcbamkpeaoCMQ9yXtYeMEEL-ve--VWKg4MAWeS08Lqyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252490>



On 6/25/2014 1:24 PM, Eric Sunshine wrote:
> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>> Use git_config_get_string instead of git_config to take advantage of
>> the config hash-table api which provides a cleaner control flow.
>>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  notes-utils.c | 31 +++++++++++++++----------------
>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/notes-utils.c b/notes-utils.c
>> index a0b1d7b..fdc9912 100644
>> --- a/notes-utils.c
>> +++ b/notes-utils.c
>> @@ -68,22 +68,23 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
>>                 return NULL;
>>  }
>>
>> -static int notes_rewrite_config(const char *k, const char *v, void *cb)
>> +static void notes_rewrite_config(struct notes_rewrite_cfg *c)
>>  {
>> -       struct notes_rewrite_cfg *c = cb;
>> -       if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
>> -               c->enabled = git_config_bool(k, v);
>> -               return 0;
>> -       } else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
>> +       struct strbuf key = STRBUF_INIT;
>> +       const char *v;
>> +       strbuf_addf(&key, "notes.rewrite.%s", c->cmd);
>> +
>> +       if (!git_config_get_string(key.buf, &v))
>> +               c->enabled = git_config_bool(key.buf, v);
>> +
>> +       if (!c->mode_from_env && !git_config_get_string("notes.rewritemode", &v)) {
>>                 if (!v)
>> -                       return config_error_nonbool(k);
>> +                       config_error_nonbool("notes.rewritemode");
> 
> There's a behavior change here. In the original code, the callback
> function would return -1, which would cause the program to die() if
> the config.c:die_on_error flag was set. The new code merely emits an
> error.
> 

Is this change serious enough? Can I ignore it?

>>                 c->combine = parse_combine_notes_fn(v);
> 
> Worse: Though you correctly emit an error when 'v' is NULL, you then
> (incorrectly) invoke parse_combine_notes_fn() with that NULL value,
> which will result in a crash.
> 

Noted.

>> -               if (!c->combine) {
>> +               if (!c->combine)
>>                         error(_("Bad notes.rewriteMode value: '%s'"), v);
>> -                       return 1;
>> -               }
>> -               return 0;
>> -       } else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
>> +       }
>> +       if (!c->refs_from_env && !git_config_get_string("notes.rewriteref", &v)) {
>>                 /* note that a refs/ prefix is implied in the
>>                  * underlying for_each_glob_ref */
>>                 if (starts_with(v, "refs/notes/"))
>> @@ -91,10 +92,8 @@ static int notes_rewrite_config(const char *k, const char *v, void *cb)
>>                 else
>>                         warning(_("Refusing to rewrite notes in %s"
>>                                 " (outside of refs/notes/)"), v);
>> -               return 0;
>>         }
>> -
>> -       return 0;
>> +       strbuf_release(&key);
> 
> It would be better to release the strbuf immediately after its final
> use rather than waiting until the end of function. Not only does that
> reduce cognitive load on people reading the code, but it also reduces
> likelihood of 'key' being leaked if some future programmer inserts an
> early 'return' into the function for some reason.
> 

Noted. Thanks.

>>  }
>>
>>
>> @@ -123,7 +122,7 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
>>                 c->refs_from_env = 1;
>>                 string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
>>         }
>> -       git_config(notes_rewrite_config, c);
>> +       notes_rewrite_config(c);
>>         if (!c->enabled || !c->refs->nr) {
>>                 string_list_clear(c->refs, 0);
>>                 free(c->refs);
>> --
>> 1.9.0.GIT
> 
