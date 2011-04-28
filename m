From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 13:31:53 +0400
Message-ID: <BANLkTikWd8=1RbY78tPFMVhuV05eKVzjkg@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu>
	<BANLkTim7bbFiSsj3PRr-_yM5gh1txYQR5w@mail.gmail.com>
	<20110428091110.GA14431@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:32:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNZp-0004QD-5I
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402Ab1D1Jbz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 05:31:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60127 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab1D1Jby convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 05:31:54 -0400
Received: by qwk3 with SMTP id 3so1152063qwk.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qB+hMygOx3rDIqi03X/OWEtW53kvNSbw+H3wsUY/Yvg=;
        b=LfkWbVHiF2TENrP6ga6IYFJ5BNPB2rgfp45EpRCgyzTAbyigYPxaCq+Y5cNc/XQnVc
         KqOGCRsOkRx2ChcrcW97TIGs5AYTmAMHsZiu0wkYhnJ23YH5TJi0IU0KvxZ58SXz6K+d
         /0UQbgg2ccCtO+UsiJnjn3w9XisPfSVwE3YZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gwnp0a/wDzmC10oRHWrNlpFzQJnkqXADY9CptzR8zgmFhCnqyB6ajnZmOXDOyihRKo
         ojKbqLGNdoBvdM7XGrkSL9k4sae3DTtbuhuh+Yb4GNCRAaWeSNDZJPvXVuQoJg1O9oUE
         DQLg2wdDPdGTUJPnzTG6GvQ+B14bVqQhNBuMk=
Received: by 10.224.201.68 with SMTP id ez4mr2344636qab.323.1303983113695;
 Thu, 28 Apr 2011 02:31:53 -0700 (PDT)
Received: by 10.229.251.85 with HTTP; Thu, 28 Apr 2011 02:31:53 -0700 (PDT)
In-Reply-To: <20110428091110.GA14431@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172332>

2011/4/28 Ingo Molnar <mingo@elte.hu>:
>
> * Dmitry Potapov <dpotapov@gmail.com> wrote:
>
>> 2011/4/28 Ingo Molnar <mingo@elte.hu>:
>> > +static inline int hashcmp(const unsigned char *sha1, const unsign=
ed char *sha2)
>> > =A0{
>> > - =A0 =A0 =A0 return !memcmp(sha1, null_sha1, 20);
>> > + =A0 =A0 =A0 int i;
>> > +
>> > + =A0 =A0 =A0 for (i =3D 0; i < 20; i++, sha1++, sha2++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*sha1 !=3D *sha2) {
>>
>> At the very least, you may want to put 'likely' in this 'if'
>> condition, otherwise the compiler may optimize this loop in
>> the same way as with memcmp. So, it may work well now, but
>> it may not work much slower with future versions or different
>> level of optimization. (AFAIK, -O3 is far more aggressive in
>> optimizing of loops).
>
> the main difference is between the string assembly instructions and t=
he loop.
> Modern CPUs will hardly notice this loop being emitted with slight va=
riations
> by the compiler. So i do not share this concern.

Here you make an assumption what kind of optimization the compiler
can do. As Jonathan noticed above, theoretically a smart compiler
can turn this loop into memcmp (or code very similar to memcmp).

The reason why memcmp does not work well is that it is optimized
for the worst case scenario (where beginning of two strings is
the same), while _we_ know that with a hash it very unlikely,
and we want to conduct this knowledge to the compiler in some
way. Just re-writing memcmp as explicit loop does not conduct
this knowledge.

Therefore, I believe it makes sense to add 'likely'. I have not
tested this code, but in the past, I had a very similar code
which was compiled with -O3, and just putting likely turned out
to 40% speed-up for that comparison function.


Dmitry
