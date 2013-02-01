From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Fri, 1 Feb 2013 02:09:21 -0500
Message-ID: <20130201070921.GA970@sigill.intra.peff.net>
References: <15540714.372461359682286477.JavaMail.weblogic@epml08>
 <7vmwvodd71.fsf@alter.siamese.dyndns.org>
 <20130201063638.GD29973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jongman.heo@samsung.com, Thomas Rast <trast@student.ethz.ch>,
	git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 08:09:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Akw-0002Rw-D7
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 08:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328Ab3BAHJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2013 02:09:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55233 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab3BAHJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 02:09:26 -0500
Received: (qmail 18782 invoked by uid 107); 1 Feb 2013 07:10:49 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 02:10:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 02:09:21 -0500
Content-Disposition: inline
In-Reply-To: <20130201063638.GD29973@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215213>

On Fri, Feb 01, 2013 at 01:36:38AM -0500, Jeff King wrote:

> On Thu, Jan 31, 2013 at 05:40:02PM -0800, Junio C Hamano wrote:
>=20
> > =ED=97=88=EC=A2=85=EB=A7=8C <jongman.heo@samsung.com> writes:
> >=20
> > > But usually when I build upstream Linux kernel, I don't do "make
> > > clean" after git pull..  I didn't expect that I needed "make
> > > clean" for git build.
> >=20
> > We don't expect anybody need "make clean", either.  There is
> > something wrong in the dependency.
>=20
> Agreed, but I cannot see what. If auto-header-dependencies is on, gcc
> should find it (it is not even a recursive dependency for
> builtin/fetch.c). And if it is not on, we should rebuild based on LIB=
_H,
> which includes string-list.h (and always has, as far as I can tell).

By the way, while researching this issue, I noticed this:

-- >8 --
Subject: [PATCH] Makefile: add version.h to LIB_H

This was forgotten when the file was added by 816fb46, and
not noticed because most developers are on modern systems
that support COMPUTE_HEADER_DEPENDENCIES.  However, people
still relying on LIB_H for dependencies might have failed to
recompile when this file changed.

=46ound with "make CHECK_HEADER_DEPENDENCIES=3Dyes".

Signed-off-by: Jeff King <peff@peff.net>
---
I don't see how this could have caused the issue at hand, but it is goo=
d
to fix nonetheless. I almost wonder if LIB_H should just be set to
$(wildcard *.h) or similar, since that is what ends up going into it.
And then we would not have to deal with manually keeping it up to date.

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 731b6a8..6b42f66 100644
--- a/Makefile
+++ b/Makefile
@@ -704,6 +704,7 @@ LIB_H +=3D varint.h
 LIB_H +=3D userdiff.h
 LIB_H +=3D utf8.h
 LIB_H +=3D varint.h
+LIB_H +=3D version.h
 LIB_H +=3D walker.h
 LIB_H +=3D wildmatch.h
 LIB_H +=3D wt-status.h
--=20
1.8.1.2.11.g1a2f572
