Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9893C678DB
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 10:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCDKbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 05:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCDKbY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 05:31:24 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0871ACD3
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 02:31:23 -0800 (PST)
Received: (qmail 16851 invoked by uid 109); 4 Mar 2023 10:31:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 10:31:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3758 invoked by uid 111); 4 Mar 2023 10:31:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Mar 2023 05:31:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Mar 2023 05:31:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: [PATCH 4/5] parse-options: consistently allocate memory in
 fix_filename()
Message-ID: <ZAMd+qJ60McWx1Hp@coredump.intra.peff.net>
References: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When handling OPT_FILENAME(), we have to stick the "prefix" (if any) in
front of the filename to make up for the fact that Git has chdir()'d to
the top of the repository. We can do this with prefix_filename(), but
there are a few special cases we handle ourselves.

Unfortunately the memory allocation is inconsistent here; if we do make
it to prefix_filename(), we'll allocate a string which the caller must
free to avoid a leak. But if we hit our special cases, we'll return the
string as-is, and a caller which tries to free it will crash. So there's
no way to win.

Let's consistently allocate, so that callers can do the right thing.

There are now three cases to care about in the function (and hence a
three-armed if/else):

  1. we got a NULL input (and should leave it as NULL, though arguably
     this is the sign of a bug; let's keep the status quo for now and we
     can pick at that scab later)

  2. we hit a special case that means we leave the name intact; we
     should duplicate the string. This includes our special "-"
     matching. Prior to this patch, it also included empty prefixes and
     absolute filenames. But we can observe that prefix_filename()
     already handles these, so we don't need to detect them.

  3. everything else goes to prefix_filename()

I've dropped the "const" from the "char **file" parameter to indicate
that we're allocating, though in practice it's not really important.
This is all being shuffled through a void pointer via opt->value before
it hits code which ever looks at the string. And it's even a bit weird,
because we are really taking _in_ a const string and using the same
out-parameter for a non-const string. A better function signature would
be:

  static char *fix_filename(const char *prefix, const char *file);

but that would mean the caller dereferences the double-pointer (and the
NULL check is currently handled inside this function). So I took the
path of least-change here.

Note that we have to fix several callers in this commit, too, or we'll
break the leak-checking tests. These are "new" leaks in the sense that
they are now triggered by the test suite, but these spots have always
been leaky when Git is run in a subdirectory of the repository. I fixed
all of the cases that trigger with GIT_TEST_PASSING_SANITIZE_LEAK. There
may be others in scripts that have other leaks, but we can fix them
later along with those other leaks (and again, you _couldn't_ fix them
before this patch, so this is the necessary first step).

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not sure if UNLEAK() has fallen out of favor, but I did use it in
one spot here. It's the exact case it was designed for: we don't care
about free-ing because we're returning from a builtin's main function,
and doing a free() requires an awkward "save the return value, then
free, then return" dance.

But I'm happy to change it if people are too offended by it. :)

 builtin/archive.c                   |  3 ++-
 builtin/checkout.c                  |  3 ++-
 builtin/reset.c                     |  4 +++-
 builtin/tag.c                       |  4 +++-
 parse-options.c                     | 14 ++++++++------
 t/helper/test-parse-pathspec-file.c |  3 ++-
 6 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index f094390ee01..d0a583ea958 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -81,7 +81,7 @@ static int run_remote_archiver(int argc, const char **argv,
 int cmd_archive(int argc, const char **argv, const char *prefix)
 {
 	const char *exec = "git-upload-archive";
-	const char *output = NULL;
+	char *output = NULL;
 	const char *remote = NULL;
 	struct option local_opts[] = {
 		OPT_FILENAME('o', "output", &output,
@@ -106,5 +106,6 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
+	UNLEAK(output);
 	return write_archive(argc, argv, prefix, the_repository, output, 0);
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a5155cf55c1..85f591c85f3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -75,7 +75,7 @@ struct checkout_opts {
 	const char *ignore_unmerged_opt;
 	int ignore_unmerged;
 	int pathspec_file_nul;
-	const char *pathspec_from_file;
+	char *pathspec_from_file;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -1876,6 +1876,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    options, checkout_usage, &new_branch_info);
 	branch_info_release(&new_branch_info);
 	clear_pathspec(&opts.pathspec);
+	free(opts.pathspec_from_file);
 	FREE_AND_NULL(options);
 	return ret;
 }
diff --git a/builtin/reset.c b/builtin/reset.c
index 0697fa89de2..45a3143567c 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -317,7 +317,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int no_refresh = 0;
 	int patch_mode = 0, pathspec_file_nul = 0, unborn;
-	const char *rev, *pathspec_from_file = NULL;
+	const char *rev;
+	char *pathspec_from_file = NULL;
 	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
@@ -495,5 +496,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 cleanup:
 	clear_pathspec(&pathspec);
+	free(pathspec_from_file);
 	return update_ref_status;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index d428c45dc8d..ccefcbd716f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -433,7 +433,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	int create_reflog = 0;
 	int annotate = 0, force = 0;
 	int cmdmode = 0, create_tag_object = 0;
-	const char *msgfile = NULL, *keyid = NULL;
+	char *msgfile = NULL;
+	const char *keyid = NULL;
 	struct msg_arg msg = { .buf = STRBUF_INIT };
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -643,5 +644,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&msg.buf);
 	strbuf_release(&err);
+	free(msgfile);
 	return ret;
 }
diff --git a/parse-options.c b/parse-options.c
index fd4743293fc..25bae8b585b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -59,12 +59,14 @@ static enum parse_opt_result get_arg(struct parse_opt_ctx_t *p,
 	return 0;
 }
 
-static void fix_filename(const char *prefix, const char **file)
+static void fix_filename(const char *prefix, char **file)
 {
-	if (!file || !*file || !prefix || is_absolute_path(*file)
-	    || !strcmp("-", *file))
-		return;
-	*file = prefix_filename(prefix, *file);
+	if (!file || !*file)
+		; /* leave as NULL */
+	else if (!strcmp("-", *file))
+		*file = xstrdup(*file);
+	else
+		*file = prefix_filename(prefix, *file);
 }
 
 static enum parse_opt_result opt_command_mode_error(
@@ -177,7 +179,7 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 			err = get_arg(p, opt, flags, (const char **)opt->value);
 
 		if (!err)
-			fix_filename(p->prefix, (const char **)opt->value);
+			fix_filename(p->prefix, (char **)opt->value);
 		return err;
 
 	case OPTION_CALLBACK:
diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
index b3e08cef4b3..71d2131fbad 100644
--- a/t/helper/test-parse-pathspec-file.c
+++ b/t/helper/test-parse-pathspec-file.c
@@ -6,7 +6,7 @@
 int cmd__parse_pathspec_file(int argc, const char **argv)
 {
 	struct pathspec pathspec;
-	const char *pathspec_from_file = NULL;
+	char *pathspec_from_file = NULL;
 	int pathspec_file_nul = 0, i;
 
 	static const char *const usage[] = {
@@ -29,5 +29,6 @@ int cmd__parse_pathspec_file(int argc, const char **argv)
 		printf("%s\n", pathspec.items[i].original);
 
 	clear_pathspec(&pathspec);
+	free(pathspec_from_file);
 	return 0;
 }
-- 
2.40.0.rc1.500.g967c04631e

