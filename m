Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A61C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5109D2224E
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508507AbgJ0H64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:58:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:38330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389344AbgJ0H6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:58:55 -0400
Received: (qmail 14517 invoked by uid 109); 27 Oct 2020 07:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 07:58:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15308 invoked by uid 111); 27 Oct 2020 07:58:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 03:58:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 03:58:53 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] verify_path(): disallow symlinks in
 .gitattributes and .gitignore
Message-ID: <20201027075853.GH3005508@coredump.intra.peff.net>
References: <20201005121609.GA2907272@coredump.intra.peff.net>
 <20201005121645.GG2907394@coredump.intra.peff.net>
 <20201027033518.GH2645313@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027033518.GH2645313@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 08:35:18PM -0700, Jonathan Nieder wrote:

> As another example, a user working with the
> https://github.com/bakerstu/openmrn.git repository noticed "git
> checkout" commands failing.  In this user's case, the checkout failed
> part-way through, producing confusing behavior ("git status" showing
> entries missing from the index).  When I tried to reproduce this, I
> wasn't able to clone the repository at all because it failed fsck;
> after disabling transfer.fsckObjects, I still wasn't able to check out
> HEAD.

I wouldn't be surprised if there are code paths which die() early
instead of checking out as much as they can. But I think fixing that is
somewhat orthogonal (here we're just adding new reasons that checking
out may fail).

> Observations:
> 
> - since some widely used repositories have .gitignore symlinks, I
>   think we can't forbid it in fsck, alas

I am a little puzzled here. You said you had the fsck checks for the
last year, so why did they just come up now? I guess nobody sets
transfer.fsckObjects, and because you were testing only with clients,
your server implementation didn't reject pushes?

I agree it's annoying for them if they fail fsck, but it's not entirely
a show-stopper. There are config options for fine-tuning what you're
willing to enforce or ignore. But they of course are also annoying to
use, because every receiver of a transfer needs to set them (on GitHub,
for example, you have to email Support).

So I won't be too devastated to remove the symlink checks, or possibly
downgrade them to purely warnings (or "info"; the naming in fsck.c is
confusing, because the transfer operations take even warnings as fatal.
I suspect we could do with some cleanup there).

> - it would be useful to be able to check whether these symlinks would
>   not escape the worktree, for a more targeted check.  It might be
>   nice to even respect these settings when they would not escape the
>   worktree, but not necessarily

I actually wrote a patch several years ago for checking symlinks (not
just these ones, but _any_ symlinks in the repo, but of course it would
be easy to limit it more). It's included at the end of this mail. It's
been part of my daily build for many years, so I'm confident it doesn't
crash or have other bad behavior. But it's possible the logic for what
it catches is faulty.

> - we could use a clearer error message than "invalid path".  

That part is tricky. The "invalid path" error comes from the caller of
verify_path(), and we have no way to pass back an intelligent error
there. We can call error() ourselves, of course. That adds an extra line
of output, but it's rare enough for verify_path() to fail that it's
likely OK. However, I would worry that some callers might be surprised
by it producing output at all.

An alternative is letting the caller pass in a strbuf that we fill out
with an extra error string.

> There's some room for improvement in "git checkout"'s error handling,
> too --- I think my ideal would be if the operation would fail
> entirely, with an advice message describing a checkout command that
> would succeed (But how do I checkout another commit while excluding
> some files? Should it suggest a sparse checkout?).

I suspect it's too late for "fail entirely". We may have already written
to the filesystem, and rolling back is difficult and error-prone. In
general I'd expect to checkout what we can, produce errors for the rest,
and let the user work from there with "git status".

But I may be wrong. The problem is loading the value into the index, not
writing it to the filesystem. So perhaps the relevant code paths load
the index fully before writing out anything to the filesystem, and it's
easy to rollback. But I imagine they are using unpack-trees' flag to
update the filesystem, and I assume that checks out as it loads entries
(but I didn't confirm).

-Peff

Here's the patch. The tests need the checkout-index fix from:

  https://lore.kernel.org/git/20201027073000.GA3651896@coredump.intra.peff.net/

but it should otherwise be stand-alone. I don't recall why I never sent
it. One obvious downside is that it's difficult to have fsck checks for
it, since the full path of an entry is not a property of a single tree
object.

-- >8 --
Date: Wed, 9 Nov 2016 23:24:09 -0500
Subject: [PATCH] optionally block out-of-repo symlinks

---
 apply.c                              |   2 +-
 cache.h                              |   3 +
 config.c                             |   5 ++
 entry.c                              |   2 +-
 environment.c                        |   1 +
 merge-recursive.c                    |   2 +-
 path.c                               |  73 ++++++++++++++++++
 t/t2031-checkout-symlink-external.sh | 107 +++++++++++++++++++++++++++
 8 files changed, 192 insertions(+), 3 deletions(-)
 create mode 100755 t/t2031-checkout-symlink-external.sh

diff --git a/apply.c b/apply.c
index 76dba93c97..2ac940dc05 100644
--- a/apply.c
+++ b/apply.c
@@ -4360,7 +4360,7 @@ static int try_create_file(struct apply_state *state, const char *path,
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
 		 */
-		return !!symlink(buf, path);
+		return !!safe_symlink(buf, path);
 
 	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
 	if (fd < 0)
diff --git a/cache.h b/cache.h
index c0072d43b1..9b56e2327a 100644
--- a/cache.h
+++ b/cache.h
@@ -959,6 +959,7 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 extern const char *core_fsmonitor;
+extern int allow_external_symlinks;
 
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
@@ -1979,4 +1980,6 @@ int print_sha1_ellipsis(void);
 /* Return 1 if the file is empty or does not exists, 0 otherwise. */
 int is_empty_or_missing_file(const char *filename);
 
+int safe_symlink(const char *target, const char *linkpath);
+
 #endif /* CACHE_H */
diff --git a/config.c b/config.c
index 2bdff4457b..6699881c6e 100644
--- a/config.c
+++ b/config.c
@@ -1404,6 +1404,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.allowexternalsymlinks")) {
+		allow_external_symlinks = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return platform_core_config(var, value, cb);
 }
diff --git a/entry.c b/entry.c
index a0532f1f00..f2d3456df3 100644
--- a/entry.c
+++ b/entry.c
@@ -291,7 +291,7 @@ static int write_entry(struct cache_entry *ce,
 		if (!has_symlinks || to_tempfile)
 			goto write_file_entry;
 
-		ret = symlink(new_blob, path);
+		ret = safe_symlink(new_blob, path);
 		free(new_blob);
 		if (ret)
 			return error_errno("unable to create symlink %s", path);
diff --git a/environment.c b/environment.c
index bb518c61cd..7c233e0e0e 100644
--- a/environment.c
+++ b/environment.c
@@ -73,6 +73,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
+int allow_external_symlinks = 1;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/merge-recursive.c b/merge-recursive.c
index d0214335a7..61208a8b43 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -986,7 +986,7 @@ static int update_file_flags(struct merge_options *opt,
 			char *lnk = xmemdupz(buf, size);
 			safe_create_leading_directories_const(path);
 			unlink(path);
-			if (symlink(lnk, path))
+			if (safe_symlink(lnk, path))
 				ret = err(opt, _("failed to symlink '%s': %s"),
 					  path, strerror(errno));
 			free(lnk);
diff --git a/path.c b/path.c
index 7b385e5eb2..251dd70ff5 100644
--- a/path.c
+++ b/path.c
@@ -1498,6 +1498,79 @@ int looks_like_command_line_option(const char *str)
 	return str && str[0] == '-';
 }
 
+static int symlink_leaves_repo(const char *target, const char *linkpath)
+{
+	/*
+	 * Absolute paths are always considered to leave the repository (even
+	 * if they happen to point to the working tree path).
+	 */
+	if (is_absolute_path(target))
+		return 1;
+
+	/*
+	 * Allow relative paths that start with a sequence of "../",
+	 * as long as they do not break out of the symlink's root.
+	 * This loop will detect break-out cases and return; otherwise, at the
+	 * end of the loop "target" will point to the first non-".." component.
+	 *
+	 * We count the depth of linkpath by eating up directory components left
+	 * to right. Technically the symlink would resolve right-to-left, but
+	 * we don't care about the actual values, only the number.
+	 */
+	while (target[0] == '.') {
+		if (!target[1]) {
+			/* trailing "." -- ignore */
+			target++;
+		} else if (is_dir_sep(target[1])) {
+			/* "./" -- ignore */
+			target += 2;
+		} else if (target[1] == '.' &&
+			   (!target[2] || is_dir_sep(target[2]))) {
+			/* ".." or "../" -- drop one from linkpath depth */
+			while (!is_dir_sep(*linkpath)) {
+				/* end-of-string; target exceeded our depth */
+				if (!*linkpath)
+					return 1;
+				linkpath++;
+			}
+			/* skip final "/" */
+			linkpath++;
+
+			/* skip past ".." */
+			target += 2;
+			/* and "/" if present */
+			if (is_dir_sep(*target))
+				target++;
+		}
+	}
+
+	/*
+	 * Now we have a path in "target" that only go down into the tree.
+	 * Disallow any interior "../", like "foo/../bar". These might be
+	 * OK, but we cannot know unless we know whether "foo" is itself a
+	 * symlink. So err on the side of caution.
+	 */
+	while (*target) {
+		const char *v;
+		if (skip_prefix(target, "..", &v) && (!*v || is_dir_sep(*v)))
+			return 1;
+		target++;
+	}
+
+	return 0;
+}
+
+int safe_symlink(const char *target, const char *linkpath)
+{
+	if (!allow_external_symlinks &&
+	    symlink_leaves_repo(target, linkpath)) {
+		errno = EPERM;
+		return -1;
+	}
+
+	return symlink(target, linkpath);
+}
+
 char *xdg_config_home(const char *filename)
 {
 	const char *home, *config_home;
diff --git a/t/t2031-checkout-symlink-external.sh b/t/t2031-checkout-symlink-external.sh
new file mode 100755
index 0000000000..c799f8158e
--- /dev/null
+++ b/t/t2031-checkout-symlink-external.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+test_description='detection and prevention of out-of-tree symlinks'
+. ./test-lib.sh
+
+if ! test_have_prereq SYMLINKS
+then
+	skip_all='skipping external symlink tests (missing SYMLINKS)'
+	test_done
+fi
+
+create_symlink() {
+	symlink=$1
+	target=$2
+	test_expect_success "create symlink ($symlink)" '
+		sha1=$(printf "%s" "$target" | git hash-object -w --stdin) &&
+		git update-index --add --cacheinfo "120000,$sha1,$symlink"
+	'
+}
+
+check_symlink () {
+	symlink=$1
+	config=$2
+	outcome=$3
+	expect=$4
+
+	if test "$outcome" = "allow"
+	then
+		fail=
+		: ${expect:=test_cmp ../target}
+	else
+		fail=test_must_fail
+		: ${expect:=! cat}
+	fi
+
+	test_expect_success " check symlink ($symlink, $config -> $outcome)" "
+		rm -f $symlink &&
+		$fail git -c core.allowExternalSymlinks=$config \\
+			checkout-index -- $symlink &&
+		$expect $symlink
+	"
+}
+
+# we want to try breaking out of the repository,
+# so let's work inside a sub-repository, and break
+# out to the top-level trash directory
+test_expect_success 'set up repository' '
+	echo content >target &&
+	git init subrepo &&
+	cd subrepo &&
+	test_commit base &&
+	echo content >in-repo-target
+'
+
+create_symlink in-repo in-repo-target
+check_symlink in-repo false allow
+
+create_symlink subdir/in-repo ../in-repo-target
+check_symlink subdir/in-repo false allow
+
+create_symlink absolute "$TRASH_DIRECTORY/target"
+check_symlink absolute true allow
+check_symlink absolute false forbid
+
+create_symlink relative "../target"
+check_symlink relative true allow
+check_symlink relative false forbid
+
+create_symlink curdir .
+check_symlink curdir false allow test_path_is_dir
+create_symlink sneaky curdir/../target
+check_symlink sneaky true allow
+check_symlink sneaky false forbid
+
+test_expect_success 'applying a patch checks symlink config' '
+	git diff-index -p --cached HEAD -- relative >patch &&
+	rm -f relative &&
+	git -c core.allowExternalSymlinks=true apply <patch &&
+	test_cmp ../target relative &&
+	rm -f relative &&
+	test_must_fail git -c core.allowExternalSymlinks=false apply <patch
+'
+
+test_expect_success 'merge-recursive checks symlinks config' '
+	git reset --hard &&
+
+	# create rename situation which requires processing
+	# outside of unpack_trees()
+	ln -s ../foo one &&
+	git add one &&
+	git commit -m base &&
+
+	ln -sf ../target one &&
+	git commit -am modify &&
+
+	git checkout -b side HEAD^ &&
+	git mv one two &&
+	git commit -am rename &&
+
+	git -c core.allowExternalSymlinks=true merge master &&
+	test_cmp ../target two &&
+
+	git reset --hard HEAD^ &&
+	test_must_fail git -c core.allowExternalSymlinks=false merge master
+'
+
+test_done
-- 
2.29.1.634.g9e41dc1bf2

