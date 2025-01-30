Received: from ext7.scm.com (ext7.scm.com [49.12.148.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AB819
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.148.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738224698; cv=none; b=XZNb9+Cdm+sFDOUIy6QGofHlb77GW7dnP3iL+sK7zIbWhHQDwqB8vIkXU403ZVJiYWeosD7heM9uz1dwWYS+AD4VvuphugGEKPn0yUezwQCGvbxEiOZiF7hZe3Xu7YNAMZANZ8o+Yt7eKeW9l0S1uq4lqTRzRjvR4K1ov7qgIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738224698; c=relaxed/simple;
	bh=M5g0n3ipCLptce5pYv8dt71RCxAqLtQVilr2NcRwPCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rbc9iAqAW1ArQ1PVlRy51F5LUOxxaH5j+y0jSEGguHtMfVMlyqoUIAL7S/U89HXdMJaJ3gp8iDKFR/l6XF3wHGH5fo8G93XGafwo5Ihy4ldXhaI4cFgzSHftVMt9qkVgd3wJqx2VUURD2dcchEgWHQAa4q9su52gYPiqzBr8IZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b=eefncqzf; arc=none smtp.client-ip=49.12.148.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b="eefncqzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scm.com;
	s=ext7dkim24; t=1738224692;
	bh=c8K2fhGa94WSl/MQTVJDQQvKLBg08qTe5AW9cHBMweA=;
	h=From:To:Cc:Subject:Date:From;
	b=eefncqzfqYOkfYzxgpohpbBUQFNxtCGLmjGvqgsk5vn7lMb47c8dIwWtyJAf0j8mp
	 kEjDW9v+ISXKGhCmdFHaseIHFOOdIPBFUZHpeO7WPn//avkR1DNcqcNIAx/T3qbu3K
	 HcXRp3Pmrs56vWXe61rCVE36PnyUZfVTim3hHIpU7AqwN6S01O2w/GMjFJATcSbkyD
	 /uzruUtN8FkVfKlT7M1pdXRiA2DcrgJQ4pNesyIQ6JaN5z5DFpkOXkaNL9rCg8TnkX
	 n6pKhD2TUc3IEg7J9UcDc+PkBLRZoLeU2wWM3Lx2Vhcso82RtNAtOxxb1zsxAVAs/u
	 cm4C1E4Gn5sittL4Z5jRB+/49yBui/vTXZmq+BQ3FshjKO0hC353aLvvm2Ksr7mkwg
	 3WtJ2mFZMmJlwo6+y44jekuT0LHKYZE5oJXN5XFTOfdNLg2DtNn7DwEccbk69eQWmq
	 GbbPxXI2/Gve7OLdyG+Io//81K2jf7EU6mayLJvGkTomg70dT1cYjhs3czpBh3TrAi
	 7k64Ba8FpfYt+e5duhZHqoSqJwct7/U+wQxsXQXC6VEL9jS0ZIJyrb215qX/xSx03Z
	 rWFq8k5otXsp/vSa4JhDMeWrEZNkpt3APKp+JrAND307OD35Y+vyfJ55G8+c2GQHF+
	 ncCSV9meDrY8DOEfOuVTCxbU=
X-Virus-Scanned: Debian amavisd-new at ext7.scm.com
From: =?UTF-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
Subject:
 [RFC PATCH resend] builtin/repack: Honor --keep-pack and .keep when repacking
 promisor objects
Date: Thu, 30 Jan 2025 09:11:31 +0100
Message-ID: <19759704.fSG56mABFh@electra>
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
ata *data,
 }
=20
 static void repack_promisor_objects(const struct pack_objects_args *args,
=2D				    struct string_list *names)
+				    struct string_list *names,
+				    struct string_list *keep_pack_list)
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
 	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
 	 * hints may result in suboptimal deltas in the resulting pack. See if
@@ -1350,7 +1358,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
=20
 	if (pack_everything & ALL_INTO_ONE) {
=2D		repack_promisor_objects(&po_args, &names);
+		repack_promisor_objects(&po_args, &names, &keep_pack_list);
=20
 		if (has_existing_non_kept_packs(&existing) &&
 		    delete_redundant &&

base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
=2D-=20
2.47.1




