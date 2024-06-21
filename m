Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F516F916
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011927; cv=none; b=EVCkmHkHdJunq2dIGVyhZ75L1JfYyhYhibL8Rv20CghgLWysp+ewid9rcz3kPaUtZomC8yxwbUtx2UqeA3f3gb74i+j8RNdxGWhdB2/4M4w8/mvDcb+nX3nsfHMddAiIKs9RlfB37J7CzAbWBvz5MPE5N0mn41maWVSAZrzuxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011927; c=relaxed/simple;
	bh=vVsxOmrnhlhgecP/kbDCaQbjFkRaZ3EwaTavy1PgHZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAT/JfbTmciF/cvMjVmXlGuffaBMsq4Pn7fKk8LrjC+hxZuQeuDDm7VskoT0kTpi5VMMhndVC2iLE9uxHcbViw+y8eO3CNn4604EdKvpnqEAVJkvaHljqulJtXUpKh2gLB3s/NnEWjGLz5LJsdxvHwjM0rIA4tbPcAYt6HZYhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BLKrB5oV; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BLKrB5oV"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AAF3339471;
	Fri, 21 Jun 2024 19:18:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=vVsxOmrnhlhgecP/kbDCaQbjF
	kRaZ3EwaTavy1PgHZk=; b=BLKrB5oVwbinXM3rIguyRzE1fPc6WzW7dD0vjiKzC
	Lj8SAFLr2cXE4vBr8diqOjwcJxJoBNZVnwdLGAtD65jSBPgYnv6wihTKT8yiex8S
	OuJyU1O5faAEkNutIJ5h8ITz87HyXpB3V/aRrMvwsECELzbH3Aa64ZnbIXTPkqX0
	ck=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A3FDA39470;
	Fri, 21 Jun 2024 19:18:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32BDF39457;
	Fri, 21 Jun 2024 19:18:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/5] patch-id: rewrite code that detects the beginning of a patch
Date: Fri, 21 Jun 2024 16:18:25 -0700
Message-ID: <20240621231826.3280338-5-gitster@pobox.com>
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
 966973E2-3024-11EF-B701-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The get_one_patchid() function reads input lines until it finds a
patch header (the line that begins a patch), whose beginning is one
of:

 (1) an "<object name>", which is "git diff-tree --stdin" shows;
 (2) "commit <object name>", which is "git log" shows; or
 (3) "From <object name>",  which is "git log --format=3Demail" gives.

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
index 128e0997d8..a649966f31 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -80,16 +80,19 @@ static int get_one_patchid(struct object_id *next_oid=
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
@@ -130,6 +133,16 @@ static int get_one_patchid(struct object_id *next_oi=
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
2.45.2-786-g49444cbe9a

