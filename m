From: Jeff King <peff@peff.net>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment
 variables sets putty = true
Date: Wed, 22 Apr 2015 16:29:10 -0400
Message-ID: <20150422202910.GB26917@peff.net>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
 <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
 <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Patrick Sharp <jakanapes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl1Gn-00029k-VY
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbbDVU3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 16:29:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:48846 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751485AbbDVU3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 16:29:13 -0400
Received: (qmail 16196 invoked by uid 102); 22 Apr 2015 20:29:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:29:13 -0500
Received: (qmail 13815 invoked by uid 107); 22 Apr 2015 20:29:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 16:29:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 16:29:10 -0400
Content-Disposition: inline
In-Reply-To: <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267638>

On Wed, Apr 22, 2015 at 02:12:53PM -0500, Patrick Sharp wrote:

> Johannes,
>=20
> You=E2=80=99re correct, looking back over it, I was pretty vague.
>=20
> In truth, we are not using Windows OR putty at all.  Running git on a=
n Ubuntu system, but we are setting the GIT_SSH environment variable to=
 point to a shell script to use.
>=20
> Upon attempting to run git ls-remote, the system was spitting out get=
addrinfo errors for =E2=80=98atch=E2=80=99 .
>=20
> Setting GIT_TRACE=3D2 showed that -batch was being added to the git c=
ommand.
>=20
> This was seen on several different servers with git versions 1.8.5.2,=
 1.9.1 and 2.3.5
>=20
> After a bit we realized that it was the string =E2=80=98uplink=E2=80=99=
 in the GIT_SSH variable that was linked to the extra -batch flag.
>=20
> Finally, after searching the git source, we narrowed it down to the =E2=
=80=98plink=E2=80=99 portion of the string.
>=20
> https://github.com/git/git/blob/7c597ef345aed345576de616c51f27e6f4b34=
2b3/connect.c#L747-L756

I think you want something like:

diff --git a/connect.c b/connect.c
index 9ae991a..58aad56 100644
--- a/connect.c
+++ b/connect.c
@@ -568,7 +568,8 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	conn->argv =3D arg =3D xcalloc(7, sizeof(*arg));
 	if (protocol =3D=3D PROTO_SSH) {
 		const char *ssh =3D getenv("GIT_SSH");
-		int putty =3D ssh && strcasestr(ssh, "plink");
+		int putty =3D ssh && (ends_with(ssh, "plink") ||
+				    ends_with("plink.exe"));
 		if (!ssh) ssh =3D "ssh";
=20
 		*arg++ =3D ssh;

though that is not quite enough (we do not have a case-insensitive
version of "ends_with"). I'm also not sure if matching just "plink" and
"plink.exe" at the end of the string is enough (I'm just guessing that
was the original reason for using strstr in the first place).

Note that I don't think just switching the strcasestr to look for
"plink.exe" is right. For one thing, it just punts on the problem (it
can still happen, it's just less likely to trigger). But for another,
you can have plink (without ".exe") on Linux systems.

-Peff
