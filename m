From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the
 presentation layer
Date: Wed, 29 Jul 2015 01:42:10 +0530
Message-ID: <CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
 <vpqbnewxwcx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:12:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBEz-0005aZ-Oj
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbbG1UMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:12:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36588 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbG1UMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:12:40 -0400
Received: by obnw1 with SMTP id w1so92842291obn.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WLNefNcsayf/wS4Bo1YmPLFlqLOEdaIlfFVv1KbP2Vo=;
        b=0HHUiGa5N0gj4ysL3yQFAmUi2jTofiJu0nLqMQA0FZivuKY/FJVTmvgIivjTW+b4WI
         dTdmB9Co5+cs+Ak1AKf4PBWHlh3pvHp8l0ywYN/z8ZjYyAO3vCfxObnEL0rmxdfclTED
         bufXr+Vxz9KCyapeLp0S+MUF+gT2XYP3slcrP23Ww/NdVFdZjjsKjxfVDarKdhQsTrQi
         T67Os3eGc9+tBSMJEdq0vKX61I2Uq/GnW9Wy2w1Hvi4Q323yhHHrzmEw2WLh+KhvBpO7
         j/bOi8G6h3pXwavE9f4TkqT2VyP/e1xIm8+KGgxuFBmWwdKe33CQH6ZZbLxTc+RRAfuN
         5pMg==
X-Received: by 10.60.41.138 with SMTP id f10mr35769720oel.84.1438114360265;
 Tue, 28 Jul 2015 13:12:40 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 13:12:10 -0700 (PDT)
In-Reply-To: <vpqbnewxwcx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274835>

On Tue, Jul 28, 2015 at 6:39 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> We check if given ref is the current branch in print_ref_list().  Move
>> this check to print_ref_item() where it is checked right before
>> printing.
>
> This means that the '*' and the different color are coded in C, hence
> it's not possible to mimick this using "git for-each-ref --format ...".
>
> I do not consider this as blocking, but I think the ultimate goal should
> be to allow this, so that all the goodies of "git branch" can be made
> available to other ref-listing commands.
>

Not sure what you mean here.

>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -534,9 +534,9 @@ static char *get_head_description(void)
>>  }
>>
>>  static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>> -                        int abbrev, int current, const char *remote_prefix)
>> +                        int abbrev, int detached, const char *remote_prefix)
>>  {
>> -     char c;
>> +     char c = ' ';
>>       int color;
>>       struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
>>       const char *prefix = "";
>> @@ -547,7 +547,11 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>>
>>       switch (item->kind) {
>>       case REF_LOCAL_BRANCH:
>> -             color = BRANCH_COLOR_LOCAL;
>> +             if (!detached && !strcmp(item->name, head)) {
>> +                     color = BRANCH_COLOR_CURRENT;
>> +                     c = '*';
>> +             } else
>> +                     color = BRANCH_COLOR_LOCAL;
>>               break;
>>       case REF_REMOTE_BRANCH:
>>               color = BRANCH_COLOR_REMOTE;
>> @@ -556,18 +560,13 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>>       case REF_DETACHED_HEAD:
>>               color = BRANCH_COLOR_CURRENT;
>>               desc = get_head_description();
>> +             c = '*';
>>               break;
>>       default:
>>               color = BRANCH_COLOR_PLAIN;
>>               break;
>>       }
>>
>> -     c = ' ';
>> -     if (current) {
>> -             c = '*';
>> -             color = BRANCH_COLOR_CURRENT;
>> -     }
>
> I actually prefered the old way: current is a Boolean that says
> semantically "this is the current branch", and the Boolean is turned
> into presentation directives in a separate piece of code.
>
> I'd write
>
> char c;
> int current = 0;
>
> ...
>
> if (...)
>         current = 1;
> ...
> case REF_DETACHED_HEAD:
>         current = 1;
> ...
>
> and keep the last hunk.
>
> (IOW, turn current from a parameter into a local variable)
>

Thanks will do this.

-- 
Regards,
Karthik Nayak
