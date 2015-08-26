From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Wed, 26 Aug 2015 11:26:58 +0530
Message-ID: <CAOLa=ZSu7XyZhWUL=25dnkiGm2mNDyFhXwS_JqudyfKPE5sisQ@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <vpqzj1hkc5q.fsf@anie.imag.fr> <xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
 <xmqqy4h01egr.fsf@gitster.dls.corp.google.com> <CAOLa=ZQwW9hpg4p8+DE2oZA28Av7mLrqAhEdcro=esuqHe35Xg@mail.gmail.com>
 <xmqqzj1fxjpj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 07:57:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUTiP-0004n4-2m
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 07:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbbHZF53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 01:57:29 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:32862 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbbHZF52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 01:57:28 -0400
Received: by oieu205 with SMTP id u205so44922533oie.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 22:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2/bnk+CF19K63iCWQkwBZDUFdxg5QF8Pfq2U1LxXCW8=;
        b=IlwZLEKomPQrMhRNp2aKtaL3cRDS963fiGjmJegTKP24/bsODbDpHdKhmk0vJjezZO
         xYX0dzzzjav9H9VlORFP9iaM0lUSoOYiTtVqwH31rTfzZ9poZKwoA0PTkS644ydqgZNu
         Y7mQCCKe9KnwnjCKZTXOk3fwdpWrxRrTzfA3mzeMN8MGV2LcL2girtCvgeiX+qXgX3lN
         16B41j4vAgFjQZRjFRbjRCqNDkQw4+jEbh1Um5GFR3AHERAFKflpIhiwKxAWd0NKb/5q
         WIfBtkfEK4XBei+Qj/iY5kXZRUNuDs6zASBO1AhZGRJt7e1lN3EQoGGj2SxdNCSs0E98
         isGg==
X-Received: by 10.202.105.133 with SMTP id e127mr29908586oic.60.1440568648063;
 Tue, 25 Aug 2015 22:57:28 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 22:56:58 -0700 (PDT)
In-Reply-To: <xmqqzj1fxjpj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276595>

On Wed, Aug 26, 2015 at 12:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> Here is what I see...
>>>
>>> ok 98 - verifying rfc1991 signature
>>>
>>> expecting success:
>>>         echo "rfc1991" >gpghome/gpg.conf &&
>>>         echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
>>>         git tag -l -n1 rfc1991-signed-tag >actual &&
>>>         test_cmp expect actual &&
>>>         git tag -l -n2 rfc1991-signed-tag >actual &&
>>>         test_cmp expect actual &&
>>>         git tag -l -n999 rfc1991-signed-tag >actual &&
>>>         test_cmp expect actual
>>>
>>> --- expect      2015-08-24 22:54:44.607272653 +0000
>>> +++ actual      2015-08-24 22:54:44.611272643 +0000
>>> @@ -1 +1 @@
>>> -rfc1991-signed-tag RFC1991 signed tag
>>> +rfc1991-signed-tagRFC1991 signed tag
>>> not ok 99 - list tag with rfc1991 signature
>>
>> Thats weird, I just ran all tests, and nothing failed.
>
> You may be missing GPG or RFC1991 prerequisites and not running this
> particular test, which could be why you missed it.
>

That explains.

> Your builtin/tag.c calls show_ref_array_item() with
>
>         "%(align:16,left)%(refname:short)%(end)"
>
> as the format, and "rfc1991-signed-tag" is longer than 16.
>
> And immediately after showing that, there is this hack at the end of
> show_ref_array_item() function, which I _think_ should not be there
> in ref-filter.c:show_ref_array_item() in the first place.
>
>         if (lines > 0) {
>                 struct object_id oid;
>                 hashcpy(oid.hash, info->objectname);
>                 show_tag_lines(&oid, lines);
>         }
>
> This belongs to the caller who knows that it is dealing with a tag.
>

Explained the idea behind this below.

> But that broken design aside, the reason why this breaks is because
> you do not have a separating SP after the aligned short refs.
>

Makes sense.

> I didn't check how wide the original is supposed to be, but perhaps
> changing builtin/tag.c this way
>
>                 if (filter->lines)
> -                       format = "%(align:16,left)%(refname:short)%(end)";
> +                       format = "%(align:15,left)%(refname:short)%(end) ";
>                 else
>                         format = "%(refname:short)";
>         }
>
> may be one way to fix it.  Check the original "tag -l" output for
> tags whose names are 14, 15, 16 and 17 display-columns wide and try
> to match it.
>

That should be the fix, since it's a space problem.

> And then move the tag-specific code at the end of
> show_ref_array_item() to here:
>
>         verify_ref_format(format);
>         filter_refs(&array, filter, FILTER_REFS_TAGS);
>         ref_array_sort(sorting, &array);
>
> -       for (i = 0; i < array.nr; i++)
> +       for (i = 0; i < array.nr; i++) {
>                 show_ref_array_item(array.items[i], format, QUOTE_NONE, filter->lines);
> +               if (lines) {
> +                       struct object_id oid;
> +                       hashcpy(oid.hash, info->objectname);
> +                       show_tag_lines(&oid, lines);
> +               }
> +       }
>
> perhaps.

The problem with doing this is, the lines need to be displayed
immediately after  the refname,
followed by a newline, what you're suggesting breaks that flow.

We could pass a boolean to show_ref_array_item() and print a newline if no
lines are to be printed and probably print the newline in tag.c
itself, but seems confusing to me.


> Heh, I did it myself.  %(align:15) with trailing whitespace is what
> you want.
>
> An alternative way to spell it would be
>
>     "%(align:16,left)%(refname:short) %(end)"
>
> I don't know which one is more readable, though.

I find this more readable, since the space is clearly visible, unlike
format = "%(align:15,left)%(refname:short)%(end) "; in which the space
after %(end) is easily unnoticeable.

-- 
Regards,
Karthik Nayak
