From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 0/5] replace signal() with sigaction()
Date: Wed, 28 May 2014 09:11:00 -0700
Message-ID: <20140528161100.GB7076@hudson.localdomain>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
 <53859307.8080506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 28 18:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpgRc-0007Cc-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 18:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbaE1QLI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 12:11:08 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50353 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbaE1QLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 12:11:06 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so11320514pab.3
        for <git@vger.kernel.org>; Wed, 28 May 2014 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nRExLbUYFiAWLuRdTymLVtXR+dq+jxA6UhDoLDrfEGc=;
        b=Wk36iSX/jSm/o9lffwI5uyDkIn/iWl+BNOFnro6k2LDOHwdX2hhwvy+E7GcAl9i8rA
         jrdYvcD7P8b8gJXPSIAXAwr5lG4SRTH/kcunLiK2mUdSP9SkLhP7hlFKp004X65GXW/X
         2dUg0F26vXzljBUku7Bh5GVzrQfVGf6zMzp0C3R25spy9Zss+9OQRm1EFDpgOsrp/1oD
         YDXE5ubtURnPZJ4gdBsWMWCDMSE2rtScSOGp3rbzsyhZei/tspelo6tRTgxrgJZrPyij
         zhXw2iBz0/Ksegd0tS2TXM6zVWKGQDaVvHMaVNLhhCHK8rqYhKy6qjZmYmeNNhsqVHdh
         2gWA==
X-Received: by 10.67.4.169 with SMTP id cf9mr624324pad.45.1401293465421;
        Wed, 28 May 2014 09:11:05 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id au4sm29126864pbc.10.2014.05.28.09.11.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 09:11:03 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 28 May 2014 09:11:00 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <53859307.8080506@viscovery.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250292>

On Wed, May 28, 2014 at 09:40:55AM +0200, Johannes Sixt wrote:
> Am 5/28/2014 8:14, schrieb Jeremiah Mahler:
> > From signal(2)
> >=20
> >   The behavior of signal() varies across UNIX versions, and has als=
o var=E2=80=90
> >   ied historically across different versions of Linux.   Avoid  its=
  use:
> >   use sigaction(2) instead.  See Portability below.
> >=20
> > This patch set replaces calls to signal() with sigaction() in all f=
iles
> > except sigchain.c.  sigchain.c is a bit more complicated than the o=
thers
> > and will be done in a separate patch.
>=20
> In compat/mingw.c we have:
>=20
> int sigaction(int sig, struct sigaction *in, struct sigaction *out)
> {
> 	if (sig !=3D SIGALRM)
> 		return errno =3D EINVAL,
> 			error("sigaction only implemented for SIGALRM");
> 	if (out !=3D NULL)
> 		return errno =3D EINVAL,
> 			error("sigaction: param 3 !=3D NULL not implemented");
>=20
> 	timer_fn =3D in->sa_handler;
> 	return 0;
> }
>=20
> Notice "only implemented for SIGALRM". Are adding the missing signals
> somewhere (here or in a later patch)?
>=20
Good catch Johannes, I did not account for this.

If I am reading this correctly, sigaction() can only be used for
SIGALRM, and no other signals.  But signal() it would have worked for
these other signals.

My first idea is why not call signal() from within this sigaction()
call?  The handler could be read from the struct sigaction passed in.

> > Jeremiah Mahler (5):
> >   progress.c: replace signal() with sigaction()
> >   daemon.c run_service(): replace signal() with sigaction()
> >   daemon.c child_handler(): replace signal() with sigaction()
> >   daemon.c service_loop(): replace signal() with sigaction()
> >   connect.c: replace signal() with sigaction()
> >=20
> >  connect.c  |  5 ++++-
> >  daemon.c   | 15 ++++++++++++---
> >  progress.c |  6 +++++-
> >  3 files changed, 21 insertions(+), 5 deletions(-)
>=20
> Isn't this a bit too much of code churn, given that there were no bug
> reports where signal handling is identified as the culprit despite
> the warning you cited above?
>=20
We might get bugs from continuing to use signal().  We might get bugs f=
rom
changing to sigaction().  I feel more comfortable using sigaction() sin=
ce
its man page is so adamant about not using signal().

--=20
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
