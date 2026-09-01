Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D6375F80
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244100; cv=none; b=Ca9V5NwH0sAZDZ5qVxLsjpgd2NYDtJ+K6idDRKB390rk+yhfvXW6A0OOwYeXpHdFtTHoVZ2ll/CiABDQkX6/7yXj8dHYqPgE6M9H554zUxiMAN9EKxTcw8FOph5OSrKQtQqbXkOX/N8u3p0lQtHEoDfFuUlWISgmD05PE/HyHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244100; c=relaxed/simple;
	bh=g9p7FGXp71YJBLwZ9PqjtgXBKci+awUlXCSHWkHgY6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRpfMaUNb1fdcheeLqwdYxlew/NKJGdibQoyvx27efUh8xEyUuJA67uTCKXzNS67YhiyT48DbTmqKfxFojrz4VmQLqPpy56Vj2/TYl62wDfw3AkdjJKPfvAGYKsEVE8nYjpXBniwC3JLI5qvDotXvPuG6ezOkAazXsOMk7t6vAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bZmF8loW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bZmF8loW"
Received: (qmail 7064 invoked by uid 106); 1 Sep 2026 06:28:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g9p7FGXp71YJBLwZ9PqjtgXBKci+awUlXCSHWkHgY6w=; b=bZmF8loW9e0W21zL7nRVOvx2sTg7ksFjzrtQabFNqNYKlgqkKzBNgvu6SRzpEVFzJmf5CAhl8sh4wbmWM5UsYlUTA71ZW+3z+kK61pkup8srf1NyelrLrE2hQ6f1KQLYZO69UKTq60jSXeind0WBzLnLcFyZOHzJ3q5A2jxXQqZvaUSXxRMDZToAvlaSrnm9hoSoXwC//G+vTH9gxQetOrizzjfM7IXUNrEt+ZnrwxhWgFYo+nY1VOYxZM43jnhVBrYkzEv6xOTuWASZC/bnBCI7QbXN7MSrsqGzmfJaL9U+lK9dyae5z8EQIyvXGdUuvtm+JgExKz2CgFaH+gRZwg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2026 06:28:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 33803 invoked by uid 111); 1 Sep 2026 06:28:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2026 02:28:16 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Sep 2026 02:28:15 -0400
From: Jeff King <peff@peff.net>
To: Nicolas Le Cam <niko.lecam@gmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH] revision: hang on to "freed" argv elements
Message-ID: <20260901062815.GC1075462@coredump.intra.peff.net>
References: <20260830215555.2660035-1-niko.lecam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260830215555.2660035-1-niko.lecam@gmail.com>

On Sun, Aug 30, 2026 at 11:55:55PM +0200, Nicolas Le Cam wrote:

> The prefixes are replaced by fragments of unrelated heap data, and the
> value changes between runs of the same command:
> 
>     $ git stash show --src-prefix=a/ --dst-prefix=b/ | head -1
>     diff --git Uf.txt Uf.txt
>     $ git stash show --src-prefix=a/ --dst-prefix=b/ | head -1
>     diff --git Vf.txt Vf.txt
> 
> On other versions the garbage is recognisable as pieces of other
> strings live in the process -- "ributes" (from "attributes"),
> "bjectmode" (from "objectmode"), "4c/" -- which is what suggests a
> use-after-free rather than an off-by-one.

Thanks for a clear and thorough bug report! The cause is indeed the
related to the commits you found. The explanation (and fix) are below.

-- >8 --
Subject: revision: hang on to "freed" argv elements

In setup_revisions() we rewrite the incoming argv array, losing
references to the strings it contains. For a synthetic argv array
constructed from heap strings, that traditionally meant we leaked those
allocated strings.

We fixed the leak in cd43948798 (revision: manage memory ownership of
argv in setup_revisions(), 2025-09-19). Now callers can tell the
revision code that argv entries are allocated and should be freed, which
it will do before overwriting them.

But this introduced a new bug! The overwritten entries go away as soon
as option parsing is finished, but a few options may actually create new
references to those strings. And once we free the strings, those stale
references become use-after-free bugs. For example, running:

  git stash show --src-prefix=foo/

demonstrates the problem:

  1. The stash command generates its own synthetic argv (because it has
     to treat the stash specifiers specially) which it then passes to
     setup_revisions().

  2. Parsing will create a reference to the partial string "foo/" in
     revs.diffopt.a_prefix.

  3. When setup_revisions() finishes, we rewrite argv to throw away
     parsed strings. This frees the entry holding "--src-prefix=foo",
     at which point we have a dangling reference in revs.diffopt.

  4. We generate an actual diff, accessing garbage memory via
     revs.diffopt.a_prefix. The output is usually garbled, but ASan also
     detects this reliably.

One obvious fix here is to allocate new strings when we pull data out of
the argv array. But doing so is error prone (every string option must
remember to do it or risk a subtle bug), and creates more questions
about memory ownership (e.g., some callers assign string literals
directly to a_prefix, and we would not want to free those).

Instead we can fix this centrally by delaying the free() calls. We'll
collect any "freed" strings in a new array, hold on to it for the life
of the rev_info struct, and then release it at the end. We can easily
use a strvec for this, since it handles growth and cleanup for us.

This fixes the prefix case above (which is now tested in t3903), and
should fix any other stray cases. Though I could not find any; we use
OPT_STRING only in the prefix diff options, and very few revision opts
store strings. Those that do (like --format and --encoding) already make
a copy of the string. They do not need for us to hold on to the memory
longer, but it does not hurt them if we do.

One may note that combined with cd43948798 we have approached a simpler
solution in a roundabout way. We are still hacking up argv, but now
carefully constructing a parallel argv of old strings we've overwritten
(and will eventually free). In an alternate universe, we could instead
leave the original argv pristine and return a new reduced-size argv.
This is conceptually simpler, though it does mean that every caller must
free that new argv array itself (not the entries). That's not something
they traditionally had to do, so it would mean tweaking every caller.

So even though the combination of this cd43948798 and this patch is a
little convoluted, it should make things just work (no leaks and no
use-after-free) without modifying any callers.

Reported-by: Nicolas Le Cam <niko.lecam@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I prepared this on top of master.

The bug is in v2.52.0. I think it took a while to get noticed because it
only affects a few options, and then only when used with a command that
produces an allocated argv (like "stash show").

I think you probably _could_ produce the problem directly on cd43948798,
but with the test here I think it shows up a little later, when we start
calling setup_revisions_from_strvec(), which frees more aggressively
(plugging the actual leaks). If we are targeting 'maint' and want to
apply the fix close to the source, probably doing it on top of
4bac57bc67 (Merge branch 'jk/setup-revisions-freefix', 2025-09-29) would
be sufficient.

 revision.c       | 36 ++++++++++++++++++++++++++++--------
 revision.h       |  9 +++++++++
 t/t3903-stash.sh | 17 +++++++++++++++++
 3 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 50dc8b1991..7aee96bd8e 100644
--- a/revision.c
+++ b/revision.c
@@ -2307,9 +2307,27 @@ static timestamp_t parse_age(const char *arg)
 	return num;
 }
 
+/*
+ * When asked to free argv strings, we should not do so immediately. Some
+ * option parsing may have stored a reference to the string (either the whole
+ * thing, or a substring inside it). We should keep it valid until the rev_info
+ * struct itself is freed.
+ *
+ * Note that we take a const str for the convenience of callers (who have the
+ * usual const argv array, even when opt->free_removed_argv_elements is set).
+ * We cast away the const on their behalf.
+ */
+static void mark_argv_for_free(struct rev_info *revs, const char *str)
+{
+	if (!str)
+		return;
+	strvec_push_nodup(&revs->argv_to_free, (char *)str);
+}
+
 static void overwrite_argv(int *argc, const char **argv,
 			   const char **value,
-			   const struct setup_revision_opt *opt)
+			   const struct setup_revision_opt *opt,
+			   struct rev_info *revs)
 {
 	/*
 	 * Detect the case when we are overwriting ourselves. The assignment
@@ -2318,7 +2336,7 @@ static void overwrite_argv(int *argc, const char **argv,
 	 */
 	if (*value != argv[*argc]) {
 		if (opt && opt->free_removed_argv_elements)
-			free((char *)argv[*argc]);
+			mark_argv_for_free(revs, argv[*argc]);
 		argv[*argc] = *value;
 		*value = NULL;
 	}
@@ -2346,7 +2364,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    starts_with(arg, "--branches=") || starts_with(arg, "--tags=") ||
 	    starts_with(arg, "--remotes=") || starts_with(arg, "--no-walk="))
 	{
-		overwrite_argv(unkc, unkv, &argv[0], opt);
+		overwrite_argv(unkc, unkv, &argv[0], opt, revs);
 		return 1;
 	}
 
@@ -2738,7 +2756,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
 		if (!opts)
-			overwrite_argv(unkc, unkv, &argv[0], opt);
+			overwrite_argv(unkc, unkv, &argv[0], opt, revs);
 		return opts;
 	}
 
@@ -3038,7 +3056,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			if (strcmp(arg, "--"))
 				continue;
 			if (opt && opt->free_removed_argv_elements)
-				free((char *)argv[i]);
+				mark_argv_for_free(revs, argv[i]);
 			argv[i] = NULL;
 			argc = i;
 			if (argv[i + 1])
@@ -3068,7 +3086,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 			if (!strcmp(arg, "--stdin")) {
 				if (revs->disable_stdin) {
-					overwrite_argv(&left, argv, &argv[i], opt);
+					overwrite_argv(&left, argv, &argv[i],
+						       opt, revs);
 					continue;
 				}
 				if (revs->read_from_stdin++)
@@ -3242,7 +3261,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (argv) {
 		if (opt && opt->free_removed_argv_elements)
-			free((char *)argv[left]);
+			mark_argv_for_free(revs, argv[left]);
 		argv[left] = NULL;
 	}
 
@@ -3264,7 +3283,7 @@ void setup_revisions_from_strvec(struct strvec *argv, struct rev_info *revs,
 	ret = setup_revisions(argv->nr, argv->v, revs, opt);
 
 	for (size_t i = ret; i < argv->nr; i++)
-		free((char *)argv->v[i]);
+		mark_argv_for_free(revs, argv->v[i]);
 	argv->nr = ret;
 }
 
@@ -3326,6 +3345,7 @@ void release_revisions(struct rev_info *revs)
 	oidset_clear(&revs->missing_commits);
 	release_revisions_bloom_keyvecs(revs);
 	release_follow_pathspec_slab(revs);
+	strvec_clear(&revs->argv_to_free);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/revision.h b/revision.h
index acf6d06b24..e5dabd18ce 100644
--- a/revision.h
+++ b/revision.h
@@ -396,6 +396,14 @@ struct rev_info {
 
 	/* Missing commits to be tracked without failing traversal. */
 	struct oidset missing_commits;
+
+	/*
+	 * Strings whose ownership has been handed over to us, but which
+	 * we may be referencing in any of the above options (including
+	 * within the diffopt struct). These will remain valid until
+	 * release_revisions() is called.
+	 */
+	struct strvec argv_to_free;
 };
 
 /**
@@ -433,6 +441,7 @@ struct rev_info {
 	.commit_format = CMIT_FMT_DEFAULT, \
 	.expand_tabs_in_log_default = 8, \
 	.rdiff_log_arg = STRVEC_INIT, \
+	.argv_to_free = STRVEC_INIT, \
 }
 
 /**
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index da27a6599a..260c809f99 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -780,6 +780,23 @@ test_expect_success 'stash show --patience shows diff' '
 	diff_cmp expected actual
 '
 
+test_expect_success 'stash show supports prefixes' '
+	git reset --hard &&
+	echo foo >>file &&
+	git stash &&
+	cat >expected <<-\EOF &&
+	diff --git foo/file bar/file
+	index 7601807..71b52c4 100644
+	--- foo/file
+	+++ bar/file
+	@@ -1 +1,2 @@
+	 baz
+	+foo
+	EOF
+	git stash show --src-prefix=foo/ --dst-prefix=bar/ >actual &&
+	diff_cmp expected actual
+'
+
 test_expect_success 'drop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
-- 
2.55.0.1050.g5a46c03bac

