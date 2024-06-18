Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2C18E77C
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754294; cv=none; b=hLC6jTmUdgiFi5YilO1UWtDnnwH+hku2nNjkIKSXdQQ8xuptmVuDLBDvytna05knPcQDiBqXO9htaA78iAkoqrPeZEgIvxg7l9RVsAVfm9jg/5hSLM+448LgtBnzxEr8IDXVcFYcuH6V5TBoB28UcNkjCrs9mLvBIJVbktoaxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754294; c=relaxed/simple;
	bh=1P7+4qu4mq0TD0OtwgUMdXi4fgNCP8TISLY79OUxRYA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7chv+/aPTnLRKUr79z9mJ72nfirILWX1v00rrOvT9YdzucTawHEuqIKllOX6FdpbOrcx2omOXmRokfIl2Wz3eR4JUuAywbucMuqHJXrTSmRTq/F+5YGotj05eXGK5s/fi2OM8uDBPE8VQNYzm0rBIiXMDS7kw7EjupmBRjAuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rqRmAWAh; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rqRmAWAh"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DD5292C5F3;
	Tue, 18 Jun 2024 19:44:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=1P7+4qu4mq0TD0OtwgUMdXi4f
	gNCP8TISLY79OUxRYA=; b=rqRmAWAhDiR30TWOKLrbGhh4DpaTRFlNK/v9QEH/t
	rMW1dEd2Jlsg8Ez1QdL5tVD8lKSBXaOuB9Rl7oXneyEzdseY4pdH1bIetrp2Rttk
	FCZzutFhtBn3q/ZiNUc6kgU5ap/mry3gli/h52fKa8qAXwyx4N37Nt9I1Hi4co7W
	Bk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D724A2C5F2;
	Tue, 18 Jun 2024 19:44:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15FAB2C5F1;
	Tue, 18 Jun 2024 19:44:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/4] submodule: ignore .gitmodules that is not a regular file
Date: Tue, 18 Jun 2024 16:44:35 -0700
Message-ID: <20240618234436.4107855-5-gitster@pobox.com>
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
 C01658AE-2DCC-11EF-AB14-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

If .gitmodules exists in the working tree but is a directory, it
would have just tried to use it as if it were a file.  On a platform
that needs FREAD_READS_DIRECTORIES, this would have been hidden by
our own fopen() that pretends as if directory did not exist, so it
is a no-op.  Just to add some documentation value, make sure we
check with file_exists_as_file() instead of file_exists(), the
latter of which will be happy as long as the given path exists no
matter what it is.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c              | 6 ++++++
 dir.h              | 1 +
 submodule-config.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 73f89f4d8c..d943da93df 100644
--- a/dir.c
+++ b/dir.c
@@ -3142,6 +3142,12 @@ int file_exists(const char *f)
 	return lstat(f, &sb) =3D=3D 0;
 }
=20
+int file_exists_as_file(const char *path)
+{
+	struct stat st;
+	return lstat(path, &st) =3D=3D 0 && S_ISREG(st.st_mode);
+}
+
 int repo_file_exists(struct repository *repo, const char *path)
 {
 	if (repo !=3D the_repository)
diff --git a/dir.h b/dir.h
index 1398a53fb4..3612dbbf9e 100644
--- a/dir.h
+++ b/dir.h
@@ -475,6 +475,7 @@ void dir_clear(struct dir_struct *dir);
=20
 int repo_file_exists(struct repository *repo, const char *path);
 int file_exists(const char *);
+int file_exists_as_file(const char *);
=20
 int is_inside_dir(const char *dir);
 int dir_inside_of(const char *subdir, const char *dir);
diff --git a/submodule-config.c b/submodule-config.c
index ec45ea67b9..6c18ae3764 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -801,7 +801,7 @@ static void config_from_gitmodules(config_fn_t fn, st=
ruct repository *repo, void
 		char *oidstr =3D NULL;
=20
 		file =3D repo_worktree_path(repo, GITMODULES_FILE);
-		if (file_exists(file)) {
+		if (file_exists_as_file(file)) {
 			config_source.file =3D file;
 		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >=3D 0 ||
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >=3D 0) {
--=20
2.45.2-711-gd2c001ca14

