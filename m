From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 13:59:54 +0200
Message-ID: <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi> <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
 <4DB941CD.2050403@cs.helsinki.fi>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:00:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFPtQ-0004MK-CB
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 14:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab1D1MAQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 08:00:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36276 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab1D1MAP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 08:00:15 -0400
Received: by pwi15 with SMTP id 15so1252757pwi.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 05:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oPOgfYNIZHodKk231ZQvYiquA8hEJmZrOMCfIkKCRqM=;
        b=wRHJEmk8EKeqxF3XBQ+vYvpOx8r+gN2/Dv6qfXRy2r5zanUhOBvvFT5KNe/TIZFh+b
         q3vNPoV10XVWjtLOPLbke/MZ3DIec9Gzg9V4/qlZwrndMkTrTVh+IG/nRPMB7qqBLPMu
         b12trArVcgNYmusLhERpp+a7SWWU/r9hND7yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=mrV00OZqM3qL3oX34UpNfAFk3kfhDuDH8iZj9mAqMllAc+QrYrWEvLFUsHr5Br1/jS
         +ORRIi833a1Xy8n1kZCPhxY7YDEXsLjYZMXVjHssWGTqR1jAWxZmFNnJ314eQrB4/53D
         t5+nuXdsFTRqOesSzdXEt3Pe6ElRWOyZ+pKZg=
Received: by 10.68.15.36 with SMTP id u4mr3651210pbc.20.1303992014045; Thu, 28
 Apr 2011 05:00:14 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Thu, 28 Apr 2011 04:59:54 -0700 (PDT)
In-Reply-To: <4DB941CD.2050403@cs.helsinki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172354>

On Thu, Apr 28, 2011 at 12:30 PM, Pekka Enberg <penberg@cs.helsinki.fi>=
 wrote:
> Hi,
>
> On 4/28/11 1:19 PM, Erik Faye-Lund wrote:
>>
>> On Thu, Apr 28, 2011 at 12:10 PM, Pekka Enberg<penberg@cs.helsinki.f=
i>
>> =A0wrote:
>>>
>>> On 4/28/11 12:50 PM, Erik Faye-Lund wrote:
>>>>>
>>>>> Alas, i have not seen these sha1 hash buffers being allocated una=
ligned
>>>>> (in my
>>>>> very limited testing). In which spots are they allocated unaligne=
d?
>>>>
>>>> Like I said above, it can happen when allocated on the stack. But =
it
>>>> can also happen in malloc'ed structs, or in global variables. An a=
rray
>>>> is aligned to the size of it's base member type. But malloc does
>>>> worst-case-allignment, because it happens at run-time without
>>>> type-information.
>>>
>>> I'd be very surprised if malloc() did "worst case alignment" - that=
'd
>>> suck
>>> pretty badly from performance point of view.
>>
>> =A0From POSIX (I don't have K&R at hand, but it's also specified the=
re):
>> "The pointer returned if the allocation succeeds shall be suitably
>> aligned so that it may be assigned to a pointer to any type of objec=
t
>> and then used to access such an object in the space allocated (until
>> the space is explicitly freed or reallocated)."
>>
>> I put it in quotes because it's not the worst-case alignment you can
>> ever think of, but rather the worst case alignment of your CPUs
>> alignment requirements. This is 4 bytes for most CPUs.
>
> That's just the minimum guarantee! Why do you think modern malloc()
> implementations don't try *very* hard to provide best possible alignm=
ent?
>

Yes, it's the minimum alignment requirement. And yes, malloc
implementations try to keep the alignment. I don't think there's any
contradiction between what you and I said.

>>> Stack allocation alignment is a harder issue but I doubt it's as ba=
d as
>>> you
>>> make it out to be. On x86, for example, stack pointer is almost alw=
ays 8
>>> or
>>> 16 byte aligned with compilers whose writers have spent any time re=
ading
>>> the
>>> Intel optimization manuals.
>>>
>>> So yes, your statements are absolutely correct but I strongly doubt=
 it
>>> matters that much in practice unless you're using a really crappy
>>> compiler...
>>
>> I'm sorry, but the the fact of the matter is that we don't write cod=
e
>> for one compiler, we try to please many. Crappy compilers are very
>> much out there in the wild, and we have to deal with it. So, we can'=
t
>> depend on char-arrays being aligned to 32-bytes. This code WILL brea=
k
>> on GCC for ARM, so it's not a theoretical issue at all. It will also
>> most likely break on GCC for x86 when optimizations are disabled.
>
> Yes, ARM is a problem and I didn't try to claim otherwise. However, i=
t's not
> "impossible to fix" as you say with memalign().

True, it's not impossible. It's just an insane thing to try to do, for
a very small gain. The important change was the early-out, and we can
get that while still using a platform-optimized memcmp.

> But my comment was mostly about your claim that "we have no guarantee=
 that
> the SHA-1s are aligned on x86 either, and unaligned accesses are slow=
 on
> x86" which only matters in practice if you have a crappy compiler. An=
d
> arguing for performance if you don't have a reasonable compiler is pr=
etty
> uninteresting.

I agree that not aligning arrays when optimizations are disabled isn't
a big problem on x86. But I don't think that assuming that every
reasonable compiler/compiler-setting pair for x86 align all char-array
makes sense. Aligning short arrays on the stack can lead to
sub-optimal caching for local variables, for instance. Alignment isn't
the only thing that matters.

But that point aside, we need an implementation that is both fast and
correct on all platforms; type-punning arrays is not the way to do it.

So my preference is still something like this. Call me conservative ;)

diff --git a/cache.h b/cache.h
index c730c58..8bc03c6 100644
--- a/cache.h
+++ b/cache.h
@@ -681,13 +681,17 @@ extern char *sha1_pack_name(const unsigned char *=
sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
 extern const unsigned char null_sha1[20];
-static inline int is_null_sha1(const unsigned char *sha1)
+static inline int hashcmp(const unsigned char *sha1, const unsigned ch=
ar *sha2)
 {
-	return !memcmp(sha1, null_sha1, 20);
+	/* early out for fast mis-match */
+	if (*sha1 !=3D *sha2)
+		return *sha1 - *sha2;
+
+	return memcmp(sha1 + 1, sha2 + 1, 19);
 }
-static inline int hashcmp(const unsigned char *sha1, const unsigned ch=
ar *sha2)
+static inline int is_null_sha1(const unsigned char *sha1)
 {
-	return memcmp(sha1, sha2, 20);
+	return !hashcmp(sha1, null_sha1);
 }
 static inline void hashcpy(unsigned char *sha_dst, const unsigned
char *sha_src)
 {
