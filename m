Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32993315D49
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137410; cv=none; b=eA1/w+qCzL3QYPse3kpoT7PAde8wgdNXC6gNkCeXUAf+4A/yYdTjmviDZdrrdWmQbZn/irulPUbHb5C0BZxegZe+WUVjIxhXijs6J6ytC1RNk9hcDfghXFIfJ2fskxDRhIO02wZ3CuCb4DlkV+YIaeBB2pfyixBmW9B3vfLnbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137410; c=relaxed/simple;
	bh=RTp+OxS5u8mPe5kYxukBt6j3vKlC8W8sdz6STOZ+VzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXrdA+Q0flgd9EXAygQwU+x0SM8hnkPqZxQlmFUzZxUjtBexdrPXiMWvefCv9KKpMPFA195HjmUmuUQ3CecFhKjYCqGHLPOd+BWtLPgrVhmgCra/YAeo0Ql3zW6fF6fMI/XdbHKXLWeYh2F/LsNYRR2nvUboDdAXQVJP2LfiZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=LTTJ1+Vk; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="LTTJ1+Vk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764137405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUMcb9s2Yn1RpEoSPku+9G1ZqMP31w745BbCOVI3BRg=;
	b=LTTJ1+Vkzct7p1RW1qg2mBv0r9BolPzHnfVVzObSfJM1ZM39KMKVtjaYDvIlOQjGUnqM97
	5c/dVffrKP373SpQ31vvQaf5n9fKPRamBslApMqeZlSJDjnv5ZBnA5keUWxwHTjX1v74Cp
	KqIwJ5YjYBDrSIF+TiMHY6aPnkKjFto=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Nov 2025 07:09:43 +0100
Subject: [PATCH 1/3] last-modified: handle and document NUL termination
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-toon-last-modified-zzzz-v1-1-608350df0caa@iotcl.com>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When option `-z` is provided to git-last-modified(1), each line is
separated with a NUL instead of a newline. Document this properly and
handle parsing of the option in the builtin itself.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc | 21 ++++++++++++++++++++-
 builtin/last-modified.c              | 13 ++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 602843e095..cd4a5040b0 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -9,7 +9,7 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
 SYNOPSIS
 --------
 [synopsis]
-git last-modified [--recursive] [--show-trees] [<revision-range>] [[--] <path>...]
+git last-modified [--recursive] [--show-trees] [-z] [<revision-range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -32,6 +32,9 @@ OPTIONS
 	Show tree entries even when recursing into them. It has no effect
 	without `--recursive`.
 
+`-z`::
+	Terminate each line with a _NUL_ rather than a newline.
+
 `<revision-range>`::
 	Only traverse commits in the specified revision range. When no
 	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
@@ -44,6 +47,22 @@ OPTIONS
 	Without an optional path parameter, all files and subdirectories
 	in path traversal the are included in the output.
 
+OUTPUT
+------
+
+The output is in the format:
+
+------------
+ <oid> TAB <path> LF
+------------
+
+If a path contains any special characters, the path is C-style quoted. To
+avoid quoting, pass option `-z` to terminate each line with a NUL.
+
+------------
+ <oid> TAB <path> NUL
+------------
+
 SEE ALSO
 --------
 linkgit:git-blame[1],
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index b0ecbdc540..9206bbdc1d 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -23,6 +23,10 @@
 #define PARENT1 (1u<<16) /* used instead of SEEN */
 #define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */
 
+#define LAST_MODIFIED_INIT { \
+	.line_termination = '\n', \
+}
+
 struct last_modified_entry {
 	struct hashmap_entry hashent;
 	struct object_id oid;
@@ -55,6 +59,7 @@ struct last_modified {
 	struct rev_info rev;
 	bool recursive;
 	bool show_trees;
+	int line_termination;
 
 	const char **all_paths;
 	size_t all_paths_nr;
@@ -165,7 +170,7 @@ static void last_modified_emit(struct last_modified *lm,
 		putchar('^');
 	printf("%s\t", oid_to_hex(&commit->object.oid));
 
-	if (lm->rev.diffopt.line_termination)
+	if (lm->line_termination)
 		write_name_quoted(path, stdout, '\n');
 	else
 		printf("%s%c", path, '\0');
@@ -507,10 +512,10 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 		      struct repository *repo)
 {
 	int ret;
-	struct last_modified lm = { 0 };
+	struct last_modified lm = LAST_MODIFIED_INIT;
 
 	const char * const last_modified_usage[] = {
-		N_("git last-modified [--recursive] [--show-trees] "
+		N_("git last-modified [--recursive] [--show-trees] [-z] "
 		   "[<revision-range>] [[--] <path>...]"),
 		NULL
 	};
@@ -520,6 +525,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 			 N_("recurse into subtrees")),
 		OPT_BOOL('t', "show-trees", &lm.show_trees,
 			 N_("show tree entries when recursing into subtrees")),
+		OPT_SET_INT('z', NULL, &lm.line_termination,
+			N_("lines are separated with NUL character"), '\0'),
 		OPT_END()
 	};
 

-- 
2.51.2

