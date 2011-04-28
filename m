From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 14:28:03 +0200
Message-ID: <BANLkTi=B4nQPC7CrLkpmn4AhwjOAvs82qw@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi> <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
 <4DB941CD.2050403@cs.helsinki.fi> <4DB95AEF.5060609@op5.se>
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
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:28:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFQKb-00030G-0M
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 14:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab1D1M2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 08:28:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37311 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab1D1M2X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 08:28:23 -0400
Received: by pzk9 with SMTP id 9so1635394pzk.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dPsak46vBwLx4Y+FtAOM/WtofWZnV1IoLEOOjNjWi9E=;
        b=wTUM7ntWhDrDTZNSaeM3EMtOh0oGMSaL1xG6i/EbNO5noHhC9Atulk8KmQwvzu1e5w
         iILsSdVAcB6q3jQEkJXWEcpK0n/4n9OgpBfGtyR9mlEtlvajFiFU+VyRrG/7eRQPb/1U
         bYAVFUOZ8Fe4Q2Y80IxsFgRdzltjjdhjEX2e4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=OJ0vpAQaLS7I6X9xjsqISZrT69jVwbSmdxzamyP8CUS1YZ+NSsjxX9JfVvwg56/ZsY
         tyTEJT1CrF265dARwb6TdIswIkjQA950TUUKFcMubKNMtTtekeECAhiu2ANJpJQNrGdC
         hGCONi/uI2wmt+FYTSTs4CDhWWaYtsDEb3kT8=
Received: by 10.68.63.5 with SMTP id c5mr1240335pbs.87.1303993703056; Thu, 28
 Apr 2011 05:28:23 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Thu, 28 Apr 2011 05:28:03 -0700 (PDT)
In-Reply-To: <4DB95AEF.5060609@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172361>

On Thu, Apr 28, 2011 at 2:17 PM, Andreas Ericsson <ae@op5.se> wrote:
>>>> Stack allocation alignment is a harder issue but I doubt it's as b=
ad as you
>>>> make it out to be. On x86, for example, stack pointer is almost al=
ways 8 or
>>>> 16 byte aligned with compilers whose writers have spent any time r=
eading the
>>>> Intel optimization manuals.
>>>>
>>>> So yes, your statements are absolutely correct but I strongly doub=
t it
>>>> matters that much in practice unless you're using a really crappy
>>>> compiler...
>>>
>>> I'm sorry, but the the fact of the matter is that we don't write co=
de
>>> for one compiler, we try to please many. Crappy compilers are very
>>> much out there in the wild, and we have to deal with it. So, we can=
't
>>> depend on char-arrays being aligned to 32-bytes. This code WILL bre=
ak
>>> on GCC for ARM, so it's not a theoretical issue at all. It will als=
o
>>> most likely break on GCC for x86 when optimizations are disabled.
>>
>> Yes, ARM is a problem and I didn't try to claim otherwise. However, =
it's not "impossible to fix" as you say with memalign().
>>
>
> #define is_aligned(ptr) (ptr & (sizeof(void *) - 1))
> if (is_aligned(sha1) && is_aligned(sha2))
> =A0 =A0 =A0 =A0return aligned_and_fast_hashcmp(sha1, sha2);
>
> return memcmp(sha1, sha2, 20);
>
> Problem solved for all architectures. Not as fast as the original
> patch when we're lucky with alignment, but we cater to sucky
> compilers and make the good ones go a lot faster. The really good
> compilers that recognizes "is it aligned?" checks will optimize the
> is_aligned() checks away or at least hint at the branch prediction
> which path it should prefer.

I'd rather go with the do-not-introduce-the-problem-in-the-first-place
approach. As I've pointed out many times already, the vast majority of
the performance increase comes from the early-out in the first
iteration. Why not just special case that ONE check, and do memcmp as
usual for the rest? The first iteration should affect 99.6% of all
mismatches, so it should have nice performance even for the unaligned
case. This gives us both speed and portability.

> Once again; Bear in mind that x86 style architectures with gcc is
> almost certainly the most common combo for git users by a very wide
> margin, so a 25-30% speedup for those users is pretty worthwhile.

Again, I never argued against speed. I argued against going a route
that is tricky to get right. Very reasonable alternatives were posted,
including Ingo's last patch.
