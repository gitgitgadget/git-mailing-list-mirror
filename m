Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53503396F1
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945650; cv=none; b=Wb+o33p5nJLLoS1Gl4Lzp4OM1Is51IcLn0UH80einZNNxekYugmlxdwxeoX39DlniG4qjWZsjywb5Bj+19xoYRF2fDs4t4JhlgorMgy12+oZcVMwTvNik7qp1cmhbDh0NumFnny1+ePVli6Pl4E13HdcCVgQYELtCnt55YM3n1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945650; c=relaxed/simple;
	bh=gKgA/oWJEDMO3S33e+k219ZNEMV5gnK+hEoIoWXm8Wc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=VpBZejzZgJTHZbnT4PRZldE9cBuE383aYo7c0G8N5Iiepzn118uFnAAynMG2BzEi6QsLnivc/FogXQgpCTAfSS5cQe2XrDEr/+xQJTs8UilC0NMYFswBoNROvRLpzy9WboZUSf/9ZLhNjIKefTP2Of001IafPtumVKLpdwt/rXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=BBkE42I5; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="BBkE42I5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768945640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibeHi/A+4XUG5Mpk90WDgW1L+wLMG3XsCoKNtH2Xaaw=;
	b=BBkE42I5gT2VARaGP2d5Lo9PRhKippOZEew0movG6P03VW2VAIE7fHaNwSKdXObxzcVAzY
	67q9aCPv2Nfb+aoz/W1atlb67LLlwnCPYoeHm9EeovXajf6aoB2YdZtUuMeywI0w74d4Kr
	DK4wtAkKaXwlQuMw4eGze+PQyXWey7g=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v3 0/4] Change git-last-modified(1) default behavior and
 add documentation
Date: Tue, 20 Jan 2026 22:47:07 +0100
Message-Id: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANv3b2kC/33NwQ7CIAyA4VdZOIsBxtjmyfcwHhCKa7INAwtRl
 727bNHEi/b2N+nXmUQICJEcipkESBjRjznKXUFMp8crULS5iWCi4pxLOnk/0l7HiQ7eokOw9Jm
 HatcafoFaOiNJvr4FcHjf5NM5d4dx8uGxPUp83b5NoX6aiVNGFWvKilnHjNZH9JPp98YPZDWT+
 DiKcf7HEdmpW5DSiYYpB9/OsiwvTm9IDwYBAAA=
X-Change-ID: 20251114-toon-last-modified-zzzz-af9c1be74fc4
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
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
Changes in v3:
- Rejoined the two commits about `-z and the two about `--max-depth`
- In the end, drop `struct last_modified::recursive`. This ensures
  the effect of `--recursive` or `--max-depth` depends on whatever comes
  last.
- Added a commit to rename `<path>` to `<pathspec>` in the docs.
- Link to v2: https://patch.msgid.link/20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com

Changes in v2:
- Change the default --max-depth.
- Split up commits in smaller pieces.
- Add more testss
- Link to v1: https://patch.msgid.link/20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com

Cc: Gusted <gusted@codeberg.org>

---
Toon Claes (4):
      last-modified: clarify in the docs the command takes a pathspec
      last-modified: document option '-z'
      last-modified: document option '--max-depth'
      last-modified: change default max-depth to 0

 Documentation/git-last-modified.adoc | 45 ++++++++++++++++++++++++++++--------
 builtin/last-modified.c              | 25 ++++++++++++--------
 t/t8020-last-modified.sh             | 35 ++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 18 deletions(-)

Range-diff versus v2:

-:  ---------- > 1:  1290dbb179 last-modified: clarify in the docs the command takes a pathspec
1:  2c9fa32799 ! 2:  8ba5c59ae8 last-modified: document NUL termination
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    last-modified: document NUL termination
    +    last-modified: document option '-z'
     
         The command git-last-modified(1) already recognizes the option '-z', and
         similar to many other commands this will make the output NUL-terminated
         instead of using newlines. Although, this option is missing from the
         documentation, so add it.
     
    +    In addition to that, to have '-z' also appear in the help output of `git
    +    last-modified -h`, move the handling of '-z' to parse_options() in
    +    builtin/last-modified.c itself.
    +
    +    Before, the parsing of option '-z' was done by diff_opt_parse(), which
    +    is called by setup_revisions(). That would fill in `struct
    +    diff_options::line_termination`, but that field was not used by the diff
    +    machinery itself. Thus it makes more sense to have the handling of that
    +    option completely in builtin/last-modified.c.
    +
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## Documentation/git-last-modified.adoc ##
    @@ Documentation/git-last-modified.adoc: git-last-modified - EXPERIMENTAL: Show whe
      SYNOPSIS
      --------
      [synopsis]
    --git last-modified [--recursive] [--show-trees] [<revision-range>] [[--] <path>...]
    +-git last-modified [--recursive] [--show-trees]
     +git last-modified [--recursive] [--show-trees] [-z]
    -+		  [<revision-range>] [[--] <path>...]
    + 		  [<revision-range>] [[--] <pathspec>...]
      
      DESCRIPTION
    - -----------
     @@ Documentation/git-last-modified.adoc: OPTIONS
      	Show tree entries even when recursing into them. It has no effect
      	without `--recursive`.
    @@ Documentation/git-last-modified.adoc: OPTIONS
      	Only traverse commits in the specified revision range. When no
      	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
     @@ Documentation/git-last-modified.adoc: OPTIONS
    - 	Without an optional path parameter, all files and subdirectories
    - 	in path traversal the are included in the output.
    + 	If no _<pathspec>_ is given, all files and subdirectories are included.
    + 	See linkgit:gitglossary[7] for details on pathspec syntax.
      
     +OUTPUT
     +------
    @@ Documentation/git-last-modified.adoc: OPTIONS
      linkgit:git-blame[1],
     
      ## builtin/last-modified.c ##
    +@@ builtin/last-modified.c: struct last_modified {
    + 	struct rev_info rev;
    + 	bool recursive;
    + 	bool show_trees;
    ++	bool nul_termination;
    + 
    + 	const char **all_paths;
    + 	size_t all_paths_nr;
    +@@ builtin/last-modified.c: static void last_modified_emit(struct last_modified *lm,
    + 		putchar('^');
    + 	printf("%s\t", oid_to_hex(&commit->object.oid));
    + 
    +-	if (lm->rev.diffopt.line_termination)
    +-		write_name_quoted(path, stdout, '\n');
    +-	else
    ++	if (lm->nul_termination)
    + 		printf("%s%c", path, '\0');
    ++	else
    ++		write_name_quoted(path, stdout, '\n');
    + }
    + 
    + static void mark_path(const char *path, const struct object_id *oid,
     @@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
      	struct last_modified lm = { 0 };
      
      	const char * const last_modified_usage[] = {
    --		N_("git last-modified [--recursive] [--show-trees] "
    --		   "[<revision-range>] [[--] <path>...]"),
    +-		N_("git last-modified [--recursive] [--show-trees]\n"
     +		N_("git last-modified [--recursive] [--show-trees] [-z]\n"
    -+		   "                  [<revision-range>] [[--] <path>...]"),
    + 		   "                  [<revision-range>] [[--] <pathspec>...]"),
      		NULL
      	};
    +@@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
    + 			 N_("recurse into subtrees")),
    + 		OPT_BOOL('t', "show-trees", &lm.show_trees,
    + 			 N_("show tree entries when recursing into subtrees")),
    ++		OPT_BOOL('z', NULL, &lm.nul_termination,
    ++			 N_("lines are separated with NUL character")),
    + 		OPT_END()
    + 	};
      
2:  04589b4ccc < -:  ---------- last-modified: add option '-z' to help output
3:  a45fe991ff < -:  ---------- last-modified: document option --max-depth
4:  3103084474 ! 3:  a1f0178263 last-modified: add option '--max-depth' to help output
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    last-modified: add option '--max-depth' to help output
    +    last-modified: document option '--max-depth'
    +
    +    Option --max-depth is supported by git-last-modified(1), because it was
    +    added to the diff machinery in a1dfa5448d (diff: teach tree-diff a
    +    max-depth parameter, 2025-08-07).
    +
    +    This option is useful for everyday use of the git-last-modified(1)
    +    command, so document it's existence in the man page.
     
    -    In previous commit option '--max-depth' was added to the documentation.
         To have it also appear in the help output of `git last-modified -h`,
         move the handling of '--max-depth' to parse_options() in
    -    builtin/last-modified.c itself.
    -
    -    It enables us to change default behavior in a subsequent commit.
    +    builtin/last-modified.c itself. This prepares for the change in default
    +    behavior in the next commit.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    + ## Documentation/git-last-modified.adoc ##
    +@@ Documentation/git-last-modified.adoc: git-last-modified - EXPERIMENTAL: Show when files were last modified
    + SYNOPSIS
    + --------
    + [synopsis]
    +-git last-modified [--recursive] [--show-trees] [-z]
    ++git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]
    + 		  [<revision-range>] [[--] <pathspec>...]
    + 
    + DESCRIPTION
    +@@ Documentation/git-last-modified.adoc: OPTIONS
    + 	Show tree entries even when recursing into them. It has no effect
    + 	without `--recursive`.
    + 
    ++`--max-depth=<depth>`::
    ++	For each pathspec given on the command line, traverse at most `<depth>`
    ++	levels into subtrees. A negative value means no limit.
    ++	The default is 0, which shows all paths matching the pathspec
    ++	without descending into subtrees.
    ++
    + `-z`::
    + 	Terminate each line with a _NUL_ character rather than a newline.
    + 
    +
      ## builtin/last-modified.c ##
     @@ builtin/last-modified.c: struct last_modified {
      	bool recursive;
      	bool show_trees;
    - 	bool null_termination;
    + 	bool nul_termination;
     +	int max_depth;
      
      	const char **all_paths;
    @@ builtin/last-modified.c: static int last_modified_init(struct last_modified *lm,
      	argc = setup_revisions(argc, argv, &lm->rev, NULL);
      	if (argc > 1) {
      		error(_("unknown last-modified argument: %s"), argv[1]);
    +@@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
    + 	struct last_modified lm = { 0 };
    + 
    + 	const char * const last_modified_usage[] = {
    +-		N_("git last-modified [--recursive] [--show-trees] [-z]\n"
    ++		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]\n"
    + 		   "                  [<revision-range>] [[--] <pathspec>...]"),
    + 		NULL
    + 	};
     @@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
      			 N_("recurse into subtrees")),
      		OPT_BOOL('t', "show-trees", &lm.show_trees,
      			 N_("show tree entries when recursing into subtrees")),
     +		OPT_INTEGER_F(0, "max-depth", &lm.max_depth,
    -+			N_("maximum tree depth to recurse"), PARSE_OPT_NONEG),
    - 		OPT_BOOL('z', NULL, &lm.null_termination,
    - 			N_("lines are separated with NUL character")),
    ++			      N_("maximum tree depth to recurse"), PARSE_OPT_NONEG),
    + 		OPT_BOOL('z', NULL, &lm.nul_termination,
    + 			 N_("lines are separated with NUL character")),
      		OPT_END()
      	};
      
5:  3795e85ab5 ! 4:  81ce108196 last-modified: change default max-depth to 0
    @@ Commit message
     
      ## Documentation/git-last-modified.adoc ##
     @@ Documentation/git-last-modified.adoc: OPTIONS
    + 
    + `-r`::
      `--recursive`::
    - 	Instead of showing tree entries, step into subtrees and show all entries
    - 	inside them recursively.
    -+	This is identical as setting `--max-depth=-1`.
    +-	Instead of showing tree entries, step into subtrees and show all entries
    +-	inside them recursively.
    ++	Recursively traverse into all subtrees. By default, the command only
    ++	shows tree entries matching the `<pathspec>`. With this option, it
    ++	descends into subtrees and displays all entries within them.
    ++	Equivalent to `--max-depth=-1`.
      
      `-t`::
      `--show-trees`::
    -@@ Documentation/git-last-modified.adoc: OPTIONS
    - `--max-depth=<depth>`::
    - 	For each pathspec given on the command line, descend at most `<depth>`
    - 	levels of directories. A negative value means no limit.
    --	Setting a positive value implies `--recursive`.
    -+	The default depth is 0.
    - 	Cannot be combined with wildcards in the pathspec.
    +-	Show tree entries even when recursing into them. It has no effect
    +-	without `--recursive`.
    ++	Show tree entries even when recursing into them.
      
    - `-z`::
    + `--max-depth=<depth>`::
    + 	For each pathspec given on the command line, traverse at most `<depth>`
     
      ## builtin/last-modified.c ##
    +@@ builtin/last-modified.c: define_commit_slab(active_paths_for_commit, struct bitmap *);
    + struct last_modified {
    + 	struct hashmap paths;
    + 	struct rev_info rev;
    +-	bool recursive;
    + 	bool show_trees;
    + 	bool nul_termination;
    + 	int max_depth;
     @@ builtin/last-modified.c: static int last_modified_init(struct last_modified *lm, struct repository *r,
      	lm->rev.no_commit_id = 1;
      	lm->rev.diff = 1;
    @@ builtin/last-modified.c: static int last_modified_init(struct last_modified *lm,
     -		lm->rev.diffopt.max_depth_valid = 1;
     -	}
     +	lm->rev.diffopt.max_depth = lm->max_depth;
    -+	lm->rev.diffopt.max_depth_valid = !lm->recursive && lm->max_depth >= 0;
    ++	lm->rev.diffopt.max_depth_valid = lm->max_depth >= 0;
      
      	argc = setup_revisions(argc, argv, &lm->rev, NULL);
      	if (argc > 1) {
    +@@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
    + 	};
    + 
    + 	struct option last_modified_options[] = {
    +-		OPT_BOOL('r', "recursive", &lm.recursive,
    +-			 N_("recurse into subtrees")),
    ++		OPT_SET_INT('r', "recursive", &lm.max_depth,
    ++			    N_("recurse into subtrees"), -1),
    + 		OPT_BOOL('t', "show-trees", &lm.show_trees,
    + 			 N_("show tree entries when recursing into subtrees")),
    + 		OPT_INTEGER_F(0, "max-depth", &lm.max_depth,
     @@ builtin/last-modified.c: int cmd_last_modified(int argc, const char **argv, const char *prefix,
      		OPT_END()
      	};


---
base-commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
change-id: 20251114-toon-last-modified-zzzz-af9c1be74fc4

