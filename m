From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 7/7] determine_author_info: stop leaking name/email
Date: Mon, 23 Jun 2014 11:33:56 +0200
Message-ID: <CABPQNSaqGaCnE7jY6yj_0m8iHpU2Y5rt9wAHW=sM_oH9r1qTzA@mail.gmail.com>
References: <20140618201944.GA23238@sigill.intra.peff.net> <20140618203609.GG23896@sigill.intra.peff.net>
 <CAPig+cT7mAGaGXZHNEWvZ31acth2wooexZ5s7wWFrJ40rBviYw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 11:34:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz0eB-0001Uj-RP
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 11:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbaFWJei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 05:34:38 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:39190 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbaFWJeg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 05:34:36 -0400
Received: by mail-ig0-f171.google.com with SMTP id h18so2731849igc.4
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=OBlZbvjUvofG18XbJyX07oEobsNqeGcNcQ36peUnXKg=;
        b=TMJ3ibvDZGfBPe9QjYjh3YPnNE2RbglV4vxKAYRSWKHUiIaSGssc3taPAmg1a1mLUW
         7ijUhLf9mPqHjfE7+5N5ZehxB8632FWvSXL+IlLoNO8xZ2sYHkmLY2DMRmiV6Zi2mZJA
         pWugDKNQVQDbHfxDwsn6a1AA1A7KacTbmERffDG3Nq2A01w4JDwm5StUVj7jqORjFUK2
         tHQiJHw6FQFuch9ya1f2yqs0HpcW/JiZGu/9WjbtsXEsTyQwHPGtRODhcradq2bhUV5l
         yfu4QZ1EpjM3Q/sassofHMCk+S3q8uAJOW0YCFOKSbbzMWlWg2ZzMrfUAu2E/pIhzN9i
         JOjw==
X-Received: by 10.50.9.104 with SMTP id y8mr25412770iga.43.1403516076068; Mon,
 23 Jun 2014 02:34:36 -0700 (PDT)
Received: by 10.64.227.43 with HTTP; Mon, 23 Jun 2014 02:33:56 -0700 (PDT)
In-Reply-To: <CAPig+cT7mAGaGXZHNEWvZ31acth2wooexZ5s7wWFrJ40rBviYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252327>

On Mon, Jun 23, 2014 at 11:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 18, 2014 at 4:36 PM, Jeff King <peff@peff.net> wrote:
>> When we get the author name and email either from an
>> existing commit or from the "--author" option, we create a
>> copy of the strings. We cannot just free() these copies,
>> since the same pointers may also be pointing to getenv()
>> storage which we do not own.
>>
>> Instead, let's treat these the same way as we do the date
>> buffer: keep a strbuf to be released, and point the bare
>> pointers at the strbuf.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>  builtin/commit.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 62abee0..72beb7f 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -546,16 +546,20 @@ static void strbuf_add_pair(struct strbuf *buf, const struct pointer_pair *p)
>>         strbuf_add(buf, p->begin, p->end - p->begin);
>>  }
>>
>> -static char *xmemdupz_pair(const struct pointer_pair *p)
>> +static char *set_pair(struct strbuf *buf, struct pointer_pair *p)
>>  {
>> -       return xmemdupz(p->begin, p->end - p->begin);
>> +       strbuf_reset(buf);
>> +       strbuf_add_pair(buf, p);
>> +       return buf->buf;
>>  }
>>
>>  static void determine_author_info(struct strbuf *author_ident)
>>  {
>>         char *name, *email, *date;
>>         struct ident_split author;
>> -       struct strbuf date_buf = STRBUF_INIT;
>> +       struct strbuf name_buf = STRBUF_INIT,
>> +                     mail_buf = STRBUF_INIT,
>
> nit: The associated 'char *' variable is named "email", so perhaps
> s/mail_buf/email_buf/g
>
>> +                     date_buf = STRBUF_INIT;
>>
>>         name = getenv("GIT_AUTHOR_NAME");
>>         email = getenv("GIT_AUTHOR_EMAIL");
>> @@ -572,8 +576,8 @@ static void determine_author_info(struct strbuf *author_ident)
>>                 if (split_ident_line(&ident, a, len) < 0)
>>                         die(_("commit '%s' has malformed author line"), author_message);
>>
>> -               name = xmemdupz_pair(&ident.name);
>> -               email = xmemdupz_pair(&ident.mail);
>> +               name = set_pair(&name_buf, &ident.name);
>> +               email = set_pair(&mail_buf, &ident.mail);
>>                 if (ident.date.begin) {
>>                         strbuf_reset(&date_buf);
>>                         strbuf_addch(&date_buf, '@');
>> @@ -589,8 +593,8 @@ static void determine_author_info(struct strbuf *author_ident)
>>
>>                 if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
>>                         die(_("malformed --author parameter"));
>> -               name = xmemdupz_pair(&ident.name);
>> -               email = xmemdupz_pair(&ident.mail);
>> +               name = set_pair(&name_buf, &ident.name);
>> +               email = set_pair(&mail_buf, &ident.mail);
>
> Does the code become too convoluted with these changes? You're now
> maintaining three 'char *' variables in parallel with three strbuf
> variables. Is it possible to drop the 'char *' variables and just pass
> the .buf member of the strbufs to fmt_ident()?
>
> Alternately, you also could solve the leaks by having an envdup() helper:
>
>     static char *envdup(const char *s)
>     {
>         const char *v = getenv(s);
>         return v ? xstrdup(v) : NULL;
>     }
>
>     ...
>     name = envdup("GIT_AUTHOR_NAME");
>     email = envdup("GIT_AUTHOR_EMAIL");
>     ...
>
> And then just free() 'name' and 'email' normally.

This approach has the added benefit of fixing the case where getenv
uses a static buffer, like POSIX allows.
