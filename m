Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A6DDD9
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962217; cv=none; b=QswQE3ErbUE3OQO6oUEcSTu5HKS+uCXZeBXyafIPpAflvaIs00Atq3r72MSatjNeQilfd0rZJ8ze1kyAhPQkauEnaF1lc+Kly5HW2S4uJA6JhxBchEVHgf9+elWN7ZNMm4cQ4TjN//Dw1Aaq9CVV8aHqSZXSt5VrzLVKyWi0V7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962217; c=relaxed/simple;
	bh=qd8TlIaNuav2xetbnliokn0aFyCHjRofZL/i5SeubgU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUH7MOHYMhwXZHz+0DD/D9GLcUJmsbi2RwsgpXNA/JB2WrstNpdd0Ok0DHB+/Knf1CxZGWxkBYjCqHU0WpxaVvydwwXbLXS+eynuSiB9G+yU/GIcRQp/UkjHiwrpkMknsADrBkttVryI1PzjGZOtrzdkuOPun0PqkB4VfnESBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=EiZFdyQN; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="EiZFdyQN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711962212; x=1712221412;
	bh=qd8TlIaNuav2xetbnliokn0aFyCHjRofZL/i5SeubgU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EiZFdyQNiLKdQmnpWbsQjYDMGTdlQHU75kOECGRFxUmWhWCzyJUilDRsTbJ5P59lM
	 430ja5n1/SIK88rtqIodY4ZQC6C046TPKp4ZCFgF/83b5tiq43Kz5UemfIEBwd5fin
	 yh7j/ovsM8NEo+t/UNCnmofYIcYjeZSbPR2yAmiSI39aQE/P0QWeyxfzosSDuOyLt+
	 IfHWX/e+2upVeCLxBT198vB5BOZTQbsavJXZ9X0/MtBX3Cg2f/GmtLUdm+cQT53Rr8
	 oKyIrYBHkyS+u430IWMPrcwWYUE2iXPDIVLoOqkYfY0IyH9JfMW8jV/ubacyQLI9/q
	 sWJwkF6lmbbRA==
Date: Mon, 01 Apr 2024 09:03:25 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v2 4/8] fast-import: remove dead strbuf
Message-ID: <cb05a184e6431edd29fbdfa42980f3fda0cd85ff.1711960552.git.thalia@archibald.dev>
In-Reply-To: <cover.1711960552.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The strbuf in `note_change_n` is to copy the remainder of `p` before
potentially invalidating it when reading the next line. However, `p` is
not used after that point. It has been unused since the function was
created in a8dd2e7d2b (fast-import: Add support for importing commit
notes, 2009-10-09) and looks to be a fossil from adapting
`file_change_m`. Remove it.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 builtin/fast-import.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 58cc8d4ede..fc6eeaf89c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2442,7 +2442,6 @@ static void file_change_cr(const char *p, struct bran=
ch *b, int rename)
=20
 static void note_change_n(const char *p, struct branch *b, unsigned char *=
old_fanout)
 {
-=09static struct strbuf uq =3D STRBUF_INIT;
 =09struct object_entry *oe;
 =09struct branch *s;
 =09struct object_id oid, commit_oid;
@@ -2507,10 +2506,6 @@ static void note_change_n(const char *p, struct bran=
ch *b, unsigned char *old_fa
 =09=09die("Invalid ref name or SHA1 expression: %s", p);
=20
 =09if (inline_data) {
-=09=09if (p !=3D uq.buf) {
-=09=09=09strbuf_addstr(&uq, p);
-=09=09=09p =3D uq.buf;
-=09=09}
 =09=09read_next_command();
 =09=09parse_and_store_blob(&last_blob, &oid, 0);
 =09} else if (oe) {
--=20
2.44.0


