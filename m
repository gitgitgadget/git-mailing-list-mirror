From: Jeff King <peff@peff.net>
Subject: Re: build warnings
Date: Fri, 29 Jan 2010 06:02:01 -0500
Message-ID: <20100129110201.GB6165@coredump.intra.peff.net>
References: <d2e97e801001290103r5b9cfc2aq8daec90c8c88f2ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 12:02:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaocC-0000m7-8l
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 12:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab0A2LCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 06:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113Ab0A2LCH
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 06:02:07 -0500
Received: from peff.net ([208.65.91.99]:53440 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409Ab0A2LCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 06:02:06 -0500
Received: (qmail 4153 invoked by uid 107); 29 Jan 2010 11:02:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 Jan 2010 06:02:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2010 06:02:01 -0500
Content-Disposition: inline
In-Reply-To: <d2e97e801001290103r5b9cfc2aq8daec90c8c88f2ff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138311>

On Fri, Jan 29, 2010 at 08:03:37PM +1100, Michael Wookey wrote:

> With current master (dace5dd1), the following build warnings appear o=
n
> Ubuntu 9.10 (x86):
>=20
>   run-command.c: In function =E2=80=98notify_parent=E2=80=99:
>   run-command.c:70: warning: ignoring return value of =E2=80=98write=E2=
=80=99,
> declared with attribute warn_unused_result
>   run-command.c: In function =E2=80=98die_child=E2=80=99:
>   run-command.c:80: warning: ignoring return value of =E2=80=98write=E2=
=80=99,
> declared with attribute warn_unused_result
>   run-command.c:81: warning: ignoring return value of =E2=80=98write=E2=
=80=99,
> declared with attribute warn_unused_result
>   run-command.c:82: warning: ignoring return value of =E2=80=98write=E2=
=80=99,
> declared with attribute warn_unused_result

There is no point in looking at the return value of any of those calls.
The first one is about notifying the parent process of a child's failur=
e
to exec while it is dying (the surrounding function is even an atexit
handler!). If we can't do that, there is really no alternative behavior=
=2E
The latter three are printing fatal error messages. If we fail at that,
there is not much to do (unless we should print an error...).

>   ~$ gcc --version
>   gcc (Ubuntu 4.4.1-4ubuntu9) 4.4.1

I have heard that Ubuntu recently switched on unused result warnings by
default, and I have seen complaints that it is generating a lot of
uninteresting warnings like these.

Does anybody know if this behavior is here to stay? Can it be worked
around with -Wno-warn-unused-result or something? There are few enough
callsites here that I am not entirely opposed to annotating them with
"(void)write" (does that actually work?), but I worry that this is a
slippery slope. There are a lot of other calls whose return values are
also uninteresting (just looking in the vicinity of this code, I see an
fflush and a close, neither of whose failure would be interesting). I'm
not excited at the prospect of annotating all of them.

-Peff
