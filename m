Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACC500962
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891142; cv=none; b=SYmM0RC900qmurDL8gjUE4y0FYvpIQIyt7L+n9FR4q1bMePtClUVc4On8rak0duFcghXgjbBjiUz/JsAYFARSMM3lJgSlkM/2siXdzwvVX7l2KcxIyuKzsJp6gcbWQqRvusGn/o8V49ItEUYA803ulrNEJGN+6TkfcfZ+fepT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891142; c=relaxed/simple;
	bh=Cgvj8MjG7ZquwlHe9TBhgkgG7tQkkH6Bz1wNMaeP6s4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVuqkh4W3r1f7bmPzJdnJpAA581iFVAYgszTAesOHqrK21PkS+rKm7XN6SMH0TUHlqYyz0sb0sVH5RO4SD3ztrkK0PMxlgEaVS7g4MPTTUYZyyLQLiuguOzyPddfl7xpUcgr+5ftd0zzlW2dPcePRelspMHjCrjG8M2c9crhDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=fail smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=sIkYSwjB; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="sIkYSwjB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1767891129; x=1768150329;
	bh=NhTgbsLYNxbRMQbOT3W0KlZ9vNT0L+PTUZ9660q6qP4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sIkYSwjBxSQe1kFqstPdYWJSICx1OZb3ZdZMJEERmRD2UBqJe2nkE6Vx+ssgdD7sl
	 rPLkBAFveHEH8he+jBAV31ylx2fDrqLzr8EwM+F9C5YQZfAANxEMeOrOOyLrHSwLJG
	 0ta2uY4pAHOaabiPbG/Tl/A0rZ/2rYhf6t10Eb+CGfbKRL3XjSF4MSxCepOJpwAdCo
	 pqFkMsEhjEiDRCieEesbTdERcGhIzoAIGlYGP+ufEtsRwNuuRn9B/NUs5qBgrtiiRZ
	 KUWjFTgDYqVeE9lJuKhiMK+h7CWZMOK5feKrdiTI+4547kvy5eke+QaRoUYwDwe0Hh
	 /Sx5LbL5yBGZw==
Date: Thu, 08 Jan 2026 16:52:05 +0000
To: Patrick Steinhardt <ps@pks.im>
From: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2] reftable/iter: fix UB in indexed_table_ref_iter_next
Message-ID: <f4gLTILYbAvRqE-aKM3PTyIajeuZBM2Vgo5V66Q8gI6gpI0niPpz8w_lMa29V4Rou2TJ95SKwm2B16KitVrt47KtCzY-eRBm7kemh0iw82s=@protonmail.com>
In-Reply-To: <aVvR6U6EJ9wfKk8l@pks.im>
References: <iaPdageDbUKEIQVlnOugIRhoojxnFo3j-WJFWY0eC5el1Epu3sxEnto6Lrd3bhAYL0Ry8T3czP5UPhLHX_gfWCDiCoLuMofdRkqfOSYP-Jk=@protonmail.com> <aVvR6U6EJ9wfKk8l@pks.im>
Feedback-ID: 35521663:user:proton
X-Pm-Message-ID: c01ed8a568012b2065264a0863558c7b6bb5a03a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The indexed_table_ref_iter_next() function provides reverse mappings from
object IDs to references. It currently accesses ref->value.val2 without
checking the reference's value_type, leading to undefined behavior when
encountering unpeeled references (REFTABLE_REF_VAL1).

While the current "obj" table implementation is suboptimal=E2=80=94it yield=
s all
reference records within a block and relies on manual filtering=E2=80=94thi=
s
manual comparison is necessary to ensure the yielded record actually
matches the target OID prefix requested by the caller.

Fix the undefined behavior by checking the value_type before performing
the memory comparison. Additionally, replace the "/* BUG */" comment
with a TODO explaining the current implementation's inefficiency, as
suggested by the maintainer.

Signed-off-by: Tsahi Elkayam <Tsahi.Elkayam@Protonmail.com>
---
 reftable/iter.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 2ecc52b336..2eee65bb1e 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -171,12 +171,19 @@ static int indexed_table_ref_iter_next(void *p, struc=
t reftable_record rec)
 =09=09=09}
 =09=09=09continue;
 =09=09}
-=09=09/* BUG */
-=09=09if (!memcmp(it->oid.buf, ref->value.val2.target_value,
-=09=09=09    it->oid.len) ||
-=09=09    !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)) {
+
+=09=09/*
+=09=09 * TODO: The current implementation is suboptimal as it yields
+=09=09 * all ref records in the block rather than filtering by the
+=09=09 * OID prefix. This manual comparison is still necessary.
+=09=09 */
+=09=09if (ref->value_type =3D=3D REFTABLE_REF_VAL2 &&
+=09=09    (!memcmp(it->oid.buf, ref->value.val2.target_value,
+=09=09=09     it->oid.len) ||
+=09=09     !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)))
+=09=09=09return 0;
+
+=09=09if (ref->value_type =3D=3D REFTABLE_REF_VAL1 &&
+=09=09    !memcmp(it->oid.buf, ref->value.val1, it->oid.len))
 =09=09=09return 0;
-=09=09}
 =09}
 }
--
2.47.1
