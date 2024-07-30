Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C428EB
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302273; cv=none; b=d/zKifoLP3Szjxke1t9i3LLbMRNkBJZ5KNGxVdqcH9jspRa21MI4TwWCLDTJifVGBYjl57UluL7dMiR63+UEpsTaaKgZTDgaXGmtIkfAPkoTS3jz9jeXz8aq3N2I7nlft3uVU/TKVjxLHZXtCAK/ZcjpxR+SXhgOmakRjeJvK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302273; c=relaxed/simple;
	bh=k+gfZd9AzS/qBbbr/ccflSHOvUawzGy/6BdwE7sZYaQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inLYOMser9DkXsZbJGuW2/7u74UIMUeOliWXC9jYXTq8GFeg1z/YgNe6/KTbWDuXJpPtG3PgwbhDVj2i+8Uo9faU5EXTXHLXzht0QvRvvr9OxwIB71pW+OroFCDuQCoYbLbSfIJlPIW7KT8ZgFeERHs/tXyvKpBSHWOKDqwpU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oRENUmI+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oRENUmI+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 12EE227F54;
	Mon, 29 Jul 2024 21:17:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=k+gfZd9AzS/qBbbr/ccflSHOv
	UawzGy/6BdwE7sZYaQ=; b=oRENUmI+aSoLUCcQ1L8dgZ0R4gKvltQOMCKr+Xm0f
	ke4nWH0xyXnS8ZC7zpcGGfncwZ6IDzVVV0YMyPuqtfZXmj/G9VlndbUFC+12ToSZ
	lIQ4cpR3LNEgXI4in8kfjPlHyaRDwA/H6fvRiUO22UzyXHu+TynRSoXJyQRPpVtZ
	CY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B80C27F53;
	Mon, 29 Jul 2024 21:17:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B55C27F52;
	Mon, 29 Jul 2024 21:17:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 4/5] patch-id: rewrite code that detects the beginning of a patch
Date: Mon, 29 Jul 2024 18:17:37 -0700
Message-ID: <20240730011738.4032377-5-gitster@pobox.com>
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
 89C4BACE-4E11-11EF-B9C5-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The get_one_patchid() function reads input lines until it finds a
patch header (the line that begins a patch), whose beginning is one
of:

 (1) an "<object name>", which is what "git diff-tree --stdin" shows;
 (2) "commit <object name>", which is what "git log" shows; or
 (3) "From <object name>",  which is what "git log --format=3Demail" show=
s.

When it finds such a line, it returns to the caller, reporting the
<object name> it found, and the size of the "patch" it processed.

The caller then calls the function again, which then ignores the
commit log message, and then processes the lines in the patch part
until it hits another "beginning of a patch".

The above logic was fairly easy to see until 2bb73ae8 (patch-id: use
starts_with() and skip_prefix(), 2016-05-28) reorganized the code,
which made another logic that has nothing to do with the "where does
the next patch begin?" logic, which came from 2485eab5
(git-patch-id: do not trip over "no newline" markers, 2011-02-17)
that ignores the "\ No newline at the end", rolled into the same
single if() statement.

Let's split it out.  The "\ No newline at the end" marker is part of
the patch, should not appear before we start reading the patch part,
and does not belong to the detection of patch header.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/patch-id.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 1d3b7ff12b..a2fdc0505d 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -85,16 +85,19 @@ static int get_one_patchid(struct object_id *next_oid=
, struct object_id *result,
 		const char *p =3D line;
 		int len;
=20
-		/* Possibly skip over the prefix added by "log" or "format-patch" */
-		if (!skip_prefix(line, "commit ", &p) &&
-		    !skip_prefix(line, "From ", &p) &&
-		    starts_with(line, "\\ ") && 12 < strlen(line)) {
+		/*
+		 * If we see a line that begins with "<object name>",
+		 * "commit <object name>" or "From <object name>", it is
+		 * the beginning of a patch.  Return to the caller, as
+		 * we are done with the one we have been processing.
+		 */
+		if (skip_prefix(line, "commit ", &p))
+			;
+		else if (skip_prefix(line, "From ", &p))
+			;
+		if (!get_oid_hex(p, next_oid)) {
 			if (verbatim)
 				the_hash_algo->update_fn(&ctx, line, strlen(line));
-			continue;
-		}
-
-		if (!get_oid_hex(p, next_oid)) {
 			found_next =3D 1;
 			break;
 		}
@@ -135,6 +138,16 @@ static int get_one_patchid(struct object_id *next_oi=
d, struct object_id *result,
 				break;
 		}
=20
+		/*
+		 * A hunk about an incomplete line may have this
+		 * marker at the end, which should just be ignored.
+		 */
+		if (starts_with(line, "\\ ") && 12 < strlen(line)) {
+			if (verbatim)
+				the_hash_algo->update_fn(&ctx, line, strlen(line));
+			continue;
+		}
+
 		if (diff_is_binary) {
 			if (starts_with(line, "diff ")) {
 				diff_is_binary =3D 0;
--=20
2.46.0-69-gd0749fd195

