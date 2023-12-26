Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853E107A5
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EOqoFszy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5066332DED;
	Tue, 26 Dec 2023 18:32:28 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=2NPRSkYZAGLLZP9BAskPccQHD
	w4ATwGn05Wd5Iw1OJk=; b=EOqoFszyCl4wfjm0KjEDkIIkGkgVLZFA4xlZqb/0J
	TBedhiax8mMe3qmKyajP/HnipGjo7n4X0bqaLEfMJocksza395DpwZfiYg2NLZxG
	191YbPJOMKSjaMpjmdRcP9+sx5+7lraeH6efboobUuziX08Ppnkx4IzZxoDWmjYX
	8c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 48E4632DEC;
	Tue, 26 Dec 2023 18:32:28 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA88F32DEB;
	Tue, 26 Dec 2023 18:32:24 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 1/3] apply: ignore working tree filemode when !core.filemode
Date: Tue, 26 Dec 2023 15:32:16 -0800
Message-ID: <20231226233218.472054-2-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-174-g055bb6e996
In-Reply-To: <20231226233218.472054-1-gitster@pobox.com>
References: <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
 <20231226233218.472054-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 0643329E-A447-11EE-9A68-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Chandra Pratap <chandrapratap3519@gmail.com>

When applying a patch that adds an executable file, git apply
ignores the core.fileMode setting (core.fileMode in git config
specifies whether the executable bit on files in the working tree
should be honored or not) resulting in warnings like:

warning: script.sh has type 100644, expected 100755

even when core.fileMode is set to false, which is undesired. This
is extra true for systems like Windows.

Fix this by inferring the correct file mode from either the existing
index entry, and when it is unavailable, assuming that the file mode
was OK by pretending it had the mode that the preimage wants to see,
when core.filemode is set to false. Add a test case that verifies
the change and prevents future regression.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c                   | 10 ++++++++--
 t/t4129-apply-samemode.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 3d69fec836..3b090652cf 100644
--- a/apply.c
+++ b/apply.c
@@ -3778,8 +3778,14 @@ static int check_preimage(struct apply_state *stat=
e,
 		return error_errno("%s", old_name);
 	}
=20
-	if (!state->cached && !previous)
-		st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
+	if (!state->cached && !previous) {
+		if (!trust_executable_bit)
+			st_mode =3D (*ce && (*ce)->ce_mode) ? (*ce)->ce_mode :
+				(state->apply_in_reverse
+				 ? patch->new_mode : patch->old_mode);
+		else
+			st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
+	}
=20
 	if (patch->is_new < 0)
 		patch->is_new =3D 0;
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index e7a7295f1b..e7026507dc 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -101,4 +101,31 @@ test_expect_success POSIXPERM 'do not use core.share=
dRepository for working tree
 	)
 '
=20
+test_expect_success 'git apply respects core.fileMode' '
+	test_config core.fileMode false &&
+	echo true >script.sh &&
+	git add --chmod=3D+x script.sh &&
+	git ls-files -s script.sh >ls-files-output &&
+	test_grep "^100755" ls-files-output &&
+	test_tick && git commit -m "Add script" &&
+	git ls-tree -r HEAD script.sh >ls-tree-output &&
+	test_grep "^100755" ls-tree-output &&
+
+	echo true >>script.sh &&
+	test_tick && git commit -m "Modify script" script.sh &&
+	git format-patch -1 --stdout >patch &&
+	test_grep "^index.*100755$" patch &&
+
+	git switch -c branch HEAD^ &&
+	git apply --index patch 2>err &&
+	test_grep ! "has type 100644, expected 100755" err &&
+	git reset --hard &&
+
+	git apply patch 2>err &&
+	test_grep ! "has type 100644, expected 100755" err &&
+
+	git apply --cached patch 2>err &&
+	test_grep ! "has type 100644, expected 100755" err
+'
+
 test_done
--=20
2.43.0-174-g055bb6e996

