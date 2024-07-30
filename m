Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F818BE8
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302267; cv=none; b=fL/nUA6FJTBKGzgiuVKltso3QiCxQ36RRIwzqpR7pXjYzENStQPy0RhfePRlqn+7rcWNBHpHgWhlx38FnmuFV+hmEXZY27RaSaYEWX/siE+pIBgkCpZhk1zBoMQvncT0wao0xyyJkSJA+Yu7ZzWxwAV4s3/Ti217dewhGppwHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302267; c=relaxed/simple;
	bh=sIm/uZmLRU8NrUA2POFrmOidfpI8ely9odWo7sFRetc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ik84QNtsmSCZ/4g0441ut5Mwz2L9V7NFYyXbLyZfsK0VT9DpDESGG2XpLY8YF3X4GW+BZtwqOhfxPPpYIojvukozR1qwJZ2lBrIm5Mu+WfgP/fSXh7FyQI0yTCiJGrXzly8Nv4tFbQrRVBq0jM7DNB8YhDytN5R/wBrKWd8bZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C3ur/07Q; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C3ur/07Q"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AED530A4D;
	Mon, 29 Jul 2024 21:17:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=sIm/uZmLRU8NrUA2POFrmOidf
	pI8ely9odWo7sFRetc=; b=C3ur/07Qqv+SMGe9E1jdg3ID2FdnRE93GK63qXUfu
	SJsD39wOVblviwPKBeGXoBNt3EmoknU1GPwQP0XONnlJVGb9XG1zKzMFjtwM2d8F
	T4RJSXu5AccJ03CuJ1XRLK2FsvSx5rQKQ9Qmj7KibqcGsNnstI8VrBM+IBfKwXTk
	aA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2412830A4C;
	Mon, 29 Jul 2024 21:17:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8910830A4B;
	Mon, 29 Jul 2024 21:17:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/5] t4204: patch-id supports various input format
Date: Mon, 29 Jul 2024 18:17:34 -0700
Message-ID: <20240730011738.4032377-2-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-71-g1aa693ace8
In-Reply-To: <20240730011738.4032377-1-gitster@pobox.com>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240730011738.4032377-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 8479F688-4E11-11EF-9D07-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"git patch-id" was first developed to read from "git diff-tree
--stdin -p" output.  Later it was enhanced to read from "git
diff-tree --stdin -p -v", which was the downstream of an early
imitation of "git log" ("git rev-list" run in the upstream of a pipe
to feed the "diff-tree").  These days, we also read from "git
format-patch".

Their output begins slightly differently, but the patch-id computed
over them for the same commit should be the same.  Ensure that we
won't accidentally break this expectation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4204-patch-id.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index a7fa94ce0a..1627fdda1b 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -114,6 +114,29 @@ test_expect_success 'patch-id supports git-format-pa=
tch output' '
 	test "$2" =3D $(git rev-parse HEAD)
 '
=20
+test_expect_success 'patch-id computes the same for various formats' '
+	# This test happens to consider "git log -p -1" output
+	# the canonical input format, so use it as the norm.
+	git log -1 -p same >log-p.output &&
+	git patch-id <log-p.output >expect &&
+
+	# format-patch begins with "From <commit object name>"
+	git format-patch -1 --stdout same >format-patch.output &&
+	git patch-id <format-patch.output >actual &&
+	test_cmp actual expect &&
+
+	# "diff-tree --stdin -p" begins with "<commit object name>"
+	same=3D$(git rev-parse same) &&
+	echo $same | git diff-tree --stdin -p >diff-tree.output &&
+	git patch-id <diff-tree.output >actual &&
+	test_cmp actual expect &&
+
+	# "diff-tree --stdin -v -p" begins with "commit <commit object name>"
+	echo $same | git diff-tree --stdin -p -v >diff-tree-v.output &&
+	git patch-id <diff-tree-v.output >actual &&
+	test_cmp actual expect
+'
+
 test_expect_success 'whitespace is irrelevant in footer' '
 	get_patch_id main &&
 	git checkout same &&
--=20
2.46.0-69-gd0749fd195

