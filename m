Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66AAA202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 06:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbdIHGip (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 02:38:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:60484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754547AbdIHGio (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 02:38:44 -0400
Received: (qmail 19805 invoked by uid 109); 8 Sep 2017 06:38:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 06:38:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6147 invoked by uid 111); 8 Sep 2017 06:39:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 02:39:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 02:38:41 -0400
Date:   Fri, 8 Sep 2017 02:38:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 10/10] add UNLEAK annotation for reducing leak false
 positives
Message-ID: <20170908063841.wb23ibs2ancdct2v@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 09:01:50AM -0400, Jeff King wrote:

> Most of this is actual leak fixes. The interesting part, I think, is the
> UNLEAK annotation in patch 10.
> 
>   [01/10]: test-lib: --valgrind should not override --verbose-log
>   [02/10]: test-lib: set LSAN_OPTIONS to abort by default
>   [03/10]: add: free leaked pathspec after add_files_to_cache()
>   [04/10]: update-index: fix cache entry leak in add_one_file()
>   [05/10]: config: plug user_config leak
>   [06/10]: reset: make tree counting less confusing
>   [07/10]: reset: free allocated tree buffers
>   [08/10]: repository: free fields before overwriting them
>   [09/10]: set_git_dir: handle feeding gitdir to itself
>   [10/10]: add UNLEAK annotation for reducing leak false positives

Here's a re-roll of just patch 10, which is the only one that got any
critical feedback. This version:

  1. Only compiles the definition of unleak_memory() when it will be
     used. Thanks, Ramsay.

  2. Tweaks the "why UNLEAK() is better than free()" to put the
     compelling arguments first. Thanks Stefan and Martin.

  3. I added an in-code comment to explain how UNLEAK() should be used.
     I resisted this at first because the commit message goes into more
     detail on how it works and the implications. But it's probably good
     to have at least some guidance for people who stumble on it in the
     code.

  4. Tweaks the examples to avoid the "argc vs void" question. :) I
     also made them "cmd_foo()" which is a more realistic example of
     when you'd want to use this, since our commands typically do not
     implement their own main() anyway.

-- >8 --
Subject: add UNLEAK annotation for reducing leak false positives

It's a common pattern in git commands to allocate some
memory that should last for the lifetime of the program and
then not bother to free it, relying on the OS to throw it
away.

This keeps the code simple, and it's fast (we don't waste
time traversing structures or calling free at the end of the
program). But it also triggers warnings from memory-leak
checkers like valgrind or LSAN. They know that the memory
was still allocated at program exit, but they don't know
_when_ the leaked memory stopped being useful. If it was
early in the program, then it's probably a real and
important leak. But if it was used right up until program
exit, it's not an interesting leak and we'd like to suppress
it so that we can see the real leaks.

This patch introduces an UNLEAK() macro that lets us do so.
To understand its design, let's first look at some of the
alternatives.

Unfortunately the suppression systems offered by
leak-checking tools don't quite do what we want. A
leak-checker basically knows two things:

  1. Which blocks were allocated via malloc, and the
     callstack during the allocation.

  2. Which blocks were left un-freed at the end of the
     program (and which are unreachable, but more on that
     later).

Their suppressions work by mentioning the function or
callstack of a particular allocation, and marking it as OK
to leak.  So imagine you have code like this:

  int cmd_foo(...)
  {
	/* this allocates some memory */
	char *p = some_function();
	printf("%s", p);
	return 0;
  }

You can say "ignore allocations from some_function(),
they're not leaks". But that's not right. That function may
be called elsewhere, too, and we would potentially want to
know about those leaks.

So you can say "ignore the callstack when main calls
some_function".  That works, but your annotations are
brittle. In this case it's only two functions, but you can
imagine that the actual allocation is much deeper. If any of
the intermediate code changes, you have to update the
suppression.

What we _really_ want to say is that "the value assigned to
p at the end of the function is not a real leak". But
leak-checkers can't understand that; they don't know about
"p" in the first place.

However, we can do something a little bit tricky if we make
some assumptions about how leak-checkers work. They
generally don't just report all un-freed blocks. That would
report even globals which are still accessible when the
leak-check is run.  Instead they take some set of memory
(like BSS) as a root and mark it as "reachable". Then they
scan the reachable blocks for anything that looks like a
pointer to a malloc'd block, and consider that block
reachable. And then they scan those blocks, and so on,
transitively marking anything reachable from a global as
"not leaked" (or at least leaked in a different category).

So we can mark the value of "p" as reachable by putting it
into a variable with program lifetime. One way to do that is
to just mark "p" as static. But that actually affects the
run-time behavior if the function is called twice (you
aren't likely to call main() twice, but some of our cmd_*()
functions are called from other commands).

Instead, we can trick the leak-checker by putting the value
into _any_ reachable bytes. This patch keeps a global
linked-list of bytes copied from "unleaked" variables. That
list is reachable even at program exit, which confers
recursive reachability on whatever values we unleak.

In other words, you can do:

  int cmd_foo(...)
  {
	char *p = some_function();
	printf("%s", p);
	UNLEAK(p);
	return 0;
  }

to annotate "p" and suppress the leak report.

But wait, couldn't we just say "free(p)"? In this toy
example, yes. But UNLEAK()'s byte-copying strategy has
several advantages over actually freeing the memory:

  1. It's recursive across structures. In many cases our "p"
     is not just a pointer, but a complex struct whose
     fields may have been allocated by a sub-function. And
     in some cases (e.g., dir_struct) we don't even have a
     function which knows how to free all of the struct
     members.

     By marking the struct itself as reachable, that confers
     reachability on any pointers it contains (including those
     found in embedded structs, or reachable by walking
     heap blocks recursively.

  2. It works on cases where we're not sure if the value is
     allocated or not. For example:

       char *p = argc > 1 ? argv[1] : some_function();

     It's safe to use UNLEAK(p) here, because it's not
     freeing any memory. In the case that we're pointing to
     argv here, the reachability checker will just ignore
     our bytes.

  3. Likewise, it works even if the variable has _already_
     been freed. We're just copying the pointer bytes. If
     the block has been freed, the leak-checker will skip
     over those bytes as uninteresting.

  4. Because it's not actually freeing memory, you can
     UNLEAK() before we are finished accessing the variable.
     This is helpful in cases like this:

       char *p = some_function();
       return another_function(p);

     Writing this with free() requires:

       int ret;
       char *p = some_function();
       ret = another_function(p);
       free(p);
       return ret;

     But with unleak we can just write:

       char *p = some_function();
       UNLEAK(p);
       return another_function(p);

This patch adds the UNLEAK() macro and enables it
automatically when Git is compiled with SANITIZE=leak.  In
normal builds it's a noop, so we pay no runtime cost.

It also adds some UNLEAK() annotations to show off how the
feature works. On top of other recent leak fixes, these are
enough to get t0000 and t0001 to pass when compiled with
LSAN.

Note the case in commit.c which actually converts a
strbuf_release() into an UNLEAK. This code was already
non-leaky, but the free didn't do anything useful, since
we're exiting. Converting it to an annotation means that
non-leak-checking builds pay no runtime cost. The cost is
minimal enough that it's probably not worth going on a
crusade to convert these kinds of frees to UNLEAKS. I did it
here for consistency with the "sb" leak (though it would
have been equally correct to go the other way, and turn them
both into strbuf_release() calls).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile           |  3 +++
 builtin/add.c      |  2 ++
 builtin/commit.c   |  3 ++-
 builtin/config.c   |  4 ++++
 builtin/init-db.c  |  2 ++
 builtin/ls-files.c |  1 +
 builtin/worktree.c |  2 ++
 git-compat-util.h  | 20 ++++++++++++++++++++
 usage.c            | 15 +++++++++++++++
 9 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f2bb7f2f63..c052f09bba 100644
--- a/Makefile
+++ b/Makefile
@@ -1036,6 +1036,9 @@ BASIC_CFLAGS += -fno-omit-frame-pointer
 ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
 endif
+ifneq ($(filter leak,$(SANITIZERS)),)
+BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
+endif
 endif
 
 ifndef sysconfdir
diff --git a/builtin/add.c b/builtin/add.c
index ef625e3fb8..a648cf4c56 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -515,5 +515,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			die(_("Unable to write new index file"));
 	}
 
+	UNLEAK(pathspec);
+	UNLEAK(dir);
 	return exit_status;
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index b3b04f5dd3..58f9747c2f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1818,6 +1818,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (!quiet)
 		print_summary(prefix, &oid, !current_head);
 
-	strbuf_release(&err);
+	UNLEAK(err);
+	UNLEAK(sb);
 	return 0;
 }
diff --git a/builtin/config.c b/builtin/config.c
index 52a4606243..d13daeeb55 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -631,6 +631,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
+		UNLEAK(value);
 		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
@@ -641,6 +642,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
+		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value, argv[2], 0);
 	}
@@ -648,6 +650,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
+		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value,
 							      CONFIG_REGEX_NONE, 0);
@@ -656,6 +659,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
+		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value, argv[2], 1);
 	}
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 47823f9aa4..c9b7946bad 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -579,6 +579,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			set_git_work_tree(work_tree);
 	}
 
+	UNLEAK(real_git_dir);
+
 	flags |= INIT_DB_EXIST_OK;
 	return init_db(git_dir, real_git_dir, template_dir, flags);
 }
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1339e6d17..8c713c47ac 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -673,5 +673,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		return bad ? 1 : 0;
 	}
 
+	UNLEAK(dir);
 	return 0;
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index c98e2ce5f5..de26849f55 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -381,6 +381,8 @@ static int add(int ac, const char **av, const char *prefix)
 		branch = opts.new_branch;
 	}
 
+	UNLEAK(path);
+	UNLEAK(opts);
 	return add_worktree(path, branch, &opts);
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 6678b488cc..003e444c46 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1169,4 +1169,24 @@ static inline int is_missing_file_error(int errno_)
 
 extern int cmd_main(int, const char **);
 
+/*
+ * You can mark a stack variable with UNLEAK(var) to avoid it being
+ * reported as a leak by tools like LSAN or valgrind. The argument
+ * should generally be the variable itself (not its address and not what
+ * it points to). It's safe to use this on pointers which may already
+ * have been freed, or on pointers which may still be in use.
+ *
+ * Use this _only_ for a variable that leaks by going out of scope at
+ * program exit (so only from cmd_* functions or their direct helpers).
+ * Normal functions, especially those which may be called multiple
+ * times, should actually free their memory. This is only meant as
+ * an annotation, and does nothing in non-leak-checking builds.
+ */
+#ifdef SUPPRESS_ANNOTATED_LEAKS
+extern void unleak_memory(const void *ptr, size_t len);
+#define UNLEAK(var) unleak_memory(&(var), sizeof(var));
+#else
+#define UNLEAK(var)
+#endif
+
 #endif
diff --git a/usage.c b/usage.c
index 1ea7df9a20..cdd534c9df 100644
--- a/usage.c
+++ b/usage.c
@@ -241,3 +241,18 @@ NORETURN void BUG(const char *fmt, ...)
 	va_end(ap);
 }
 #endif
+
+#ifdef SUPPRESS_ANNOTATED_LEAKS
+void unleak_memory(const void *ptr, size_t len)
+{
+	static struct suppressed_leak_root {
+		struct suppressed_leak_root *next;
+		char data[FLEX_ARRAY];
+	} *suppressed_leaks;
+	struct suppressed_leak_root *root;
+
+	FLEX_ALLOC_MEM(root, data, ptr, len);
+	root->next = suppressed_leaks;
+	suppressed_leaks = root;
+}
+#endif
-- 
2.14.1.769.g4f4ea7dfd3

