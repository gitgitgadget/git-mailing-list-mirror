From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/2] git apply: option to ignore whitespace differences
Date: Thu, 2 Jul 2009 19:46:27 +0200
Message-ID: <cb7bb73a0907021046x7fcb921bs86d55b69de540c9d@mail.gmail.com>
References: <1246539137-24754-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1246539137-24754-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vws6r822y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMQN2-0003OS-E3
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 19:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbZGBRqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbZGBRqq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 13:46:46 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:48387 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbZGBRqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 13:46:45 -0400
Received: by fxm18 with SMTP id 18so1662232fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ddxu2Gg5uES+DXobZwcd0uN2GLNOkp99jKk27fNVZjs=;
        b=idZ7BjhcT/T7+k/DKM+Rd2QluJ0l4gSPVxewJ32xVVmfzpragGGmiAFp/6HaIRYG1v
         iYKsCo0YjEgj/rK1gxueRrdjX1cN6fwhVth0IKynduf4yYReuMhtO8vVIZc0gcjzFY4U
         yQZ4SXtIZFOCe73HtTFOrtW8LS9vynVIcpldw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PAATbv6WTo2n6XjoKG57NcLJBCo6S9awwABwDNgH3yLQfelJZuVg2fI+SrBCyPf3fh
         MVllpTkxIiV8k/7JSy7FmVLHHI9PnjtbF1h2Eorg1GFY+Ym9/6BtqLpquwHjk6tedQE0
         DMtZN3cYk8SwrfNm/PvMtVhaDla8JXKfEWIJY=
Received: by 10.204.71.210 with SMTP id i18mr284066bkj.48.1246556807343; Thu, 
	02 Jul 2009 10:46:47 -0700 (PDT)
In-Reply-To: <7vws6r822y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122657>

On Thu, Jul 2, 2009 at 6:46 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
>> diff --git a/builtin-apply.c b/builtin-apply.c
>> index dc0ff5e..86860d6 100644
>> --- a/builtin-apply.c
>> +++ b/builtin-apply.c
>> @@ -39,6 +39,7 @@ static int diffstat;
>> =A0static int numstat;
>> =A0static int summary;
>> =A0static int check;
>> +static int ignore_whitespace =3D 0;
>
> s/ =3D 0//;

Ah, I wondered about that. I assume this leaves no possibility for
uninitialized values because of the way option parsing is done?

>> +/*
>> + * Compare two memory areas ignoring whitespace differences
>> + */
>> +static int memcmp_ignore_whitespace(const char *s1, const char *s2,=
 size_t n)
>> +{
>
> Don't you think this function signature is bogus?

I did have a few doubts on it. I think I worked out a proper solution,
per your suggestion.

>> +static int memcmp_switch(const char *s1, const char *s2, size_t n)
>
> This function signature shares the same bogosity with the previous on=
e.
>
> In addition, it's name and semantics is bogus.

> If you are separating that "compare two lines" logic into a helper
> function, I would expect its name actually reflect its purpose, whose
> behaviour may change depending on --ignore-whitespace. =A0The traditi=
onal
> codepath would say "do they have the same length and match byte-for-b=
yte?"
> while the new loosened codepath would say "we do not care about the
> whitespaces; do they match if we disregard ws differences?"

Indeed. See upcoming patch for a better name 8-)

> I also suspect that you might be able to optimize the existing "allow
> whitespace-fixed match" a bit by "fix"ing the target buffer only once=
,
> instead of doing so line-by-line for every offset that find_pos() che=
cks
> by calling match_fragment(). =A0It is an independent issue, but it ap=
pears
> to me that the change this patch wants to do to match_fragment() migh=
t
> become cleaner if we did that conversion first, as match_fragment() i=
tself
> won't have to have two cases (early return for exact match, and match=
 with
> whitespace-fixed target).

But OTOH that would 'waste time' fixing whitespace when it might not
be needed ...

--=20
Giuseppe "Oblomov" Bilotta
