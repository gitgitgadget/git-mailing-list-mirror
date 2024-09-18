Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808F1CBE85
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726702113; cv=none; b=M/jAeL6W8denayHq/NGcdv2eEVkoG0Xw9+NMtYmzLCI+/OhNPOoVnhT8pC10n4i8QzD7RD/3fmm9BUo14OVYit8a2YBh/w1F6p7mMykyb/ye2QxoaHqQnLpPqfJadVDFAtqK0QXppeNXlC6JjzF8jH/d+LOVLXpGIKoP9xroels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726702113; c=relaxed/simple;
	bh=CWpFLgGEwHrbd8pmUYSC/H62S63WCPyizP8eDf3aTe8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2KzDgf2wi5hx+Lt6z0AfYl+/o/G14zMI+y9ntHAW/roSIgPKJczIwIwGKXC/g+Yj4nzH3wcKfG5gi0yAo7N9ziETcCO8bzKVsVfMsoh9bXLMr9SVMMs+DNzp2hjjKxr2hOw22V4UPyT1DttQvvPjARszhsMqhAOstl02s/l5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nvMBtj9P; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nvMBtj9P"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2170B3549E;
	Wed, 18 Sep 2024 19:28:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=CWpFLgGEwHrbd8pmUYSC/H62S
	63WCPyizP8eDf3aTe8=; b=nvMBtj9PtX7I/N8mQeh6Kc0LeCIC71oSLEyw9dewU
	8BUTbg0HLUREDfUKjUTADBrBapUPgxgQuSD+ryxgO7r9Av/p3IASC6L36xkTseSU
	3PLD1Em4DuXaC4yxHHe7YCNuD/xtDzcxHqtWTX4zrhJxSCRQ9zcnFQ2M9toxYWjy
	0g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 177193549D;
	Wed, 18 Sep 2024 19:28:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 464813549C;
	Wed, 18 Sep 2024 19:28:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/4] refs: mostly remove core.preferSymlinkRefs
Date: Wed, 18 Sep 2024 16:28:23 -0700
Message-ID: <20240918232825.2627999-3-gitster@pobox.com>
X-Mailer: git-send-email 2.46.1-742-g4240f61078
In-Reply-To: <20240918232825.2627999-1-gitster@pobox.com>
References: <20240918232825.2627999-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 B6ADEDF4-7615-11EF-8BB8-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

This step and the next step are for Git 3.0.

Now we are preparing for a big Git 3.0 transition after warning
against use of this configuration variable to create a new symlink
that represents a symbolic ref for N months, it is time to actually
remove the support of the configuration variable.

In this patch, we mostly ignore core.preferSymlinkRefs and always
create a textual symref when we are asked to create a symref, but
when core.preferSymlinkRefs would have caused us to use a symbolic
link in an older version of Git, we will issue a warning.  We also
have in our build infrastructure to selectively set the CPP macro
NO_SYMLINK_HEAD, but an accompanying patch will remove them.

The final warning is meant to help users who set the configuration
variable and expected it to create a symlink, but instead got a
textual symref.  They may not even recognise the configuration after
they set it long time ago and forgot about it by now, so we keep the
"git config --help" entry for the variable to help them recall what
it was about.

After a few releases, we will get rid of this warning and the
codebase will look as if such a configuration variable never
existed, but we are not quite there yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/core.txt |  4 ++--
 refs/files-backend.c          | 29 +++---------------------
 t/t0600-reffiles-backend.sh   | 42 +++++++++++++++++++++++------------
 3 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.tx=
t
index f0245f5050..a6f67cab27 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -285,10 +285,10 @@ CIFS/Microsoft Windows.
 +
 False by default.
=20
-core.preferSymlinkRefs (deprecated)::
+core.preferSymlinkRefs (removed)::
 	Instead of the default "symref" format for HEAD and other
 	symbolic reference files, use symbolic links.  The support
-	for this variable will be dropped in Git 3.0.
+	for this variable was dropped in Git 3.0.
=20
 core.alternateRefsCommand::
 	When advertising tips of available history from an alternate, use the s=
hell to
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c40a248b9f..1296272252 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2011,26 +2011,6 @@ static int commit_ref_update(struct files_ref_stor=
e *refs,
 	return 0;
 }
=20
-#ifdef NO_SYMLINK_HEAD
-#define create_ref_symlink(a, b) (-1)
-#else
-static int create_ref_symlink(struct ref_lock *lock, const char *target)
-{
-	int ret =3D -1;
-
-	char *ref_path =3D get_locked_file_path(&lock->lk);
-	unlink(ref_path);
-	ret =3D symlink(target, ref_path);
-	free(ref_path);
-
-	if (ret)
-		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
-	else
-		warning("core.preferSymlinkRefs will be removed in Git 3.0");
-	return ret;
-}
-#endif
-
 static int create_symref_lock(struct ref_lock *lock, const char *target,
 			      struct strbuf *err)
 {
@@ -3003,13 +2983,10 @@ static int files_transaction_finish(struct ref_st=
ore *ref_store,
 			}
 		}
=20
-		/*
-		 * We try creating a symlink, if that succeeds we continue to the
-		 * next update. If not, we try and create a regular symref.
-		 */
+		/* Warn against core.preferSymlinkRefs set to true */
 		if (update->new_target && prefer_symlink_refs)
-			if (!create_ref_symlink(lock, update->new_target))
-				continue;
+			/* we used to, but no longer, create a symlink here */
+			warning("core.preferSymlinkRefs was removed in Git 3.0");
=20
 		if (update->flags & REF_NEEDS_COMMIT) {
 			clear_loose_ref_cache(refs);
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index d369330562..4e517cdc13 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -468,26 +468,40 @@ test_expect_success POSIXPERM 'git reflog expire ho=
nors core.sharedRepository' '
 	esac
 '
=20
-test_expect_success SYMLINKS 'symref transaction supports symlinks' '
+test_expect_success SYMLINKS 'symlinks used as symrefs are still support=
ed' '
 	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD || :" &&
 	git update-ref refs/heads/new HEAD &&
-	test_config core.prefersymlinkrefs true &&
-	cat >stdin <<-EOF &&
-	start
-	symref-create TEST_SYMREF_HEAD refs/heads/new
-	prepare
-	commit
-	EOF
-	git update-ref --no-deref --stdin <stdin 2>stderr &&
+	# manually do this, as core.prefersymlinkrefs no longer
+	# affects how a symref is created (as a textual symref).
+	ln -f -s refs/heads/new .git/TEST_SYMREF_HEAD &&
 	test_path_is_symlink .git/TEST_SYMREF_HEAD &&
-	test "$(test_readlink .git/TEST_SYMREF_HEAD)" =3D refs/heads/new &&
-	test_grep "core\.preferSymlinkRefs will be removed" stderr
+	echo refs/heads/new >expect &&
+	git symbolic-ref TEST_SYMREF_HEAD >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'core.prefersymlinkrefs gets a warning' '
+	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD || :" &&
+	git update-ref refs/heads/new HEAD &&
+
+	test_config core.prefersymlinkrefs true &&
+	git symbolic-ref TEST_SYMREF_HEAD refs/heads/new 2>stderr &&
+	test_grep "core\.preferSymlinkRefs was removed" stderr &&
+
+	git symbolic-ref -d TEST_SYMREF_HEAD &&
+	git config core.prefersymlinkrefs false &&
+	git symbolic-ref TEST_SYMREF_HEAD refs/heads/new 2>stderr &&
+	test_grep ! "core\.preferSymlinkRefs was removed" stderr &&
+
+	git symbolic-ref -d TEST_SYMREF_HEAD &&
+	git config --unset core.prefersymlinkrefs &&
+	git symbolic-ref TEST_SYMREF_HEAD refs/heads/new 2>stderr &&
+	test_grep ! "core\.preferSymlinkRefs was removed" stderr
 '
=20
-test_expect_success 'symref transaction supports false symlink config' '
+test_expect_success 'symref transaction' '
 	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD || :" &&
 	git update-ref refs/heads/new HEAD &&
-	test_config core.prefersymlinkrefs false &&
 	cat >stdin <<-EOF &&
 	start
 	symref-create TEST_SYMREF_HEAD refs/heads/new
@@ -499,7 +513,7 @@ test_expect_success 'symref transaction supports fals=
e symlink config' '
 	git symbolic-ref TEST_SYMREF_HEAD >actual &&
 	echo refs/heads/new >expect &&
 	test_cmp expect actual &&
-	test_grep ! "core\.preferSymlinkRefs will be removed" stderr
+	test_grep ! "core\.preferSymlinkRefs was removed" stderr
 '
=20
 test_done
--=20
2.46.1-742-g4240f61078

