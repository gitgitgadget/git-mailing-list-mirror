Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD313DDD0
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894771; cv=none; b=KBmtrnvuYgQg1g4QTs5fG8GcceKe1uvuW+RZ6iHzFkCypRDk4Os7EPP+H4naeS0F6DC1/WfEZWNNo7SHkEjBPTyyjnjHqH8xopJm81QsjMZglX/wXmGGu1+s1/+PjcrCLN59MpHP1bRUU4U0aR8mF8yY0Ud23o6WEU+kGRdUiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894771; c=relaxed/simple;
	bh=XnDn5uvCdpNTSgMzBtMXGmXXZUQlZrjMVlpyASmmrdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0J7uvSQ0b5b1o+h+eLFYVMsSGiJxWC9iXSFeNi91luFH0cJVVQSk6jlbyny2ZuLqxnUG0JybcQN6yjdjFVADG/U57yUgo+yLGQYmkurN4Tq6vDq0EqQrj3aXRK5k0KxA6JTRMyjPH+XdPpRUClBWJIFt8L9VTpFJTXcVtnjme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=T22OfRwF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T22OfRwF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C220A2CA5C;
	Tue, 23 Apr 2024 13:52:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=XnDn5uvCdpNTSgMzBtMXGmXXZ
	UQlZrjMVlpyASmmrdo=; b=T22OfRwFvKwoTWcCDCnMK4yEG+xszxLOLi3uiPRjW
	MLwP7XjA6L4/foXrKbKLzmpyNIOBNm3qtlkJ7towHRsfNBsxa1E2Z/C2qnLfmnNg
	0MsMTx9vC1v1q8RkKjneTdJTS/EKWVRmWYAU/qg6ooF3ZnE03KEKapXiCZjIYKWG
	lQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BA3362CA5B;
	Tue, 23 Apr 2024 13:52:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7799C2CA5A;
	Tue, 23 Apr 2024 13:52:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v4 2/2] format-patch: "--rfc=-(WIP)" appends to produce [PATCH (WIP)]
Date: Tue, 23 Apr 2024 10:52:34 -0700
Message-ID: <20240423175234.170434-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-rc0-3-g00e10ef10e
In-Reply-To: <20240423175234.170434-1-gitster@pobox.com>
References: <20240421185915.1031590-1-gitster@pobox.com>
 <20240423175234.170434-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 46BB8D5C-019A-11EF-971A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

In the previous step, the "--rfc" option of "format-patch" learned
to take an optional string value to prepend to the subject prefix,
so that --rfc=3DWIP can give "[WIP PATCH]".

There may be cases in which the extra string wants to come after the
subject prefix.  Extend the mechanism to allow "--rfc=3D-(WIP)" [*] to
signal that the extra string is to be appended instead of getting
prepended, resulting in "[PATCH (WIP)]".

In the documentation, discourage (ab)using "--rfc=3D-RFC" to say
"[PATCH RFC]" just to be different, when "[RFC PATCH]" is the norm.

[Footnote]

 * The syntax takes inspiration from Perl's open syntax that opens
   pipes "open fh, '|-', 'cmd'", where the dash signals "the other
   stuff comes here".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt | 6 ++++++
 builtin/log.c                      | 8 ++++++--
 t/t4014-format-patch.sh            | 9 +++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-forma=
t-patch.txt
index e553810b1e..369af2c4a7 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -247,6 +247,12 @@ RFC means "Request For Comments"; use this when send=
ing
 an experimental patch for discussion rather than application.
 "--rfc=3DWIP" may also be a useful way to indicate that a patch
 is not complete yet ("WIP" stands for "Work In Progress").
++
+If the convention of the receiving community for a particular extra
+string is to have it _after_ the subject prefix, the string _<rfc>_
+can be prefixed with a dash ("`-`") to signal that the the rest of
+the _<rfc>_ string should be appended to the subject prefix instead,
+e.g., `--rfc=3D'-(WIP)'` results in "PATCH (WIP)".
=20
 -v <n>::
 --reroll-count=3D<n>::
diff --git a/builtin/log.c b/builtin/log.c
index 97ca885b33..4750e480e6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2065,8 +2065,12 @@ int cmd_format_patch(int argc, const char **argv, =
const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode =3D parse_cover_from_description(cover_fro=
m_description_arg);
=20
-	if (rfc && rfc[0])
-		strbuf_insertf(&sprefix, 0, "%s ", rfc);
+	if (rfc && rfc[0]) {
+		if (rfc[0] =3D=3D '-')
+			strbuf_addf(&sprefix, " %s", rfc + 1);
+		else
+			strbuf_insertf(&sprefix, 0, "%s ", rfc);
+	}
=20
 	if (reroll_count) {
 		strbuf_addf(&sprefix, " v%s", reroll_count);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 645c4189f9..fcbde15b16 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1394,6 +1394,15 @@ test_expect_success '--rfc=3DWIP and --rfc=3D' '
 	test_cmp expect-raw actual
 '
=20
+test_expect_success '--rfc=3D-(WIP) appends' '
+	cat >expect <<-\EOF &&
+	Subject: [PATCH (WIP) 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --rfc=3D"-(WIP)" >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--rfc does not overwrite prefix' '
 	cat >expect <<-\EOF &&
 	Subject: [RFC PATCH foobar 1/1] header with . in it
--=20
2.45.0-rc0-3-g00e10ef10e

