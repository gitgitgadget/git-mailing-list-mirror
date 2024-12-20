Received: from ext7.scm.com (ext7.scm.com [49.12.148.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB71CAAC
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.148.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710215; cv=none; b=F42ieDb6XThYnMuMZ70kghiJen45KsNxJX0A1f/+8wNGFMk6nrdbJQ5MTVNWD3EMlJexK6ZUpNHuYY2/u3+0f03VbYKqf2AKZUZ1YlmFp2Dc0v+kx4qWAqX/j8ngbEHXc39Wk0VygEGuSUQbzPNsbzz6grUGxqdIM7kf8KeZ+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710215; c=relaxed/simple;
	bh=M5g0n3ipCLptce5pYv8dt71RCxAqLtQVilr2NcRwPCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KdCch03E4ZXbgigYW0/11Wp4Vz6iciJcFSsaie2pfp3z0Q8RJqEwd/v2z2qG3JV8VdB63TbccoqLtssbecN8uzpBkY7ioQqCWrYu9DUtNdD+9tHvVOKPDTGaon/7T9AkNQSbzxxc1BvYUMBLN5fHZ14Hm9zfw1L8rr7I3onPXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b=v83dO1l9; arc=none smtp.client-ip=49.12.148.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b="v83dO1l9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scm.com;
	s=ext7dkim24; t=1734709818;
	bh=c8K2fhGa94WSl/MQTVJDQQvKLBg08qTe5AW9cHBMweA=;
	h=From:To:Cc:Subject:Date:From;
	b=v83dO1l9+RX5zsiaWE2bp69fWB/1akAyIZznG6A4adtJ4ZfDcixjd9uohN6vXsNjs
	 GuAo9vuaZYKpWOFbc4jHb1HjngV6iMxTz567cj7aeFPNa9sWIZ9V7CRN2Lr+KoeLVn
	 e6RtpvLWC5+cuNIaA4ySy/5lVJRHc1140GO19p3ZEm68oX4sRjMIZ+5Vv5+t2OOyp3
	 lYki0jVJzS+jCXWZngvZ7Lw2tjq3kGk6rNuM8fo2REHuWz+gxYGnotFi1bFqME73n8
	 h2+WvQL0sTyOa2I0ZryJW2qG3LgwvvphLmGfZ8Nb2yHeej+ZK7iZD+Ap0SBX1/H9Ed
	 4RAQ6T49SFblNhq80l2xKVG+LQ7tl1Icx13iuFsoXzQeLFIXd4zG/OTZqAZfNECLJd
	 bFYXnSbTgM9LRDsd9sDJNI0kCPeuKOiRKNOH7gurKEYPBMXYWHuX7LouDksraU3MiC
	 n7T6371LnrKJ07AqSD3Wjh2LSjOSO9TPRRcjzwEt/kRgu19huymhG512afWAzVXi1C
	 2ifcZPiZCPhP/iYwk7ahACoWetFbCwVTOK/lYLC0cWRwtqXAC4Q29xBKFWs8Tvrg1o
	 xKyPCphnnFtMgqM1TZOt2TjfBrFK9w+bSNVSBC7SDaS3FyRU9NdinK8Ir1A/CkmFHK
	 hDR1Y5CV5J+OY73addnkRcEA=
X-Virus-Scanned: Debian amavisd-new at ext7.scm.com
From: =?UTF-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
Subject:
 [RFC PATCH] builtin/repack: Honor --keep-pack and .keep when repacking
 promisor objects
Date: Fri, 20 Dec 2024 16:50:16 +0100
Message-ID: <26692704.1r3eYUQgxm@electra>
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




