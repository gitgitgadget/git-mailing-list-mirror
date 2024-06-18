Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117218E77E
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754295; cv=none; b=RIPAk5ip6yv8wDwCbTtLX+RjTnViEpDLZ1no3gBghBxu0LpV8gST5tIU/zQgIIgAjzlcirMm7YN0prMZrl4TZnMunbDCVEXUluZbWh46/wC4mFkG/kPP6xvtg+kZH+RYycOXbN4uG7Pvgmvbsv6rwHqsrfpZFV2sTOivaZdEm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754295; c=relaxed/simple;
	bh=Yb0TMbnGaa4vcvNXwbNIMOrUKcazKzoaRmXN/E80iv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2uLLRXfOVeZHv5BtxyixJrw0iHexvbmPqLSOi9DeEr7XyIamihCWcrVRDBPS9/Fr1GPChaZX2utTEfvjzIAkVod9D597RO4eWv+Y+oz9D8Gi/rW8HwPFlcLUU5wbZwhgP0uh9h5qaAo5W1EcZ74VKtOxBp/yJC6u3vcobknyws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q3FurwD6; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q3FurwD6"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A0B7E29481;
	Tue, 18 Jun 2024 19:44:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Yb0TMbnGaa4vcvNXwbNIMOrUK
	cazKzoaRmXN/E80iv4=; b=q3FurwD692TxE4l7QmIiVxoieyARbuGy9tA+1OC/2
	xm3FQ8GG7G/gEEuOxBIWtKknPz4tP73GKDzuYKogGWJ3KM/wuMw049eueyz953ty
	Qv+GutdxW0QYrIulb3m/RItC+fPZtRMnUnWS21TAVEddVc2uuIJwEwcopi+NMEt5
	H8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 987DE29480;
	Tue, 18 Jun 2024 19:44:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC9ED2947F;
	Tue, 18 Jun 2024 19:44:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/4] exclude: notice and report read failure of .gitignore files
Date: Tue, 18 Jun 2024 16:44:34 -0700
Message-ID: <20240618234436.4107855-4-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-711-gd2c001ca14
In-Reply-To: <20240618234436.4107855-1-gitster@pobox.com>
References: <20240618233303.GA188880@coredump.intra.peff.net>
 <20240618234436.4107855-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 BED3C026-2DCC-11EF-9F21-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The code that reads .gitignore files was careless in dealing in
unusual circumstances.

 - It let read errors silently ignored.

 - It tried to read ".gitignore" that is a directory on platforms
   that allow open(2) to open directories.

To make the latter consistent with what we do for fopen() on
directories ("git grep" for FREAD_READS_DIRECTORIES for details),
check if we opened a directory, silently close it and return
success.  Catch all read errors before we close and report as
needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c              |  6 ++++++
 t/t0008-ignores.sh | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/dir.c b/dir.c
index ec875e3878..73f89f4d8c 100644
--- a/dir.c
+++ b/dir.c
@@ -1127,6 +1127,10 @@ static int add_patterns(const char *fname, const c=
har *base, int baselen,
 						       oid_stat);
 		if (r !=3D 1)
 			return r;
+	} else if (S_ISDIR(st.st_mode)) {
+		/* On FREAD_READS_DIRECTORIES platforms */
+		close(fd);
+		return 0;
 	} else {
 		size =3D xsize_t(st.st_size);
 		if (size =3D=3D 0) {
@@ -1140,6 +1144,8 @@ static int add_patterns(const char *fname, const ch=
ar *base, int baselen,
 		}
 		buf =3D xmallocz(size);
 		if (read_in_full(fd, buf, size) !=3D size) {
+			warning_errno(_("failed while reading gitignore file '%s'"),
+				      fname);
 			free(buf);
 			close(fd);
 			return -1;
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 02a18d4fdb..c367824c66 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -953,4 +953,22 @@ test_expect_success EXPENSIVE 'large exclude file ig=
nored in tree' '
 	test_cmp expect err
 '
=20
+test_expect_success POSIXPERM 'unreadable exclude file reported' '
+	test_when_finished "rm -f .gitignore" &&
+	>.gitignore &&
+	chmod a=3D .gitignore &&
+	# we do not care if the pattern matches
+	{ git check-ignore xyzzy 2>err || :; } &&
+	test_grep "unable to access ${SQ}\.gitignore${SQ}:" err
+'
+
+test_expect_success '.gitignore directory ignored' '
+	test_when_finished "rm -rf .gitignore" &&
+	rm -f .gitignore &&
+	mkdir .gitignore &&
+	# we do not care if the pattern matches
+	{ git check-ignore xyzzy 2>err || :; } &&
+	test_grep ! "failed while reading gitignore file ${SQ}\.gitignore${SQ}:=
" err
+'
+
 test_done
--=20
2.45.2-711-gd2c001ca14

