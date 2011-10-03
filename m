From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Tue, 4 Oct 2011 05:13:38 +1100
Message-ID: <20111003181338.GA13392@duynguyen-vnpc>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net>
 <20111003110159.GA13064@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Oct 03 20:14:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAn1a-0005nD-Mm
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 20:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364Ab1JCSNy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 14:13:54 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61333 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834Ab1JCSNx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 14:13:53 -0400
Received: by yxl31 with SMTP id 31so3747767yxl.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A2FlalZRrXiLN5sxOaPL/LdZTTZvT51pAu7AwnVH7+k=;
        b=edx1cqXWMLb+RhocfXFAhyWApaoo9bvQzevMjK6dnWdZmonw+K7M4WKcPkvJ+I2UsQ
         +ezTE1/UDsxPJnbVKU+bnVqbxIGz1iGubvhuFU+dUAvFZlI6tF0RwvzhaJOhXG53Mttp
         vfecCSEulJeRgjnGxJCMiMzg0vGaZjErJKnto=
Received: by 10.236.192.197 with SMTP id i45mr1270298yhn.128.1317665632734;
        Mon, 03 Oct 2011 11:13:52 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id l42sm15312899yhj.12.2011.10.03.11.13.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 11:13:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 04 Oct 2011 05:13:38 +1100
Content-Disposition: inline
In-Reply-To: <20111003110159.GA13064@LK-Perkele-VI.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182682>

On Mon, Oct 03, 2011 at 02:01:59PM +0300, Ilari Liusvaara wrote:
> On Mon, Oct 03, 2011 at 03:42:51AM -0400, Jeff King wrote:
> > On Sat, Oct 01, 2011 at 11:26:55AM +1000, Nguyen Thai Ngoc Duy wrot=
e:
> >=20
> > The real problem here seems to be that instead of communicating "no=
, we
> > don't support that", git-daemon just hangs up. It would be a much n=
icer
> > fix if we could change that. I'm not sure it's possible, though. Th=
ere's
> > not much room in the beginning of the room to make that communicati=
on in
> > a way that's backwards compatible.
>=20
> Oh, sure it is possible (except for remote snapshot):
>=20
> $ /usr/bin/git fetch git://localhost/foobar
> fatal: remote error: R access for foobar DENIED to anonymous
> $=C2=A0/usr/bin/git push git://localhost/foobar
> fatal: remote error: W access for foobar DENIED to anonymous
> $ /usr/bin/git archive --remote=3Dgit://localhost/foobar HEAD
> fatal: git archive: protocol error
> $ /usr/bin/git --version
> git version 1.7.6.3
>=20
> Supported for fetch and push since 1.6.1-rc1 (And 1.6.1 was over
> 2.5 years ago). Oh, and even before that, but with slightly more
> ugly error message.
>=20
> Oh, and adding interpretation of ERR packets to git archive is easy
> (and I even happen to have git:// server that can send those to
> test against):
>=20
> $ git archive --remote=3Dgit://localhost/foobar HEAD
> fatal: remote error: R access for foobar DENIED to anonymous
>=20
> (I also tested that remote snapshotting of repository that should be
> readable succeeds, it does).
>=20
> --- >8 ----
> From ce3a402e4fa72cf603f92801d6f021ff89d3ac35 Mon Sep 17 00:00:00 200=
1
> From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> Date: Mon, 3 Oct 2011 13:55:37 +0300
> Subject: [PATCH] Support ERR in remote archive like in fetch/push
>=20
> Make ERR as first packet of remote snapshot reply work like it does i=
n
> fetch/push. Lets servers decline remote snapshot with message the sam=
e
> way as declining fetch/push with a message.
>=20
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>

Yeah, maybe with this patch also?

-- 8< --
Subject: [PATCH] pack-protocol: document "ERR" line

Since a807328 (connect.c: add a way for git-daemon to pass an error
back to client), git client recognizes "ERR" line and prints a
friendly message to user if an error happens at server side.

Document this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index a7004c6..546980c 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -60,6 +60,13 @@ process on the server side over the Git protocol is =
this:
      "0039git-upload-pack /schacon/gitbook.git\0host=3Dexample.com\0" =
|
      nc -v example.com 9418
=20
+If the server refuses the request for some reasons, it could abort
+gracefully with an error message.
+
+----
+  error-line     =3D  PKT-LINE("ERR" SP explanation-text)
+----
+
=20
 SSH Transport
 -------------
--=20
-- 8< --
