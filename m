From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH] Thread-safe xmalloc and xrealloc needs a recursive mutex
Date: Thu, 8 Apr 2010 10:42:28 +0200
Message-ID: <g2h4c8ef71004080142r5df32f10u66ebba19799804eb@mail.gmail.com>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
	 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
	 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
	 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
	 <20100407031655.GA7156@spearce.org>
	 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
	 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
	 <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
	 <20100407144555.GA23911@fredrik-laptop>
	 <4BBD829B.8040700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 10:42:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NznJt-0004dZ-87
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 10:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab0DHImb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 04:42:31 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:36293 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab0DHIma convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 04:42:30 -0400
Received: by fxm23 with SMTP id 23so1835870fxm.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fmPbww4Zssn3hIBewQuBKKRTh8afPx27c9zqkM8eGZo=;
        b=LSGKmNrqLphQ7NGqf7cBxHEXcRwb5lHP811z04uS6vR4vmDagdJMacxe9/QjWHedm2
         UVaakoMdeVuTfAo65nLRPkq0BygpOxR7+2qa5gC2dvwIy9qyM1om3+iODC8Ao+TKIf0z
         o7JLac7ESrQaYW1EMGOURbKC2EKAeGA+kGeHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WiDlqAXTh3BiG6e9IkpFvBC6LahnoW098ENNh5AXE+cXjoZxn/xqGjEjppmWVuIhjB
         ED4p+yFdkRwbm8GLWGpMUAi4aBwdD/gOD2c26mzy3FNGKRktAOUZdDZRTe5BH0REtWQB
         eVZECVbM6qY5nY4u0n4LXD9KwOKK77bxV6nXc=
Received: by 10.239.140.138 with HTTP; Thu, 8 Apr 2010 01:42:28 -0700 (PDT)
In-Reply-To: <4BBD829B.8040700@viscovery.net>
Received: by 10.239.161.84 with SMTP id g20mr1009268hbd.200.1270716148836; 
	Thu, 08 Apr 2010 01:42:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144345>

On Thu, Apr 8, 2010 at 09:15, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> From: Johannes Sixt <j6t@kdbg.org>
>
> The mutex used to protect object access (read_mutex) may need to be
> acquired recursively. =A0Introduce init_recursive_mutex() helper func=
tion
> in thread-utils.c that constructs a mutex with the PHREAD_MUTEX_RECUR=
SIVE
> attribute.
>
> pthread_mutex_init() emulation on Win32 is already recursive as it is
> implemented on top of the CRITICAL_SECTION type, which is recursive.
>
> =A0 =A0http://msdn.microsoft.com/en-us/library/ms682530%28VS.85%29.as=
px
>
> Add do-nothing compatibility wrappers for pthread_mutexattr* function=
s.
>
> Initial-version-by: Fredrik Kuivinen <frekui@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 4/7/2010 16:45, schrieb Fredrik Kuivinen:
>> We only need something like the following (on top of Nico's previous
>> patch). Warning: It hasn't even been compile tested on WIN32.
>
> Unfortunately, it doesn't build. This patch replaces the tip of
> nd/malloc-threading.
>
> BTW, your uses of strerror(errno) in init_recursive_mutex() were wron=
g
> (pthread functions do not set errno), but it is better in any case to
> avoid die() in this function.

Very true. Thanks.

- Fredrik
