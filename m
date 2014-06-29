From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] notes-util.c: replace git_config with git_config_get_string
Date: Sun, 29 Jun 2014 07:01:31 -0400
Message-ID: <CAPig+cSRBk5Q2amvFXyjH4dpoP83qbYUEUizE7v38Wh8Ofnfpw@mail.gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-4-git-send-email-tanayabh@gmail.com>
	<CAPig+cRcbamkpeaoCMQ9yXtYeMEEL-ve--VWKg4MAWeS08Lqyg@mail.gmail.com>
	<53ABD78E.3050800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 13:01:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1CrY-0001SE-P1
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 13:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbaF2LBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 07:01:33 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:64447 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbaF2LBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 07:01:31 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so4177577yho.16
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GSCyGpWwIz9kxIa3j2XqNurfkc5KwafFzijDfmqrR1w=;
        b=CBou3AOtxjiCPomaqeBqi+cv0ECfXCqet6deScbL8UqHh/OzUEMdZE3s/T1UuvDL1+
         tlXo55raGRuxSeMf0h4nekLcUiUjz6AK4NRMDXRihg2WSQYyJa1WFydgsDcro2oYNKtl
         0aBjaXqhuSHa6jALmXek8rDtSqj75MXxvhGHIrv+JZz5HBQISypRA0pilucWii6RA5Fe
         b0Fa9mIQYTPt0pqdQASmaudzKDURYHu/Zp19Zo2EKDzCF0lm066yoBnfWqYFSNFspX6E
         DFiRPfRKOM7wBh9i08+4tNmpWmg5ucGdW9iRmmLfvCME2hhIrcJoMifKIqpY5yZcWfTj
         mOMQ==
X-Received: by 10.236.131.42 with SMTP id l30mr1543206yhi.130.1404039691255;
 Sun, 29 Jun 2014 04:01:31 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Sun, 29 Jun 2014 04:01:31 -0700 (PDT)
In-Reply-To: <53ABD78E.3050800@gmail.com>
X-Google-Sender-Auth: W17VK3RAC0p5UgViMloPeqwKho0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252637>

On Thu, Jun 26, 2014 at 4:19 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> On 6/25/2014 1:24 PM, Eric Sunshine wrote:
>> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>> Use git_config_get_string instead of git_config to take advantage of
>>> the config hash-table api which provides a cleaner control flow.
>>>
>>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>>> ---
>>>  notes-utils.c | 31 +++++++++++++++----------------
>>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/notes-utils.c b/notes-utils.c
>>> index a0b1d7b..fdc9912 100644
>>> --- a/notes-utils.c
>>> +++ b/notes-utils.c
>>> @@ -68,22 +68,23 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
>>>                 return NULL;
>>>  }
>>>
>>> -static int notes_rewrite_config(const char *k, const char *v, void *cb)
>>> +static void notes_rewrite_config(struct notes_rewrite_cfg *c)
>>>  {
>>> -       struct notes_rewrite_cfg *c = cb;
>>> -       if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
>>> -               c->enabled = git_config_bool(k, v);
>>> -               return 0;
>>> -       } else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
>>> +       struct strbuf key = STRBUF_INIT;
>>> +       const char *v;
>>> +       strbuf_addf(&key, "notes.rewrite.%s", c->cmd);
>>> +
>>> +       if (!git_config_get_string(key.buf, &v))
>>> +               c->enabled = git_config_bool(key.buf, v);
>>> +
>>> +       if (!c->mode_from_env && !git_config_get_string("notes.rewritemode", &v)) {
>>>                 if (!v)
>>> -                       return config_error_nonbool(k);
>>> +                       config_error_nonbool("notes.rewritemode");
>>
>> There's a behavior change here. In the original code, the callback
>> function would return -1, which would cause the program to die() if
>> the config.c:die_on_error flag was set. The new code merely emits an
>> error.
>
> Is this change serious enough? Can I ignore it?

I don't know. Even within this single function there is no consistency
about whether such problems should die() or just emit a message and
continue. For instance:

- if "notes.rewritemode" is bool, it die()s.

- if "notes.rewritemode" doesn't specify a recognized mode, it
error()s but continues

- if "notes.rewriteref" doesn't start with "refs/notes/, it warning()s
and continues

It would be nice to hear an opinion from someone more invested in the
config system.

>>>                 c->combine = parse_combine_notes_fn(v);
>>
>> Worse: Though you correctly emit an error when 'v' is NULL, you then
>> (incorrectly) invoke parse_combine_notes_fn() with that NULL value,
>> which will result in a crash.
>>
>
> Noted.
>
>>> -               if (!c->combine) {
>>> +               if (!c->combine)
>>>                         error(_("Bad notes.rewriteMode value: '%s'"), v);
>>> -                       return 1;
>>> -               }
>>> -               return 0;
>>> -       } else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
>>> +       }
>>> +       if (!c->refs_from_env && !git_config_get_string("notes.rewriteref", &v)) {
>>>                 /* note that a refs/ prefix is implied in the
>>>                  * underlying for_each_glob_ref */
>>>                 if (starts_with(v, "refs/notes/"))
>>> @@ -91,10 +92,8 @@ static int notes_rewrite_config(const char *k, const char *v, void *cb)
>>>                 else
>>>                         warning(_("Refusing to rewrite notes in %s"
>>>                                 " (outside of refs/notes/)"), v);
>>> -               return 0;
>>>         }
>>> -
>>> -       return 0;
>>> +       strbuf_release(&key);
>>
>> It would be better to release the strbuf immediately after its final
>> use rather than waiting until the end of function. Not only does that
>> reduce cognitive load on people reading the code, but it also reduces
>> likelihood of 'key' being leaked if some future programmer inserts an
>> early 'return' into the function for some reason.
>>
>
> Noted. Thanks.
>
>>>  }
>>>
>>>
>>> @@ -123,7 +122,7 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
>>>                 c->refs_from_env = 1;
>>>                 string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
>>>         }
>>> -       git_config(notes_rewrite_config, c);
>>> +       notes_rewrite_config(c);
>>>         if (!c->enabled || !c->refs->nr) {
>>>                 string_list_clear(c->refs, 0);
>>>                 free(c->refs);
>>> --
>>> 1.9.0.GIT
>>
