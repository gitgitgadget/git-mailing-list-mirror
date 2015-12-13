From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 00/10] ref-filter: use parsing functions
Date: Sun, 13 Dec 2015 16:55:03 -0500
Message-ID: <CAPig+cSTpLFgeVJuPyFVuRGkwBH_axW1Vik9+6cY4g2Ajeu4iw@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<xmqq1taseh2x.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQtoUXuOZjGjev8MGYUMyjd+n_=o+jOVXkhPReSkWgxmw@mail.gmail.com>
	<CAOLa=ZSEGf7TAKNkYCogw7nz9UMUxEZ7Vg2vGXHqFP2s=tnWcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 22:55:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Ebp-0004mi-7C
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 22:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbbLMVzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 16:55:05 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33469 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbLMVzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 16:55:04 -0500
Received: by vkca188 with SMTP id a188so144532111vkc.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QBXwIA9r8uGRE2ZthPbLbTbIuT1Y5UrLAln/7wNu1YA=;
        b=GIRw9aOJ0I6Cw3su8XYgTF1KJUWo6hV+qCPj1tjNLOmqdjvcqAfLoBoGwtD287aLR2
         AON0X9IKqB5e8+DI9waNlDkGDYl0gnLOzjLHbZC9FoKyyM+chDuDCw+hdFCkPk8utjYA
         TtA/dBQ7X2tdWO8pMP8VsZMMGU17w7SqWM4Kd10DiHH9qoZHboEjafIeqHTCjoQbtVQL
         yx6z67U+mS7LV+nJP4Nrcv4AaySs0IlkiGZrn7jr+jtWEDqGaUAFt4lJsHw4q3OhcM9g
         Tt2ibBgTIZPTsv3HbAJI7d95h+ROBWzAiy4tqmnXgxAYRN/Xw4eL2OPb9TDJtuqde0rt
         G/OA==
X-Received: by 10.31.47.130 with SMTP id v124mr22731373vkv.117.1450043703136;
 Sun, 13 Dec 2015 13:55:03 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 13 Dec 2015 13:55:03 -0800 (PST)
In-Reply-To: <CAOLa=ZSEGf7TAKNkYCogw7nz9UMUxEZ7Vg2vGXHqFP2s=tnWcg@mail.gmail.com>
X-Google-Sender-Auth: RYr4vWH1VsGRtWK_XLU_3g6G-CQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282352>

On Sun, Dec 13, 2015 at 4:31 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Dec 13, 2015 at 11:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> If the intention is to rid that inner loop of much of the expensive
>> processing, then wouldn't we want to introduce an enum of valid atoms
>> which is to be a member of 'struct used_atom', and have
>> populate_value() switch on the enum value rather than doing all the
>> expensive strcmp()s and starts_with()?
>>
>>     enum atom_type {
>>         AT_REFNAME,
>>         AT_OBJECTTYPE,
>>         ...
>>         AT_COLOR,
>>         AT_ALIGN
>>     };
>>
>>     static struct used_atom {
>>         enum atom_type atom;
>>         cmp_type cmp;
>>         union {
>>             char *color; /* parsed color */
>>             struct align align;
>>             enum { ... } remote_ref;
>>             struct {
>>                 enum { ... } portion;
>>                 unsigned int nlines;
>>             } contents;
>>             int short_objname;
>>         } u;
>>     } *used_atom;
>>
>> In fact, the 'cmp_type cmp' field can be dropped altogether since it
>> can just as easily be looked up when needed by keeping 'enum
>> atom_type' and valid_atoms[] in-sync and indexing into valid_atoms[]
>> by atom_type:
>>
>>     struct used_atom *a = ...;
>>     cmp_type cmp = valid_atoms[a->atom].cmp_type;
>>
>> As a bonus, an 'enum atom_type' would resolve the problem of how
>> starts_with() is abused in populate_value() for certain cases
>> (assuming I'm understanding the logic), such as how matching of
>> "color" could incorrectly match some yet-to-be-added atom named
>> "colorize".
>
> This actually makes sense to me, especially how we can eliminate most of
> the starts_with() in populate_value(). Well then I guess I'll work on this and
> see what I can come up with, Thanks for the review :)

The 'enum atom_type' approach doesn't necessarily need to be part of
this patch series; it may make sense to layer it atop the current
series, which is already long enough to make review onerous. Patches
in the current series are things you would want to do anyhow for the
'enum atom_type' approach, and there isn't really anything in the
current series which should present a roadblock for layering 'enum
atom_type' atop. Plus, by layering 'enum atom_type' atop, you get a
chance to polish the current series (based upon review comments) and
let it settle down, which should make working on 'enum atom_type'
easier.
