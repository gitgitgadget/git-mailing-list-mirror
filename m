From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 11:55:57 +0200
Message-ID: <BANLkTikU3evfo86WmQeVS_Z41s3xSK1DJw@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428003541.GA18382@linux-mips.org> <20110428081817.GA29344@pcpool00.mathematik.uni-freiburg.de>
 <4DB9367B.2050607@op5.se>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:56:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNxP-0000U9-Te
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab1D1J4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 05:56:18 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59490 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab1D1J4R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 05:56:17 -0400
Received: by pvg12 with SMTP id 12so1709859pvg.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IAQkmE7Q4HOisnW9rhnOoEGFgVw+WyEkDusyE2xbIUw=;
        b=GATdAguETz6i2Y6FRTQf972A5RyKrh0pz2NvrwHU7xsKSeRskCUHqTzEnpOgmQdtdc
         HB7X4JJ4ACoU30pM9MBRIdoolaF1yK4YgRl+wmtFdTPBGmGvPWcNyYwwoILGUigr2SIW
         0XJvvi5rj5aKd+ElooqjwkgeGVx8bRZkAnZGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=rCG7o9LsP48wXTieqB+CaZf46eiICvrNup4jxyazxxLrENS6qqSp2I5XXnrCwTDmhT
         Izow5Q1etkiefns4Q0yTd68NR+TDU6URxBC2KyVEt9Q2dlD/l014G02xrdfe2eceg/lP
         Bb3vBqSPnp4HkqY0sRTMuOpM+42PlQcxDJJMI=
Received: by 10.68.15.36 with SMTP id u4mr3527382pbc.20.1303984577077; Thu, 28
 Apr 2011 02:56:17 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Thu, 28 Apr 2011 02:55:57 -0700 (PDT)
In-Reply-To: <4DB9367B.2050607@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172340>

On Thu, Apr 28, 2011 at 11:42 AM, Andreas Ericsson <ae@op5.se> wrote:
> On 04/28/2011 10:18 AM, Bernhard R. Link wrote:
>> * Ralf Baechle<ralf@linux-mips.org> =A0[110428 02:35]:
>>> On Wed, Apr 27, 2011 at 04:32:12PM -0700, Junio C Hamano wrote:
>>>
>>>>> +static inline int is_null_sha1(const unsigned char *sha1)
>>>>> =A0 {
>>>>> - =A0return memcmp(sha1, sha2, 20);
>>>>> + =A0const unsigned long long *sha1_64 =3D (void *)sha1;
>>>>> + =A0const unsigned int *sha1_32 =3D (void *)sha1;
>>>>
>>>> Can everybody do unaligned accesses just fine?
>>>
>>> Misaligned accesses cause exceptions on some architectures which th=
en
>>> are fixed up in software making these accesses _very_ slow. =A0You =
can
>>> use __attribute__((packed)) to work around that but that will on th=
e
>>> affected architectures make gcc generate code pessimistically that =
is
>>> slower than not using __attribute__((packed)) in case of proper
>>> alignment. =A0And __attribute__((packed)) only works with GCC.
>>
>> Even __attribute__((packed)) usually does not allow arbitrary aligne=
d
>> data, but can intruct the code to generate code to access code
>> misaligned in a special way. (I have already seen code where thus
>> accessing a properly aligned long caused a SIGBUS, because it was
>> aligned because being in a misaligned packed struct).
>>
>> In short: misaligning stuff works on x86, everywhere else it is disa=
ster
>> waiting to happen. (And people claiming compiler bugs or broken
>> architectures, just because they do not know the basic rules of C).
>>
>
> Given that the vast majority of user systems are x86 style ones, it's
> probably worth using this patch on such systems and stick to a
> partially unrolled byte-by-byte comparison that finishes early on
> the rest of them.

I disagree. We have no guarantee that the SHA-1s are aligned on x86
either, and unaligned accesses are slow on x86.

I think it's much much cleaner to add an early-out on the first byte,
and hope that memcmp is optimized properly. If it's not, those
platforms can add an override to memcmp in git-compat-util and/or
compat/*.
