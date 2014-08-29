From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Fri, 29 Aug 2014 16:58:10 -0400
Message-ID: <20140829205809.GB7060@peff.net>
References: <20140829205538.GD29456@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:58:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNTFQ-0001cq-8N
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 22:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbaH2U6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Aug 2014 16:58:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:33423 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750898AbaH2U6M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 16:58:12 -0400
Received: (qmail 4744 invoked by uid 102); 29 Aug 2014 20:58:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 15:58:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 16:58:10 -0400
Content-Disposition: inline
In-Reply-To: <20140829205538.GD29456@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256194>

If a pack contains duplicates of an object, and if that
object has any deltas pointing at it with REF_DELTA, we will
try to resolve the deltas twice. While unusual, this is not
strictly an error, but we currently die() with an unhelpful
message.  We should instead silently ignore the delta and
move on. The first resolution already filled in any data we
needed (like the sha1).

The duplicate base object is not our concern during the
resolution phase, and the .idx-writing phase will decide
whether to complain or allow it (based on whether --strict
is set).

Based-on-work-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c              | 18 ++++++++++--------
 t/t5308-pack-detect-duplicates.sh | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index eebf1a8..acc30a9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -936,20 +936,22 @@ static struct base_data *find_unresolved_deltas_1=
(struct base_data *base,
 		link_base_data(prev_base, base);
 	}
=20
-	if (base->ref_first <=3D base->ref_last) {
+	while (base->ref_first <=3D base->ref_last) {
 		struct object_entry *child =3D objects + deltas[base->ref_first].obj=
_no;
-		struct base_data *result =3D alloc_base_data();
+		struct base_data *result =3D NULL;
=20
-		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
-					   base->obj->real_type))
-			die("BUG: child->real_type !=3D OBJ_REF_DELTA");
+		if (compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
+					  base->obj->real_type)) {
+			result =3D alloc_base_data();
+			resolve_delta(child, base, result);
+		}
=20
-		resolve_delta(child, base, result);
 		if (base->ref_first =3D=3D base->ref_last && base->ofs_last =3D=3D -=
1)
 			free_base_data(base);
-
 		base->ref_first++;
-		return result;
+
+		if (result)
+			return result;
 	}
=20
 	if (base->ofs_first <=3D base->ofs_last) {
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-du=
plicates.sh
index 9c5a876..50f7a69 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -77,4 +77,19 @@ test_expect_success 'index-pack can reject packs wit=
h duplicates' '
 	test_expect_code 1 git cat-file -e $LO_SHA1
 '
=20
+test_expect_success 'duplicated delta base does not trigger assert' '
+	clear_packs &&
+	{
+		A=3D01d7713666f4de822776c7622c10f1b07de280dc &&
+		B=3De68fe8129b546b101aee9510c5328e7f21ca1d18 &&
+		pack_header 3 &&
+		pack_obj $A $B &&
+		pack_obj $B &&
+		pack_obj $B
+	} >dups.pack &&
+	pack_trailer dups.pack &&
+	git index-pack --stdin <dups.pack &&
+	test_must_fail git index-pack --stdin --strict <dups.pack
+'
+
 test_done
--=20
2.1.0.346.ga0367b9
