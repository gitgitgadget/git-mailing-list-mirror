Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5ADC7EE2D
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 22:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBZWku (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 17:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBZWkt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 17:40:49 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30C1F96B
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 14:40:47 -0800 (PST)
Received: (qmail 1961 invoked by uid 109); 26 Feb 2023 22:40:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Feb 2023 22:40:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9678 invoked by uid 111); 26 Feb 2023 22:40:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Feb 2023 17:40:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 26 Feb 2023 17:40:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] gpg-interface: lazily initialize and read the
 configuration
Message-ID: <Y/vf7n2+LN/3Nddi@coredump.intra.peff.net>
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
 <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
 <xmqqmt5orqgv.fsf@gitster.g>
 <xmqqh6vwrpce.fsf@gitster.g>
 <xmqqlel7rj9z.fsf_-_@gitster.g>
 <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net>
 <xmqqwn4qokug.fsf@gitster.g>
 <xmqqpmaimvtd.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmaimvtd.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2023 at 12:24:14PM -0800, Junio C Hamano wrote:

> Instead of forcing the porcelain commands to always read the
> configuration variables related to the signing and verifying
> signatures, lazily initialize the necessary subsystem on demand upon
> the first use.
> 
> This hopefully would make it more future-proof as we do not have to
> think and decide whether we should call git_gpg_config() in the
> git_config() callback for each command.

Sorry, I seem to have missed this when you originally posted it. And I
saw it marked as "will merge to next?" in the latest what's cooking. It
looks good to me, and I think we can proceed with it (though of course
it is not urgent and can probably wait until post-2.40).

> A few git_config() callback functions that used to be custom
> callbacks are now just a thin wrapper around git_default_config().
> We could further remove, git_FOO_config and replace calls to
> git_config(git_FOO_config) with git_config(git_default_config), but
> to make it clear which ones are affected and the effect is only the
> removal of git_gpg_config(), it is vastly preferred not to do such a
> change in this step (they can be done on top once the dust settled).

Yes, I think it is good not to do so in this patch. If we want to do it
now on top, here's a patch. Though I could also see the argument for
just leaving them.

-- >8 --
Subject: [PATCH] drop pure pass-through config callbacks

Commit fd2d4c135e (gpg-interface: lazily initialize and read the
configuration, 2023-02-09) shrunk a few custom config callbacks so that
they are just one-liners of:

  return git_default_config(...);

We can drop them entirely and replace them direct calls of
git_default_config() intead. This makes the code a little shorter and
easier to understand (with the downside being that if they do grow
custom options again later, we'll have to recreate the functions).

Signed-off-by: Jeff King <peff@peff.net>
---
I looked over the output of:

  git grep --function-context 'return git_default_config'

to see if there were other cases, not caused by fd2d4c135e. But I didn't
see any.

 builtin/am.c            | 7 +------
 builtin/commit-tree.c   | 7 +------
 builtin/verify-commit.c | 7 +------
 builtin/verify-tag.c    | 7 +------
 4 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 40126b59c5..fccf40f8ee 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2312,11 +2312,6 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	return 0;
 }
 
-static int git_am_config(const char *k, const char *v, void *cb UNUSED)
-{
-	return git_default_config(k, v, NULL);
-}
-
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
@@ -2440,7 +2435,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage, options);
 
-	git_config(git_am_config, NULL);
+	git_config(git_default_config, NULL);
 
 	am_state_init(&state);
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index f6a099d601..c0bbe9373d 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -37,11 +37,6 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 	commit_list_insert(parent, parents_p);
 }
 
-static int commit_tree_config(const char *var, const char *value, void *cb)
-{
-	return git_default_config(var, value, cb);
-}
-
 static int parse_parent_arg_callback(const struct option *opt,
 		const char *arg, int unset)
 {
@@ -118,7 +113,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(commit_tree_config, NULL);
+	git_config(git_default_config, NULL);
 
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage_with_options(commit_tree_usage, options);
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 3c5d0b024c..7aedf10e85 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -52,11 +52,6 @@ static int verify_commit(const char *name, unsigned flags)
 	return run_gpg_verify((struct commit *)obj, flags);
 }
 
-static int git_verify_commit_config(const char *var, const char *value, void *cb)
-{
-	return git_default_config(var, value, cb);
-}
-
 int cmd_verify_commit(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
@@ -67,7 +62,7 @@ int cmd_verify_commit(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_verify_commit_config, NULL);
+	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_commit_options,
 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index ecffb069bf..5c00b0b0f7 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -19,11 +19,6 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-static int git_verify_tag_config(const char *var, const char *value, void *cb)
-{
-	return git_default_config(var, value, cb);
-}
-
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
@@ -36,7 +31,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_verify_tag_config, NULL);
+	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
-- 
2.40.0.rc0.479.g8b3a13b6b0

