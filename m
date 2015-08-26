From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Thu, 27 Aug 2015 00:44:44 +0530
Message-ID: <CAOLa=ZS3Fj8EFMp+BXEomeW2PfkBJemoO2-8Tv=RBRb9xGmEyw@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <vpqzj1hkc5q.fsf@anie.imag.fr> <xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
 <xmqqy4h01egr.fsf@gitster.dls.corp.google.com> <CAOLa=ZQwW9hpg4p8+DE2oZA28Av7mLrqAhEdcro=esuqHe35Xg@mail.gmail.com>
 <xmqqzj1fxjpj.fsf@gitster.dls.corp.google.com> <CAOLa=ZSu7XyZhWUL=25dnkiGm2mNDyFhXwS_JqudyfKPE5sisQ@mail.gmail.com>
 <xmqq6142w1xf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 21:15:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUgAM-0005z2-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 21:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbbHZTPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 15:15:16 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34711 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbHZTPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 15:15:15 -0400
Received: by oiex83 with SMTP id x83so1111788oie.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W3B69rpIGRrb0ANbqrQ+1ko3DLnPq4M+4LtdpPMkXDc=;
        b=LIzvyxZTVUP0waTjF06bcPSPdFpbstk+spC85Vse413tf6hUf2MEFDn59n0YYI6PMs
         cXeqSX8lxhxnTx3muVPCk2mwEw1GxxIK2bBEjjP+KitcTaFagOfvhNzFaY5oDLeMT85W
         spd4/hvhAhBWZJMHV3KJvpwMJ1nuanSPzsoeggJia42vO+pFB9nfbgsddU6ozq8mes7Z
         KxKWQ9tJHToEC6epZPMf2+43Ma7tmA9NFYFPOJAzwPjjeoE8x/q9GDqmRQvlPV53Yz89
         y3DdZz5t6nsdRktDIS3BtRu63eFfXaG3xAzFQ1ZwXybkYlm3VGlwydUsRM/LVpp0hXjp
         9SMA==
X-Received: by 10.202.200.75 with SMTP id y72mr32425857oif.111.1440616514237;
 Wed, 26 Aug 2015 12:15:14 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 26 Aug 2015 12:14:44 -0700 (PDT)
In-Reply-To: <xmqq6142w1xf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276625>

On Wed, Aug 26, 2015 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Aug 26, 2015 at 12:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>> I didn't check how wide the original is supposed to be, but perhaps
>>> changing builtin/tag.c this way
>>>
>>>                 if (filter->lines)
>>> -                       format = "%(align:16,left)%(refname:short)%(end)";
>>> +                       format = "%(align:15,left)%(refname:short)%(end) ";
>>>                 else
>>>                         format = "%(refname:short)";
>>>         }
>>>
>>> may be one way to fix it.  Check the original "tag -l" output for
>>> tags whose names are 14, 15, 16 and 17 display-columns wide and try
>>> to match it.
>>
>> That should be the fix, since it's a space problem.
>> ....
>> The problem with doing this is, the lines need to be displayed
>> immediately after  the refname,
>> followed by a newline, what you're suggesting breaks that flow.
>
> That is only because show_ref_array_item() does too much.  The
> function is given a placeholder string and a set of data to fill the
> placeholder with for an item, and the reason why the caller
> repeatedly calls it, once per item it has, is because it wants to
> produce a one-line-per-item output.  An alternative valid way to
> structure the API is to have it format into a string and leave the
> printing to the caller.  You can give a new format_ref_array_item()
> that does not print but fills a strbuf to this caller, make
> show_ref_array_item() a thin wrapper that calls it and prints it
> with the final LF for other callers.
>
> Another alternate approach, if you want to give "tag -l" annotation
> available to for-each-ref, would be to do this:
>
>        if (filter->lines)
>                format = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) "
>                                 "%%(contents:lines=%s)", filter->lines);
>        else
>                format = "%(refname:short)";
>
> and teach a new %(contents:lines=1) atom.  That way, you can lose
> the ugly special case call to show_tag_lines() that can only be at
> the end of the output.  I somehow think this is a better approach.
>

This seems like a good approach, since contents is already an atom, this would
fit in easily.

> Of course you can (and probably would want to) do both, giving a
> bit lower level "emit to a strbuf" function to the callers _and_
> losing hardcoded call to show_tag_lines().

You're saying remove show_ref_array_item() (even the wrapper you mentioned
above) and just have something like format_ref_array_item() which
would output to a strbuf. and let the caller worry about the printing?

-- 
Regards,
Karthik Nayak
