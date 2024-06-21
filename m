Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60C16F85E
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011919; cv=none; b=G1o/RKTYk6Esz5Vrx3krB6h3P+IkgHtHj6qka9+TG3ch0PB0ehK1zeYkcfpDcQmaBj2Vzo3fN5WdoPwuLhceLSPeV7lRc+NU+0kIFZHuLWw2/vOYq2TRIeAKNkuzZr63S9V65EJrt1yjA8lLtqLKy1xq+zYwJdr/hAv2xrxfEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011919; c=relaxed/simple;
	bh=f4iX3F/uNIwfAdib9dw8aT4AvAD92G+YPup5AxuRuNY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhcL5xIhsKLVbicj5klWCmn+FY2+fyE9tNJVxvtN5s5jwN1v8zt6dGCVQve0U2UVZ/Yumn+xAdl10R+b+rDE3pxJG6U7n/WMfgPQHSFPgkl+DEVN6rEPSe9Gi8hJYnbVGyWG/p2G++B/mNytwvUq2SuaxNil2yjJGEpKQcFjcY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LIer/AUv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LIer/AUv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C102722EEC;
	Fri, 21 Jun 2024 19:18:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=f4iX3F/uNIwfAdib9dw8aT4Av
	AD92G+YPup5AxuRuNY=; b=LIer/AUvUl1h9XKCxguysVsjAjR03SPRxiMl60JUE
	hpmd8kCo6bPsBCC65Gxzn1E7TllhyBOvo+AKfIiqZqJ9i6VM4gCyEdlMTqWD0HK2
	d1Tu0jnfJiCWU/HL4VrCbfHI47VIHAkfkzRhcGSA7N7PBRcMlvOKS4kxhD2wlVBS
	4Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BA6ED22EEB;
	Fri, 21 Jun 2024 19:18:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 856BD22EEA;
	Fri, 21 Jun 2024 19:18:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/5] patch-id: make get_one_patchid() more extensible
Date: Fri, 21 Jun 2024 16:18:24 -0700
Message-ID: <20240621231826.3280338-4-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-786-g49444cbe9a
In-Reply-To: <20240621231826.3280338-1-gitster@pobox.com>
References: <20240621231826.3280338-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 93A283E2-3024-11EF-BCCC-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

We pass two independent Boolean flags (i.e. do we want the stable
variant of patch-id?  do we want to hash the stuff verbatim?) into
the function as two separate parameters.  Before adding the third
one and make the interface even wider, let's consolidate them into
a single flag word.

No changes in behaviour.  Just a trivial interface change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/patch-id.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 0f262e7a03..128e0997d8 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -58,9 +58,14 @@ static int scan_hunk_header(const char *p, int *p_befo=
re, int *p_after)
 	return 1;
 }
=20
+#define GOPID_STABLE   01
+#define GOPID_VERBATIM 02
+
 static int get_one_patchid(struct object_id *next_oid, struct object_id =
*result,
-			   struct strbuf *line_buf, int stable, int verbatim)
+			   struct strbuf *line_buf, unsigned flags)
 {
+	int stable =3D flags & GOPID_STABLE;
+	int verbatim =3D flags & GOPID_VERBATIM;
 	int patchlen =3D 0, found_next =3D 0;
 	int before =3D -1, after =3D -1;
 	int diff_is_binary =3D 0;
@@ -171,7 +176,7 @@ static int get_one_patchid(struct object_id *next_oid=
, struct object_id *result,
 	return patchlen;
 }
=20
-static void generate_id_list(int stable, int verbatim)
+static void generate_id_list(unsigned flags)
 {
 	struct object_id oid, n, result;
 	int patchlen;
@@ -179,7 +184,7 @@ static void generate_id_list(int stable, int verbatim=
)
=20
 	oidclr(&oid);
 	while (!feof(stdin)) {
-		patchlen =3D get_one_patchid(&n, &result, &line_buf, stable, verbatim)=
;
+		patchlen =3D get_one_patchid(&n, &result, &line_buf, flags);
 		if (patchlen)
 			flush_current_id(&oid, &result);
 		oidcpy(&oid, &n);
@@ -218,6 +223,7 @@ int cmd_patch_id(int argc, const char **argv, const c=
har *prefix)
 	/* if nothing is set, default to unstable */
 	struct patch_id_opts config =3D {0, 0};
 	int opts =3D 0;
+	unsigned flags =3D 0;
 	struct option builtin_patch_id_options[] =3D {
 		OPT_CMDMODE(0, "unstable", &opts,
 		    N_("use the unstable patch-id algorithm"), 1),
@@ -237,7 +243,11 @@ int cmd_patch_id(int argc, const char **argv, const =
char *prefix)
 	argc =3D parse_options(argc, argv, prefix, builtin_patch_id_options,
 			     patch_id_usage, 0);
=20
-	generate_id_list(opts ? opts > 1 : config.stable,
-			 opts ? opts =3D=3D 3 : config.verbatim);
+	if (opts ? opts > 1 : config.stable)
+		flags |=3D GOPID_STABLE;
+	if (opts ? opts =3D=3D 3 : config.verbatim)
+		flags |=3D GOPID_VERBATIM;
+	generate_id_list(flags);
+
 	return 0;
 }
--=20
2.45.2-786-g49444cbe9a

