From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/3] index-pack: eliminate unlimited recursion in get_base_data()
Date: Sat, 14 Jan 2012 19:19:55 +0700
Message-ID: <1326543595-28300-4-git-send-email-pclouds@gmail.com>
References: <1326081546-29320-1-git-send-email-pclouds@gmail.com>
 <1326543595-28300-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 13:21:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm2bX-0002Ow-4I
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 13:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313Ab2ANMUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 07:20:52 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36772 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117Ab2ANMUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 07:20:51 -0500
Received: by mail-iy0-f174.google.com with SMTP id y12so695187iab.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 04:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tcjW9vj6SFJuGBD7rFHkPMScHnmnxmyv9qWgjOmxfvc=;
        b=otw3bTwPUef/2JaK7UqzzESNkl6u1r5k0squQSNfuyZVL4CkYuYUkyeoV2UGxccICr
         /OkLIK2XTdFz6G2G6OEHn4+5OIsMGVp3VfC7NxYXVd8+d9Z7wqoBOlV66+5mIrJDWZ0t
         XmV0WoHY3XauPlxjRTQ2P6QXVGe3A91w7KsiY=
Received: by 10.43.120.2 with SMTP id fw2mr3793352icc.37.1326543651021;
        Sat, 14 Jan 2012 04:20:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.41.201])
        by mx.google.com with ESMTPS id yg2sm12709085igb.1.2012.01.14.04.20.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Jan 2012 04:20:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 14 Jan 2012 19:20:18 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1326543595-28300-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188565>

Revese the order of delta applying so that by the time a delta is
applied, its base is either non-delta or already inflated.
get_base_data() is still recursive, but because base's data is always
ready, the inner get_base_data() call never has any chance to call
itself again.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   53 +++++++++++++++++++++++++++++++++++++++++-=
-------
 1 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 38ff03a..dc6a584 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -515,14 +515,52 @@ static int is_delta_type(enum object_type type)
 	return (type =3D=3D OBJ_REF_DELTA || type =3D=3D OBJ_OFS_DELTA);
 }
=20
+/*
+ * This function is part of find_unresolved_deltas(). There are two
+ * walkers going in the opposite ways.
+ *
+ * The first one in find_unresolved_deltas() traverses down from
+ * parent node to children, deflating nodes along the way. However,
+ * memory for deflated nodes is limited by delta_base_cache_limit, so
+ * at some point parent node's deflated content may be freed.
+ *
+ * The second walker is this function, which goes from current node up
+ * to top parent if necessary to deflate the node. In normal
+ * situation, its parent node would be already deflated, so it just
+ * needs to apply delta.
+ *
+ * In worst case scenario, parent node is no longer deflated because
+ * we're running out of delta_base_cache_limit, then we need to
+ * re-deflate parents, possibly up to the top base.
+ *
+ * All deflated objecsts here are subject to be freed if we exceed
+ * delta_base_cache_limit, just like in find_unresolved_deltas(), we
+ * just need to make sure the last node is not freed.
+ */
 static void *get_base_data(struct base_data *c)
 {
 	if (!c->data) {
 		struct object_entry *obj =3D c->obj;
+		struct base_data **delta =3D NULL;
+		int delta_nr =3D 0, delta_alloc =3D 0;
=20
-		if (is_delta_type(obj->type)) {
-			void *base =3D get_base_data(c->base);
-			void *raw =3D get_data_from_pack(obj);
+		while (is_delta_type(c->obj->type) && !c->data) {
+			ALLOC_GROW(delta, delta_nr + 1, delta_alloc);
+			delta[delta_nr++] =3D c;
+			c =3D c->base;
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
@@ -530,13 +568,10 @@ static void *get_base_data(struct base_data *c)
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
