From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 00/10] ref-filter: use parsing functions
Date: Wed, 16 Dec 2015 20:15:19 +0530
Message-ID: <CAOLa=ZS-iBYds4uqy=YQD3fH9332HufrE34twcftPkjZh4gDmw@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <xmqq1taseh2x.fsf@gitster.mtv.corp.google.com> <CAPig+cQtoUXuOZjGjev8MGYUMyjd+n_=o+jOVXkhPReSkWgxmw@mail.gmail.com>
 <CAOLa=ZSEGf7TAKNkYCogw7nz9UMUxEZ7Vg2vGXHqFP2s=tnWcg@mail.gmail.com> <CAPig+cSTpLFgeVJuPyFVuRGkwBH_axW1Vik9+6cY4g2Ajeu4iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 15:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9DL0-0002d3-U5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 15:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbbLPOpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 09:45:51 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33625 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbbLPOpt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 09:45:49 -0500
Received: by mail-vk0-f46.google.com with SMTP id a188so27558772vkc.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 06:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ztTFYygFNbhqlpre7H023CXc38oRwagwFOX/S3mncIg=;
        b=CeX6Q9eq1sVgv6WaIV5XThSP5PtuLVqjIetxIvZakZ5K0z1dYFmYtRmm+j/jmcy9DY
         h6Opro5k4VU6ALo38FlJVoemf1XiVy1OaR89SD95IHMrPunbg8UEGrP70Z8q7BhxmYcN
         Z2RleOJUz5OOJUxzg2pUTwzetcfwDJecyOQzIrnvrhYt8sPew5Cqm4uDIKekjT2LdjZs
         4bGldArkDUEbrODsaJVvgg97whLsdf/niGNJ464lYX48TjJJL3RQkRuLd+b1LGJHHiIl
         AWRloofCZ8dnj1DAI9bi4qqYSBigofDq+XG5R5Ce1z7GXeC7RtTXVRTuNq6pdeQDs6Nx
         3/SA==
X-Received: by 10.31.8.8 with SMTP id 8mr31932315vki.106.1450277149040; Wed,
 16 Dec 2015 06:45:49 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Wed, 16 Dec 2015 06:45:19 -0800 (PST)
In-Reply-To: <CAPig+cSTpLFgeVJuPyFVuRGkwBH_axW1Vik9+6cY4g2Ajeu4iw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282560>

On Mon, Dec 14, 2015 at 3:25 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Dec 13, 2015 at 4:31 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Dec 13, 2015 at 11:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> If the intention is to rid that inner loop of much of the expensive
>>> processing, then wouldn't we want to introduce an enum of valid atoms
>>> which is to be a member of 'struct used_atom', and have
>>> populate_value() switch on the enum value rather than doing all the
>>> expensive strcmp()s and starts_with()?
>>>
>>>     enum atom_type {
>>>         AT_REFNAME,
>>>         AT_OBJECTTYPE,
>>>         ...
>>>         AT_COLOR,
>>>         AT_ALIGN
>>>     };
>>>
>>>     static struct used_atom {
>>>         enum atom_type atom;
>>>         cmp_type cmp;
>>>         union {
>>>             char *color; /* parsed color */
>>>             struct align align;
>>>             enum { ... } remote_ref;
>>>             struct {
>>>                 enum { ... } portion;
>>>                 unsigned int nlines;
>>>             } contents;
>>>             int short_objname;
>>>         } u;
>>>     } *used_atom;
>>>
>>> In fact, the 'cmp_type cmp' field can be dropped altogether since it
>>> can just as easily be looked up when needed by keeping 'enum
>>> atom_type' and valid_atoms[] in-sync and indexing into valid_atoms[]
>>> by atom_type:
>>>
>>>     struct used_atom *a = ...;
>>>     cmp_type cmp = valid_atoms[a->atom].cmp_type;
>>>
>>> As a bonus, an 'enum atom_type' would resolve the problem of how
>>> starts_with() is abused in populate_value() for certain cases
>>> (assuming I'm understanding the logic), such as how matching of
>>> "color" could incorrectly match some yet-to-be-added atom named
>>> "colorize".
>>
>> This actually makes sense to me, especially how we can eliminate most of
>> the starts_with() in populate_value(). Well then I guess I'll work on this and
>> see what I can come up with, Thanks for the review :)
>
> The 'enum atom_type' approach doesn't necessarily need to be part of
> this patch series; it may make sense to layer it atop the current
> series, which is already long enough to make review onerous. Patches
> in the current series are things you would want to do anyhow for the
> 'enum atom_type' approach, and there isn't really anything in the
> current series which should present a roadblock for layering 'enum
> atom_type' atop. Plus, by layering 'enum atom_type' atop, you get a
> chance to polish the current series (based upon review comments) and
> let it settle down, which should make working on 'enum atom_type'
> easier.

Ya could do that, I have the series ready then, I was gonna work on the
'enum atom_type' but I'll work on top of this, like you suggested.

Thanks.

-- 
Regards,
Karthik Nayak
