Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92171F4DD
	for <e@80x24.org>; Wed, 30 Aug 2017 05:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbdH3FbM (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 01:31:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:52584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750835AbdH3FbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 01:31:10 -0400
Received: (qmail 1111 invoked by uid 109); 30 Aug 2017 05:31:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 05:31:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16005 invoked by uid 111); 30 Aug 2017 05:31:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 01:31:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Aug 2017 01:31:08 -0400
Date:   Wed, 30 Aug 2017 01:31:08 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
Message-ID: <20170830053108.g2xsn43rwulnwn3p@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <CAN0heSomjqiSStq3eqGgCe21b0Pr0gbAQLL-2EEB6Zfnjj+Mjg@mail.gmail.com>
 <20170829214809.xxpsp76eqhd4hupo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170829214809.xxpsp76eqhd4hupo@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 05:48:09PM -0400, Jeff King wrote:

> On Tue, Aug 29, 2017 at 09:22:08PM +0200, Martin Ågren wrote:
> 
> > One take-away for me from this thread is that memory-leak-plugging seems
> > to be appreciated, i.e., it's not just an academic problem. I think I'll
> > look into it some more, i.e., slowly pursue option 2. :-) That might help
> > give some insights on how to identify interesting leaks.
> 
> Yes, I think if it's tractable that's the best path forward. It's not
> clear to me how many of the things valgrind reports are false positives
> (and in what way). Certainly the lock_file patch I just posted seems
> like something worth addressing, even if we _tend_ to only leak a small
> number of such structs per program invocation. It's not a problem now,
> but it's a sign of a bad pattern.

I wanted to see what it would take to get t0000 to pass with "definite"
leak-checking on, as in:

diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
index 669ebaf68b..5f01c06280 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -10,7 +10,7 @@ test-*)
 	;;
 esac
 
-TOOL_OPTIONS='--leak-check=no'
+TOOL_OPTIONS='--leak-check=full --errors-for-leak-kinds=definite'
 
 test -z "$GIT_VALGRIND_ENABLED" &&
 exec "$program" "$@"

The results gave an interesting overview of the problems I'd expect to
face for the rest of the tests. I started with the config lock_file fix
I sent earlier, but we needed a few more.

This one in cmd_update_index() can become static in the same way:

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d955cd56b3..3bff7de720 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -908,6 +908,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
 
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
+	static struct lock_file lock_file;
 	int newfd, entries, has_errors = 0, nul_term_line = 0;
 	enum uc_mode untracked_cache = UC_UNSPECIFIED;
 	int read_from_stdin = 0;
@@ -917,7 +918,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
-	struct lock_file *lock_file;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
@@ -1016,11 +1016,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-
 	/* we will diagnose later if it turns out that we need to update it */
-	newfd = hold_locked_index(lock_file, 0);
+	newfd = hold_locked_index(&lock_file, 0);
 	if (newfd < 0)
 		lock_error = errno;
 
@@ -1155,11 +1152,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				exit(128);
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
-		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
 	}
 
-	rollback_lock_file(lock_file);
+	rollback_lock_file(&lock_file);
 
 	return has_errors ? 1 : 0;
 }

But there's another one in write_index_as_tree(), which is less
obviously a candidate for turning into a single static variable. We
might plausibly have multiple indices. I hacked around it with:

diff --git a/cache-tree.c b/cache-tree.c
index 2440d1dc89..f2a5aa138f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -603,7 +603,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
 	int entries, was_valid, newfd;
-	struct lock_file *lock_file;
+	static struct lock_file *lock_file;
 
 	/*
 	 * We can't free this memory, it becomes part of a linked list

which means that if we call this function once per program we'll keep a
single static pointer, and valgrind will consider it "reachable". But if
we call multiple, they really will leak as before. So it's definitely a
hack, though it was enough for t0000. I think I'd favor loosening the
"you can never free locks" requirement instead, which makes this problem
just go away (we could even declare it as a stack variable then).

Next up is the fact that setup_git_env() happily overwrites its own
pointers without freeing them if it's called twice. I expect this will
be a reasonably common problem for things like config or option parsing
where we might see multiple values. In the simple cases, we just need to
make sure we do:

  free(foo);
  foo = xstrdup(...);

instead of just calling the latter.

But we can't always do that, because we sometimes point to string
literals like:

  static const char *foo = "default_value";
  ...
  foo = xstrfmt("computed_value: %s", value_from_user);

If we assign to "foo" again, we need to free only when the previous
value was from xstrfmt, not when it points to the string literal. But we
can't duplicate the string literal, because that default assignment is
outside any function.

We could solve that by using a struct instead, with a few helpers. Or
possibly we could just use strbufs, if we taught it to handle "unowned"
strings (i.e., where "alloc" is zero but "len" isn't necessarily, and we
don't just point to the slopbuf). And then you'd have something like:

  #define STRBUF_INIT_STR(x) { 0, strlen(x), (char *)(x) }
  ...
  static struct strbuf foo = STRBUF_INIT_STR("default_value");
  ...
  strbuf_addf(&foo, "computed_value...");

And then strbuf_grow() would have to learn to copy the existing bytes
when it moves from the "alloc==0" case.

Anyway, that actually ended up _not_ being how I solved this one. I was
puzzled why we were calling setup_git_env() twice in the first place.
And the answer is that setup_work_tree() frequently does a noop
set_git_dir(). And we can just get rid of that:

diff --git a/setup.c b/setup.c
index 23950173fc..9104740e2d 100644
--- a/setup.c
+++ b/setup.c
@@ -399,12 +399,9 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
 
-	/*
-	 * NEEDSWORK: this call can essentially be set_git_dir(get_git_dir())
-	 * which can cause some problems when trying to free the old value of
-	 * gitdir.
-	 */
-	set_git_dir(remove_leading_path(git_dir, work_tree));
+	git_dir = remove_leading_path(git_dir, work_tree);
+	if (strcmp(get_git_dir(), git_dir))
+		set_git_dir(git_dir);
 	initialized = 1;
 }
 

I think this is really papering over underlying problems, though in this
case they are fairly simple "just call free()" cases that don't need the
strbuf magic.

Next up is update-index's add_one_path. This one is a real leak:

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d562f2ec69..d955cd56b3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -287,8 +287,10 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option))
+	if (add_cache_entry(ce, option)) {
+		free(ce);
 		return error("%s: cannot add to the index - missing --add option?", path);
+	}
 	return 0;
 }
 

It's not a big deal in practice since we exit soon, but since it's in a
sub-function I think it's worth addressing (and the earlier error code
path already does the same free, so I think this really is just a bug).

And the final case I hit is in ls-files. Deep inside dir.c we allocate
some structures into the dir_struct. But there's no cleanup function, so
of course we just let it go out of scope at the end of cmd_ls_files()
and let the OS deal with it.

Obviously one solution is to add a cleanup function and call it at the
end of cmd_ls_files(). But here's another trick:

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1339e6d17..5f2396392e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -504,7 +504,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree = 0, show_tag = 0, i;
 	const char *max_prefix;
-	struct dir_struct dir;
+	static struct dir_struct dir;
 	struct exclude_list *el;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option builtin_ls_files_options[] = {

By marking it as static, it remains reachable even after the function
exits, and valgrind doesn't complain about the leak. In a sense, this is
accomplishing exactly what we want to say: there should be one of these
per program run, and its lifetime is the same as that of the whole
program.

But it does make me feel just a little dirty. If for some reason we
called cmd_ls_files() multiple times in a single process, the current
behavior would be to have a small leak for each call. But the behavior
with the hunk above would be that the second run sees whatever cruft was
left in "dir" from the last run.

Overall I suspect that running our cmd_*() functions multiple times in a
single process is already going to cause chaos, because they often are
touching static globals, etc. So it's probably not that big a deal in
practice to add one more variable to the list, and declare that calling
cmd_ls_files() anywhere except as the main function of ls-files is
forbidden.

-Peff
