From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 06:57:50 -0400
Message-ID: <20090914105750.GB9216@sigill.intra.peff.net>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 12:58:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn9Fv-0007iv-R2
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 12:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbZINK5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2009 06:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZINK5t
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 06:57:49 -0400
Received: from peff.net ([208.65.91.99]:50097 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbZINK5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 06:57:49 -0400
Received: (qmail 23962 invoked by uid 107); 14 Sep 2009 10:58:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 14 Sep 2009 06:58:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2009 06:57:50 -0400
Content-Disposition: inline
In-Reply-To: <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128444>

On Mon, Sep 14, 2009 at 12:16:10PM +0200, Erik Faye-Lund wrote:

> From: Erik Faye-Lund <kusmabite@googlemail.com>
>=20
> Some compilers (including at least MSVC and ARM RVDS) supports
> NORETURN on function declarations, but not on function pointers.
>=20
> This patch makes it possible to define NORETURN for these compilers.
>=20
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

I didn't see a patch 1/2, so maybe it impacts this in some way, but by
itself, I don't think this patch is a good idea. See below.

> ---
>=20
> __attribute__((noreturn)) is, according to the GCC documentation, abo=
ut
> two things: code generation (performance, really) and warnings.
>=20
> On the warnings-side, we need to keep the code warning-free for
> compilers who doesn't support noreturn anyway, so hiding potential
> warnings through this mechanism is probably not a good idea in the
> first place.

[Your justification text would almost certainly be useful as part of th=
e
commit message itself, and should go there.]

Unfortunately, this patch _introduces_ warnings when running with gcc,
as it now thinks those function pointers return (which means it thinks
die() returns). So simply removing the NORETURN is not a good idea.

If I understand you correctly, the problem is that there are actually
three classes of compilers:

  1. Ones which understand some NORETURN syntax for both functions and
     function pointers, and correctly trace returns through both (e.g.,
     gcc).

  2. Ones which understand some NORETURN syntax for just functions, and
     complain about it on function pointers. We currently turn off
     NORETURN for these compilers (from your commit message, MSVC,
     for example).

  3. Ones which have no concept of NORETURN at all.

I think the right solution to turn on NORETURN for (2) is to split it
into two cases: NORETURN and NORETURN_PTR. Gcc platforms can define bot=
h
identically, platforms under (2) above can define NORETURN_PTR as empty=
,
and (3) will keep both off.

I do have to wonder, though. What do compilers that fall under (2) do
with calls to function pointers from NORETURN functions? Do they assume
they don't return, or that they do? Or do they not check that NORETURN
functions actually don't return?

I.e., what does this program do under MSVC:

#include <stdlib.h>
void (*exit_fun)(int) =3D exit;
static void die(void) __attribute__((__noreturn__));
static void die(void) { exit_fun(1); }
int main(void) { die(); }

In gcc, it rightly complains:

  foo.c: In function =E2=80=98die=E2=80=99:
  foo.c:4: warning: =E2=80=98noreturn=E2=80=99 function does return

-Peff
