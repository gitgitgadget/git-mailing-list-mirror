Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C901C244B
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672048; cv=none; b=OM6oX7/1HRGMjg6cGxww2QLpgSqkdcML/82Jjj9urtFrfRFodkEDM0gDb/8Vc6/BQ1gCpH7lpPf1OVovuVcn35plikbIASh9U84MyFDyyd5Weaz6Efs+QZ/WlvtNcbsFXnoB0X7EhP4uTW9yGuPIlfQFk3OFxOnXijsvxG/Wt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672048; c=relaxed/simple;
	bh=IU+M7Po1uFbs2b8K0hCSPpPn6KpyLgivOi9tYy+HfW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mG/h1t8t7Gb1sliXofQ3K9D5YewEAIibIRyapdA/WIWz/1Fm7sfdIO8NM6Y49/fHV1xCP56oZU++SSwkbFVVtNCvWjb0cBTqpUt93QzXf9I53VVUnagf3mhKEBBhokw85A7JUt7txpffczMZeHat8sQEkevAe3zfc6hvoAjkPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=ZtnQsZeS; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="ZtnQsZeS"
From: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1728671690;
	bh=IU+M7Po1uFbs2b8K0hCSPpPn6KpyLgivOi9tYy+HfW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=ZtnQsZeSD8BYg9b99gxQeO+Fz5gt/CmLbQzSojtACL/xiAexPQJrK376M6BC07tvV
	 FBzQoLGOLPbqlB3Z13+n6n/vrWnDcOPMi3V+ZKMUMDCkdd9SDDEUANqWQdShpykCjl
	 0vHlj0xyHaoldktfF9c8J0h+ewVqEW5fmXAPPe47sQFWaFGBpf3ymavKXCPmdUiK8n
	 /JJZ7/hrpadH/70ZLfPH+n2tPjKtPFEnmZQy2OG5jraPY58r4djUi4VwmmLcfRqtPi
	 9GVCC4UU5KOO8q6FPRCutLVoUDHtWcjR8K9847IBwmojkC3vNMpXBKOuGtTV5jQZvm
	 gPLY5K5XAinbQ==
To: git@vger.kernel.org
Cc: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
Subject: [RFC PATCH] builtin/shortlog: explicitly set hash algo when there is no repo
Date: Fri, 11 Oct 2024 20:34:45 +0200
Message-ID: <20241011183445.229228-1-wolf@oriole.systems>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Whilst git-shortlog(1) does not explicitly need any repository
information when run without reference to one, it still parses some of
its arguments with parse_revision_opt() which assumes that the hash
algorithm is set. However, in c8aed5e8da (repository: stop setting SHA1
as the default object hash, 2024-05-07) we stopped setting up a default
hash algorithm and instead require commands to set it up explicitly.

This was done for most other commands like in ab274909d4 (builtin/diff:
explicitly set hash algo when there is no repo, 2024-05-07) but was
missed for builtin/shortlog, making git-shortlog(1) segfault outside of
a repository when given arguments like --author that trigger a call to
parse_revision_opt().

Fix this for now by explicitly setting the hash algorithm to SHA1.

Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
---
I think there is a much cleaner patch here if one would look at
disentangling the parsing machinery split between cmd_shortlog() and
parse_revision_opt() such that the latter is only called if there is an
actual repository, but I'm not at all familiar enough with the codebase
to do that. Like the commit says some other commands were fixed like
this as well, so I thought to send this patch your way.

 builtin/shortlog.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3ed5c46078..6422f088b2 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -387,6 +387,14 @@ int cmd_shortlog(int argc,
 	struct rev_info rev;
 	int nongit = !startup_info->have_repository;
 
+	/*
+	 * Later on we'll call parse_revision_opt which relies on the hash
+	 * algorithm being set but since we are operating outside of a Git
+	 * repository we cannot determine one. For now default to SHA1.
+	 */
+	if (nongit && !the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	const struct option options[] = {
 		OPT_BIT('c', "committer", &log.groups,
 			N_("group by committer rather than author"),

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
2.47.0

