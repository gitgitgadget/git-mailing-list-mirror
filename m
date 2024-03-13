Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597963511
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351142; cv=none; b=KhSJ9TGT/3xkwBX8SpiiSGXJVV0O0eMrR3S4PIGr3IR9A6ngRwOltBa4q4aG7yCvSM4M+ji/Q0fYK9S6hdSufIrYiee2aOiPAEawVVzmEbntc16tJ05V++jeRCv1rpnj0Ss5cU0kXNM5H/+pZTIBpQ4Qw6vh+wlFhg/iEFpqFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351142; c=relaxed/simple;
	bh=xHEPQYWBnIuY77UaE/EGhKkdGFN1C3ZI2WZmBZl7FyQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjfSln0BQfEWCj41GkuJFWQ134fw+qTfZCHU8FpSAu4JK2D28+g7DrEyE6OpsVGivbmdBJ118ppyGIBUB4J+q8B3ODBToo8pkPzN7u0IPFuV5OktK+s04hc6u7tPcv4rZsSG7S8POOqBNWGgUdMyx8585Qdh7M//BeRWKDs/et8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rBMjNA5r; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rBMjNA5r"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D4C3F19E99;
	Wed, 13 Mar 2024 13:32:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=xHEPQYWBnIuY77UaE/EGhKkdG
	FN1C3ZI2WZmBZl7FyQ=; b=rBMjNA5rokIvfw/vdX8i+MRZUfMciMbf2KmFil7lT
	gYbB4o52GakxOnErBAPmJmCW1e7w+351sbntJ4bRCPEt11OE5j7aF3YSo4WveJyi
	eGX5Zi8sHJT5eL7IYkATbXYiyTqLt2ek+m/0Crm/gPPXi7bamD2gZAXBK9r0kL/t
	KM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CC91119E98;
	Wed, 13 Mar 2024 13:32:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7279B19E97;
	Wed, 13 Mar 2024 13:32:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] status: unify parsing of --untracked= and status.showUntrackedFiles
Date: Wed, 13 Mar 2024 10:32:13 -0700
Message-ID: <20240313173214.962532-2-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-191-g945115026a
In-Reply-To: <20240313173214.962532-1-gitster@pobox.com>
References: <20240313173214.962532-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A369EA0E-E15F-11EE-AD62-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

There are two code paths that take a string and parse it to enum
untracked_status_type.  Introduce a helper function and use it.

As these two places handle an error differently, add an additional
invalid value to the enum, and have the caller of the helper handle
the error condition, instead of dying or emitting error message from
the helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 44 +++++++++++++++++++++++++++-----------------
 wt-status.h      |  3 ++-
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a91197245f..e61e459ca9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1157,22 +1157,34 @@ static void handle_ignored_arg(struct wt_status *=
s)
 		die(_("Invalid ignored mode '%s'"), ignored_arg);
 }
=20
-static void handle_untracked_files_arg(struct wt_status *s)
+static enum untracked_status_type parse_untracked_setting_name(const cha=
r *u)
 {
-	if (!untracked_files_arg)
-		; /* default already initialized */
-	else if (!strcmp(untracked_files_arg, "no"))
-		s->show_untracked_files =3D SHOW_NO_UNTRACKED_FILES;
-	else if (!strcmp(untracked_files_arg, "normal"))
-		s->show_untracked_files =3D SHOW_NORMAL_UNTRACKED_FILES;
-	else if (!strcmp(untracked_files_arg, "all"))
-		s->show_untracked_files =3D SHOW_ALL_UNTRACKED_FILES;
 	/*
 	 * Please update $__git_untracked_file_modes in
 	 * git-completion.bash when you add new options
 	 */
+	if (!strcmp(u, "no"))
+		return SHOW_NO_UNTRACKED_FILES;
+	else if (!strcmp(u, "normal"))
+		return SHOW_NORMAL_UNTRACKED_FILES;
+	else if (!strcmp(u, "all"))
+		return SHOW_ALL_UNTRACKED_FILES;
 	else
-		die(_("Invalid untracked files mode '%s'"), untracked_files_arg);
+		return SHOW_UNTRACKED_FILES_ERROR;
+}
+
+static void handle_untracked_files_arg(struct wt_status *s)
+{
+	enum untracked_status_type u;
+
+	if (!untracked_files_arg)
+		return; /* default already initialized */
+
+	u =3D parse_untracked_setting_name(untracked_files_arg);
+	if (u =3D=3D SHOW_UNTRACKED_FILES_ERROR)
+		die(_("Invalid untracked files mode '%s'"),
+		    untracked_files_arg);
+	s->show_untracked_files =3D u;
 }
=20
 static const char *read_commit_message(const char *name)
@@ -1455,16 +1467,14 @@ static int git_status_config(const char *k, const=
 char *v,
 		return 0;
 	}
 	if (!strcmp(k, "status.showuntrackedfiles")) {
+		enum untracked_status_type u;
+
 		if (!v)
 			return config_error_nonbool(k);
-		else if (!strcmp(v, "no"))
-			s->show_untracked_files =3D SHOW_NO_UNTRACKED_FILES;
-		else if (!strcmp(v, "normal"))
-			s->show_untracked_files =3D SHOW_NORMAL_UNTRACKED_FILES;
-		else if (!strcmp(v, "all"))
-			s->show_untracked_files =3D SHOW_ALL_UNTRACKED_FILES;
-		else
+		u =3D parse_untracked_setting_name(v);
+		if (u =3D=3D SHOW_UNTRACKED_FILES_ERROR)
 			return error(_("Invalid untracked files mode '%s'"), v);
+		s->show_untracked_files =3D u;
 		return 0;
 	}
 	if (!strcmp(k, "diff.renamelimit")) {
diff --git a/wt-status.h b/wt-status.h
index 5e99ba4707..4e377ce62b 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -23,7 +23,8 @@ enum color_wt_status {
 };
=20
 enum untracked_status_type {
-	SHOW_NO_UNTRACKED_FILES,
+	SHOW_UNTRACKED_FILES_ERROR =3D -1,
+	SHOW_NO_UNTRACKED_FILES =3D 0,
 	SHOW_NORMAL_UNTRACKED_FILES,
 	SHOW_ALL_UNTRACKED_FILES
 };
--=20
2.44.0-191-g945115026a

