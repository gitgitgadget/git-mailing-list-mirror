From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 14:40:16 +0200
Message-ID: <BANLkTi=6zzW41OagqAQfifHfQ4Mvy+BwsA@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi> <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
 <4DB941CD.2050403@cs.helsinki.fi> <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
 <20110428123617.GA2062@elie>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:40:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFQWR-000204-6x
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 14:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757023Ab1D1Mki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 08:40:38 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40547 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab1D1Mkh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 08:40:37 -0400
Received: by pzk9 with SMTP id 9so1640660pzk.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=63Nigeqpi+alUSXxWhaZiJn58LxGCePviEwR7RNEdR0=;
        b=P6ORVn2RaNIllUg7eotj1t5f5YpRIn/t7z9YStGArwRg7hvQLIdR5e5qwJbxjjD53w
         WUqafOkbEJh7fFzkV49ZZoUcKa7u38nqd0BzmCostEWevC52NpkKKoyyFTAFQFy67FaF
         ooGtTRKstHEml4A4whCdQFELy9iXnyEfJOfRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=JZrNgCKKPZ19HSSACuRMutMNzVVhv64bTGhhf26OvF1umEsx+Y8xUDNcth41IF4xE1
         pNBlGkwmazUEQ3drjs8Xfd9f6yrTTWtAHcNYX0dQI9OIJIq8UMnjL0pugH9o6U3MIs/U
         aEUw00I7N2g3A15qnKj/lalYzy40UoXFairo0=
Received: by 10.68.63.5 with SMTP id c5mr1252931pbs.87.1303994436175; Thu, 28
 Apr 2011 05:40:36 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Thu, 28 Apr 2011 05:40:16 -0700 (PDT)
In-Reply-To: <20110428123617.GA2062@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172363>

On Thu, Apr 28, 2011 at 2:36 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> A side note for amusement.
>
> Erik Faye-Lund wrote:
>
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -681,13 +681,17 @@ extern char *sha1_pack_name(const unsigned cha=
r *sha1);
>> =A0extern char *sha1_pack_index_name(const unsigned char *sha1);
>> =A0extern const char *find_unique_abbrev(const unsigned char *sha1, =
int);
>> =A0extern const unsigned char null_sha1[20];
>> -static inline int is_null_sha1(const unsigned char *sha1)
>> +static inline int hashcmp(const unsigned char *sha1, const unsigned=
 char *sha2)
>> =A0{
>> - =A0 =A0 return !memcmp(sha1, null_sha1, 20);
>> + =A0 =A0 /* early out for fast mis-match */
>> + =A0 =A0 if (*sha1 !=3D *sha2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return *sha1 - *sha2;
>> +
>> + =A0 =A0 return memcmp(sha1 + 1, sha2 + 1, 19);
>> =A0}
>
> On the off-chance that sha1 and sha2 are nicely aligned, a more
> redundant
>
> =A0 =A0 =A0 =A0if (*sha1 !=3D *sha2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return *sha1 - *sha2;
>
> =A0 =A0 =A0 =A0return memcmp(sha1, sha2, 20);
>
> would take advantage of that (yes, this is just superstition, but it
> somehow seems comforting anyway).

Good point, I think that's an improvement.

> Anyway, assuming it does not kill performance for some reason, the
> above sounds good to me. =A0Thanks for spelling it out.

If it does, then we haven't fully understood where it came from in the
first place, no? :P
