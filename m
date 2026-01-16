Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC323FC54
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569784; cv=none; b=VZuqMMbZNRoM+N/QwnIWtQ0+NNf+ZDQaLjp1SLcQ38pp+muKIuHPzOnyIBsYb6XXJZiUUD6DE5v2JKc+E08Gs+P0av4KK/zXNa3RQafNR/fbiRE5JLWrmJUD1F2+DRcqYXvt/G2BD/4hoAc/SyO3h7PgUTlUJ4uX6rqwU5PJQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569784; c=relaxed/simple;
	bh=tkQbcT+sR7Az0xDbXk7CtTANaEieNcCN8/hIYCoCM5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=IhvS32M8X4QuRppeJ/0Alfzx+Nv/CWhpZzpq8nRVwbiDwatbaObU2512brflEfKxCIOdc4lr+WxcHv5WCzICdki4qGxWf5mri3/bWopuLHavfSRU5sGsj/SSanYZzskJPDS/gKSiHUMGHiNEKV9Dtf3KoGRrHoGTkmbWRF2b5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gP5Owb1C; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gP5Owb1C"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768569779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1TOImUCM5tOmQ0k8MqVVfMGsAoSbTv9nAWYq63MABc=;
	b=gP5Owb1C4ww6MVgTfqj35+QU1oqvVMaIdIYMA/WcGvU1dka592Wlj8QvuqnigqIujtEQee
	goYuj0YfS3z43DR/UU7NV8yMKNnekbE44uVAcRYJiK6jCXFyXp0HDJDRug5rfoYSos1Phk
	NpTI4QM0zWmtdlvfHwVguOlI9djSFEE=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/5] Change git-last-modified(1) default behavior and
 add documentation
Date: Fri, 16 Jan 2026 14:22:48 +0100
Message-Id: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKg7amkC/3WNzQrCMBCEX6Xs2ZUktvXn5HtIDzHZ2IW2K0koa
 um7G8Wrc/sG5psFEkWmBKdqgUgzJ5apgNlU4Ho73QjZFwajTKO1rjGLTDjYlHEUz4HJ46sEbTg
 6faV9HVwNZX2PFPjxNV+6wj2nLPH5PZr1p/05TfvXOWtU2KrDrlE+KGftmSW7YetkhG5d1zddD
 6BavgAAAA==
X-Change-ID: 20251114-toon-last-modified-zzzz-af9c1be74fc4
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

We have had several reports[1][2] from users that have been thoroughly
confused by the default behaviour of git-last-modified(1). Most
importantly, when using the command on trees other than the root tree
the requests are seemingly ignoring that request and instead blame the
top-level subtree. For example:

    $ git last-modified t/lib-bash.sh
    acdfea4394db8e8b42f48e36f7726d64a909a89d t

This result is completely unexpected and feels buggy to anybody who is
not deeply familiar with git-last-modified(1). Furthermore, users
typically have a hard time to figure out the correct parameters.

This series changes the behavior to something that intuitively makes
more sense.

The change of the default behavior is done in the last commit, in the
lead-up commits changes in the documentation are made.

[1]: <f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com>
[2]: <03f96860-29fc-42a7-a220-c3ec65eb8516@codeberg.org>

---
Changes in v2:
- Change the default --max-depth.
- Split up commits in smaller pieces.
- Add more testss
- Link to v1: https://patch.msgid.link/20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com

Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: Gusted <gusted@codeberg.org>

---
Toon Claes (5):
      last-modified: document NUL termination
      last-modified: add option '-z' to help output
      last-modified: document option --max-depth
      last-modified: add option '--max-depth' to help output
      last-modified: change default max-depth to 0

 Documentation/git-last-modified.adoc | 29 ++++++++++++++++++++++++++++-
 builtin/last-modified.c              | 20 ++++++++++++++------
 t/t8020-last-modified.sh             | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 7 deletions(-)

Range-diff versus v1:

1:  7f599cf0d1 ! 1:  4a9b8170c3 last-modified: handle and document NUL termination
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    last-modified: handle and document NUL termination
    +    last-modified: document NUL termination
     
    -    When option `-z` is provided to git-last-modified(1), each line is
    -    separated with a NUL instead of a newline. Document this properly and
    -    handle parsing of the option in the builtin itself.
    +    The command git-last-modified(1) already recognizes the option '-z', and
    +    similar to many other commands this will make the output NUL-terminated
    +    instead of using newlines. Although, this option is missing from the
    +    documentation, so add it.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    @@ Documentation/git-last-modified.adoc: git-last-modified - EXPERIMENTAL: Show whe
      --------
      [synopsis]
     -git last-modified [--recursive] [--show-trees] [<revision-range>] [[--] <path>...]
    -+git last-modified [--recursive] [--show-trees] [-z] [<revision-range>] [[--] <path>...]
    ++git last-modified [--recursive] [--show-trees] [-z]
    ++		  [<revision-range>] [[--] <path>...]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-last-modified.adoc: OPTIONS
      	without `--recursive`.
      
     +`-z`::
    -+	Terminate each line with a _NUL_ rather than a newline.
    ++	Terminate each line with a _NUL_ character rather than a newline.
     +
      `<revision-range>`::
      	Only traverse commits in the specified revision range. When no
    @@ Documentation/git-last-modified.adoc: OPTIONS
      linkgit:git-blame[1],
     
      ## builtin/last-modified.c ##
    -@@
    - #define PARENT1 (1u<<16) /* used instead of SEEN */
    - #define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */
    - 
    -+#define LAST_MODIFIED_INIT { \
    -+	.line_termination = '\n', \
    -+}
    -+
    - struct last_modified_entry {
    - 	struct hashmap_entry hashent;
    - 	struct object_id oid;
    -@@ builtin/last-modified.c: struct last_modified {
    - 	struct rev_info rev;
    - 	bool recursive;
    - 	bool show_trees;
    -+	int line_termination;
    - 
    - 	const char **all_paths;
    - 	size_t all_paths_nr;
    -@@ builtin/last-modified.c: static void last_modified_emit(struct last_modified *lm,
    - 		putchar('^');
    - 	printf("%s\t", oid_to_hex(&commit->object.oid));
    - 
    --	if (lm->rev.diffopt.line_termination)
    -+	if (lm->line_termination)
    - 		write_name_quoted(path, stdout, '\n');
    - 	else
    - 		printf("%s%c", path, '\0');
     @@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
    - 		      struct repository *repo)
    - {
    - 	int ret;
    --	struct last_modified lm = { 0 };
    -+	struct last_modified lm = LAST_MODIFIED_INIT;
    + 	struct last_modified lm = { 0 };
      
      	const char * const last_modified_usage[] = {
     -		N_("git last-modified [--recursive] [--show-trees] "
    -+		N_("git last-modified [--recursive] [--show-trees] [-z] "
    - 		   "[<revision-range>] [[--] <path>...]"),
    +-		   "[<revision-range>] [[--] <path>...]"),
    ++		N_("git last-modified [--recursive] [--show-trees] [-z]\n"
    ++		   "                  [<revision-range>] [[--] <path>...]"),
      		NULL
      	};
    -@@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
    - 			 N_("recurse into subtrees")),
    - 		OPT_BOOL('t', "show-trees", &lm.show_trees,
    - 			 N_("show tree entries when recursing into subtrees")),
    -+		OPT_SET_INT('z', NULL, &lm.line_termination,
    -+			N_("lines are separated with NUL character"), '\0'),
    - 		OPT_END()
    - 	};
      
-:  ---------- > 2:  94efeb29b1 last-modified: add option '-z' to help output
-:  ---------- > 3:  5669ab25e8 last-modified: document option --max-depth
2:  f193241248 ! 4:  b3060f8b38 last-modified: document option --max-depth
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    last-modified: document option --max-depth
    +    last-modified: add option '--max-depth' to help output
     
    -    Option --max-depth is supported by git-last-modified(1), because it was
    -    added to the diff machinery in a1dfa5448d (diff: teach tree-diff a
    -    max-depth parameter, 2025-08-07).
    +    In previous commit option '--max-depth' was added to the documentation.
    +    To have it also appear in the help output of `git last-modified -h`,
    +    move the handling of '--max-depth' to parse_options() in
    +    builtin/last-modified.c itself.
     
    -    This option is useful for everyday use of the git-last-modified(1)
    -    command, so document it's existence in the man page and `-h` output.
    +    It enables us to change default behavior in a subsequent commit.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    - ## Documentation/git-last-modified.adoc ##
    -@@ Documentation/git-last-modified.adoc: git-last-modified - EXPERIMENTAL: Show when files were last modified
    - SYNOPSIS
    - --------
    - [synopsis]
    --git last-modified [--recursive] [--show-trees] [-z] [<revision-range>] [[--] <path>...]
    -+git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]
    -+	[<revision-range>] [[--] <path>...]
    - 
    - DESCRIPTION
    - -----------
    -@@ Documentation/git-last-modified.adoc: OPTIONS
    - 	Show tree entries even when recursing into them. It has no effect
    - 	without `--recursive`.
    - 
    -+`--max-depth=<depth>`::
    -+	For each pathspec given on the command line, descend at most `<depth>`
    -+	levels of directories. A negative value means no limit.
    -+	Setting a positive value implies `--recursive`.
    -+	Cannot be combined with wildcards in the pathspec.
    -+
    - `-z`::
    - 	Terminate each line with a _NUL_ rather than a newline.
    - 
    -
      ## builtin/last-modified.c ##
    -@@
    - 
    - #define LAST_MODIFIED_INIT { \
    - 	.line_termination = '\n', \
    -+	.max_depth = -1, \
    - }
    - 
    - struct last_modified_entry {
     @@ builtin/last-modified.c: struct last_modified {
      	bool recursive;
      	bool show_trees;
    - 	int line_termination;
    + 	bool null_termination;
     +	int max_depth;
      
      	const char **all_paths;
    @@ builtin/last-modified.c: static int last_modified_init(struct last_modified *lm,
      	argc = setup_revisions(argc, argv, &lm->rev, NULL);
      	if (argc > 1) {
      		error(_("unknown last-modified argument: %s"), argv[1]);
    -@@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
    - 	struct last_modified lm = LAST_MODIFIED_INIT;
    - 
    - 	const char * const last_modified_usage[] = {
    --		N_("git last-modified [--recursive] [--show-trees] [-z] "
    -+		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z] "
    - 		   "[<revision-range>] [[--] <path>...]"),
    - 		NULL
    - 	};
     @@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
      			 N_("recurse into subtrees")),
      		OPT_BOOL('t', "show-trees", &lm.show_trees,
      			 N_("show tree entries when recursing into subtrees")),
     +		OPT_INTEGER_F(0, "max-depth", &lm.max_depth,
     +			N_("maximum tree depth to recurse"), PARSE_OPT_NONEG),
    - 		OPT_SET_INT('z', NULL, &lm.line_termination,
    - 			N_("lines are separated with NUL character"), '\0'),
    + 		OPT_BOOL('z', NULL, &lm.null_termination,
    + 			N_("lines are separated with NUL character")),
      		OPT_END()
    + 	};
    + 
    ++	/*
    ++	 * Set the default of a max-depth to "unset". This will change in a
    ++	 * subsequent commit.
    ++	 */
    ++	lm.max_depth = -1;
    ++
    + 	argc = parse_options(argc, argv, prefix, last_modified_options,
    + 			     last_modified_usage,
    + 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
3:  6773f073d6 < -:  ---------- last-modified: better document how depth in handled
-:  ---------- > 5:  41819f8732 last-modified: change default max-depth to 0


---
base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
change-id: 20251114-toon-last-modified-zzzz-af9c1be74fc4

