Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8942AA9
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767523607; cv=none; b=DfJdTVY3gtb9sAS7zh+8yMRQsMlFIzu/z1wYzdgOo9RR8pP0vqMup5UhvsH1wVczEkxcsZ3k/n6ZDfjVTa1AeCpF4+M5EMvf5mUnytNmC5HHamYe/tI5IojyDSDrLP8VRLBqSFBXyRLUIQj+lXGjfHdK5lb0JEvGy7YLY6K0GN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767523607; c=relaxed/simple;
	bh=d6sTddOHTHPaK92bxqdyWU7XH+LVaTo9mqdWQ0Fkoyw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=OnSB0+8rDX/KHjxa53UzJt1bXRvMHPJ55g4t5AoAj/hv2yQXgfN5XHU9Fv59KC9XeWrkcvVEYXlhaWcMxT+1t6bvp62JU5+ucPnXNqhLyXh2BSEHuUfTgD2gZeY4FPIS1jZHdYSjdS/WmP9CPPTlyY9TKtf74DetYvVDQav8DK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Ez3t2Qdj; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Ez3t2Qdj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1767523603; x=1767782803;
	bh=1csj8FIe2uVrcmgrahFJPf0RCF6VAp6vownXnZrNqzk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ez3t2QdjUWgveOabIG6RxG+2oazerC9UByC4oQAuWINy/Pm+BmERgxClmPNhh3wHy
	 wCKWzU4oS0IYKsWuQsqAiDVMjgtsljjKtdoIoBpNaySxVr2PkTNDpBPdo0X4KSXZPr
	 0yxB1XEb/6LlcshVIaA+23ZGHxTpk7DXFhKnHzHTVh7dxq0oClQ0tjZZuAsUas/rSh
	 fmXOc7ixEMIzEfttAbMDCCMAKh1UeICqHjbEJEKODPlmniFIIIGqoykJwH8LSiAE0W
	 REJqtdO9kXJo8X5lczvuWNXGJbVT/OGCPsZfmkVdlu08WWPM/rrFYDtSAk4iurGBG0
	 Ol+x47HOL/AEA==
Date: Sun, 04 Jan 2026 10:46:40 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Subject: [PATCH v2] reftable/iter: fix undefined behavior in indexed_table_ref_iter_next
Message-ID: <iaPdageDbUKEIQVlnOugIRhoojxnFo3j-WJFWY0eC5el1Epu3sxEnto6Lrd3bhAYL0Ry8T3czP5UPhLHX_gfWCDiCoLuMofdRkqfOSYP-Jk=@protonmail.com>
Feedback-ID: 35521663:user:proton
X-Pm-Message-ID: f847097a3f14941a859cc066b85192c75fe37de7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


The indexed_table_ref_iter_next() function accesses ref->value.val2
without first checking the ref's value_type. This is undefined behavior
when the ref is not of type REFTABLE_REF_VAL2.

The correct pattern is already used in filtering_ref_iterator_next()
which checks value_type before accessing the appropriate union member.
Apply the same pattern here:

 - Check for REFTABLE_REF_VAL2 before accessing val2 members
 - Add missing check for REFTABLE_REF_VAL1 to handle single-value refs

This was marked with a "/* BUG */" comment indicating the issue was
known but not yet fixed.

Signed-off-by: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
---
 reftable/iter.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 2ecc52b336..2eee65bb1e 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -171,12 +171,15 @@ static int indexed_table_ref_iter_next(void *p, struc=
t reftable_record *rec)
 =09=09=09}
 =09=09=09continue;
 =09=09}
-=09=09/* BUG */
-=09=09if (!memcmp(it->oid.buf, ref->value.val2.target_value,
-=09=09=09    it->oid.len) ||
-=09=09    !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)) {
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
=20
--=20
2.37.1 (Apple Git-137.1)




Sent with Proton Mail secure email.
