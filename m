From: Jeff King <peff@peff.net>
Subject: Re: [PATCH next v2] log_ref_setup: don't return stack-allocated
 array
Date: Fri, 11 Jun 2010 01:12:36 -0400
Message-ID: <20100611051236.GA3947@coredump.intra.peff.net>
References: <e888313d5a782585f4a5e7ee8914302953c187e2.1276173576.git.trast@student.ethz.ch>
 <47daf53b6b2cc25cc013c5f2183e309a671dc9d3.1276174233.git.trast@student.ethz.ch>
 <AANLkTillDOCNQrpaEiFsFdq6HpU_LlwWI2ELIrEcrWHc@mail.gmail.com>
 <201006101929.11034.trast@student.ethz.ch>
 <AANLkTimEwV_bJkd_2csJB0L6T9Lq6F0hpllUO2pJTL8m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 07:12:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMwXw-0001ol-OJ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 07:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab0FKFMn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 01:12:43 -0400
Received: from peff.net ([208.65.91.99]:37092 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278Ab0FKFMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 01:12:42 -0400
Received: (qmail 2385 invoked by uid 107); 11 Jun 2010 05:12:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Jun 2010 01:12:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jun 2010 01:12:36 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimEwV_bJkd_2csJB0L6T9Lq6F0hpllUO2pJTL8m@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148924>

On Thu, Jun 10, 2010 at 08:09:36PM -0300, Erick Mattos wrote:

> 2010/6/10 Thomas Rast <trast@student.ethz.ch>:
> > What the - side of the hunk above does is returning a local (stack
> > allocated) variable, in the form of a pointer to logfile. =C2=A0Onc=
e those
> > go out of scope, you have zero guarantees on what happens with them=
=2E
>=20
> Not really.
>=20
> What the actual log_ref_setup() does when is instantiated is to creat=
e
> a pointer in the stack, called log_file, to a pointer to a char array=
=2E
>  This pointer receives the address of a char array of the calling
> function because that is why passing by reference is made to.  See
> that the calling functions is using the "&" when making the call (If =
I
> was using C++ I would pass by reference the array itself but in C I
> can only pass pointer variables by reference that is why the pointer
> to a pointer).

No, Thomas is right. This invokes undefined behavior. We point the
passed-in log_file pointer to the front of a character array with
automatic duration. After log_ref_setup returns, we must never
dereference that pointer again, but we do. So we need this patch or
something like it.

In practice, it worked because allocating on the stack is really just
about bumping the stack pointer, so that memory sits there until anothe=
r
function call needs it for stack variables. After returning from
log_ref_setup, we don't actually make any other function calls before
calling open(log_file), so the buffer was still there, untouched. There
is a later use of log_file which is probably bogus, but was likely neve=
r
triggered because it is in an unlikely error conditional.

> Then git_snpath() creates a char array in the heap with the right
> content and changes the stack pointer logfile to it.  Then when we do

No, it doesn't. git_snpath writes into the buffer you provide it, just
like snprintf (hence the name).

> > Admittedly my experience is somewhat limited since I don't do C cod=
ing
> > outside of git and some teaching. =C2=A0But so far I have not had a=
 single
> > false alarm with valgrind (when compiled without optimizations;
> > otherwise the compiler may do some magic).

We have some false positives in git, but you don't see them because
t/valgrind/default.supp suppresses them. For example:

  http://thread.gmane.org/gmane.comp.version-control.git/106335/focus=3D=
107302

If you are using a binary package of valgrind, it probably ships with
some system-specific suppressions, too. Right now valgrind on Debian
unstable is next to useless because glibc has been upgraded to 2.11, bu=
t
the suppressions haven't been updated. So you get false positives all
over the place because of clever architecture-specific optimizations
(e.g., I am seeing a lot of __strlen_sse2 problems, which are probably
just the function over-reading its input data because processing big
chunks is faster).

-Peff
