From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 12:19:17 +0200
Message-ID: <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
X-From: git-owner@vger.kernel.org Thu Apr 28 12:19:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFOJz-00036o-Aa
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 12:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab1D1KTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 06:19:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53113 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab1D1KTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 06:19:37 -0400
Received: by pvg12 with SMTP id 12so1719856pvg.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=rjZQV4GdNWj1okJW8kLfDJyHTYPD10H5Aij3wUBzAEM=;
        b=nmgzhRRzsGxc+0HxOY/AJUfEPn37W9Dc5CauHsFKuAsn/KswuCJc3gab+gVmPslv2w
         fry/6jIxZrXsvni69SjWWL2jVzQ6oZhmonEeqbKhZVWZ0Gm2V9Kep00qS/788wzhNOQ6
         ZFJrpST0s6jjn+Ocrb5Yj0S/AqmasQMPjZSPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=bWJTAHYR+jk4usD9ral7/yJuaQW8xsvzem2YyFn0AoIdynWv5SSo3zkIm+UWim3p+U
         IWfyQg7Bj3lwKihAIUgQKXyUTxB21pSGYAveVOmPktUHibGjQF+Erp0Qsng1b7VZeEQ9
         S3BE/c6AQu/9L6tTEhf0pU74zd3VCx7YQennU=
Received: by 10.68.4.38 with SMTP id h6mr3445124pbh.422.1303985977069; Thu, 28
 Apr 2011 03:19:37 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Thu, 28 Apr 2011 03:19:17 -0700 (PDT)
In-Reply-To: <4DB93D16.4000603@cs.helsinki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172345>

On Thu, Apr 28, 2011 at 12:10 PM, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 4/28/11 12:50 PM, Erik Faye-Lund wrote:
>>>
>>> Alas, i have not seen these sha1 hash buffers being allocated unaligned
>>> (in my
>>> very limited testing). In which spots are they allocated unaligned?
>>
>> Like I said above, it can happen when allocated on the stack. But it
>> can also happen in malloc'ed structs, or in global variables. An array
>> is aligned to the size of it's base member type. But malloc does
>> worst-case-allignment, because it happens at run-time without
>> type-information.
>
> I'd be very surprised if malloc() did "worst case alignment" - that'd suck
> pretty badly from performance point of view.

>From POSIX (I don't have K&R at hand, but it's also specified there):
"The pointer returned if the allocation succeeds shall be suitably
aligned so that it may be assigned to a pointer to any type of object
and then used to access such an object in the space allocated (until
the space is explicitly freed or reallocated)."

I put it in quotes because it's not the worst-case alignment you can
ever think of, but rather the worst case alignment of your CPUs
alignment requirements. This is 4 bytes for most CPUs.

> Stack allocation alignment is a harder issue but I doubt it's as bad as you
> make it out to be. On x86, for example, stack pointer is almost always 8 or
> 16 byte aligned with compilers whose writers have spent any time reading the
> Intel optimization manuals.
>
> So yes, your statements are absolutely correct but I strongly doubt it
> matters that much in practice unless you're using a really crappy
> compiler...

I'm sorry, but the the fact of the matter is that we don't write code
for one compiler, we try to please many. Crappy compilers are very
much out there in the wild, and we have to deal with it. So, we can't
depend on char-arrays being aligned to 32-bytes. This code WILL break
on GCC for ARM, so it's not a theoretical issue at all. It will also
most likely break on GCC for x86 when optimizations are disabled.
