Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E2520229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755428AbcJUMYh (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:60145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755300AbcJUMYe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:34 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mda8q-1cIXcu1WG4-00PLvo; Fri, 21 Oct 2016 14:24:28
 +0200
Date:   Fri, 21 Oct 2016 14:24:13 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 05/27] sequencer: plug memory leaks for the option
 values
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <2adce611dc9157167d715b5985ebb492bb880b37.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2Sd236E5fm+xCPUBR6K5rSeFeky5pXSbQNyIxMqckJIPYwhkj8n
 b97q4hNW5un2Ht5sw1AAIUiO0q1j3GccjkcGdusjtW3j2SBjQ56RWernnAd5O6qP2gBhSR2
 NmGUKi1DZY2iB7nc2dftvWq2+6nWn2aK0HJ13x+10W++TTDey2ZJX5It4jhGG5hzxK8Igk1
 1V9js9K3vjVO7sabspCfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P3T3gnlxago=:EX5i9IUSx7VfjP7T7pGFJ3
 ESKZeBkJXC1sXaRlAdfQUY7+AM7upX2+biZwpxMKlqv9xdhQ6Hv3hK8AUDGphgnI9bWW2Q5jp
 wAZSSqT8oSiqOXYQtmpgtxWq7K2PSynXgpP6jz/YaowrySDRmDG3ZHZmyv8qEI5HNuMkOOatu
 vNNrR39WHLWLgR/421Q2P57jKFAFOl0QO7G7UfL9tSL/kfMelYOIeee2ChyZdc3s+ogHXekUy
 7SHDt2lIKhoELYfkwsIQQ56XYpF3jJsN9RVMwPlFaR+SEIKxce4M/w9rZafNelETyRTHvvVcX
 ae9xAAQzEGqcK0ezXAPWip088hf6hhFRyk8SDfpuplxBs5HF2o3NIQaCbhMOeS3E5vWHs7GPY
 mAJFOR4k6i5ebFKjnzerlXy4C+K/syyFhvLMuxUx9jPCbRAAGy9HO0bVEfFVVGlNfTIe6HKLw
 IG9mQhWrWnvjosQJF8rXNTknkepBv2uwHPFbJIOPzhTKLO0g7GdCdTpUL68dTvn9s/Av/NcVC
 YAJSUcxthNmrF/BMjqXYHg6XfXWK1pGEcjSMM8lJp7oEtFC6hxUoLC+lLjvO7QxGSwl+sKI9W
 qeAVb8X4mV0qHa5mcQlZL6gHNnpyVnu9oZdjZ2dj78vI3KybjCwCL8aPlOwIS2yecMfeWWl3c
 4yL3Ypva/DLK4xJIheBl4E0UThF6I8Y6sEvluTzMpkTKna+7Bw/GAEhFjknCgV/hAglgJNvTt
 4TkEOhSq8D1myCXOzMGA9AEYKTkKtPkgrJqY0fIORyxNK0H32GG89Z1hLF4WTE0C8w5zLWXR3
 195k7wi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer is our attempt to lib-ify cherry-pick. Yet it behaves
like a one-shot command when it reads its configuration: memory is
allocated and released only when the command exits.

This is kind of okay for git-cherry-pick, which *is* a one-shot
command. All the work to make the sequencer its work horse was
done to allow using the functionality as a library function, though,
including proper clean-up after use.

To remedy that, we now take custody of the option values in question,
requiring those values to be malloc()ed or strdup()ed (an alternative
approach, to add a list of pointers to malloc()ed data and to ask the
sequencer to release all of them in the end, was proposed earlier but
rejected during review).

Note: this means that we now have to take care to strdup() the values
passed via the command-line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/revert.c |  4 ++++
 sequencer.c      | 26 ++++++++++++++++++++++----
 sequencer.h      |  6 +++---
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7365559..ba5a88c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -174,6 +174,10 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 
 	if (argc > 1)
 		usage_with_options(usage_str, options);
+
+	/* These option values will be free()d */
+	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
+	opts->strategy = xstrdup_or_null(opts->strategy);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/sequencer.c b/sequencer.c
index 8d272fb..04c55f2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -117,6 +117,13 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 static void remove_sequencer_state(const struct replay_opts *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
+	int i;
+
+	free(opts->gpg_sign);
+	free(opts->strategy);
+	for (i = 0; i < opts->xopts_nr; i++)
+		free(opts->xopts[i]);
+	free(opts->xopts);
 
 	strbuf_addf(&dir, "%s", get_dir(opts));
 	remove_dir_recursively(&dir, 0);
@@ -280,7 +287,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
 	int clean;
-	const char **xopt;
+	char **xopt;
 	static struct lock_file index_lock;
 
 	hold_locked_index(&index_lock, 1);
@@ -583,7 +590,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
+		res |= try_merge_command(opts->strategy,
+					 opts->xopts_nr, (const char **)opts->xopts,
 					common, sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
@@ -783,6 +791,16 @@ static int read_populate_todo(struct commit_list **todo_list,
 	return 0;
 }
 
+static int git_config_string_dup(char **dest,
+				 const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	free(*dest);
+	*dest = xstrdup(value);
+	return 0;
+}
+
 static int populate_opts_cb(const char *key, const char *value, void *data)
 {
 	struct replay_opts *opts = data;
@@ -803,9 +821,9 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value);
 	else if (!strcmp(key, "options.strategy"))
-		git_config_string(&opts->strategy, key, value);
+		git_config_string_dup(&opts->strategy, key, value);
 	else if (!strcmp(key, "options.gpg-sign"))
-		git_config_string(&opts->gpg_sign, key, value);
+		git_config_string_dup(&opts->gpg_sign, key, value);
 	else if (!strcmp(key, "options.strategy-option")) {
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
diff --git a/sequencer.h b/sequencer.h
index dd4d33a..8453669 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -34,11 +34,11 @@ struct replay_opts {
 
 	int mainline;
 
-	const char *gpg_sign;
+	char *gpg_sign;
 
 	/* Merge strategy */
-	const char *strategy;
-	const char **xopts;
+	char *strategy;
+	char **xopts;
 	size_t xopts_nr, xopts_alloc;
 
 	/* Only used by REPLAY_NONE */
-- 
2.10.1.583.g721a9e0


