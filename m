From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/5] replace signal() with sigaction()
Date: Wed, 28 May 2014 09:40:55 +0200
Message-ID: <53859307.8080506@viscovery.net>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 09:41:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpYUG-0000Wk-Mv
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 09:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbaE1HlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 03:41:19 -0400
Received: from so.liwest.at ([212.33.55.23]:49140 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375AbaE1HlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 03:41:05 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WpYTo-0002ix-0J; Wed, 28 May 2014 09:40:56 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9977716613;
	Wed, 28 May 2014 09:40:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250269>

Am 5/28/2014 8:14, schrieb Jeremiah Mahler:
> From signal(2)
>=20
>   The behavior of signal() varies across UNIX versions, and has also =
var=E2=80=90
>   ied historically across different versions of Linux.   Avoid  its  =
use:
>   use sigaction(2) instead.  See Portability below.
>=20
> This patch set replaces calls to signal() with sigaction() in all fil=
es
> except sigchain.c.  sigchain.c is a bit more complicated than the oth=
ers
> and will be done in a separate patch.

In compat/mingw.c we have:

int sigaction(int sig, struct sigaction *in, struct sigaction *out)
{
	if (sig !=3D SIGALRM)
		return errno =3D EINVAL,
			error("sigaction only implemented for SIGALRM");
	if (out !=3D NULL)
		return errno =3D EINVAL,
			error("sigaction: param 3 !=3D NULL not implemented");

	timer_fn =3D in->sa_handler;
	return 0;
}

Notice "only implemented for SIGALRM". Are adding the missing signals
somewhere (here or in a later patch)?

> Jeremiah Mahler (5):
>   progress.c: replace signal() with sigaction()
>   daemon.c run_service(): replace signal() with sigaction()
>   daemon.c child_handler(): replace signal() with sigaction()
>   daemon.c service_loop(): replace signal() with sigaction()
>   connect.c: replace signal() with sigaction()
>=20
>  connect.c  |  5 ++++-
>  daemon.c   | 15 ++++++++++++---
>  progress.c |  6 +++++-
>  3 files changed, 21 insertions(+), 5 deletions(-)

Isn't this a bit too much of code churn, given that there were no bug
reports where signal handling is identified as the culprit despite
the warning you cited above?

-- Hannes
