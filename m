Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12273C00AA
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945664; cv=none; b=OY9inaAbeis9Sp9dv26VU9BYqxlT73hYRVID8K9S53HDU8kziEHG6ths2WLUP41VOZAweDztTep2q6VZtJiiTP/xLEQnXsUwr11wWyNsxdjNoOabcGvhRoH27C1EGmWKeBmbn1yPixbILQXL1VOS8GiGqg5O2L6CwItH0he6fF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945664; c=relaxed/simple;
	bh=Q6nTQT8Ew00QFuV6hVIKX+3P2EeerbfAFYUyXV2YePw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1WmJsNCc/498Vvyv9bv8uvIxMK6ZXnQ6riC1U+dUWVKm4TrcQDi66qycyN8RjPaIOuOfKMwr9Y+s/Nce7sG3DHx/BxSNLUyK+bVZntRjDSqYVpztwFsom+G6B4S1uRPW9o4ZeUHgDku6yiBqYfHXKXup59PHG0EDKKNtBemU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ZxIP64tj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ZxIP64tj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768945658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvH+C1iwUv+V9B2JqXOArzGNLtwqBPIRjHiCg1aJHOA=;
	b=ZxIP64tjsuPaPj0vZzDaDJ608dhTsFr3r36JC1gR/EL3WY2LEiB4Zs6o910vUI3FzvGDVW
	AfIw3QrjwH5Bxt9J0sOX/AziPeGVCsVELYcEilipmGfc6Zb9FEk9GhhaubTljyHYCQ8wHQ
	48qwWS0pSoxwr8idQKucFlBV1P8dtTU=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 20 Jan 2026 22:47:09 +0100
Subject: [PATCH v3 2/4] last-modified: document option '-z'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-toon-last-modified-zzzz-v3-2-9bffd4968b0e@iotcl.com>
References: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
In-Reply-To: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The command git-last-modified(1) already recognizes the option '-z', and
similar to many other commands this will make the output NUL-terminated
instead of using newlines. Although, this option is missing from the
documentation, so add it.

In addition to that, to have '-z' also appear in the help output of `git
last-modified -h`, move the handling of '-z' to parse_options() in
builtin/last-modified.c itself.

Before, the parsing of option '-z' was done by diff_opt_parse(), which
is called by setup_revisions(). That would fill in `struct
diff_options::line_termination`, but that field was not used by the diff
machinery itself. Thus it makes more sense to have the handling of that
option completely in builtin/last-modified.c.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc | 21 ++++++++++++++++++++-
 builtin/last-modified.c              | 11 +++++++----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 7c3fd844b8..3760fd33a1 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -9,7 +9,7 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
 SYNOPSIS
 --------
 [synopsis]
-git last-modified [--recursive] [--show-trees]
+git last-modified [--recursive] [--show-trees] [-z]
 		  [<revision-range>] [[--] <pathspec>...]
 
 DESCRIPTION
@@ -33,6 +33,9 @@ OPTIONS
 	Show tree entries even when recursing into them. It has no effect
 	without `--recursive`.
 
+`-z`::
+	Terminate each line with a _NUL_ character rather than a newline.
+
 `<revision-range>`::
 	Only traverse commits in the specified revision range. When no
 	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
@@ -45,6 +48,22 @@ OPTIONS
 	If no _<pathspec>_ is given, all files and subdirectories are included.
 	See linkgit:gitglossary[7] for details on pathspec syntax.
 
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
index e38e0bc4ca..4060abfad3 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -55,6 +55,7 @@ struct last_modified {
 	struct rev_info rev;
 	bool recursive;
 	bool show_trees;
+	bool nul_termination;
 
 	const char **all_paths;
 	size_t all_paths_nr;
@@ -165,10 +166,10 @@ static void last_modified_emit(struct last_modified *lm,
 		putchar('^');
 	printf("%s\t", oid_to_hex(&commit->object.oid));
 
-	if (lm->rev.diffopt.line_termination)
-		write_name_quoted(path, stdout, '\n');
-	else
+	if (lm->nul_termination)
 		printf("%s%c", path, '\0');
+	else
+		write_name_quoted(path, stdout, '\n');
 }
 
 static void mark_path(const char *path, const struct object_id *oid,
@@ -510,7 +511,7 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 	struct last_modified lm = { 0 };
 
 	const char * const last_modified_usage[] = {
-		N_("git last-modified [--recursive] [--show-trees]\n"
+		N_("git last-modified [--recursive] [--show-trees] [-z]\n"
 		   "                  [<revision-range>] [[--] <pathspec>...]"),
 		NULL
 	};
@@ -520,6 +521,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 			 N_("recurse into subtrees")),
 		OPT_BOOL('t', "show-trees", &lm.show_trees,
 			 N_("show tree entries when recursing into subtrees")),
+		OPT_BOOL('z', NULL, &lm.nul_termination,
+			 N_("lines are separated with NUL character")),
 		OPT_END()
 	};
 

-- 
2.52.0

