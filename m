From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 01/15] Move split_cmdline() to alias.c
Date: Sun, 29 Jun 2008 16:05:55 +0200
Message-ID: <486796C3.7040304@free.fr>
References: <cover.1214581610.git.vmiklos@frugalware.org> <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 16:07:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCxYP-0008WT-LU
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 16:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759796AbYF2OFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 10:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759539AbYF2OFu
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 10:05:50 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:46306 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758808AbYF2OFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 10:05:49 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id B107C12B6B9;
	Sun, 29 Jun 2008 16:05:48 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 5062D12B6FB;
	Sun, 29 Jun 2008 16:05:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86804>

Miklos Vajna a =E9crit :
> split_cmdline() is currently used for aliases only, but later it can =
be
> useful for other builtins as well. Move it to alias.c for now,
> indicating that originally it's for aliases, but we'll have it in lib=
git
> this way.

This function does not trim cmdline.=20

Perhaps, the following patch can be inserted after 1/15.

-- >8 --
=46rom: Olivier Marin <dkr@freesurf.fr>
Date: Sat, 28 Jun 2008 13:06:21 +0200
Subject: [PATCH] split_cmdline(): ignore whitespace at start/end of cmd=
line

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 alias.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/alias.c b/alias.c
index ccb1108..7b69d18 100644
--- a/alias.c
+++ b/alias.c
@@ -24,14 +24,16 @@ char *alias_lookup(const char *alias)
=20
 int split_cmdline(char *cmdline, const char ***argv)
 {
-       int src, dst, count =3D 0, size =3D 16;
+       int src =3D 0, dst, count =3D 0, size =3D 16;
        char quoted =3D 0;
=20
        *argv =3D xmalloc(sizeof(char*) * size);
=20
        /* split alias_string */
-       (*argv)[count++] =3D cmdline;
-       for (src =3D dst =3D 0; cmdline[src];) {
+       while (cmdline[src] && isspace(cmdline[src]))
+               src++;
+       (*argv)[count++] =3D cmdline + src;
+       for (dst =3D src; cmdline[src];) {
                char c =3D cmdline[src];
                if (!quoted && isspace(c)) {
                        cmdline[dst++] =3D 0;
@@ -42,7 +44,8 @@ int split_cmdline(char *cmdline, const char ***argv)
                                size +=3D 16;
                                *argv =3D xrealloc(*argv, sizeof(char*)=
 * size);
                        }
-                       (*argv)[count++] =3D cmdline + dst;
+                       if (cmdline[src])
+                               (*argv)[count++] =3D cmdline + dst;
                } else if (!quoted && (c =3D=3D '\'' || c =3D=3D '"')) =
{
                        quoted =3D c;
                        src++;
--=20
1.5.6.1.103.g191a2.dirty
