From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] index-pack: never prune base_cache.
Date: Wed, 23 Jul 2008 15:44:48 +0200
Message-ID: <20080723134448.GB11679@atjola.homenet>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness> <20080723111931.GF15243@artemis.madism.org> <alpine.DEB.1.00.0807231235150.8986@racer> <20080723120045.GA21274@atjola.homenet> <20080723121118.GA20614@artemis.madism.org> <20080723125226.GA11679@atjola.homenet> <alpine.DEB.1.00.0807231407040.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, spearce@spearce.org,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 15:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLefA-0005j2-Fx
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYGWNox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 09:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYGWNox
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:44:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:40732 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751402AbYGWNox (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:44:53 -0400
Received: (qmail invoked by alias); 23 Jul 2008 13:44:50 -0000
Received: from i577BBDAB.versanet.de (EHLO atjola.local) [87.123.189.171]
  by mail.gmx.net (mp007) with SMTP; 23 Jul 2008 15:44:50 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+tVUJmWW2tgVQTZJ2+SLal6YKGKHpVKocCRro0h/
	bwt+TMPBMrpnUT
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231407040.8986@racer>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89651>

On 2008.07.23 14:09:40 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 23 Jul 2008, Bj=F6rn Steinbrink wrote:
>=20
> > On 2008.07.23 14:11:18 +0200, Pierre Habouzit wrote:
> > > It may belong to something (stdin) that is consumed.
> >=20
> > Probably thanks to me, babbling about stdin without having a clue w=
hat=20
> > I'm talking about, that rationale is wrong.
> >=20
> > We may not prune base_cache since that object might come from a
> > different pack than the one that we are processing. In such a case,=
 we
> > would try to restore the data for that object from the pack we're
> > processing and fail miserably.
>=20
> Then the proper fix would be to load the object from that pack again.

Actually, my analysis was total bullshit. Right after reading the objec=
t
from the foreign pack, we also call append_obj_to_pack, so we are
actually able to reread that object just fine. The real issue seems to
be that we just forget to initialize some fields.

This patch fixes the issue for me, but I guess it's not quite the right
way to do it, pure guesswork.

Bj=F6rn

---

diff --git a/index-pack.c b/index-pack.c
index ac20a46..33ba8ef 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -699,6 +699,9 @@ static struct object_entry *append_obj_to_pack(
 	write_or_die(output_fd, header, n);
 	obj[0].idx.crc32 =3D crc32(0, Z_NULL, 0);
 	obj[0].idx.crc32 =3D crc32(obj[0].idx.crc32, header, n);
+	obj[0].hdr_size =3D n;
+	obj[0].type =3D type;
+	obj[0].size =3D size;
 	obj[1].idx.offset =3D obj[0].idx.offset + n;
 	obj[1].idx.offset +=3D write_compressed(output_fd, buf, size, &obj[0]=
=2Eidx.crc32);
 	hashcpy(obj->idx.sha1, sha1);
