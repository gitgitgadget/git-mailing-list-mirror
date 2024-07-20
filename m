Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58D143733
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721513377; cv=none; b=Gyzf5sfF5Ej2H44O0ne0z9Fy8nEDu7yj8CXNNIXUpvDpSbRlt+GeGXftTu3G2HXflnO5pto0uQIPULxghoSycpMZn9pJxLIRn9EsKZGQUk2PGA+vUfG/jpaBLWK/MdP41VZmEUSJ/8KVDBElNPVlsqDRWuZhSkIepIxClp8Mje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721513377; c=relaxed/simple;
	bh=ow1TZ4NK1632aAlwLfOaf3nyJJjw558ZRnxIHPkE9IQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jF9DP5ICSAENPc5E6vwpSfsazMqn+OORmuD1j75egzaWUnXCv9Q83+tvBv3+O6KqusrLo7FJgs3ckv/SbILvWnuO/sWYmIhkNZpaWcZz6wW+Bsn28eeSlFqZnxwzw82llZyjeaYP86a+S3UaFKAjltgBEAHS88H9WESV8LCLD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MuCR+cP/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MuCR+cP/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 237C926908;
	Sat, 20 Jul 2024 18:09:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=ow1TZ4NK1632aAlwLfOaf3nyJ
	Jjw558ZRnxIHPkE9IQ=; b=MuCR+cP/ZF+ovoZykXfKQ6EQOFVvzNGQ5gDLDVZfP
	Vs5kDQrD5AsebyPYQpXA9a/QOnPy40kQa62TQh6Xd0dBTkZu2ItdEosNRNCJ4AYh
	0lWQLjxcpV5JsjQprxpvf46eOrquArLb1e+e4/IDak2CN5zuyH2zCftp0AXSFDve
	lM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C4CE26907;
	Sat, 20 Jul 2024 18:09:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 92B2926904;
	Sat, 20 Jul 2024 18:09:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/2] setup: cache normalized safe.directory configuration
Date: Sat, 20 Jul 2024 15:09:15 -0700
Message-ID: <20240720220915.2933266-5-gitster@pobox.com>
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
 B9D79490-46E4-11EF-9128-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

[Do not use. For illustration purposes only]

The current check performed in ensure_valid_ownership() reads each
safe.directory configuration item and normalizes it before checking
against the path to the repository.

This is OK as long as we are checking just a single directory, like
in die_upon_dubious_ownership() and setup_git_directory_gently_1().
But let's pretend that the latter calls ensure_valid_ownership()
many times in the loop, and demonstrate how we would avoid having to
normalize the same safe.directory configuration item over and over.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 12 deletions(-)

diff --git a/setup.c b/setup.c
index 29e23a905c..75bcce0368 100644
--- a/setup.c
+++ b/setup.c
@@ -20,6 +20,7 @@
 #include "trace2.h"
 #include "worktree.h"
 #include "exec-cmd.h"
+#include "strvec.h"
=20
 static int inside_git_dir =3D -1;
 static int inside_work_tree =3D -1;
@@ -1217,6 +1218,7 @@ static int canonicalize_ceiling_entry(struct string=
_list_item *item,
 struct safe_directory_data {
 	char *path;
 	int is_safe;
+	int prenormalized;
 };
=20
 static int safe_directory_cb(const char *key, const char *value,
@@ -1236,14 +1238,20 @@ static int safe_directory_cb(const char *key, con=
st char *value,
=20
 		if (!git_config_pathname(&allowed, key, value)) {
 			const char *check =3D allowed ? allowed : value;
-			char *to_free =3D real_pathdup(check, 0);
-
-			if (!to_free) {
-				warning(_("safe.directory '%s' cannot be normalized"),
-					check);
-				goto next;
-			} else {
+			char *to_free =3D NULL;
+
+			if (!data->prenormalized) {
+				to_free =3D real_pathdup(check, 0);
+				if (!to_free) {
+					warning(_("safe.directory '%s' "
+						  "cannot be normalized"),
+						check);
+					goto next;
+				}
 				check =3D to_free;
+			} else {
+				to_free =3D NULL;
+				check =3D value;
 			}
=20
 			if (ends_with(check, "/*")) {
@@ -1263,6 +1271,39 @@ static int safe_directory_cb(const char *key, cons=
t char *value,
 	return 0;
 }
=20
+static int prenorm_cb(const char *key, const char *value,
+		      const struct config_context *ctx UNUSED, void *v_)
+{
+	struct strvec *v =3D v_;
+
+	if (strcmp(key, "safe.directory"))
+		return 0;
+	if (!value || !*value) {
+		strvec_clear(v);
+	} else if (!strcmp(value, "*")) {
+		strvec_push(v, value);
+	} else {
+		char *allowed =3D NULL;
+		if (!git_config_pathname(&allowed, key, value)) {
+			const char *ccheck =3D allowed ? allowed : value;
+			char *check =3D real_pathdup(ccheck, 0);
+			if (check)
+				strvec_push_nodup(v, check);
+			else
+				warning(_("safe.directory '%s' cannot be normalized"),
+					ccheck);
+		}
+		if (allowed !=3D value)
+			free(allowed);
+	}
+	return 0;
+}
+
+static void prenormalize_safe_directory(struct strvec *v)
+{
+	git_protected_config(prenorm_cb, v);
+}
+
 /*
  * Check if a repository is safe, by verifying the ownership of the
  * worktree (if any), the git directory, and the gitfile (if any).
@@ -1273,6 +1314,7 @@ static int safe_directory_cb(const char *key, const=
 char *value,
  */
 static int ensure_valid_ownership(const char *gitfile,
 				  const char *worktree, const char *gitdir,
+				  struct strvec *safe_cache,
 				  struct strbuf *report)
 {
 	struct safe_directory_data data =3D { 0 };
@@ -1297,8 +1339,15 @@ static int ensure_valid_ownership(const char *gitf=
ile,
 	 * constant regardless of what failed above. data.is_safe should be
 	 * initialized to false, and might be changed by the callback.
 	 */
-	git_protected_config(safe_directory_cb, &data);
-
+	if (!safe_cache) {
+		git_protected_config(safe_directory_cb, &data);
+	} else {
+		data.prenormalized =3D 1;
+		for (size_t i =3D 0; i < safe_cache->nr; i++) {
+			safe_directory_cb("safe.directory", safe_cache->v[i],
+					  NULL, &data);
+		}
+	}
 	free(data.path);
 	return data.is_safe;
 }
@@ -1309,7 +1358,7 @@ void die_upon_dubious_ownership(const char *gitfile=
, const char *worktree,
 	struct strbuf report =3D STRBUF_INIT, quoted =3D STRBUF_INIT;
 	const char *path;
=20
-	if (ensure_valid_ownership(gitfile, worktree, gitdir, &report))
+	if (ensure_valid_ownership(gitfile, worktree, gitdir, NULL, &report))
 		return;
=20
 	strbuf_complete(&report, '\n');
@@ -1416,6 +1465,7 @@ static enum discovery_result setup_git_directory_ge=
ntly_1(struct strbuf *dir,
 	int ceil_offset =3D -1, min_offset =3D offset_1st_component(dir->buf);
 	dev_t current_device =3D 0;
 	int one_filesystem =3D 1;
+	struct strvec safe_cache =3D STRVEC_INIT;
 	enum discovery_result result;
=20
 	/*
@@ -1463,6 +1513,8 @@ static enum discovery_result setup_git_directory_ge=
ntly_1(struct strbuf *dir,
 	one_filesystem =3D !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
 	if (one_filesystem)
 		current_device =3D get_device_or_die(dir->buf, NULL, 0);
+
+	prenormalize_safe_directory(&safe_cache);
 	for (;;) {
 		int offset =3D dir->len, error_code =3D 0;
 		char *gitdir_path =3D NULL;
@@ -1499,7 +1551,8 @@ static enum discovery_result setup_git_directory_ge=
ntly_1(struct strbuf *dir,
 				gitdir_path ? gitdir_path : gitdirenv;
=20
 			if (ensure_valid_ownership(gitfile, dir->buf,
-						   gitdir_candidate, report)) {
+						   gitdir_candidate,
+						   &safe_cache, report)) {
 				strbuf_addstr(gitdir, gitdirenv);
 				result =3D GIT_DIR_DISCOVERED;
 			} else
@@ -1525,7 +1578,8 @@ static enum discovery_result setup_git_directory_ge=
ntly_1(struct strbuf *dir,
 			if (get_allowed_bare_repo() =3D=3D ALLOWED_BARE_REPO_EXPLICIT &&
 			    !is_implicit_bare_repo(dir->buf))
 				return GIT_DIR_DISALLOWED_BARE;
-			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report)) {
+			if (!ensure_valid_ownership(NULL, NULL, dir->buf,
+						    &safe_cache, report)) {
 				result =3D GIT_DIR_INVALID_OWNERSHIP;
 			} else {
 				strbuf_addstr(gitdir, ".");
@@ -1555,6 +1609,7 @@ static enum discovery_result setup_git_directory_ge=
ntly_1(struct strbuf *dir,
 	}
=20
 cleanup_and_return:
+	strvec_clear(&safe_cache);
 	return result;
 }
=20
--=20
2.46.0-rc1-48-g0900f1888e

