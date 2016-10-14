Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D95B1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932853AbcJNNUU (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:52880 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755372AbcJNNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M0cs6-1cpTCc497O-00uoZQ; Fri, 14 Oct 2016 15:17:25
 +0200
Date:   Fri, 14 Oct 2016 15:17:24 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 05/25] sequencer: eventually release memory allocated for
 the option values
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <b771bfbc88734b74acda0c377446e984ca81fd9c.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:THX9FIJgQkFLQYjvP0hPY0Bn9ZDTbsnshoQkQuhE279ujXp7WtK
 ECwkSz443cjccqhCei2SwJ6NfD60bv6In6HUy0/jU6cnqvz28fzA9Cw1gVvQzrxs3q3WT4d
 y7Mszzq6GsTJKoReBEu08dVmHstj8SruA/xT9t455ILF+Ny5XNX4Oforc77NQWleY35/Fjl
 Mjac0AgkRCupcShLE3iKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eCQImrUjdiE=:p5BEI2VxdmlQQWYa5icMTH
 96YmBbczDzSZkRzqrAG2v6Hwcsro0uTaamVoQgCVUY6Rb8lWJnyEntjcMbKSSUiUqWKTh/DYD
 C6wjpThHlzBZS5HA17/q1jHXDOlCIfVmvceL9Y48PdX8JlEoQxpuZxGZI9uGC2MMeAZP2Eano
 nDofbyYW53L40+1ox5B/d3U7Oo/b0w2UkMSjR9xEHIreGrt/bk8Vq3d5cUurKrLdES31tCplM
 7EWA8IlZhbYkFIE68qwBy6LZiPdtcdP1LHnfBJkBVT9Kxt02f4BbSlOPB3UT6WhA33agk9ZTV
 6mnOA0ZHiQ7aDdrERGqA2OnL+eAro2/BVo7WHV/HezaLF9bimVYSbQQgRh4oED0Y4BIn/buJR
 pQ9Jetnu33je3Cmwix6cEvwVt74uCwCHKGJACXheR/T9cC1jQGvZweTGVlS3hRyPXm0UqkcXd
 UAOCxkUoOMtjbHJpFlpApiuKrXLg8BBENiYZJlM7d/2hT3jGmj0zU8JAd4XuyBvoK4Un/fgI5
 4dY7bHPWKcaqdFpT638GJdbu9CmrlOhixQe4tDdUiXcK0v3Kt+Md1Won730FVBWBGxFKQojh1
 pTTM8gKtbsDVVNBQKONlPUPP+DR2WrP2Mx/u4Z5YXj/YuA36oYHWbRZkgejkbXr9+5T5iaisk
 Vj4PidxDuxVuvSH3TdbaRsU8B5ylQW6r784+lCe+fdAQyDTf+UXF7LPy7E8NS2UNr3OU9chAU
 uY7CRN9lcCaNbSD20/KrVpBVY/Og4GwxAJIrqJDAmcKGkYS8T2VF6qP6Lz6Zc0Mwg6F7ZiGMp
 5RbaTrB
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

Sadly, the current approach makes the code uglier, as we now have to
take care to strdup() the values passed via the command-line.

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
2.10.1.513.g00ef6dd


