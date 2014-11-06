From: Jeff King <peff@peff.net>
Subject: Re: Installed git 2.1.3 on sparc 8, but got core dump during 'git
 clone'
Date: Thu, 6 Nov 2014 00:31:35 -0500
Message-ID: <20141106053134.GA22835@peff.net>
References: <1415251144220-7620692.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: victor <liwenxi9999@163.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 06:31:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmFfY-0002HV-Br
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 06:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbaKFFbg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2014 00:31:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:37172 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750868AbaKFFbg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 00:31:36 -0500
Received: (qmail 19756 invoked by uid 102); 6 Nov 2014 05:31:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Nov 2014 23:31:36 -0600
Received: (qmail 31670 invoked by uid 107); 6 Nov 2014 05:31:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Nov 2014 00:31:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Nov 2014 00:31:35 -0500
Content-Disposition: inline
In-Reply-To: <1415251144220-7620692.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 05, 2014 at 09:19:04PM -0800, victor wrote:

> (gdb) bt full
> #0  0xff0332ec in strlen () from /usr/lib/libc.so.1
> No symbol table info available.
> #1  0xff0866b8 in _doprnt () from /usr/lib/libc.so.1
> No symbol table info available.
> #2  0xff088ac0 in vsnprintf () from /usr/lib/libc.so.1
> No symbol table info available.
> #3  0x00137c18 in vreportf (prefix=3D0x190038 "cannot create thread: =
%s",
> err=3D0x190038 "cannot create thread: %s", params=3D0xffbef280)
>     at usage.c:12
>         msg =3D "cannot create thread:
> \0d~=E2=96=92=E2=96=92=E2=96=92\201\001\001\0\0\036\rP\0\034=E2=96=92=
\0\0\034=E2=96=92\0\0\036\rP", '\0' <repeats 16
> times>,
> "=E2=96=92\f\027\004=E2=96=92\f\027\b=E2=96=92\v=E2=96=92=E2=96=92=E2=
=96=92\v=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92\177=E2=96=
=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92\f\02=
7$=E2=96=92\v=E2=96=92\b\0\036\rP", '\0'
> <repeats 35 times>,
> "\001\0\030=E2=96=920\0\0\0\001\0\034=E2=96=92\0=E2=96=92=E2=96=92=E2=
=96=92=E2=96=92\0\0\0/\0\0\0\0=E2=96=92\003=E2=96=92@", '\0' <repeats
> 12 times>,
> "\201\001\001\0\0\036\rP\0\0\0\0\0\0\0\001\0\031\032\220\0\0\0\0\0\03=
0=E2=96=920=E2=96=92=E2=96=92=E2=96=92=E2=96=92\0\0\0\0=E2=96=92=E2=96=92=
=E2=96=92=E2=96=92\0\0\0\v",
> '\0' <repeats 27 times>...
> #4  0x00137f6c in error (err=3D0x196128 "error: ") at usage.c:147
> No locals.
> #5  0x00112aa0 in start_async (async=3D0xffbef5b0) at run-command.c:7=
27

We tried to start a thread in start_async, but it failed. We then pass
the error number to strerror(), and try to print the result. That seems
to involve feeding garbage to vsnprintf, so presumably what strerror()
handed us back was garbage.

Are you sure that pthreads really work on your platform? Between the
thread failure and the garbage strerror(), it sounds like there might b=
e
some weird linking problems. Does running "./configure
--disable-pthreads" produce a working build?

-Peff
