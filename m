From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Mon, 16 Apr 2012 13:42:30 -0400
Message-ID: <20120416174230.GA19226@sigill.intra.peff.net>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki>
 <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	gitster@pobox.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:42:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJpwl-0001Wm-GL
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110Ab2DPRme convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 13:42:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36423
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab2DPRme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 13:42:34 -0400
Received: (qmail 26901 invoked by uid 107); 16 Apr 2012 17:42:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Apr 2012 13:42:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Apr 2012 13:42:30 -0400
Content-Disposition: inline
In-Reply-To: <4F8C3E0F.2040300@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195671>

On Mon, Apr 16, 2012 at 05:43:11PM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> % dash -x test2.sh | wc -l
> + mkfifo fd
> + pid=3D10738
> + read line
> + yes
> + echo y
> + sleep 1
> + kill 10738
> test2.sh: 12: kill: No such process
>=20
> + wait 10738
> + rm -f fd
> ^C
>=20
> It hangs at the end until killed with ^C. This seem to happen fairly =
reliably
> (nineteen times out of twenty or so). This is with dash 0.5.7-3 and 0=
=2E5.5.1-7.4
> from debian. With bash test2.sh seems to always run successfully.

Hmm. t5570 seems to pass reliably on dash for me with:

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index ef2d01f..9f52cb6 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -33,7 +33,7 @@ start_git_daemon() {
 	{
 		read line
 		echo >&4 "$line"
-		cat >&4 &
+		cat >&4 <git_daemon_output &
=20
 		# Check expected output
 		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" !=3D x"Ready to rum=
ble"

But the test above does fail. Is it purely luck of the timing that
git-daemon never gets SIGPIPE? I guess the problem is that the
{}-section can finish before "cat <git_daemon_output" has actually
opened the pipe?

I'd just feel better about the solution if we were sure we understood
the exact problem.

-Peff
