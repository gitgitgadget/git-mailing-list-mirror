From: Jeff King <peff@peff.net>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 10:44:33 -0400
Message-ID: <20100422144433.GB28923@coredump.intra.peff.net>
References: <20100421195822.GX10984@baikonur.stro.at>
 <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
 <20100422121408.GI3211@stro.at>
 <20100422124042.GA1433@progeny.tock>
 <m2hbn37e7q.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	maximilian attems <max@stro.at>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Apr 22 16:45:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4xeV-0007s6-1E
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 16:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab0DVOpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 10:45:07 -0400
Received: from peff.net ([208.65.91.99]:56598 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203Ab0DVOpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 10:45:06 -0400
Received: (qmail 1763 invoked by uid 107); 22 Apr 2010 14:45:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Apr 2010 10:45:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Apr 2010 10:44:33 -0400
Content-Disposition: inline
In-Reply-To: <m2hbn37e7q.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145536>

On Thu, Apr 22, 2010 at 04:29:29PM +0200, Andreas Schwab wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>=20
> > Hi maks,
> >
> > maximilian attems wrote:
> >
> >> ~/src/linux-2.6$ git name-rev a1de02dccf906faba2ee2d99cac56799bda3=
b96a
> >> =C2=A0a1de02dccf906faba2ee2d99cac56799bda3b96a undefined
> >
> > Thanks for pointing it out.  This is weird.
> >
> > The commit doesn=E2=80=99t seem to be part of any tagged release, n=
or linus=E2=80=99s
> > master:
>=20
> $ git branch --contains a1de02dccf906faba2ee2d99cac56799bda3b96a
> * master
> $ git merge-base v2.6.34-rc1 a1de02dccf906faba2ee2d99cac56799bda3b96a
> a1de02dccf906faba2ee2d99cac56799bda3b96a
> git merge-base v2.6.33 a1de02dccf906faba2ee2d99cac56799bda3b96a
> 724e6d3fe8003c3f60bf404bf22e4e331327c596
>=20
> So it has been merged beween v2.6.33 and v2.6.34-rc1

Hmm. Maybe clock skew in the commit timestamps is at fault? With this
patch to git:

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 06a38ac..7a024ab 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -29,9 +29,6 @@ static void name_rev(struct commit *commit,
 	if (!commit->object.parsed)
 		parse_commit(commit);
=20
-	if (commit->date < cutoff)
-		return;
-
 	if (deref) {
 		char *new_name =3D xmalloc(strlen(tip_name)+3);
 		strcpy(new_name, tip_name);

I get:

  $ $ git name-rev a1de02dccf906faba2ee2d99cac56799bda3b96a
  a1de02dccf906faba2ee2d99cac56799bda3b96a tags/v2.6.34-rc1~199^2~35

but I haven't tracked down the problematic commit and timestamp yet.

-Peff
