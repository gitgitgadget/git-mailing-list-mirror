From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] fix hang in git push when pack-objects fails
Date: Thu, 31 Mar 2011 21:34:04 -0400
Message-ID: <20110401013404.GA21036@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201103312245.38987.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 03:34:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5TFg-0001l9-1z
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 03:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab1DABeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 21:34:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36466
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab1DABeH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 21:34:07 -0400
Received: (qmail 4831 invoked by uid 107); 1 Apr 2011 01:34:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 21:34:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 21:34:04 -0400
Content-Disposition: inline
In-Reply-To: <201103312245.38987.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170545>

On Thu, Mar 31, 2011 at 10:45:38PM +0200, Johannes Sixt wrote:

> On Donnerstag, 31. M=C3=A4rz 2011, Jeff King wrote:
> > =C2=A0 1. do nothing. I'm not 100% sure why, but the bug does not m=
anifest
> > =C2=A0 =C2=A0 =C2=A0itself with pthreads. I don't know how it behav=
es on win32.
>=20
> The reason might be that with threads we carefully close file descrip=
tors, so=20
> that the other end sees EOF or broken pipe and terminates, while with=
 a=20
> forked sideband demux one of the channels remains open in the forked =
process?

That was my thought, too, except that:

  1. I don't see us closing the descriptor after we fork the async code
     off. So even if the async code carefully closed it, the main
     process would still have it open.

  2. In some cases it may not even be a file descriptor that needs
     closed, but rather a half-duplex shutdown (e.g., for git-over-tcp)=
=2E
     Because the point of the async code is that it is reading from the
     remote socket.

So I'm really not sure. I can do some straces and try to investigate
further on what happens in the pthread case.  But regardless, it seems
like we should be killing off any async processes explicitly on error.

-Peff
