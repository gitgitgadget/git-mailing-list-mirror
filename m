Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E35FDAD
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932815; cv=none; b=IBU8P23zzS2xrTPqpRDaiauulHw+RwwB0dQMiqIZEhXyOqzTvHltDn1NK4QYJGXkWbr13h2+J1Yk36ojqae+B65fGvrIh/N7/D5xUq1VcFeDoxB5vy3Hr7HJijAmPMEW7sD4+uCFTEz0qQ57OmQpPWo74RUBDvV7eY6Wpj8kPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932815; c=relaxed/simple;
	bh=cP3lm3shVWrkpSrUji0nCqAMlkf/hqKkz5+tsIon5TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4a33QJE+VEZ1xukneNTyg/5gPt4MLhmdjQK1NCVCu+K02v84W3XHODGzo3A0UJmwjjXD11Xf/nj5z69FqBvAoq7Q3xzMrgKEHdFPhnvXKtwBq7alqZ5EhjLsGayErD6WpUJQkZqdRSla65aX2Lbx4geGaI0l4xu73lx7g+DXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RnjvaAwV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RnjvaAwV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C7F33B15D;
	Fri,  8 Mar 2024 16:20:08 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=cP3lm3shVWrkpSrUji0nCqAMl
	kf/hqKkz5+tsIon5TM=; b=RnjvaAwVXTJiEQzJ/i4uCV8+Xv9AAIR7q16VThEhS
	fAHeJxDDA5tVxjkexoU/c2as1cDaYeubn/PvrP3WsYV+h9CcbAUOIdLTRcqIjAwU
	Vu+tdku/PyX2Nno3zzxdXZA+LTcLy9vsyyWJAKP7G5nX4xBv9bAWylTXnZbNW8vU
	e4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 546873B15C;
	Fri,  8 Mar 2024 16:20:08 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4419A3B159;
	Fri,  8 Mar 2024 16:20:03 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>
Subject: [PATCH 1/2] setup: detect to be in $GIT_DIR with a new helper
Date: Fri,  8 Mar 2024 13:19:56 -0800
Message-ID: <20240308211957.3758770-2-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-165-ge09f1254c5
In-Reply-To: <20240308211957.3758770-1-gitster@pobox.com>
References: <xmqqv85zqniu.fsf@gitster.g>
 <20240308211957.3758770-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A0CE40C8-DD91-11EE-BB8C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Earlier, 45bb9162 (setup: allow cwd=3D.git w/ bareRepository=3Dexplicit,
2024-01-20) loosened the "safe.bareRepository=3Dexplicit" to allow Git
operations inside ".git/" directory in the root level of a working
tree of a non-bare repository.  It used the fact that the $GIT_DIR
you discover has ".git" as the last path component, if you descended
into ".git" of a non-bare repository.

Let's move the logic into a separate helper function.  We can
enhance this to detect the case where we are inside $GIT_DIR of a
secondary worktree (where "ends with .git" trick does not work) in
the next commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index a09b7b87ec..3081be4970 100644
--- a/setup.c
+++ b/setup.c
@@ -1231,6 +1231,11 @@ static const char *allowed_bare_repo_to_string(
 	return NULL;
 }
=20
+static int is_repo_with_working_tree(const char *path)
+{
+	return ends_with_path_components(path, ".git");
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was call=
ed.
@@ -1360,7 +1365,7 @@ static enum discovery_result setup_git_directory_ge=
ntly_1(struct strbuf *dir,
 		if (is_git_directory(dir->buf)) {
 			trace2_data_string("setup", NULL, "implicit-bare-repository", dir->bu=
f);
 			if (get_allowed_bare_repo() =3D=3D ALLOWED_BARE_REPO_EXPLICIT &&
-			    !ends_with_path_components(dir->buf, ".git"))
+			    !is_repo_with_working_tree(dir->buf))
 				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
 				return GIT_DIR_INVALID_OWNERSHIP;
--=20
2.44.0-165-ge09f1254c5

