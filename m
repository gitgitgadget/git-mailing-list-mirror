From: pclouds@gmail.com
Subject: [PATCH 2/2] index-pack: a naive attempt to flatten find_unresolved_deltas
Date: Thu,  8 Dec 2011 20:40:38 +0700
Message-ID: <4ee0be70.44f2320a.3fe8.632b@mx.google.com>
References: <CAJo=hJvrk3Jzg3dQhQnfbmKAFovLuEtJAP4rakHPFeuZ0T5R7g@mail.gmail.com>
 <1323351638-4790-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 14:41:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYeDp-00077t-AX
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207Ab1LHNlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 08:41:08 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62692 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab1LHNlG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:41:06 -0500
Received: by qcqz2 with SMTP id z2so1260834qcq.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6tBGRiYMzpStCreTcyqmJqJtplACDsrKT6WTnrapvhY=;
        b=W1trX6F4BLhSKHHdDgHa+g+ZinFQYrAdVZNzyqyYD+g6aLSMYI++R9wvpTKNZ/fhe9
         bhg1URB7Xzu6cswuO+p0pXWx55ZvUCCUp2IqTJFC4eXSfycgNTOwt3OmxiqkLLekxyOW
         Eye3v+3HNrWCdzLo2Qgl1S6UDQhcTA5IqHRpM=
Received: by 10.50.88.199 with SMTP id bi7mr3700633igb.45.1323351665368;
        Thu, 08 Dec 2011 05:41:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.54.147])
        by mx.google.com with ESMTPS id wo4sm10778486igc.5.2011.12.08.05.41.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 05:41:04 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 08 Dec 2011 20:40:49 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323351638-4790-1-git-send-email-y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186564>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This seems to work for me. But I think this approach uses (much?) more
memory because it turns a tree of calls into a flat list of calls and
keep the list until the end, while the recursive version only has to
keep one call chain at a time.

Any ideas how to improve it?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   57 +++++++++++++++++++++++++++++++++++++-----=
-------
 1 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9855ada..d4c182f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -565,18 +565,31 @@ static void resolve_delta(struct object_entry *de=
lta_obj,
 	nr_resolved_deltas++;
 }
=20
+struct fud_stack {
+	struct base_data base_;
+	struct base_data *base;
+	struct base_data *prev_base;
+};
+
 static void find_unresolved_deltas(struct base_data *base,
 				   struct base_data *prev_base)
 {
+	struct fud_stack **stack =3D NULL;
+	int stk, stack_nr =3D 0, stack_alloc =3D 0;
 	int i, ref_first, ref_last, ofs_first, ofs_last;
=20
-	/*
-	 * This is a recursive function. Those brackets should help reducing
-	 * stack usage by limiting the scope of the delta_base union.
-	 */
-	{
+	ALLOC_GROW(stack, stack_nr + 1, stack_alloc);
+	stack[stack_nr] =3D xmalloc(sizeof(struct fud_stack));
+	stack[stack_nr]->base =3D base;
+	stack[stack_nr]->prev_base =3D prev_base;
+	stack_nr++;
+
+	for (stk =3D 0; stk < stack_nr; stk++) {
 		union delta_base base_spec;
=20
+		base =3D stack[stk]->base;
+		prev_base =3D stack[stk]->prev_base;
+
 		hashcpy(base_spec.sha1, base->obj->idx.sha1);
 		find_delta_children(&base_spec,
 				    &ref_first, &ref_last, OBJ_REF_DELTA);
@@ -588,34 +601,50 @@ static void find_unresolved_deltas(struct base_da=
ta *base,
=20
 		if (ref_last =3D=3D -1 && ofs_last =3D=3D -1) {
 			free(base->data);
-			return;
+			free(stack[stk]);
+			stack[stk] =3D NULL;
+			continue;
 		}
=20
 		link_base_data(prev_base, base);
=20
+		ALLOC_GROW(stack, stack_nr +
+			   (ref_last - ref_first + 1) +
+			   (ofs_last - ofs_first + 1),
+			   stack_alloc);
+
 		for (i =3D ref_first; i <=3D ref_last; i++) {
 			struct object_entry *child =3D objects + deltas[i].obj_no;
-			struct base_data result;
=20
 			assert(child->real_type =3D=3D OBJ_REF_DELTA);
-			resolve_delta(child, base, &result);
+			stack[stack_nr] =3D xmalloc(sizeof(struct fud_stack));
+			stack[stack_nr]->base =3D &stack[stack_nr]->base_;
+			resolve_delta(child, base, stack[stack_nr]->base);
 			if (i =3D=3D ref_last && ofs_last =3D=3D -1)
 				free_base_data(base);
-			find_unresolved_deltas(&result, base);
+			stack[stack_nr]->prev_base =3D base;
+			stack_nr++;
 		}
=20
 		for (i =3D ofs_first; i <=3D ofs_last; i++) {
 			struct object_entry *child =3D objects + deltas[i].obj_no;
-			struct base_data result;
-
 			assert(child->real_type =3D=3D OBJ_OFS_DELTA);
-			resolve_delta(child, base, &result);
+			stack[stack_nr] =3D xmalloc(sizeof(struct fud_stack));
+			stack[stack_nr]->base =3D &stack[stack_nr]->base_;
+			resolve_delta(child, base, stack[stack_nr]->base);
 			if (i =3D=3D ofs_last)
 				free_base_data(base);
-			find_unresolved_deltas(&result, base);
+			stack[stack_nr]->prev_base =3D base;
+			stack_nr++;
 		}
 	}
-	unlink_base_data(base);
+
+	for (stk =3D stack_nr - 1; stk >=3D 0; stk--)
+		if (stack[stk]) {
+			unlink_base_data(stack[stk]->base);
+			free(stack[stk]);
+		}
+	free(stack);
 }
=20
 static int compare_delta_entry(const void *a, const void *b)
--=20
1.7.8.36.g69ee2
