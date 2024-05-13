Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378B84DF1
	for <git@vger.kernel.org>; Mon, 13 May 2024 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640100; cv=none; b=N49c8VqEulxSQ2+Ui1/capcBJbuplZNHyDEY+ifs63FT0H9IK4JEKn4Vuj2HyUxUdh+0ShzQtAirpdxGRsOk+tKUpDGHsKc+/VwvbLfAkdGaxBwBdckz5FK4o7eDmWKk6wJuwIB7gy/1pifS/qMFdeynUpkq0e3m1JZoR5StHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640100; c=relaxed/simple;
	bh=geiXU3Qn/EY6v3MdrNoEbvpHh9Ug+xrR5qAMHfxOAFQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i42gIEsTdMn9JVzd8Nk+mxOT0ytxpO16Gos2VUofq/UtIj149cu3k2U/uUJ54DoeM3VfHNXmHbwpcpZwOoahqsCB6wvocRszBgNCh1TU0OuTZO88O0590pK4XSzTWQPN8nwes0siknKHMzYnQuhwu2tsbdOiR+EhGqqc2nk/CLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=noHYt/yi; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="noHYt/yi"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E7E128E29;
	Mon, 13 May 2024 18:41:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=geiXU3Qn/EY6v3MdrNoEbvpHh
	9Ug+xrR5qAMHfxOAFQ=; b=noHYt/yii08vAGw3SbiAOalsZhamMIdp1bEnS0jRP
	a5MgYwbhhqRejjXoDCf5DShRF9jvNuOxg05gqRCImC7/sLErP7fxRzODNDSWprQX
	gV0ptBtVYJ+QyBKR+IuwB+J04KON5IkauAiMDhnhFbuBu/l1b+MyiEgETqs/P2Yi
	vc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 06EFF28E28;
	Mon, 13 May 2024 18:41:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66AB028E27;
	Mon, 13 May 2024 18:41:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 2/5] t1517: test commands that are designed to be run outside repository
Date: Mon, 13 May 2024 15:41:24 -0700
Message-ID: <20240513224127.2042052-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <20240513224127.2042052-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240513224127.2042052-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F5345C12-1179-11EF-9C36-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

A few commands, like "git apply" and "git patch-id", have been
broken with a recent change to stop setting the default hash
algorithm to SHA-1.  Test them and fix them in later commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1517-outside-repo.sh | 64 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100755 t/t1517-outside-repo.sh

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
new file mode 100755
index 0000000000..16d9714c27
--- /dev/null
+++ b/t/t1517-outside-repo.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description=3D'check random commands outside repo'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
+. ./test-lib.sh
+
+# Do not use the end-user workaround for this test.
+# GIT_DEFAULT_HASH_ALGORITHM=3Dsha1; export GIT_DEFAULT_HASH_ALGORITHM
+
+test_expect_success 'set up a non-repo directory and test file' '
+	GIT_CEILING_DIRECTORIES=3D$(pwd) &&
+	export GIT_CEILING_DIRECTORIES &&
+	mkdir non-repo &&
+	(
+		cd non-repo &&
+		# confirm that git does not find a repo
+		test_must_fail git rev-parse --git-dir
+	) &&
+	test_write_lines one two three four >nums &&
+	git add nums &&
+	cp nums nums.old &&
+	test_write_lines five >>nums &&
+	git diff >sample.patch
+'
+
+test_expect_failure 'compute a patch-id outside repository' '
+	git patch-id <sample.patch >patch-id.expect &&
+	(
+		cd non-repo &&
+		git patch-id <../sample.patch >../patch-id.actual
+	) &&
+	test_cmp patch-id.expect patch-id.actual
+'
+
+test_expect_failure 'hash-object outside repository' '
+	git hash-object --stdin <sample.patch >hash.expect &&
+	(
+		cd non-repo &&
+		git hash-object --stdin <../sample.patch >../hash.actual
+	) &&
+	test_cmp hash.expect hash.actual
+'
+
+test_expect_failure 'apply a patch outside repository' '
+	(
+		cd non-repo &&
+		cp ../nums.old nums &&
+		git apply ../sample.patch
+	) &&
+	test_cmp nums non-repo/nums
+'
+
+test_expect_success 'grep outside repository' '
+	git grep --cached two >expect &&
+	(
+		cd non-repo &&
+		cp ../nums.old nums &&
+		git grep --no-index two >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_done
--=20
2.45.0-145-g3e4a232f6e

