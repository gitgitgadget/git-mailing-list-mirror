From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] notes-util.c: replace git_config with git_config_get_string
Date: Mon, 30 Jun 2014 10:32:16 -0400
Message-ID: <CAPig+cSpQ2NS9R-jsUvGFB0Uk5kqwhsFTm3RKhzcx+8FLyQgsw@mail.gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-4-git-send-email-tanayabh@gmail.com>
	<CAPig+cRcbamkpeaoCMQ9yXtYeMEEL-ve--VWKg4MAWeS08Lqyg@mail.gmail.com>
	<53ABD78E.3050800@gmail.com>
	<CAPig+cSRBk5Q2amvFXyjH4dpoP83qbYUEUizE7v38Wh8Ofnfpw@mail.gmail.com>
	<53B16748.8080703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tanay Abhra <tanayabh@gmail.com>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 16:32:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1cd3-0002Fd-P6
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 16:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbaF3OcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 10:32:17 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:63021 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaF3OcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 10:32:17 -0400
Received: by mail-yk0-f172.google.com with SMTP id 142so4695146ykq.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n9BjhDfMj9YWyOVLaawCzWbeHoh0BoCd//7jW3uSzXg=;
        b=rTVS4UiUNsXf7H9EX/8fy4z46umb7yfNFZDTUUZTkx8/MqoSf14YDIUd0PaFBl25gs
         AzTFhRX/6rQIsMo6eJPppepiD7ivt08aGAAIzT9ufcAk6Dv928N5xZG/IhkNGPjvM4Mc
         mr7G8Q/7pZh2CXyss9cqMfRGsQpUcRq09vyOC9mobBRP2cSGyncAhuvopEIoEXjVs0a1
         26RcTaOc46x/BAzOUv5ZLgfWpokN8qU4UQYuHQnaObWW9a4a8MfXqpmmFN16ne2eSq+x
         EBTP5D3nc4tp+rzGjxoXNOIyMkt+IrVd4lZp6aPbzvY+lcMeXYZjPH/ckvkB9MpSzfSU
         /hHA==
X-Received: by 10.236.149.72 with SMTP id w48mr13567627yhj.101.1404138736355;
 Mon, 30 Jun 2014 07:32:16 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Mon, 30 Jun 2014 07:32:16 -0700 (PDT)
In-Reply-To: <53B16748.8080703@gmail.com>
X-Google-Sender-Auth: YP3qbrAOrUMzUCwYzuKeUQfyMhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252671>

On Mon, Jun 30, 2014 at 9:34 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 29.06.2014 13:01, schrieb Eric Sunshine:
>> On Thu, Jun 26, 2014 at 4:19 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>> On 6/25/2014 1:24 PM, Eric Sunshine wrote:
>>>> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>>>> Use git_config_get_string instead of git_config to take advantage of
>>>>> the config hash-table api which provides a cleaner control flow.
>>>>>
>>>>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>>>>> ---
>>>>>  notes-utils.c | 31 +++++++++++++++----------------
>>>>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/notes-utils.c b/notes-utils.c
>>>>> index a0b1d7b..fdc9912 100644
>>>>> --- a/notes-utils.c
>>>>> +++ b/notes-utils.c
>>>>> @@ -68,22 +68,23 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
>>>>>                 return NULL;
>>>>>  }
>>>>>
>>>>> -static int notes_rewrite_config(const char *k, const char *v, void *cb)
>>>>> +static void notes_rewrite_config(struct notes_rewrite_cfg *c)
>>>>>  {
>>>>> -       struct notes_rewrite_cfg *c = cb;
>>>>> -       if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
>>>>> -               c->enabled = git_config_bool(k, v);
>>>>> -               return 0;
>>>>> -       } else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
>>>>> +       struct strbuf key = STRBUF_INIT;
>>>>> +       const char *v;
>>>>> +       strbuf_addf(&key, "notes.rewrite.%s", c->cmd);
>>>>> +
>>>>> +       if (!git_config_get_string(key.buf, &v))
>>>>> +               c->enabled = git_config_bool(key.buf, v);
>>>>> +
>>>>> +       if (!c->mode_from_env && !git_config_get_string("notes.rewritemode", &v)) {
>>>>>                 if (!v)
>>>>> -                       return config_error_nonbool(k);
>>>>> +                       config_error_nonbool("notes.rewritemode");
>>>>
>>>> There's a behavior change here. In the original code, the callback
>>>> function would return -1, which would cause the program to die() if
>>>> the config.c:die_on_error flag was set. The new code merely emits an
>>>> error.
>>>
>>> Is this change serious enough? Can I ignore it?
>
> IMO its better to Fail Fast than continue with some invalid config (which
> may lead to more severe errors such as data corruption / data loss).
>
>>
>> I don't know. Even within this single function there is no consistency
>> about whether such problems should die() or just emit a message and
>> continue. For instance:
>>
>> - if "notes.rewritemode" is bool, it die()s.
>>
>> - if "notes.rewritemode" doesn't specify a recognized mode, it
>> error()s but continues
>>
>
> I think this would also die in git_parse_source():
> ...
>     if (get_value(fn, data, var) < 0)
>       break;
>   }
>   if (cf->die_on_error)
>     die("bad config file line %d in %s", cf->linenr, cf->name);
> ...

One would expect so, but notes-utils.c:notes_rewrite_config() is
actually doing this:

    if (!c->combine) {
        error(_("Bad notes.rewriteMode value: '%s'"), v);
        return 1;
    }

Rather than returning the -1 result of error(), which would make
git_parse_source() die(), it's explicitly returning 1, which
get_parse_source() ignores.

> (AFAICT, die_on_error is always true, except if invoked via 'git-config
> --blob', which isn't used anywhere...)
>
> This, however, raises another issue: switching to the config cache looses
> file/line-precise error reporting for semantic errors. I don't know if
> this feature is important enough to do something about it, though. A
> message of the form "Key 'xyz' is bad" should usually enable a user to
> locate the problematic file and line.
