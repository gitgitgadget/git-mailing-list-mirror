From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 7 Apr 2010 18:13:18 +0200
Message-ID: <v2t4c8ef71004070913r2de3c8car31f39a2ab7aa6d15@mail.gmail.com>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
	 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
	 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
	 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
	 <20100407031655.GA7156@spearce.org>
	 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
	 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
	 <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
	 <20100407144555.GA23911@fredrik-laptop>
	 <alpine.LFD.2.00.1004071103341.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXsc-00037T-Gf
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051Ab0DGQNV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 12:13:21 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:37728 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580Ab0DGQNU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 12:13:20 -0400
Received: by fxm23 with SMTP id 23so1197375fxm.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Kfit/VneJfR/Fo2rTynhBlal5cL2SAfGpNM/x4SQhbc=;
        b=R2fCWG6VfDNRJ9sPGlM0aX/1ugRMBbOm+kKlxnxwcJOIjUGe+6KDPQ8qeM/2tcBT+f
         SyxnCSQ+xCfy0a7LUIQvMOHx7ptXBzdvPfNNB5vq/WyaIH/LsVqsAZr9AmwSxgjlu9Gg
         eWmkFdsbmkeIWA65h4IhSfKEhx8TODAvc/IQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bA/0CTNFgh1KGF1uwvTQ8CKoXmEyc4apsVc9F5xvL1x8xCLPt5bEhd3GZ22cUHzQBA
         cfOAkB4xdMQjonH/kaesBb4Rn/KGX/0RtOHgvBMwvF4Bxx3QejLc31qomPXBht+5n951
         h1Y0km5L8tnbdFlpxqXNmaBmD0UcpFpk/6veI=
Received: by 10.239.140.138 with HTTP; Wed, 7 Apr 2010 09:13:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004071103341.7232@xanadu.home>
Received: by 10.239.193.139 with SMTP id j11mr880980hbi.127.1270656798497; 
	Wed, 07 Apr 2010 09:13:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144244>

On Wed, Apr 7, 2010 at 17:08, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 7 Apr 2010, Fredrik Kuivinen wrote:
>> diff --git a/thread-utils.c b/thread-utils.c
>> index 4f9c829..3c8d817 100644
>> --- a/thread-utils.c
>> +++ b/thread-utils.c
>> @@ -1,4 +1,5 @@
>> =A0#include "cache.h"
>> +#include <pthread.h>
>
> This will fail compilation on Windows surely?

I think it will work. We use "#include <pthread.h>" in builtin/grep.c,
builtin/pack-objects.c, and preload-index.c already.

>> =A0#if defined(hpux) || defined(__hpux) || defined(_hpux)
>> =A0# =A0include <sys/pstat.h>
>> @@ -43,3 +44,24 @@ int online_cpus(void)
>>
>> =A0 =A0 =A0 return 1;
>> =A0}
>> +
>> +int init_recursive_mutex(pthread_mutex_t *m)
>> +{
>> +#ifdef _WIN32
>> + =A0 =A0 /* The mutexes in the WIN32 pthreads emulation layer are
>> + =A0 =A0 =A0* recursive, so we don't have to do anything extra here=
=2E */
>> + =A0 =A0 return pthread_mutex_init(m, NULL);
>> +#else
>> + =A0 =A0 pthread_mutexattr_t a;
>> + =A0 =A0 int ret;
>> + =A0 =A0 if (pthread_mutexattr_init(&a))
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("pthread_mutexattr_init failed: %s", s=
trerror(errno));
>> +
>> + =A0 =A0 if (pthread_mutexattr_settype(&a, PTHREAD_MUTEX_RECURSIVE)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("pthread_mutexattr_settype failed: %s"=
, strerror(errno));
>> +
>> + =A0 =A0 ret =3D pthread_mutex_init(m, &a);
>> + =A0 =A0 pthread_mutexattr_destroy(&a);
>> + =A0 =A0 return ret;
>
> Are you sure the pthread_mutexattr_t object can be destroyed even if =
the
> mutex is still in use? =A0Is the attribute object "attached" to the m=
utex
> or merely used as a template?

It is safe. See
http://www.opengroup.org/onlinepubs/009695399/functions/pthread_mutexat=
tr_init.html

- Fredrik
