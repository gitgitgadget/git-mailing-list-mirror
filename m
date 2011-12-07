From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: eliminate unlimited recursion in get_delta_base()
Date: Thu,  8 Dec 2011 00:50:23 +0700
Message-ID: <1323280223-7990-1-git-send-email-pclouds@gmail.com>
References: <7vvcpthh97.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 18:50:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYLdl-0003NM-PD
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 18:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684Ab1LGRuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 12:50:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64601 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab1LGRuj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 12:50:39 -0500
Received: by faar15 with SMTP id r15so262332faa.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=G0SxVc2/22ayIxaCuVH0xzB3aBhdHko1BjFhiXhufUk=;
        b=Eix5NWXTVfBBByFfqNF1hVad6a3iQWw/tMumGjBygPhHeUWyy+LVgXYd4HXJi7btkE
         QNDSDLMaAwmF35qHhlIoV8JxBn4lS2Rtg/886HIYSd+HmuFpeTc4HiSKCWJveT+iSk8J
         gI/vyuR7upPONalSo3PpcfejDEZmUVfjCC5rE=
Received: by 10.50.208.72 with SMTP id mc8mr20487229igc.19.1323280237896;
        Wed, 07 Dec 2011 09:50:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.54.147])
        by mx.google.com with ESMTPS id df6sm1935627ibb.1.2011.12.07.09.50.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 09:50:37 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 08 Dec 2011 00:50:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <7vvcpthh97.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186476>

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
index 0945adb..103e19c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -508,10 +508,25 @@ static void *get_base_data(struct base_data *c)
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
@@ -519,13 +534,10 @@ static void *get_base_data(struct base_data *c)
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
1.7.8.36.g69ee2
