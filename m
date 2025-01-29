Received: from ext7.scm.com (ext7.scm.com [49.12.148.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A51B0F18
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.148.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145520; cv=none; b=PA4aK0OTJaTxgok9xjEsmkMXxj1bLUSFV1DQML0pIyJk0sAesibOur110terqrRD8XbIBsqT87CDaaSjpdp24iNdeKV46v1QgaqADXyKfhxh4OvIKxU8kX5BmMbgvcmR8qOkb02wyLRJEAa7Aqv7E3+yeF8Was1DIwvG2QryWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145520; c=relaxed/simple;
	bh=I07B8LFviU4lBLRpe02HnAAtVvxcaieYpICnSmDv10A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bv59UvFyT6oqLIXOub5nY/Qb+Pf5P4RNztnwRRhwYlZyFzbNjwXuS9ghJv+QX9CAFBp4P5WVTVDy/POSTO54qKw3WsMNc/NcQCu/y4UZWlID0/AMKwl+mp6Bd/fUQ6ZHq4VBYujTclL83jhZAryoCWfoSrYh346LlJjfW3y3eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b=ct8L46up; arc=none smtp.client-ip=49.12.148.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b="ct8L46up"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scm.com;
	s=ext7dkim24; t=1738144927;
	bh=ZvCOo9yzpuW77Vxv6HeQm/SHV7xrAu+gUQWvyIcBb9w=;
	h=From:To:Cc:Subject:Date:From;
	b=ct8L46up+CYGhr3JLgLCoHnpw4Cx0zrMvLC2NfPBflQ7T/A/A3PoOngtaNfOorp8z
	 xMNkWkwtzAn2zZ/2Zk+UwXFFpxJLrNhR2IBWVpFtItyDeUXDabEu2QSk/+2Do0dNeA
	 BUqPHS89bl9RtrJf4/RmhmSFJ/7L35xfmNNm0aK7monDQ+MAv7fYKgAX4AYGP0qG54
	 X9rmOuIqXy9oQVIJTWyFvzwkaMnz+BAfHkkwq2jlCSqK76QxeOiC0mXdyL/xC9ipqT
	 uy6W4K1L9UPyNLXdP+UAxwunP/z8Zi5OyVZizy3CUEs9Nu2kp/m3StZgnK2081+ueC
	 qSgv0Sq3pkcJjyiNW8lje8W1HTbTb7Jq1RSCztkz30vvUih3vpzuFx/vgmyVg1xG28
	 y6DOEN5UvcgKm/14afOCNQnsmyykdfoPrXyJ2Xy8tOg/Qtk568OI9lc9Da0YSb41oq
	 A9Zu+ePLpplp3cYaMmduMHAMYWiAqA4Cqm7Dzi1w9Urst6igdfdhqxxZFDuWNTnTfW
	 r11nrtUcjGDFwV75c2d8yJ4u7DAKmByaIw7xtnekeosflyk+BJtkEPWiR0zMp7GL79
	 dmA2zDmGUOEok1vwnUZQ0Iy4NWuBDTJpzmMJJxFiBQqiDa0NIIexGR6381izr0e+yL
	 Ar13uLJkIjSmNIt+pfJ3+lG8=
X-Virus-Scanned: Debian amavisd-new at ext7.scm.com
From: =?UTF-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
Subject:
 [RFC PATCH resend] builtin/repack: Honor --keep-pack and .keep when repacking
 promisor objects
Date: Wed, 29 Jan 2025 11:02:06 +0100
Message-ID: <2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

git-repack currently does not pass --keep-pack or --honor-pack-keep to
the git-pack-objects handling promisor packs. This means that settings
like gc.bigPackThreshold are completely ignored for promisor packs.

The simple fix is to just copy the keep-pack logic into
repack_promisor_objects(), although this could possibly be improved by
making prepare_pack_objects() handle it instead.

Signed-off-by: Tom=C3=A1=C5=A1 Trnka <trnka@scm.com>
=2D--

RFC: This probably needs a test, but where and how should it be
implemented? Perhaps in t7700-repack.sh, copying one of the tests using
prepare_for_keep_packs and just touching .promisor files? Or instead in
t/t0410-partial-clone.sh using a copy/variant of one of the basic=20
repack tests there?

 builtin/repack.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d6bb37e84a..fe62fe03eb 100644
=2D-- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -388,15 +388,23 @@ static int has_pack_ext(const struct generated_pack_d=
ata=20
*data,
 }
=20
 static void repack_promisor_objects(const struct pack_objects_args *args,
=2D				    struct string_list *names)
+				    struct string_list *names,
+				    struct string_list=20
*keep_pack_list)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	FILE *out;
 	struct strbuf line =3D STRBUF_INIT;
+	int i;
=20
 	prepare_pack_objects(&cmd, args, packtmp);
 	cmd.in =3D -1;
=20
+	if (!pack_kept_objects)
+		strvec_push(&cmd.args, "--honor-pack-keep");
+	for (i =3D 0; i < keep_pack_list->nr; i++)
+		strvec_pushf(&cmd.args, "--keep-pack=3D%s",
+			     keep_pack_list->items[i].string);
+
 	/*
 	 * NEEDSWORK: Giving pack-objects only the OIDs without any=20
ordering
 	 * hints may result in suboptimal deltas in the resulting pack. See=20
if
@@ -1350,7 +1358,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
=20
 	if (pack_everything & ALL_INTO_ONE) {
=2D		repack_promisor_objects(&po_args, &names);
+		repack_promisor_objects(&po_args, &names,=20
&keep_pack_list);
=20
 		if (has_existing_non_kept_packs(&existing) &&
 		    delete_redundant &&

base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
=2D-=20
2.47.1




