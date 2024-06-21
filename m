Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3B6F2F1
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011911; cv=none; b=iNmkWPDT7D3BtIgOPQPHTAwON9UiJjFIy+NmUsVdC9SLOXpOrHNr/E17NeudrjD0yyu+yIlXgLE5L8QkEriYO4Vq1tXtXisZ+KvaIAJyO2wlHRQFm5cjDh7oX0VsdgiICt1M7CKipp5cpLNqbxzlmfFDdBCmb4RJxMm0siZn4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011911; c=relaxed/simple;
	bh=rwJD3pg3SWLZ/tJrkcRqx6duawt60WJC9U4Psd+hk/s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqEqpBE5lkolglmozXkOGs6nILKVbbAPW3rOuwBUkwVsePiO/f6gBOzdM8SEpeIv3tQb/38eyUutuzhhFLrzSMVpOj2spPffpFbgKQDbuJqS8Vuih5INYECK5nfPcYHX/5/iweTm+DWq62nCsaQQPkl7Y0bNepZImGNRgoqAPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pbXAEMer; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pbXAEMer"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7718D27E26;
	Fri, 21 Jun 2024 19:18:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=rwJD3pg3SWLZ/tJrkcRqx6dua
	wt60WJC9U4Psd+hk/s=; b=pbXAEMerWCEpdEsZjD+oKlm9uPcWRIj9m/XGkXBc9
	mTY1aUb6vjrobm8la7WsxLEkJ9C+HVzSmDXNbgBZEZRxgW4P3jj4dPy2L2qK5ifo
	MuqTDsOWLWW5dOIH51CY6Jgd6L8l8VC6LSKLrHK5KKvQIyiD61LhG/3faDLhIR1f
	sE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 709FA27E25;
	Fri, 21 Jun 2024 19:18:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E454527E24;
	Fri, 21 Jun 2024 19:18:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/5] t4204: patch-id supports various input format
Date: Fri, 21 Jun 2024 16:18:22 -0700
Message-ID: <20240621231826.3280338-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-786-g49444cbe9a
In-Reply-To: <20240621231826.3280338-1-gitster@pobox.com>
References: <20240621231826.3280338-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 917ADA9C-3024-11EF-9E2B-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
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
2.45.2-786-g49444cbe9a

