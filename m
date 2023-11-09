Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9D18AEA
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="QkV52KDc"
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473DB272C
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 03:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail2; t=1699528812; x=1699788012;
	bh=F9EeJAgg58mFeyxh9RCOhOb2f1KYcY8h6L00x392uwU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QkV52KDcgxdEANwxgVvFZDx3Y1wvTDAeXvyUdUgdVn7+x2s1IafMhMzDm+fHyc2eA
	 h65nlxQkpGB/RN4s5maBJVy+of5xxFZv0rPndVfTRkMbaLhptmidKYeSTE/qK+EADH
	 ERmoYawhzZjUy+eyBrAYX7X6jYmqjvHMQwWcwZ7DpbXISBPttnyg44d2H3izX/9XCl
	 x9wA3YpTEFBZfJNP/Bt+43lm8wmte/LkIsDUjCZEg/H5URd4zapz9Ubz4D2MoGILan
	 9bd/DOYCrpGMcyliDJZsq4imRiExj4rozoQRj0m8wUx5p2h+J+a13E8sVPBq533Cpq
	 d7YU+N90cU6Jw==
Date: Thu, 09 Nov 2023 11:19:56 +0000
To: git@vger.kernel.org
From: Simon Ser <contact@emersion.fr>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] format-patch: fix ignored encode_email_headers for cover letter
Message-ID: <20231109111950.387219-1-contact@emersion.fr>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When writing the cover letter, the encode_email_headers option was
ignored. That is, UTF-8 subject lines and email addresses were
written out as-is, without any Q-encoding, even if
--encode-email-headers was passed on the command line.

This is due to encode_email_headers not being copied over from
struct rev_info to struct pretty_print_context. Fix that and add
a test.

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 builtin/log.c           |  1 +
 t/t4014-format-patch.sh | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index ba775d7b5cf8..87fd1c8560de 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1364,6 +1364,7 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 =09pp.date_mode.type =3D DATE_RFC2822;
 =09pp.rev =3D rev;
 =09pp.print_email_subject =3D 1;
+=09pp.encode_email_headers =3D rev->encode_email_headers;
 =09pp_user_info(&pp, NULL, &sb, committer, encoding);
 =09prepare_cover_text(&pp, description_file, branch_name, &sb,
 =09=09=09   encoding, need_8bit_cte);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 5ced27ed4571..e37a1411ee24 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1906,6 +1906,16 @@ body" &&
 =09grep "^body$" actual
 '
=20
+test_expect_success 'cover letter with --cover-from-description subject (U=
TF-8 subject line)' '
+=09test_config branch.rebuild-1.description "Caf=C3=A9?
+
+body" &&
+=09git checkout rebuild-1 &&
+=09git format-patch --stdout --cover-letter --cover-from-description subje=
ct --encode-email-headers main >actual &&
+=09grep "^Subject: \[PATCH 0/2\] =3D?UTF-8?q?Caf=3DC3=3DA9=3D3F?=3D$" actu=
al &&
+=09! grep "Caf=C3=A9" actual
+'
+
 test_expect_success 'cover letter with format.coverFromDescription =3D aut=
o (short subject line)' '
 =09test_config branch.rebuild-1.description "config subject
=20
--=20
2.42.0


