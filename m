From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] index-pack: eliminate unlimited recursion in get_delta_base()
Date: Mon,  9 Jan 2012 10:59:06 +0700
Message-ID: <1326081546-29320-4-git-send-email-pclouds@gmail.com>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 04:59:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk6Oo-0002Mz-6x
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 04:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392Ab2AID7p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 22:59:45 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35276 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab2AID7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 22:59:44 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so6123831iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 19:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7xggGAWycNNyYklfrByjMczXAvr56v4wlJgFj1y9epQ=;
        b=wm3nlIv4DsoO3V2jkY3auq1Ouom3Z7vrBYFr/rj/q48/gDOaFf+N2jXnq9W1m+9Jx3
         wtOoRjtwZF+8sUjWJRJGD0IIQAug2oal+PJ9mttu1aQmWDzLwYFj8HnRxSIVCUTK+AsP
         reHEEdlBlufTFbLtjW5GTtQShpGa8KET7n0DA=
Received: by 10.50.183.166 with SMTP id en6mr17053520igc.7.1326081584189;
        Sun, 08 Jan 2012 19:59:44 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id lu10sm124635322igc.0.2012.01.08.19.59.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 19:59:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 09 Jan 2012 10:59:35 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188158>

Revert the order of delta applying so that by the time a delta is
applied, its base is either non-delta or already inflated.
get_delta_base() is still recursive, but because base's data is always
ready, the inner get_delta_base() call never has any chance to call
itself again.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 38ff03a..8c1f5d9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -519,10 +519,25 @@ static void *get_base_data(struct base_data *c)
 {
 	if (!c->data) {
 		struct object_entry *obj =3D c->obj;
+		struct base_data **delta =3D NULL;
+		int delta_nr =3D 0, delta_alloc =3D 0;
=20
-		if (is_delta_type(obj->type)) {
-			void *base =3D get_base_data(c->base);
-			void *raw =3D get_data_from_pack(obj);
+		for (; is_delta_type(c->obj->type); c =3D c->base) {
+			ALLOC_GROW(delta, delta_nr + 1, delta_alloc);
+			delta[delta_nr++] =3D c;
+		}
+		if (!delta_nr) {
+			c->data =3D get_data_from_pack(obj);
+			c->size =3D obj->size;
+			base_cache_used +=3D c->size;
+			prune_base_data(c);
+		}
+		for (; delta_nr > 0; delta_nr--) {
+			void *base, *raw;
+			c =3D delta[delta_nr - 1];
+			obj =3D c->obj;
+			base =3D get_base_data(c->base);
+			raw =3D get_data_from_pack(obj);
 			c->data =3D patch_delta(
 				base, c->base->size,
 				raw, obj->size,
@@ -530,13 +545,10 @@ static void *get_base_data(struct base_data *c)
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, "failed to apply delta");
-		} else {
-			c->data =3D get_data_from_pack(obj);
-			c->size =3D obj->size;
+			base_cache_used +=3D c->size;
+			prune_base_data(c);
 		}
-
-		base_cache_used +=3D c->size;
-		prune_base_data(c);
+		free(delta);
 	}
 	return c->data;
 }
--=20
1.7.3.1.256.g2539c.dirty
