From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 3 Sep 2015 19:04:25 +0530
Message-ID: <CAOLa=ZRiGg1snfsi_mxQYq-wV6Zz4cTkxum47dRowp1XopQejw@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-8-git-send-email-Karthik.188@gmail.com> <vpq8u8ptcjq.fsf@anie.imag.fr>
 <CAOLa=ZTB_uMvKjU=f9UgmvOmeZD4YtFL_Gv1+VvZAgDV-6WYDA@mail.gmail.com> <vpq7fo8ol7i.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 03 15:35:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXUfM-0000Gl-1R
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 15:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbbICNe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 09:34:56 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34727 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbbICNez (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 09:34:55 -0400
Received: by obcts10 with SMTP id ts10so32376486obc.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=63JBrJnNC7Lv3+vlxV6lFLjR+PzXKc6jut7DDyD7VMc=;
        b=WAH6+3gH23HE8zO52HxpzDj5HAbO5Dk9fKbYylGYwks0Hj5r//YaTPKt1GXHMJMG1e
         k+7WbGabGB97GKiA/AEIK2ALD71pUdf1Gunr3UWBBkbBEJ9wLWpsfb0L3CzRZQKDuZuA
         5vEcBo9wdFN41U7fjbxjGojeu+7YYCA8aZynBqIzQ7dWGwimun9fzcNBFVl5A19G3G2l
         DBe+QCFCnsq8Cc/3ceppvL6SYcxDwBPfUxKk+rg25m1jK87vD8wyPUNv/kvkMhwBbPXK
         8sqz5pQ84gEWA7zE5ZvQzQp1RzsXlxwKjm7jIYSGPCvir6O6oraA5kVMUIKOHnqKpnYA
         A1gw==
X-Received: by 10.60.65.68 with SMTP id v4mr25464423oes.84.1441287294667; Thu,
 03 Sep 2015 06:34:54 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 3 Sep 2015 06:34:25 -0700 (PDT)
In-Reply-To: <vpq7fo8ol7i.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277202>

On Wed, Sep 2, 2015 at 9:41 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Sep 2, 2015 at 2:37 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> --- a/builtin/tag.c
>>>> +++ b/builtin/tag.c
>>>> @@ -185,6 +185,10 @@ static enum contains_result contains(struct commit *candidate,
>>>>       return contains_test(candidate, want);
>>>>  }
>>>>
>>>> +/*
>>>> + * Currently modified and used in ref-filter as append_lines(), will
>>>> + * eventually be removed as we port tag.c to use ref-filter APIs.
>>>> + */
>>>>  static void show_tag_lines(const struct object_id *oid, int lines)
>>>
>>> I would rather have one "cut and paste" patch followed by a "modify and
>>> use" patch for review.
>>>
>>> As-is, reading the patch doesn't tell me what change you did.
>>>
>>> That said, I did get this information in the interdiff, so I won't
>>> insist on that.
>>
>> Its only borrowed slightly, so I don't really see the need for this.
>> But if you insist, we could do that .
>
> As you prefer.
>
> Perhaps just adapt the comment to say "Currently redundant with
> ref-filter'.c's append_line ...", but that's not important.

"Currently modified and used in ref-filter as append_lines()" seems better
as only a part of this is used.

>
>>>> +static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
>>>> +{
>>>> +     int i;
>>>> +     const char *sp, *eol;
>>>> +     size_t len;
>>>> +
>>>> +     if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
>>>> +             size += 2;
>>>
>>> Why is this "size += 2" needed?
>>>
>>
>> We pass size as "sublen + bodylen - siglen" if there exists a "\n\n"
>> between sublen and bodylen this is not accounted for. hence we
>> add 2 here.
>
> That's too much magic for uncommented code. If this is really needed,
> then thes explanations should go in a comment, and I think this logic
> should be moved out of append_lines (if you read the comment above, the
> function, it is actually lying about what the function does).
>
> I think you can simplify this: you know where the buffer ends (bodypos +
> bodylen) and where it starts (subpos), so you know the size: bodypos +
> bodylen - subpos.
>
> IOW, I think you can apply this:
>
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -645,9 +645,6 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
>         const char *sp, *eol;
>         size_t len;
>
> -       if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
> -               size += 2;
> -
>         sp = buf;
>
>         for (i = 0; i < lines && sp < buf + size; i++) {
> @@ -707,7 +704,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>                         struct strbuf s = STRBUF_INIT;
>                         if (strtoul_ui(valp, 10, &v->u.contents.lines))
>                                 die(_("positive width expected contents:lines=%s"), valp);
> -                       append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
> +                       append_lines(&s, subpos, bodypos + bodylen - subpos, v->u.contents.lines);
>                         v->s = strbuf_detach(&s, NULL);
>                 }
>         }
>
> (half-tested only)

It is important, without it we'll be missing characters at the end.

I'll try what you suggested. Looks good, will test :)

-- 
Regards,
Karthik Nayak
