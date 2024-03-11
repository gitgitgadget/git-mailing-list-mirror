Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D843AAB
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193179; cv=none; b=qu3axNa/IsiL61w1vmCyeZLbqvf0VihuVsX3a1zBrFizr0nYd3rM4vqox1ehK7O9ijMY8k967IfX48DbP6V0v2cOyTCyRR3UFAe/QNvHmVytMFZPtPW29fRikd/RqIoBW9fj+wL/NFtcv1337J/StV/WGy5Z+Mj1VM9Y/r8HBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193179; c=relaxed/simple;
	bh=8kQTIy7aTZlhuMWulhDYxtGLUNyZUEjDughHoQMD0Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hM1uUsdVQzmMkyzhJ4lmwfjvFC8McNjy9StfLaIxpeETvuzII1Ld1E67aDEXr9NaprVTkwUVz6iGuZDpZohUqReK6xgkvGzB3F4TPMnYZ+kpd6SM2oXrm6q0eInScAt5aFDagVtJ8fATyxfHYDK2881H9qeSd+c0N52CDUS1Xio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>
Subject: [PATCH v3 0/2] diff: copies-harder support
Date: Mon, 11 Mar 2024 21:38:52 +0000
Message-ID: <20240311213928.1872437-1-sam@gentoo.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

range-diff:
```
1:  4ad89a3f1a ! 1:  879565c99a diff: implement config.diff.renames=copies-harder
    @@ Commit message
         This allows specifying that 'git log -p', 'git diff', etc should always act
         as if '-C --find-copies-harder' was passed.

    -    I've found this especially useful for certain types of repository (like
    +    It has proven this especially useful for certain types of repository (like
         Gentoo's ebuild repositories) because files are often copies of a previous
    -    version.
    +    version:
    +
    +    Suppose a directory 'sys-devel/gcc' contains recipes for building
    +    GCC, with one file for each supported upstream branch:
    +      gcc-13.x.build.recipe
    +      gcc-12.x.build.recipe
    +      gcc-11.x.build.recipe
    +      gcc-10.x.build.recipe
    +
    +    gcc-13.x.build.recipe was started as a copy of gcc-12.x.build.recipe
    +    (which was started as a copy of gcc-11.x.build.recipe, etc.). Previous versions
    +    are kept around to support parallel installation of multiple versions.
    +
    +    Being able to easily observe the diff relative to other recipes within the
    +    directory has been a quality of life improvement for such repo layouts.

         Signed-off-by: Sam James <sam@gentoo.org>

    @@ Documentation/config/diff.txt: diff.renames::
      	rename detection is disabled. If set to "true", basic rename
      	detection is enabled.  If set to "copies" or "copy", Git will
     -	detect copies, as well.  Defaults to true.  Note that this
    -+	detect copies, as well.  If set to "copies-harder", Git will try harder
    -+	to detect copies.  Defaults to true.  Note that this
    - 	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
    - 	linkgit:git-log[1], and not lower level commands such as
    +-	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
    +-	linkgit:git-log[1], and not lower level commands such as
    ++	detect copies, as well.  If set to "copies-harder", Git will spend extra
    ++	cycles to find more copies even in unmodified paths, see
    ++	'--find-copies-harder' in linkgit:git-diff[1]. Defaults to true.
    ++	Note that this affects only 'git diff' Porcelain like linkgit:git-diff[1]
    ++	and linkgit:git-log[1], and not lower level commands such as
      	linkgit:git-diff-files[1].
    +
    + diff.suppressBlankEmpty::

      ## Documentation/config/status.txt ##
     @@ Documentation/config/status.txt: status.renames::
    @@ Documentation/config/status.txt: status.renames::
      	linkgit:git-commit[1] .  If set to "false", rename detection is
      	disabled. If set to "true", basic rename detection is enabled.
     -	If set to "copies" or "copy", Git will detect copies, as well.
    -+	If set to "copies" or "copy", Git will detect copies, as well.  If
    -+	set to "copies-harder", Git will try harder to detect copies.
    ++	If set to "copies" or "copy", Git will detect copies, as well.  If set
    ++	to "copies-harder", Git will spend extra cycles to find more copies even
    ++	in unmodified paths, see '--find-copies-harder' in linkgit:git-diff[1].
      	Defaults to the value of diff.renames.

      status.showStash::
    @@ diff.c: int git_config_rename(const char *var, const char *value)
     +	if (!strcasecmp(value, "copies-harder"))
     +		return DIFF_DETECT_COPY_HARDER;
      	if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
    --		return  DIFF_DETECT_COPY;
    -+		return DIFF_DETECT_COPY;
    -+
    + 		return  DIFF_DETECT_COPY;
      	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
    - }
    -
     @@ diff.c: void diff_setup_done(struct diff_options *options)
      	else
      		options->flags.diff_from_contents = 0;

     -	if (options->flags.find_copies_harder)
     +	/* Just fold this in as it makes the patch-to-git smaller */
    -+	if (options->flags.find_copies_harder || options->detect_rename == DIFF_DETECT_COPY_HARDER) {
    ++	if (options->flags.find_copies_harder ||
    ++	    options->detect_rename == DIFF_DETECT_COPY_HARDER) {
     +		options->flags.find_copies_harder = 1;
      		options->detect_rename = DIFF_DETECT_COPY;
     +	}
    @@ diff.c: static int diff_opt_find_copies(const struct option *opt,
      		return error(_("invalid argument to %s"), opt->long_name);

     -	if (options->detect_rename == DIFF_DETECT_COPY)
    -+	if (options->detect_rename == DIFF_DETECT_COPY || options->detect_rename == DIFF_DETECT_COPY_HARDER)
    ++	if (options->detect_rename == DIFF_DETECT_COPY ||
    ++	    options->detect_rename == DIFF_DETECT_COPY_HARDER)
      		options->flags.find_copies_harder = 1;
      	else
      		options->detect_rename = DIFF_DETECT_COPY;
    @@ diffcore-rename.c: static int find_identical_files(struct hashmap *srcs,
      		/* Give higher scores to sources that haven't been used already */
      		score = !source->rename_used;
     -		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
    -+		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY && options->detect_rename != DIFF_DETECT_COPY_HARDER)
    ++		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY &&
    ++		    options->detect_rename != DIFF_DETECT_COPY_HARDER)
      			continue;
      		score += basename_same(source, target);
      		if (score > best_score) {
    @@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
      	info.setup = 0;
      	assert(!dir_rename_count || strmap_empty(dir_rename_count));
     -	want_copies = (detect_rename == DIFF_DETECT_COPY);
    -+	want_copies = (detect_rename == DIFF_DETECT_COPY || detect_rename == DIFF_DETECT_COPY_HARDER);
    ++	want_copies = (detect_rename == DIFF_DETECT_COPY ||
    ++		       detect_rename == DIFF_DETECT_COPY_HARDER);
      	if (dirs_removed && (break_idx || want_copies))
      		BUG("dirs_removed incompatible with break/copy detection");
      	if (break_idx && relevant_sources)
-:  ---------- > 2:  eda1e07ac2 diff: whitespace cleanup
```

Sam James (2):
  diff: implement config.diff.renames=copies-harder
  diff: whitespace cleanup

 Documentation/config/diff.txt   |  8 +++++---
 Documentation/config/status.txt |  4 +++-
 diff.c                          | 14 +++++++++++---
 diff.h                          |  1 +
 diffcore-rename.c               |  6 ++++--
 merge-ort.c                     |  2 +-
 merge-recursive.c               |  2 +-
 7 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.44.0

