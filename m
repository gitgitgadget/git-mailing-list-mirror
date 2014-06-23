From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/7] determine_author_info: stop leaking name/email
Date: Mon, 23 Jun 2014 05:48:45 -0400
Message-ID: <CAPig+cRfTrUgJPV781zyV+m5gbYM9f2z+t=gfTU7grUDtX0mxA@mail.gmail.com>
References: <20140618201944.GA23238@sigill.intra.peff.net>
	<20140618203609.GG23896@sigill.intra.peff.net>
	<CAPig+cT7mAGaGXZHNEWvZ31acth2wooexZ5s7wWFrJ40rBviYw@mail.gmail.com>
	<CABPQNSaqGaCnE7jY6yj_0m8iHpU2Y5rt9wAHW=sM_oH9r1qTzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 11:49:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz0rr-0005Rv-7L
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 11:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbaFWJsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 05:48:47 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36145 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbaFWJsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 05:48:46 -0400
Received: by mail-yk0-f177.google.com with SMTP id 10so4601605ykt.36
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FAszes1B84EGPiK1GYSDqmd82vsrLcgI1Hn9vRMDwXA=;
        b=M/1/FXN9ZmJzv7tSC1Wl8K2yqFEWeWsNPMnk88Ba+xEn+6MZGcTmXh86nQzn2wGj/k
         RRKAbT19Salkw29qxi87NWd81ktxjyyndNVe4guc8WLiILNs9+bwTAWyEyGJVOjkaV6L
         6FoUiZjnpwaczqLK7Ae7gS/jebWbyJYbVivMFt/sQYZtbuAO/rzX6dKLkWIoZJoYQ7Z0
         4QCEgYcVppYdsg02ErvMlNApyh6/x2ZdrFbs79jMX2+71Fmr0kh+f6xWfrAutIqfJKwj
         bCNwyhy+hLthDwHlFmfG9VpJuJ8mq3jbMRPCtdSdffHcOqhQxHbbRmUsih/Pikw0gCKa
         xeKQ==
X-Received: by 10.236.134.169 with SMTP id s29mr32891686yhi.4.1403516925914;
 Mon, 23 Jun 2014 02:48:45 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Mon, 23 Jun 2014 02:48:45 -0700 (PDT)
In-Reply-To: <CABPQNSaqGaCnE7jY6yj_0m8iHpU2Y5rt9wAHW=sM_oH9r1qTzA@mail.gmail.com>
X-Google-Sender-Auth: dl1hQZVZV1fG44i9e3XDD9lcQaQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252328>

On Mon, Jun 23, 2014 at 5:33 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Mon, Jun 23, 2014 at 11:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jun 18, 2014 at 4:36 PM, Jeff King <peff@peff.net> wrote:
>>> When we get the author name and email either from an
>>> existing commit or from the "--author" option, we create a
>>> copy of the strings. We cannot just free() these copies,
>>> since the same pointers may also be pointing to getenv()
>>> storage which we do not own.
>>>
>>> Instead, let's treat these the same way as we do the date
>>> buffer: keep a strbuf to be released, and point the bare
>>> pointers at the strbuf.
>>>
>>> Signed-off-by: Jeff King <peff@peff.net>
>>> ---
>>>  builtin/commit.c | 20 +++++++++++++-------
>>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/builtin/commit.c b/builtin/commit.c
>>> index 62abee0..72beb7f 100644
>>> --- a/builtin/commit.c
>>> +++ b/builtin/commit.c
>>> @@ -546,16 +546,20 @@ static void strbuf_add_pair(struct strbuf *buf, const struct pointer_pair *p)
>>>         strbuf_add(buf, p->begin, p->end - p->begin);
>>>  }
>>>
>>> -static char *xmemdupz_pair(const struct pointer_pair *p)
>>> +static char *set_pair(struct strbuf *buf, struct pointer_pair *p)
>>>  {
>>> -       return xmemdupz(p->begin, p->end - p->begin);
>>> +       strbuf_reset(buf);
>>> +       strbuf_add_pair(buf, p);
>>> +       return buf->buf;
>>>  }
>>>
>>>  static void determine_author_info(struct strbuf *author_ident)
>>>  {
>>>         char *name, *email, *date;
>>>         struct ident_split author;
>>> -       struct strbuf date_buf = STRBUF_INIT;
>>> +       struct strbuf name_buf = STRBUF_INIT,
>>> +                     mail_buf = STRBUF_INIT,
>>
>> nit: The associated 'char *' variable is named "email", so perhaps
>> s/mail_buf/email_buf/g
>>
>>> +                     date_buf = STRBUF_INIT;
>>>
>>>         name = getenv("GIT_AUTHOR_NAME");
>>>         email = getenv("GIT_AUTHOR_EMAIL");
>>> @@ -572,8 +576,8 @@ static void determine_author_info(struct strbuf *author_ident)
>>>                 if (split_ident_line(&ident, a, len) < 0)
>>>                         die(_("commit '%s' has malformed author line"), author_message);
>>>
>>> -               name = xmemdupz_pair(&ident.name);
>>> -               email = xmemdupz_pair(&ident.mail);
>>> +               name = set_pair(&name_buf, &ident.name);
>>> +               email = set_pair(&mail_buf, &ident.mail);
>>>                 if (ident.date.begin) {
>>>                         strbuf_reset(&date_buf);
>>>                         strbuf_addch(&date_buf, '@');
>>> @@ -589,8 +593,8 @@ static void determine_author_info(struct strbuf *author_ident)
>>>
>>>                 if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
>>>                         die(_("malformed --author parameter"));
>>> -               name = xmemdupz_pair(&ident.name);
>>> -               email = xmemdupz_pair(&ident.mail);
>>> +               name = set_pair(&name_buf, &ident.name);
>>> +               email = set_pair(&mail_buf, &ident.mail);
>>
>> Does the code become too convoluted with these changes? You're now
>> maintaining three 'char *' variables in parallel with three strbuf
>> variables. Is it possible to drop the 'char *' variables and just pass
>> the .buf member of the strbufs to fmt_ident()?
>>
>> Alternately, you also could solve the leaks by having an envdup() helper:
>>
>>     static char *envdup(const char *s)
>>     {
>>         const char *v = getenv(s);
>>         return v ? xstrdup(v) : NULL;
>>     }
>>
>>     ...
>>     name = envdup("GIT_AUTHOR_NAME");
>>     email = envdup("GIT_AUTHOR_EMAIL");
>>     ...
>>
>> And then just free() 'name' and 'email' normally.
>
> This approach has the added benefit of fixing the case where getenv
> uses a static buffer, like POSIX allows.

That reminds me that I was going to suggest a suitable variation of
envdup if Peff wanted to keep the strbufs:

    static void strbuf_env(struct strbuf *s, const char *e)
    {
        const char *v = getenv(e);
        if (v)
            strbuf_add(s, v);
    }

(Or add a generalized strbuf_add_gently() to strbuf.{h,c}, if it seems
likely to come up more often, which would allow
strbuf_add_gently(&name_buf, getenv("GIT_AUTHOR_NAME")) -- with a
better name than "gently", of course.)
