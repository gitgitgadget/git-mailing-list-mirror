From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 00/10] ref-filter: use parsing functions
Date: Sun, 13 Dec 2015 15:01:29 +0530
Message-ID: <CAOLa=ZSEGf7TAKNkYCogw7nz9UMUxEZ7Vg2vGXHqFP2s=tnWcg@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <xmqq1taseh2x.fsf@gitster.mtv.corp.google.com> <CAPig+cQtoUXuOZjGjev8MGYUMyjd+n_=o+jOVXkhPReSkWgxmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 10:32:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a831N-0007QR-J0
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 10:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbbLMJcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 04:32:06 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34543 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbLMJcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 04:32:00 -0500
Received: by vkgj66 with SMTP id j66so42430315vkg.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 01:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=al/HW83aOFT7bgg6Pg7+xilvS/lTkAvrqydu3LZcK8o=;
        b=l/V3LEqZQSkxyL0XkAEQh5prKB4QFusddg4IgB543OOOg75grZX17zEvSTZRvdiban
         jOKXwmSfYwtx8FBNSuimrHz4OAoNDVOp0igfZYsPANtadfhpuTI1hGWoFWAksakzxCje
         ntfgtpBCwclPT+TIMqO6pJbL3TOo9UUppq6CrMauSi0MkrCGbXfJIKdrBMC33T2UZOuY
         xoLUm97aZbE/2P78HhBjW8vK680gw1p8jstjnmwqEIiXhf1ecccJbTpKJPDiqDxIjPWF
         HGaTP2MvpBZdxjTyJYtzdaZHANtVMcyq9app6GHqrAeNdmyIT/YCuG3iSz7jc99aOH5J
         uWpw==
X-Received: by 10.31.188.83 with SMTP id m80mr20504528vkf.46.1449999119125;
 Sun, 13 Dec 2015 01:31:59 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sun, 13 Dec 2015 01:31:29 -0800 (PST)
In-Reply-To: <CAPig+cQtoUXuOZjGjev8MGYUMyjd+n_=o+jOVXkhPReSkWgxmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282328>

On Sun, Dec 13, 2015 at 11:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Dec 11, 2015 at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>   ref-filter: introduce a parsing function for each atom in valid_atom
>>>   ref-filter: introduce struct used_atom
>>>   ref-fitler: bump match_atom() name to the top
>>>   ref-filter: skip deref specifier in match_atom_name()
>>>   ref-filter: introduce color_atom_parser()
>>>   strbuf: introduce strbuf_split_str_without_term()
>>>   ref-filter: introduce align_atom_parser()
>>>   ref-filter: introduce remote_ref_atom_parser()
>>>   ref-filter: introduce contents_atom_parser()
>>>   ref-filter: introduce objectname_atom_parser()
>>
>> It seems that this series had seen quite a good inputs, mostly from
>> Eric.  I finished reading it over and I didn't find anything more to
>> add.  The patches are mostly good and would be ready once these
>> points raised during the review are addressed, I think
>
> I'm still a bit fuzzy about what this series is trying to achieve. It
> feels like it wants to avoid doing repeated processing of unchanging
> bits of %(foo:bar) atoms for each ref processed, but it only partly
> achieves that goal. For instance, there are still an awful lot of
> strcmp()s and starts_with()s in that inner loop, and even the
> unchanging %(color:) argument gets re-evaulated repeatedly, which is
> probably quite expensive.
>

Yes, you're right. It started off as per Junio's suggestion which you
can find here: http://thread.gmane.org/gmane.comp.version-control.git/279254

> If the intention is to rid that inner loop of much of the expensive
> processing, then wouldn't we want to introduce an enum of valid atoms
> which is to be a member of 'struct used_atom', and have
> populate_value() switch on the enum value rather than doing all the
> expensive strcmp()s and starts_with()?
>
>     enum atom_type {
>         AT_REFNAME,
>         AT_OBJECTTYPE,
>         ...
>         AT_COLOR,
>         AT_ALIGN
>     };
>
>     static struct used_atom {
>         enum atom_type atom;
>         cmp_type cmp;
>         union {
>             char *color; /* parsed color */
>             struct align align;
>             enum { ... } remote_ref;
>             struct {
>                 enum { ... } portion;
>                 unsigned int nlines;
>             } contents;
>             int short_objname;
>         } u;
>     } *used_atom;
>
> In fact, the 'cmp_type cmp' field can be dropped altogether since it
> can just as easily be looked up when needed by keeping 'enum
> atom_type' and valid_atoms[] in-sync and indexing into valid_atoms[]
> by atom_type:
>
>     struct used_atom *a = ...;
>     cmp_type cmp = valid_atoms[a->atom].cmp_type;
>
> As a bonus, an 'enum atom_type' would resolve the problem of how
> starts_with() is abused in populate_value() for certain cases
> (assuming I'm understanding the logic), such as how matching of
> "color" could incorrectly match some yet-to-be-added atom named
> "colorize".

This actually makes sense to me, especially how we can eliminate most of
the starts_with() in populate_value(). Well then I guess I'll work on this and
see what I can come up with, Thanks for the review :)

-- 
Regards,
Karthik Nayak
