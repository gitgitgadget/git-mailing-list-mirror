Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABD18A6B6
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726702112; cv=none; b=GEotzZYUos15TcFhDjjZAnrpyQQJ0484fgyIvRegfqh0itv0Lok2c1u6wVqoLkDPOWhGOv/ZLSjlCIvNRv3Ty2PsoYEUJ6Zj5sdL/iSiahKM7f7DsNSbH1Hr1K/G0z0swzvigDqU85Z1QfTf4NheRD9zgpnRf+3Y9MamOsIPGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726702112; c=relaxed/simple;
	bh=LVideiFPaqno3t4JANQTixbR/iHU49Xsdvqpyfr2lBE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyS8y+uCr6Vz5w1ndJTlZVh2rEggiWNKKEq1DwdZFGXpWrw6mbgixrLM+JWszn9EWYBOpicqoqQ0AzxohBpizrECwCsQnYnGoSQJUJT8wRNPzHyjM3rIAmDwSMk694x9sbINbIklcxnUQb4vlnLniu/Gil94/JJNHrn89cwMzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dv8rR6Un; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dv8rR6Un"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D4481B714;
	Wed, 18 Sep 2024 19:28:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=LVideiFPaqno3t4JANQTixbR/
	iHU49Xsdvqpyfr2lBE=; b=dv8rR6UnR9DsWK8+ZdT1A++SG908hJKmzV9zU49lN
	EjyYl493RQS6+tVrvU0VKwC2T5M7fPbVhITo7H1iQa+O/aJosXxcKO/thrUsxlGM
	F7TzrIhpcDZXSYD1g2tPqDduqTY8AmWf84z8Sar4KTrh9a+I5nCQlYPlnqIYkSRN
	kU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 548DA1B713;
	Wed, 18 Sep 2024 19:28:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B22001B712;
	Wed, 18 Sep 2024 19:28:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/4] refs: deprecate core.preferSymlinkRefs
Date: Wed, 18 Sep 2024 16:28:22 -0700
Message-ID: <20240918232825.2627999-2-gitster@pobox.com>
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
 B5C041F8-7615-11EF-B694-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

This step is for immediate consumption.

Symbolic links, e.g. .git/HEAD or .git/refs/remotes/origin/HEAD,
have been used to represent a symref since very early versions of
Git, and they can still be created if the core.preferSymlinkRefs
configuration variable tells us to.

They however have two downsides:

 - Obviously, a filesystem that does not support a symbolic link
   cannot use the feature.  For this reason alone, we have long
   flipped the default to use textual symref, i.e., a regular file
   with a format that Git recognises.

 - Except for HEAD and anything at the root level of the refname
   hierarchy, following a symbolic link that represents the symref
   would not lead to the referent ref.  For example, in order to
   express that we consider 'main' branch to be the primary among
   our tracking branches for the 'origin' remote, we would have a
   symbolic ref .git/refs/remotes/origin/HEAD but the result of
   calling readlink(2) on the symbolic link is not 'main', nor
   "$(pwd)/.git/refs/remotes/origin/main".  It is relative to the
   $GIT_DIR, i.e., "refs/remotes/origin/master".  This is highly
   counter-intuitive.

Let's decide and declare to remove the support to create such
symbolic links at the Git 3.0 version boundary, and in preparation
for the move, start warning when somebody _creates_ a symbolic link
to represent a new symref.

If a third-party tool still expects that HEAD is nothing but a
symbolic link, either its authors have got end-user complaints since
we made the textual symrefs the default in mid 2006, or nobody is
using such a tool so breaking them does not matter.  It would not be
a problem in practice if Git would never create a symbolic link to
represent a symbolic ref.

We do not plan to deprecate (or remove) the support to use existing
symbolic links at this point, though.

As to the implementation:

 - We give a warning only where the configuration set to true is
   actually affecting the behaviour of Git, since the behaviour the
   user is getting today will change with the planned removal.  A
   configuration set to true will not cause a warning, unless you
   create a symref (e.g., by switching a branch).

 - The clean-up procedure of the existing tests did not account for
   the fact that "git symbolic -d REF" on an non-existing REF to
   fail, which was corrected, together with use of @ where HEAD is
   more descriptive and perfectly understandable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/BreakingChanges.txt | 11 +++++++++++
 Documentation/config/core.txt     |  9 ++++-----
 refs/files-backend.c              |  2 ++
 t/t0600-reffiles-backend.sh       | 18 ++++++++++--------
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingCh=
anges.txt
index 2b64665694..57c002dd0d 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -135,6 +135,17 @@ Cf. <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>,
     <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=3DKAKhtpDNTvHJFuX1NA@mail.gmail.co=
m>,
     <20230323204047.GA9290@coredump.intra.peff.net>,
=20
+* Support for the `core.preferSymlinkRefs` configuration variable
+  will be removed.
++
+  ** The configuration would obviously not work on a filesystem
+     where symbolic links are not supported.
+  ** The contents of such a symbolic link used as a symref does
+     not match end-user intuition unless it is `HEAD`.
++
+The support to treat existing symbolic links under the
+`$GIT_DIR/refs/` directory as symrefs is not going away.
+
 =3D=3D Superseded features that will not be deprecated
=20
 Some features have gained newer replacements that aim to improve the des=
ign in
diff --git a/Documentation/config/core.txt b/Documentation/config/core.tx=
t
index 60ca9f2b68..f0245f5050 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -285,11 +285,10 @@ CIFS/Microsoft Windows.
 +
 False by default.
=20
-core.preferSymlinkRefs::
-	Instead of the default "symref" format for HEAD
-	and other symbolic reference files, use symbolic links.
-	This is sometimes needed to work with old scripts that
-	expect HEAD to be a symbolic link.
+core.preferSymlinkRefs (deprecated)::
+	Instead of the default "symref" format for HEAD and other
+	symbolic reference files, use symbolic links.  The support
+	for this variable will be dropped in Git 3.0.
=20
 core.alternateRefsCommand::
 	When advertising tips of available history from an alternate, use the s=
hell to
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c7f3f4e591..c40a248b9f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2025,6 +2025,8 @@ static int create_ref_symlink(struct ref_lock *lock=
, const char *target)
=20
 	if (ret)
 		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
+	else
+		warning("core.preferSymlinkRefs will be removed in Git 3.0");
 	return ret;
 }
 #endif
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 20df336cc3..d369330562 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -469,8 +469,8 @@ test_expect_success POSIXPERM 'git reflog expire hono=
rs core.sharedRepository' '
 '
=20
 test_expect_success SYMLINKS 'symref transaction supports symlinks' '
-	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
-	git update-ref refs/heads/new @ &&
+	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD || :" &&
+	git update-ref refs/heads/new HEAD &&
 	test_config core.prefersymlinkrefs true &&
 	cat >stdin <<-EOF &&
 	start
@@ -478,14 +478,15 @@ test_expect_success SYMLINKS 'symref transaction su=
pports symlinks' '
 	prepare
 	commit
 	EOF
-	git update-ref --no-deref --stdin <stdin &&
+	git update-ref --no-deref --stdin <stdin 2>stderr &&
 	test_path_is_symlink .git/TEST_SYMREF_HEAD &&
-	test "$(test_readlink .git/TEST_SYMREF_HEAD)" =3D refs/heads/new
+	test "$(test_readlink .git/TEST_SYMREF_HEAD)" =3D refs/heads/new &&
+	test_grep "core\.preferSymlinkRefs will be removed" stderr
 '
=20
 test_expect_success 'symref transaction supports false symlink config' '
-	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
-	git update-ref refs/heads/new @ &&
+	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD || :" &&
+	git update-ref refs/heads/new HEAD &&
 	test_config core.prefersymlinkrefs false &&
 	cat >stdin <<-EOF &&
 	start
@@ -493,11 +494,12 @@ test_expect_success 'symref transaction supports fa=
lse symlink config' '
 	prepare
 	commit
 	EOF
-	git update-ref --no-deref --stdin <stdin &&
+	git update-ref --no-deref --stdin <stdin 2>stderr &&
 	test_path_is_file .git/TEST_SYMREF_HEAD &&
 	git symbolic-ref TEST_SYMREF_HEAD >actual &&
 	echo refs/heads/new >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_grep ! "core\.preferSymlinkRefs will be removed" stderr
 '
=20
 test_done
--=20
2.46.1-742-g4240f61078

