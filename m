From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 08/10] dir: simplify untracked cache "ident" field
Date: Wed, 30 Dec 2015 23:01:38 +0100
Message-ID: <CAP8UFD1KcMOQ2M7=OnC3i2OKrzBigDphdOAgwjVWqMSU9VRo7g@mail.gmail.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-9-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi2kga1x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 23:01:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEOoS-0002yu-Rv
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 23:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbbL3WBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 17:01:41 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33742 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbL3WBj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 17:01:39 -0500
Received: by mail-lb0-f182.google.com with SMTP id sv6so113827200lbb.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 14:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IFfhZRS/vaa663yp8l7REvVWSGwtMyXroRbSac3hYSs=;
        b=qx0+OeEU6M4DtyIkRYngF67n7mDvK5q95txgX7OavWPaANMMPEI5BS1bTqzNg4wrFy
         wkyLKYeE9pzb8SNNe+MHGN+nMRgGyJAeok7Jmdk9WRp38bmJjOWdJWCRZViH3FA/cMYA
         XAF3F1JM/f3uW6w64DhRaSrOOQwCcKHXRtQeyNPXkRIV9t1wcDxrzcLE+IL5yAWD0r1N
         8B/FTzBtshxgk/PD1Gt9Y0owfOME4D/LSbiCit54EGDmvxUIjiFCZxx69qjJxbSwhn25
         tezlacuOqvx2DowF0ngNBEhJRp8oAQZgg9j0RviYgTZH42weqrCSwtfA0mNktmBwC8mr
         6vIQ==
X-Received: by 10.112.190.67 with SMTP id go3mr17420943lbc.56.1451512898307;
 Wed, 30 Dec 2015 14:01:38 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Wed, 30 Dec 2015 14:01:38 -0800 (PST)
In-Reply-To: <xmqqsi2kga1x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283207>

On Tue, Dec 29, 2015 at 11:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> -static int ident_in_untracked(const struct untracked_cache *uc)
>> +static int ident_current_location_in_untracked(const struct untracked_cache *uc)
>>  {
>> -     const char *end = uc->ident.buf + uc->ident.len;
>> -     const char *p   = uc->ident.buf;
>> +     struct strbuf cur_loc = STRBUF_INIT;
>> +     int res = 0;
>>
>> -     for (p = uc->ident.buf; p < end; p += strlen(p) + 1)
>> -             if (!strcmp(p, get_ident_string()))
>> -                     return 1;
>> -     return 0;
>> +     /*
>> +      * Previous git versions may have saved many strings in the
>> +      * "ident" field, but it is insane to manage many locations,
>> +      * so just take care of the first one.
>> +      */
>> +
>> +     strbuf_addf(&cur_loc, "Location %s, system ", get_git_work_tree());
>> +
>> +     if (starts_with(uc->ident.buf, cur_loc.buf))
>> +             res = 1;
>> +
>> +     strbuf_release(&cur_loc);
>> +
>> +     return res;
>>  }
>
> The ", system " part looks funny.  I think I know what you are
> trying to do, though.
>
> If the path to the working tree has ", system " as a substring,
> I wonder if funny things may happen with this starts_with()?

Yeah, I think in the next iteration I will do what Torsten suggests.
It looks like the only sane solution, other than just not using the
"ident" field anymore and relying only on config variables like the
example I give in my reply to Torsten.
