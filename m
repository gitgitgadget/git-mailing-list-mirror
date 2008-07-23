From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] index-pack: never prune base_cache.
Date: Wed, 23 Jul 2008 14:11:18 +0200
Message-ID: <20080723121118.GA20614@artemis.madism.org>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness> <20080723111931.GF15243@artemis.madism.org> <alpine.DEB.1.00.0807231235150.8986@racer> <20080723120045.GA21274@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 14:12:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLdCh-0000Iq-1u
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 14:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYGWMLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 08:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYGWMLW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 08:11:22 -0400
Received: from pan.madism.org ([88.191.52.104]:54654 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbYGWMLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 08:11:21 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AE3D034590;
	Wed, 23 Jul 2008 14:11:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B6E7CA4D6; Wed, 23 Jul 2008 14:11:18 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080723120045.GA21274@atjola.homenet>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89640>

It may belong to something (stdin) that is consumed.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    On Wed, Jul 23, 2008 at 12:00:45PM +0000, Bj=C3=B6rn Steinbrink wro=
te:
    > On 2008.07.23 12:37:00 +0100, Johannes Schindelin wrote:
    > > Hi,
    > >=20
    > > Well, I cannot.  However, I get some pread issue on i686.  To b=
e nice to=20
    > > kernel.org, I downloaded the pack in question:
    > >=20
    > > 	http://pacific.mpi-cbg.de/git/thin-pack.pack
    > >=20
    > > You should be able to reproduce the behavior by piping this int=
o
    > >=20
    > > git-index-pack --stdin -v --fix-thin --keep=3Dfetch-pack --pack=
_header=3D2,263
    >=20
    > OK, that gave me a seemingly sane backtrace. What seems to happen=
 (AFA
    > my limited knowledge tells me):
    >=20
    > In fix_unresolved_deltas, we read base_obj from an existing pack,=
 other
    > than the one we're reading. We then link that object to the base =
cache.=20
    >=20
    > Then in resolve_delta, we create the "result" base_data object an=
d link
    > that one, too. Now this triggers the pruning, and because the cac=
he is
    > so small, we prune the object that we read from the existing pack=
! Fast
    > forward a few function calls, we end up in get_base_data trying t=
o
    > re-read the data for that object, but this time from the pack tha=
t we
    > got on stdin. And boom it goes.
    >=20
    > Does that make any sense to you?

      Yes, that's obvious, the pack that we read from stdin is consumed=
, we
    should *NEVER* prune base_cache. And indeed that little patch works=
 for
    me.

 index-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index ac20a46..eb81ed4 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -227,7 +227,7 @@ static void prune_base_data(struct base_data *retai=
n)
 	for (b =3D base_cache;
 	     base_cache_used > delta_base_cache_limit && b;
 	     b =3D b->child) {
-		if (b->data && b !=3D retain) {
+		if (b !=3D base_cache && b->data && b !=3D retain) {
 			free(b->data);
 			b->data =3D NULL;
 			base_cache_used -=3D b->size;
--=20
1.6.0.rc0.155.ga0442.dirty
