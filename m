Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8EAC2C6
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302272; cv=none; b=GKcj0TyEIVQdm0zCwP6yAIfQLoY8GSuq7UE5g6Geb6rbNMva3RGt4empriXlTjmFkxUvPwFgIcHjPpefvV+yqRmIWXthXGRe2bTRnzLhai4UZT5WS562KIpPVZNKNRwn/SXg1pAgGZrBecr+PJyb+tLCduU9krHnd1+nHzg1LHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302272; c=relaxed/simple;
	bh=DAhTwaJlv04Kj9cz5l4czl0JNwykokjSC6CzbWcv9BM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/EeC18tMp5x4t6PADlT4/4ocScxlSnXcL8v1qWUaNat4QZnccZU+5zO6SeEBIg9jz7r6mAGO5b/ZAhNbVtl72LMj2HimIOYuoPCikRjpZmaOuPrWNlwoUpy8J54V27ynm/vKuvAn53d7CAlv8PhjEDvH8PU7lmSdhHS5goVLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M1vo1GeH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M1vo1GeH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B13D3B20C;
	Mon, 29 Jul 2024 21:17:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=DAhTwaJlv04Kj9cz5l4czl0JN
	wykokjSC6CzbWcv9BM=; b=M1vo1GeHxXrNgdBeAUx0tU2vJHnWM+L74MQaGopN6
	ODo/VH5G0x2/bY6PvsEm4XWeL6J0yetRFygcHWPQ9oh6mq10z763/C6z5VKvO18r
	J2cGXUZjSODk7Yrrkxy2b4hBKcu0NFN6W+rbPgoTKK9Xhr+q0d5KSXiX1lzgozUH
	us=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 845CD3B20B;
	Mon, 29 Jul 2024 21:17:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1BB4A3B20A;
	Mon, 29 Jul 2024 21:17:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 3/5] patch-id: make get_one_patchid() more extensible
Date: Mon, 29 Jul 2024 18:17:36 -0700
Message-ID: <20240730011738.4032377-4-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-71-g1aa693ace8
In-Reply-To: <20240730011738.4032377-1-gitster@pobox.com>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240730011738.4032377-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 87C8B0E0-4E11-11EF-8FCD-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

We pass two independent Boolean flags (i.e. do we want the stable
variant of patch-id?  do we want to hash the stuff verbatim?) into
the function as two separate parameters.  Before adding the third
one and make the interface even wider, let's consolidate them into
a single flag word.

No changes in behaviour.  Just a trivial interface change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/patch-id.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 0f262e7a03..1d3b7ff12b 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -58,9 +58,19 @@ static int scan_hunk_header(const char *p, int *p_befo=
re, int *p_after)
 	return 1;
 }
=20
+/*
+ * flag bits to control get_one_patchid()'s behaviour.
+ */
+enum {
+	GOPID_STABLE =3D (1<<0),		/* --stable */
+	GOPID_VERBATIM =3D (1<<1),	/* --verbatim */
+};
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
@@ -171,7 +181,7 @@ static int get_one_patchid(struct object_id *next_oid=
, struct object_id *result,
 	return patchlen;
 }
=20
-static void generate_id_list(int stable, int verbatim)
+static void generate_id_list(unsigned flags)
 {
 	struct object_id oid, n, result;
 	int patchlen;
@@ -179,7 +189,7 @@ static void generate_id_list(int stable, int verbatim=
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
@@ -218,6 +228,7 @@ int cmd_patch_id(int argc, const char **argv, const c=
har *prefix)
 	/* if nothing is set, default to unstable */
 	struct patch_id_opts config =3D {0, 0};
 	int opts =3D 0;
+	unsigned flags =3D 0;
 	struct option builtin_patch_id_options[] =3D {
 		OPT_CMDMODE(0, "unstable", &opts,
 		    N_("use the unstable patch-id algorithm"), 1),
@@ -237,7 +248,11 @@ int cmd_patch_id(int argc, const char **argv, const =
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
2.46.0-69-gd0749fd195

