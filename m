Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FDE63D5
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904563; cv=none; b=bjTbtigcGPveHB/cUOHmp6Y15X3z8eMXSgHF2DeBCxf9wpLGtoPdaDc3y7kWyUXzdNitigPukEBvPYg9xOey6CkbxSyQQI+eSdBZU2kqZ9py6qklh/p+4B/wsp4p8ANwuvn1p4tfxJ70JEoRJ/EbO0etZXi9T6woC5SwKtUhjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904563; c=relaxed/simple;
	bh=M9KcmDY+UAXiWqoa1XGndAnqA65uw/fofXprqgMuT5M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSdy2cpyQfpraYPWAUA7Feo65cAzj2DlV+8SfuBXB6mHtk7bNsbPx9DmTPqwObRt5XIxXCdUtwqmTQVxiljrpR8uhhZkY1OguF/TA3yPlZQC6idSHVeAGSqEwFMwacWNMavQOlYIhu/y1rKY/sRgSntBukwUpajxZsGuktQS5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LAFcVpn4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LAFcVpn4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 972EF39FFD;
	Mon,  5 Aug 2024 20:35:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=M9KcmDY+UAXiWqoa1XGndAnqA
	65uw/fofXprqgMuT5M=; b=LAFcVpn4raChPcihemlIx9Itpmlm4ZNiJ4Gi6viWd
	SnWAoqzgo8JBvQHxrKPK32H8SWw0/JtvuScb8M1tWfhKfT7tR5x7/Hhgho5tQ4De
	n3wyybTl/eVk4oseu948heKNo8nhLeGq4gZDC8opzEUOO+5VqMLUOMIL8RSC+pa0
	/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EAE239FFC;
	Mon,  5 Aug 2024 20:35:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F10CA39FFB;
	Mon,  5 Aug 2024 20:35:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 4/4] miscellaneous: avoid "too many arguments"
Date: Mon,  5 Aug 2024 17:35:39 -0700
Message-ID: <20240806003539.3292562-5-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-235-g968ce1ce0e
In-Reply-To: <20240806003539.3292562-1-gitster@pobox.com>
References: <20240806003539.3292562-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 D6BC83F0-538B-11EF-B40C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Imagine seeing your command failing with "too many arguments" when
you run "git cmd foo bar baz".  Can you tell it will work if you
said "git cmd foo bar"?  Or is that trimming your command line too
much?  Too little?

Instead, if the command reports "unknown argument: 'bar'", you'd know
that "bar" and everything after it is unwanted.

Let's make it so for a few remaining commands.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/prune-packed.c | 6 +++---
 builtin/receive-pack.c | 3 ++-
 builtin/tag.c          | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index ca3578e158..46989e12f9 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -23,9 +23,9 @@ int cmd_prune_packed(int argc, const char **argv, const=
 char *prefix)
 			     prune_packed_usage, 0);
=20
 	if (argc > 0)
-		usage_msg_opt(_("too many arguments"),
-			      prune_packed_usage,
-			      prune_packed_options);
+		usage_msg_optf(_("unknown argument: '%s'"),
+			       prune_packed_usage, prune_packed_options,
+			       argv[0]);
=20
 	prune_packed_objects(opts);
 	return 0;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 339524ae2a..e49f4ea4dd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2503,7 +2503,8 @@ int cmd_receive_pack(int argc, const char **argv, c=
onst char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, receive_pack_usage,=
 0);
=20
 	if (argc > 1)
-		usage_msg_opt(_("too many arguments"), receive_pack_usage, options);
+		usage_msg_optf(_("unknown argument: '%s'"),
+			       receive_pack_usage, options, argv[0]);
 	if (argc =3D=3D 0)
 		usage_msg_opt(_("you must specify a directory"), receive_pack_usage, o=
ptions);
=20
diff --git a/builtin/tag.c b/builtin/tag.c
index a1fb218512..274bd0e6ce 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -641,7 +641,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
=20
 	object_ref =3D argc =3D=3D 2 ? argv[1] : "HEAD";
 	if (argc > 2)
-		die(_("too many arguments"));
+		die(_("unknown argument: '%s'"), argv[2]);
=20
 	if (repo_get_oid(the_repository, object_ref, &object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
--=20
2.46.0-235-g968ce1ce0e

