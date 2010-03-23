From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Tue, 23 Mar 2010 22:21:40 +0100
Message-ID: <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
	 <20100323173114.GB4218@fredrik-laptop>
	 <20100323184309.GA31668@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 22:21:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuBXn-0000eD-Nf
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 22:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab0CWVVm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 17:21:42 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:38727 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab0CWVVl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 17:21:41 -0400
Received: by fxm23 with SMTP id 23so2649002fxm.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WnMuqSQSA3sbKD7+igowiUryolSw04Qcvz9pPq2jCZ0=;
        b=VLNYGSTl4CHlML4kxoXgHVBoRZmqAktPnB89tGidxlGMMsim9/vPqyGX3vL1UxmuXq
         5zcRsWsvIz1FCLd7uEvuu77gGs5NepEcgaYCeSqvMVkSNw2OENDrWFyROXe9/iRP9Dtf
         AEC/rldIg3nALqyVg5a9lgCAammoVfbD1uSDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pwIZ1cdahEKhj5ZapZjMm5NPAsuyv6hHgCB8XIW4DoR9uATMjtJz3NeNnYzyUUkGX4
         ohurMSySQLQtMbQgAWXfcsdJgDbId0JPXHXykIquSW1Y/eDdhbnoIz8muemoBFaRIbje
         /dTXXFP/et34DL8HPq00J1hOzwYKazIHDRxas=
Received: by 10.239.184.65 with SMTP id x1mr1304338hbg.75.1269379300427; Tue, 
	23 Mar 2010 14:21:40 -0700 (PDT)
In-Reply-To: <20100323184309.GA31668@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143051>

On Tue, Mar 23, 2010 at 19:43, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Fredrik Kuivinen <frekui@gmail.com> wrote:
>> +static int multiple_threads;
>> +#ifndef NO_PTHREADS
>> +int xpthread_create(pthread_t *thread, const pthread_attr_t *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *(*start_routine)(void*), voi=
d *arg)
>> +{
>> + =A0 =A0 multiple_threads =3D 1;
>> + =A0 =A0 return pthread_create(thread, attr, start_routine, arg);
>> +}
>> +#endif
>> +
>> =A0void *xmalloc(size_t size)
>> =A0{
>> =A0 =A0 =A0 void *ret =3D malloc(size);
>> =A0 =A0 =A0 if (!ret && !size)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D malloc(1);
>> - =A0 =A0 if (!ret) {
>> + =A0 =A0 if (!ret && !multiple_threads) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_pack_memory(size, -1);
>
> So by "make thread safe" you really mean "disable release of
> least-frequently used pack windows once any thread starts".

Yes.

> If that is what we are doing, disabling the release of pack windows
> when malloc fails, why can't we do that all of the time?

The idea was that most git programs are single threaded, so they can
still benefit from releasing the pack windows when they are low on
memory.

- Fredrik
