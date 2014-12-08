From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] index-pack: terminate object buffers with NUL
Date: Mon, 8 Dec 2014 15:17:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412081511390.13845@s15462909.onlinehome-server.info>
References: <20141208054812.GA30154@peff.net> <20141208055706.GA30207@peff.net> <20141208112835.GA15919@lanh>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1144113655-1418048275=:13845"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 15:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxz8e-00039T-GT
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 15:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbaLHOSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 09:18:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:49274 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbaLHOSE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 09:18:04 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MF4iR-1YDc402mR1-00GF6s;
 Mon, 08 Dec 2014 15:17:55 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141208112835.GA15919@lanh>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:AEbmOL7+9B6qKhx5q/4p5X7Zrq/tu8lEwTPinEHGG7O4jrgkMeJ
 GIkB1usNdLuvPJdnwvcYCipgoj3mhqZjH6gJngfo1iuTfBTGdU8ZsjTgZrpz50Ap/ng8MZt
 Ff3TNPfmzYKCSWl5er3mpFyvMt6iHDXWblsynXWGT1X/OR+sRSj3XZUsYhaPYoDVEMJSh3B
 J83RA8C+66xjvIAx+OW3g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261044>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1144113655-1418048275=:13845
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

From: Duy Nguyen <pclouds@gmail.com>

We have some tricky checks in fsck that rely on a side effect of
require_end_of_header(), and would otherwise easily run outside
non-NUL-terminated buffers. This is a bit brittle, so let's make sure
that only NUL-terminated buffers are passed around to begin with.

Jeff "Peff" King contributed the detailed analysis which call paths are
involved and pointed out that we also have to patch the get_data()
function in unpack-objects.c, which is what Johannes "Dscho" Schindelin
implemented.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Analyzed-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

=09On Mon, 8 Dec 2014, Duy Nguyen wrote:

=09> Subject: [PATCH] index-pack: terminate object buffers with NUL
=09>=20
=09> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>

=09Here is a patch that is updated with Peff's suggested
=09unpack-object.c:get_data change.

=09While it is not as good as Peff's analysis, I can provide an
=09additional data point: the test suite passes cleanly even with

=09=09https://github.com/dscho/git/commit/567ad592

=09applied (and with 567ad592, but without below changes, at least
=09t1050 does not pass).

 builtin/index-pack.c     | 4 ++--
 builtin/unpack-objects.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a369f55..4632117 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -447,7 +447,7 @@ static void *unpack_entry_data(unsigned long offset, un=
signed long size,
 =09if (type =3D=3D OBJ_BLOB && size > big_file_threshold)
 =09=09buf =3D fixed_buf;
 =09else
-=09=09buf =3D xmalloc(size);
+=09=09buf =3D xmallocz(size);
=20
 =09memset(&stream, 0, sizeof(stream));
 =09git_inflate_init(&stream);
@@ -552,7 +552,7 @@ static void *unpack_data(struct object_entry *obj,
 =09git_zstream stream;
 =09int status;
=20
-=09data =3D xmalloc(consume ? 64*1024 : obj->size);
+=09data =3D xmallocz(consume ? 64*1024 : obj->size);
 =09inbuf =3D xmalloc((len < 64*1024) ? len : 64*1024);
=20
 =09memset(&stream, 0, sizeof(stream));
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 855d94b..ac66672 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -91,7 +91,7 @@ static void use(int bytes)
 static void *get_data(unsigned long size)
 {
 =09git_zstream stream;
-=09void *buf =3D xmalloc(size);
+=09void *buf =3D xmallocz(size);
=20
 =09memset(&stream, 0, sizeof(stream));
=20
--=20
1.8.4.msysgit.0.dirty

--1784107012-1144113655-1418048275=:13845--
