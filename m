From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 14:43:55 -0700
Message-ID: <f488382f0908171443n7fa92342v1ac12f52a17fd048@mail.gmail.com>
References: <4A85F270.20703@draigBrady.com> <87eirbef3c.fsf@master.homenet>
	 <4A88B80D.40804@draigBrady.com> <8763cmemsa.fsf@master.homenet>
	 <f488382f0908170844h649126efxb27f87d7b319961b@mail.gmail.com>
	 <alpine.LFD.2.01.0908170852320.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Scrivano <gscrivano@gnu.org>,
	=?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>,
	Bug-coreutils@gnu.org, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:44:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9zn-0003Oo-Oc
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbZHQVnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbZHQVnz
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:43:55 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:54830 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbZHQVnz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 17:43:55 -0400
Received: by ywh3 with SMTP id 3so4567893ywh.22
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 14:43:56 -0700 (PDT)
Received: by 10.91.189.1 with SMTP id r1mr3134968agp.109.1250545436045; Mon, 
	17 Aug 2009 14:43:56 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0908170852320.3162@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126295>

On Mon, Aug 17, 2009 at 9:22 AM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 17 Aug 2009, Steven Noonan wrote:
>>
>> Interesting. I compared Linus' implementation to the public domain o=
ne
>> by Steve Reid[1]
>
> You _really_ need to talk about what kind of environment you have.
>
> There are three major issues:
> =A0- Netburst vs non-netburst
> =A0- 32-bit vs 64-bit
> =A0- compiler version

Right. I'm running a Core 2 "Merom" 2.33GHz. The code was compiled for
x86_64 with GCC 4.2.1. I didn't _expect_ it to compile for x86_64, but
apparently the version of GCC that ships with Xcode 3.2 defaults to
compiling 64-bit code on machines that are capable of running it.

>
> Steve Reid's code looks great, but the way it is coded, gcc makes a m=
ess
> of it, which is exactly what my SHA1 tries to avoid.
>
> [ In contrast, gcc does very well on just about _any_ straightforward
> =A0unrolled SHA1 C code if the target architecture is something like =
PPC or
> =A0ia64 that has enough registers to keep it all in registers.
>
> =A0I haven't really tested other compilers - a less aggressive compil=
er
> =A0would actually do _better_ on SHA1, because the problem with gcc i=
s that
> =A0it turns the whole temporary 16-entry word array into register acc=
esses,
> =A0and tries to do register allocation on that _array_.
>
> =A0That is wonderful for the above-mentioned PPC and IA64, but it mak=
es gcc
> =A0create totally crazy code when there aren't enough registers, and =
then
> =A0gcc starts spilling randomly (ie it starts spilling a-e etc). This=
 is
> =A0why the compiler and version matters so much. ]
>
>> (average of 5 runs)
>> Linus' sha1: 283MB/s
>> Steve Reid's sha1: 305MB/s
>
> So I get very different results:
>
> =A0 =A0 =A0 =A0# =A0 =A0 =A0 =A0 =A0 =A0 TIME[s] SPEED[MB/s]
> =A0 =A0 =A0 =A0Reid =A0 =A0 =A0 =A0 =A0 =A02.742 =A0 =A0 =A0 222.6
> =A0 =A0 =A0 =A0linus =A0 =A0 =A0 =A0 =A0 1.464 =A0 =A0 =A0 =A0 417

Added -m32:

Steve Reid: 156MB/s
Linus: 209MB/s

So on x86, your code really kicks butt.

> this is Intel Nehalem, but compiled for 32-bit mode (which is the mor=
e
> challenging one because x86-32 only has 7 general-purpose registers),=
 and
> with gcc-4.4.0.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>
