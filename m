From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 11:50:06 +0200
Message-ID: <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:58:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNzA-0001N4-3R
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab1D1J6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:58:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35211 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab1D1J6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:58:05 -0400
Received: by pzk9 with SMTP id 9so1573237pzk.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=jB28jskYH/TZ4eMaOsFSrqOeE3JDUD2kavzvvkkleBc=;
        b=Dr3MXphCOZMU7Psb1deIIdIx3UOTwVU55dYe1RbQTnOsBkHOju59Of6ndBmRnEThSz
         h0t/V82Y/2Sxs8xOdccqebHO1vbC3/baQYdpH3JHVCi2cq0QfX7BNGfRC0vMA5c83sZp
         gNufWCdxYwHMoa76vRGUm1wMzwMmpoWhH0iWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=FMqXAJ7J36IjFevkHX9ObrKeKnGOZ9EuHEIWsCVxK/eHYaiuTixafXkeJflmRLCJ1j
         szr0nuM5bzl4Gc2eD+TFCJjumX4R4zyjE/tkQ3Lvq0VJ4yC0RQRpAlNJ7/YYx0dZtxZK
         vYSu7EQrkPoSYevTto9hY20I5qog9z1gpQ3sY=
Received: by 10.68.34.136 with SMTP id z8mr2988637pbi.355.1303984226160; Thu,
 28 Apr 2011 02:50:26 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Thu, 28 Apr 2011 02:50:06 -0700 (PDT)
In-Reply-To: <20110428093703.GB15349@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172341>

2011/4/28 Ingo Molnar <mingo@elte.hu>:
>
> * Erik Faye-Lund <kusmabite@gmail.com> wrote:
>
>> > Secondly, the combined speedup of the cached case with my two patches
>> > appears to be more than 30% on my testbox so it's a very nifty win from two
>> > relatively simple changes.
>>
>> That speed-up was on ONE test vector, no? There are a lot of other uses of
>> hash-comparisons in Git, did you measure those?
>
> I picked this hash function because it showed up in the profile (see the
> profile i posted). There's one other hash that mattered as well in the profile,
> see the lookup_object() patch i sent yesterday.
>

My point was that the 30% improvement was in "git gc", which is not
the only important use-case. How does this affect other git commands?

My suspicion is that it's generally an improvement, but I don't know
for sure. I think something like this might be an acceptable
trade-off, though:

diff --git a/cache.h b/cache.h
index c730c58..50b6f55 100644
--- a/cache.h
+++ b/cache.h
@@ -687,6 +687,10 @@ static inline int is_null_sha1(const unsigned char *sha1)
 }
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
+	/* early out for fast mis-match */
+	if (*sha1 != *sha2)
+		return *sha2 - *sha1;
+
 	return memcmp(sha1, sha2, 20);
 }
 static inline void hashcpy(unsigned char *sha_dst, const unsigned
char *sha_src)

>> > I have added some quick debug code and none of the sha1 pointers (in my
>> > admittedly very limited) testing showed misaligned pointers on 64-bit
>> > systems.
>> >
>> > On 32-bit systems the pointer might be 32-bit aligned only - the patch
>> > below implements the function 32-bit comparisons.
>>
>> That's simply wrong. Unsigned char arrays can and will be unaligned, and this
>> causes exceptions on most architectures (x86 is pretty much the exception
>> here). While some systems for these architectures support unaligned reads
>> from the exception handler, others doesn't. So this patch is pretty much
>> guaranteed to cause a crash in some setups.
>
> If unsigned char arrays are allocated unaligned then that's another bug i
> suspect that should be fixed.

We can't. The compiler decides the alignment of variables on the
stack. Some compilers / compiler-setting pairs might align
char-arrays, while others might not.

> Unaligned access on x86 is not free either -
> there's cycle penalties.
>
> Alas, i have not seen these sha1 hash buffers being allocated unaligned (in my
> very limited testing). In which spots are they allocated unaligned?

Like I said above, it can happen when allocated on the stack. But it
can also happen in malloc'ed structs, or in global variables. An array
is aligned to the size of it's base member type. But malloc does
worst-case-allignment, because it happens at run-time without
type-information.
