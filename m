From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 00/10] ref-filter: use parsing functions
Date: Sun, 13 Dec 2015 00:40:35 -0500
Message-ID: <CAPig+cQtoUXuOZjGjev8MGYUMyjd+n_=o+jOVXkhPReSkWgxmw@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<xmqq1taseh2x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 06:41:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7zP7-0007Yp-Bf
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 06:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbbLMFkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 00:40:37 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34459 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbLMFkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 00:40:36 -0500
Received: by vkgj66 with SMTP id j66so41185561vkg.1
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 21:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=crSBmc8zKA5/jQJlPjutJ3q9nWDpG17Yjk2ktc2mW38=;
        b=d8TvYzwoyv+ZXcSpklC694PIFkgvFzxdZVtD1E1g5d9xWA2HeQbE/ZuLQdjG8fb6er
         TxkhJTjbWPg7b7LZBQhnann/4wC5srzsJloPgcwhO5e7KQy9YoTR39nNMd0Z2RrcgRid
         XZUHl/6XPizd8cOdCw3Hh7b/hG65JWbO/CRYE1GU45JUKPtFtP6XZuOljioVjETmxIuD
         L3L+zGE9z0/w1JKNXqEGKKloeXWnWPiAKFyq3bYcbXoCqSYdWeLyFcZOSvlki7fn4nnl
         Ie+Pm8ZwZO+4GzNzAurLTzJErrAEEuppCWl1b/IBJfxKQR2zciSoHzhVUCkPJDhBKQcs
         3mqg==
X-Received: by 10.31.58.142 with SMTP id h136mr20320227vka.115.1449985235657;
 Sat, 12 Dec 2015 21:40:35 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 12 Dec 2015 21:40:35 -0800 (PST)
In-Reply-To: <xmqq1taseh2x.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: CUM2flJVmiQ1YnmiGtDBh5WUp8A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282320>

On Fri, Dec 11, 2015 at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>>   ref-filter: introduce a parsing function for each atom in valid_atom
>>   ref-filter: introduce struct used_atom
>>   ref-fitler: bump match_atom() name to the top
>>   ref-filter: skip deref specifier in match_atom_name()
>>   ref-filter: introduce color_atom_parser()
>>   strbuf: introduce strbuf_split_str_without_term()
>>   ref-filter: introduce align_atom_parser()
>>   ref-filter: introduce remote_ref_atom_parser()
>>   ref-filter: introduce contents_atom_parser()
>>   ref-filter: introduce objectname_atom_parser()
>
> It seems that this series had seen quite a good inputs, mostly from
> Eric.  I finished reading it over and I didn't find anything more to
> add.  The patches are mostly good and would be ready once these
> points raised during the review are addressed, I think

I'm still a bit fuzzy about what this series is trying to achieve. It
feels like it wants to avoid doing repeated processing of unchanging
bits of %(foo:bar) atoms for each ref processed, but it only partly
achieves that goal. For instance, there are still an awful lot of
strcmp()s and starts_with()s in that inner loop, and even the
unchanging %(color:) argument gets re-evaulated repeatedly, which is
probably quite expensive.

If the intention is to rid that inner loop of much of the expensive
processing, then wouldn't we want to introduce an enum of valid atoms
which is to be a member of 'struct used_atom', and have
populate_value() switch on the enum value rather than doing all the
expensive strcmp()s and starts_with()?

    enum atom_type {
        AT_REFNAME,
        AT_OBJECTTYPE,
        ...
        AT_COLOR,
        AT_ALIGN
    };

    static struct used_atom {
        enum atom_type atom;
        cmp_type cmp;
        union {
            char *color; /* parsed color */
            struct align align;
            enum { ... } remote_ref;
            struct {
                enum { ... } portion;
                unsigned int nlines;
            } contents;
            int short_objname;
        } u;
    } *used_atom;

In fact, the 'cmp_type cmp' field can be dropped altogether since it
can just as easily be looked up when needed by keeping 'enum
atom_type' and valid_atoms[] in-sync and indexing into valid_atoms[]
by atom_type:

    struct used_atom *a = ...;
    cmp_type cmp = valid_atoms[a->atom].cmp_type;

As a bonus, an 'enum atom_type' would resolve the problem of how
starts_with() is abused in populate_value() for certain cases
(assuming I'm understanding the logic), such as how matching of
"color" could incorrectly match some yet-to-be-added atom named
"colorize".
