Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4410FF
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904546; cv=none; b=u25BXQIFhFvkaNdrvltg45RK4BL4nAvSwss6FtIyaGLkwSgN7O9JfROAcosxcUfawduOC/ChUE4cSax329nfwroU4WPpeHeDgf8MQtSZVxYIYvO+pe2hfmikgzwh/2gABw9PA6CcMHZN4IvjRXJJrh2USxF2nL+MqdLMg6zDriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904546; c=relaxed/simple;
	bh=aWHwMZL82j8QemStSVaMIJirsEoEAcKbv/haASSBXBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibo1FTPaP+6Oa2aDDsSJ0VxOvzl+XbYzDq4LEeg5HoHwLI7C9o+1oLGGX8/wcuUesFyMMt13GOY4GOY46xzYN6QN3Lctn9fEo3ZeOkcA23zDB0MOiOvteIILoChVASTiyejbPr+LOMhYHIK8jS9gEv8zDq6HPDWzlUhSXYrpAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YSOrUXt/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YSOrUXt/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF19828347;
	Mon,  5 Aug 2024 20:35:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=aWHwMZL82j8QemStSVaMIJirs
	EoEAcKbv/haASSBXBI=; b=YSOrUXt/ZIHlRR5Rh2NkjwLNHVOSHak8xjW+A2szc
	QaTKmwfPA8kXYPAa99H32lnP3HV6EWl63k8ngmPmuCS7SAcLEWVt46GTi/45knY5
	FjpZUxuQdKoVBaPhTeD4L0mgIKL7sCmMCL+ijJE5Dq7UKciM1oo7fZibOJClO/fO
	30=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D83AA28346;
	Mon,  5 Aug 2024 20:35:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 453B928345;
	Mon,  5 Aug 2024 20:35:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 1/4] refs: avoid "too many arguments"
Date: Mon,  5 Aug 2024 17:35:36 -0700
Message-ID: <20240806003539.3292562-2-gitster@pobox.com>
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
 D05B4CD0-538B-11EF-B5B4-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Running "git refs migrate master main" would fail and say "too many
arguments".  By reading that message, you cannot tell if you just
should have given a single ref and made it "git refs migrate
master", or the command refuses to take any arguments.

Let's report that 'master' is unknown in such an input, which would
be easier for the user to understand.

In this particular case, "the command takes no arguments" would also
be a good alternative message, but because we plan to reuse the same
pattern for commands that take 1 or more messages, and saying "the
command takes exactly 1 argument" when "git foo --option bar baz"
has to fail (because it does not want to see "baz") can mislead the
reader into thinking that "--option" may count as that single
argument, so let's be a bit more explicit and mention the first
thing we do not want to see on the command line instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/refs.c          | 4 +++-
 t/t1460-refs-migrate.sh | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index 46dcd150d4..a2aac38ceb 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -30,7 +30,9 @@ static int cmd_refs_migrate(int argc, const char **argv=
, const char *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, options, migrate_usage, 0);
 	if (argc)
-		usage(_("too many arguments"));
+		usage_msg_optf(_("unknown argument: '%s'"),
+			       migrate_usage, options,
+			       argv[0]);
 	if (!format_str)
 		usage(_("missing --ref-format=3D<format>"));
=20
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index f7c0783d30..b32e740001 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -31,9 +31,10 @@ test_expect_success "superfluous arguments" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	test_must_fail git -C repo refs migrate foo 2>err &&
-	cat >expect <<-EOF &&
-	usage: too many arguments
-	EOF
+	{
+		printf "fatal: unknown argument: ${SQ}foo${SQ}\n\n" &&
+		( git -C repo refs migrate -h || : )
+	} >expect &&
 	test_cmp expect err
 '
=20
--=20
2.46.0-235-g968ce1ce0e

