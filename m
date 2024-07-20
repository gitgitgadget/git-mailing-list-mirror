Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673E143733
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721513373; cv=none; b=sz7nv1xpt/TOGV1dF4Z6WbR/sAvvahTyaQ9lonovHbgX5eeIXeQleZ/I39+4jgcb0j1hrJOaM06s5wGTkQJQbmdBhiSE1Whyjak/XOPp8ehqraq/6zVfgSAGfZum1IGn/yrvmr2QNou11As2e1Cwkmqe58rNA5tWAZiy/o8VpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721513373; c=relaxed/simple;
	bh=2EnNQF34moMG0J+33113JUkH6pHfbuFLq331E6X70YA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqUlENUyRVmnp+BjZav0/vQopl6b0PLNcq/o4Wf52O+7YKzjcJ9qQVSaa4zsKw+I9c65M9fL04uPxeN+XA7uPsURjRS9bJDsgXdta5BRbMIgvn8yGUMyElpEFXlrTv6m2B2Lu+fMftGjkVqS/lBCIrXRHyFpzims++ZFHGwJu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JQDF//hd; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JQDF//hd"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 454A42B338;
	Sat, 20 Jul 2024 18:09:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=2EnNQF34moMG0J+33113JUkH6
	pHfbuFLq331E6X70YA=; b=JQDF//hdDLRjCuKjq5ED4jnTHvq8DdREDrBoa46Tf
	ImVW/aCNJvZdluXGpPiAIJi8Nh+/6CDbdWPa/ALdrROyN27EKwRtxIZGBaI/8cg4
	tWY519grr++tW0H5KWHL1gRryDztdyNL2Yj1UaURGbFnCksSmTC+GDlKN3Xo9iiM
	vw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E7282B337;
	Sat, 20 Jul 2024 18:09:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C19E62B336;
	Sat, 20 Jul 2024 18:09:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/2] setup: use a single return path in setup_git_directory*()
Date: Sat, 20 Jul 2024 15:09:14 -0700
Message-ID: <20240720220915.2933266-4-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-rc1-48-g0900f1888e
In-Reply-To: <20240720220915.2933266-1-gitster@pobox.com>
References: <20240720220915.2933266-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 B791ECF8-46E4-11EF-A68E-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

[Do not use. For illustration purposes only]

Instead of sprinkling "return" all over the place, use the "assign
to the result variable and then jump to the single label set up to
leave the function" pattern, so that we can clean up any extra
resource allocated before returning at a single place.

No functional change is intended with this step, but it will be used
soon.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/setup.c b/setup.c
index 29304d7452..29e23a905c 100644
--- a/setup.c
+++ b/setup.c
@@ -1416,6 +1416,7 @@ static enum discovery_result setup_git_directory_ge=
ntly_1(struct strbuf *dir,
 	int ceil_offset =3D -1, min_offset =3D offset_1st_component(dir->buf);
 	dev_t current_device =3D 0;
 	int one_filesystem =3D 1;
+	enum discovery_result result;
=20
 	/*
 	 * If GIT_DIR is set explicitly, we're not going
@@ -1425,7 +1426,8 @@ static enum discovery_result setup_git_directory_ge=
ntly_1(struct strbuf *dir,
 	gitdirenv =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
 		strbuf_addstr(gitdir, gitdirenv);
-		return GIT_DIR_EXPLICIT;
+		result =3D GIT_DIR_EXPLICIT;
+		goto cleanup_and_return;
 	}
=20
 	if (env_ceiling_dirs) {
@@ -1479,8 +1481,10 @@ static enum discovery_result setup_git_directory_g=
ently_1(struct strbuf *dir,
 					gitdirenv =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 					gitdir_path =3D xstrdup(dir->buf);
 				}
-			} else if (error_code !=3D READ_GITFILE_ERR_STAT_FAILED)
-				return GIT_DIR_INVALID_GITFILE;
+			} else if (error_code !=3D READ_GITFILE_ERR_STAT_FAILED) {
+				result =3D GIT_DIR_INVALID_GITFILE;
+				goto cleanup_and_return;
+			}
 		} else
 			gitfile =3D xstrdup(dir->buf);
 		/*
@@ -1491,16 +1495,15 @@ static enum discovery_result setup_git_directory_=
gently_1(struct strbuf *dir,
 		 */
 		strbuf_setlen(dir, offset);
 		if (gitdirenv) {
-			enum discovery_result ret;
 			const char *gitdir_candidate =3D
 				gitdir_path ? gitdir_path : gitdirenv;
=20
 			if (ensure_valid_ownership(gitfile, dir->buf,
 						   gitdir_candidate, report)) {
 				strbuf_addstr(gitdir, gitdirenv);
-				ret =3D GIT_DIR_DISCOVERED;
+				result =3D GIT_DIR_DISCOVERED;
 			} else
-				ret =3D GIT_DIR_INVALID_OWNERSHIP;
+				result =3D GIT_DIR_INVALID_OWNERSHIP;
=20
 			/*
 			 * Earlier, during discovery, we might have allocated
@@ -1514,8 +1517,7 @@ static enum discovery_result setup_git_directory_ge=
ntly_1(struct strbuf *dir,
 			 */
 			free(gitdir_path);
 			free(gitfile);
-
-			return ret;
+			goto cleanup_and_return;
 		}
=20
 		if (is_git_directory(dir->buf)) {
@@ -1523,25 +1525,37 @@ static enum discovery_result setup_git_directory_=
gently_1(struct strbuf *dir,
 			if (get_allowed_bare_repo() =3D=3D ALLOWED_BARE_REPO_EXPLICIT &&
 			    !is_implicit_bare_repo(dir->buf))
 				return GIT_DIR_DISALLOWED_BARE;
-			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
-				return GIT_DIR_INVALID_OWNERSHIP;
-			strbuf_addstr(gitdir, ".");
-			return GIT_DIR_BARE;
+			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report)) {
+				result =3D GIT_DIR_INVALID_OWNERSHIP;
+			} else {
+				strbuf_addstr(gitdir, ".");
+				result =3D GIT_DIR_BARE;
+			}
+			goto cleanup_and_return;
 		}
=20
-		if (offset <=3D min_offset)
-			return GIT_DIR_HIT_CEILING;
+		if (offset <=3D min_offset) {
+			result =3D GIT_DIR_HIT_CEILING;
+			goto cleanup_and_return;
+		}
=20
 		while (--offset > ceil_offset && !is_dir_sep(dir->buf[offset]))
 			; /* continue */
-		if (offset <=3D ceil_offset)
-			return GIT_DIR_HIT_CEILING;
+		if (offset <=3D ceil_offset) {
+			result =3D GIT_DIR_HIT_CEILING;
+			goto cleanup_and_return;
+		}
=20
 		strbuf_setlen(dir, offset > min_offset ?  offset : min_offset);
 		if (one_filesystem &&
-		    current_device !=3D get_device_or_die(dir->buf, NULL, offset))
-			return GIT_DIR_HIT_MOUNT_POINT;
+		    current_device !=3D get_device_or_die(dir->buf, NULL, offset)) {
+			result =3D GIT_DIR_HIT_MOUNT_POINT;
+			goto cleanup_and_return;
+		}
 	}
+
+cleanup_and_return:
+	return result;
 }
=20
 enum discovery_result discover_git_directory_reason(struct strbuf *commo=
ndir,
--=20
2.46.0-rc1-48-g0900f1888e

