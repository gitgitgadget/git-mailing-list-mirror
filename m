From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 11:17:26 +0200
Message-ID: <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:24:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNSE-0000Gj-R9
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab1D1JYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 05:24:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54680 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab1D1JYD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 05:24:03 -0400
Received: by pvg12 with SMTP id 12so1696052pvg.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PsFfZEIZAU/SfDUxUTR0jAXvemMccr7hROdipYRQz6g=;
        b=WJIgOXvMKnpvfGmtn7Qti3nLG+xLWEh+nHESkhARMkS88Nh4dujs+sCMfDE0dswotj
         zKdkWpqk8kjnaYL2r0S9UjDBSJM7zw+CX7C7AkiEn9fs/EUbubUF2f0iJ1GDtzRIIOte
         Su00s+SqEGH+5xYJH3Ze22yfv0bq1z9WIk/aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=QRt2RG+X2EpSjsVlm3ReXP3ienychNHSVRv320b+p2/97eQMRQCCkjxMAG1W1IBVWd
         k4k0IDtDNDWXJaP6Bv2Chi2aeAO+ex7XMI1VjclFDgqGRvelRpL7cWuuZdCvPHGPLj7j
         c3dLBLchE6AeWSjOWPnavEcX0o4BRbnNiwfSI=
Received: by 10.68.40.65 with SMTP id v1mr3497217pbk.154.1303982266057; Thu,
 28 Apr 2011 02:17:46 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Thu, 28 Apr 2011 02:17:26 -0700 (PDT)
In-Reply-To: <20110428062717.GA952@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172329>

2011/4/28 Ingo Molnar <mingo@elte.hu>:
>
> * Junio C Hamano <gitster@pobox.com> wrote:
>
>> Ingo Molnar <mingo@elte.hu> writes:
>>
>> > +static inline int hashcmp(const unsigned char *sha1, const unsign=
ed char *sha2)
>> > =A0{
>> > - =A0 return !memcmp(sha1, null_sha1, 20);
>> > + =A0 int i;
>> > +
>> > + =A0 for (i =3D 0; i < 20; i++, sha1++, sha2++) {
>> > + =A0 =A0 =A0 =A0 =A0 if (*sha1 !=3D *sha2) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*sha1 < *sha2)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return +1;
>> > + =A0 =A0 =A0 =A0 =A0 }

Why not just:

if (*sha1 !=3D *sha2)
        return *sha2 - *sha1;

memcmp isn't guaranteed to return onlt the values -1, 0, +1, it can
return any value, just as long as it's sign of a non-zero return
express the relationship between the first mis-matching byte.

>> > + =A0 }
>> > +
>> > + =A0 return 0;
>>
>> This is very unfortunate, as it is so trivially correct and we shoul=
dn't
>> have to do it. =A0If the compiler does not use a good inlined memcmp=
(), this
>> patch may fly, but I fear it may hurt other compilers, no?

If the common case is that the hashes are random (as the assumption in
this patch is), then this patch should give very close to ideal
performance, no? A good memcmp might be faster when there's a match;
but how often do we really compare SHA-1's that are identical?

I see your worry, but if the assumption is correct, I doubt it'd turn
out to be a real problem. ~99.6% of the time we'd early-out on the
first byte, which is ideal.

If comparing identical SHA-1's are important, perhaps just having a
early-out just on the first byte and then doing memcmp is a good
solution (similar to what Jonathan Nieder proposed, but without
alignment problems)?

> Secondly, the combined speedup of the cached case with my two patches=
 appears
> to be more than 30% on my testbox so it's a very nifty win from two r=
elatively
> simple changes.

That speed-up was on ONE test vector, no? There are a lot of other
uses of hash-comparisons in Git, did you measure those?

>> > +static inline int is_null_sha1(const unsigned char *sha1)
>> > =A0{
>> > - =A0 return memcmp(sha1, sha2, 20);
>> > + =A0 const unsigned long long *sha1_64 =3D (void *)sha1;
>> > + =A0 const unsigned int *sha1_32 =3D (void *)sha1;
>>
>> Can everybody do unaligned accesses just fine?
>
> I have added some quick debug code and none of the sha1 pointers (in =
my
> admittedly very limited) testing showed misaligned pointers on 64-bit=
 systems.
>
> On 32-bit systems the pointer might be 32-bit aligned only - the patc=
h below
> implements the function 32-bit comparisons.

That's simply wrong. Unsigned char arrays can and will be unaligned,
and this causes exceptions on most architectures (x86 is pretty much
the exception here). While some systems for these architectures
support unaligned reads from the exception handler, others doesn't. So
this patch is pretty much guaranteed to cause a crash in some setups.
