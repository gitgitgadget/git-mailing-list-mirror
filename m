Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2FF209B4
	for <e@80x24.org>; Mon, 10 Oct 2016 17:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbcJJRZC (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:25:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:51882 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753112AbcJJRZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:25:01 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lh6sJ-1b7R422JpX-00oYRl; Mon, 10 Oct 2016 19:24:57
 +0200
Date:   Mon, 10 Oct 2016 19:24:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 05/25] sequencer: eventually release memory allocated for
 the option values
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <a67af02ef363311b526bddba864c7f1ca9087b43.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1mL39Bf8MNYnPjVNUFPo29HGMIMOe36aPcu8gjkPs1i7yVXbMy/
 BLztcFB5uAq+TAcpRnc8JzHYxOvXMht0ngZZftcagF5/5911XskJxni0l6Ag/TARvS5Ng7k
 wdrkA3utk0r4iso2tiAZO7aBwhEbvxRO5Ei6tJjGmyHMx7v46K3CmgN4Cv4sMHxec4529KN
 SG3o4lSBLNdRnnPJtFmNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zak85avXO6o=:TCw8FB1sUATt4uas4bx4fw
 tfELdy19g+VAcfdtcJpGM106yAOA2AlEITXsw27Prj/7yZn5aQBEihUFvujWPIWpLh+wOV9vL
 auPau0AAWbtl8AFOahgZWDk+GkVrAT+TgmMD+WyhhJDXikOi7tsduRzRnMqEHgfBhOYhSCpr3
 wdMcHGCm53XZbozDDHgFyWpIqRq3VLG+WdM9qcurt4efxvCaXrkYDY/hY7BETbuipCMPSkSQI
 9YaEE6VberNomMKeiZNy0tpouHZ5+nx3l1ZUD+mOK2TQTakGzXxLho4wLPkcfzv0vUdKG+YCl
 nISh6iNs/vIn69A5ylcXg+pBxxV56FkxRqQuRvToRzlRidpDjMMd/1MwLrIj99QMBNt7+2phm
 KQt9GQs0RZUrD6GksgbLMJyHtTIh5iE02GrIPHdM8/vNbef8pIvt3OBfDOn3o32BCt3ifNDQL
 EKiGlFX9yHgNHJYsV4U7yvolpPxEHuFp/s3Rd+17XaTf105KRo4pNoKSG1CqZmqmGhPmNvei+
 RpvKpQ8+ktBOrs6bv938cHu/JkuKuANxIDxpsd+dGvFUj1YNaWfya4Z2BvHek1yEEotniXXH8
 rwn+kCO5TjUBRCJM5t0/GYj46rjz3ZfJUk0yt8GPg+11XNndGEV+VVhX8jlI+tNhRJfSyACWE
 xWsO7xSiK9LJoKqYhryCCb3f1JD8Rwgt+k2TWJWoJX/ZxqBZM76F4n87n06V9nES2TlrZv9MZ
 SNlUvdfpqn//lN8DGrTKom6LwW6OPK+OL9aCUx9Es6iW5T4j6tBnVzipdzhnyBRQ5W4uBAKZO
 jbASmYG
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
 builtin/revert.c |  6 ++++++
 sequencer.c      | 32 ++++++++++++++++++++++++++------
 sequencer.h      |  6 +++---
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7365559..fce9c75 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -174,6 +174,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 
 	if (argc > 1)
 		usage_with_options(usage_str, options);
+
+	/* These option values will be free()d */
+	if (opts->gpg_sign)
+		opts->gpg_sign = xstrdup(opts->gpg_sign);
+	if (opts->strategy)
+		opts->strategy = xstrdup(opts->strategy);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/sequencer.c b/sequencer.c
index 8d272fb..22c31c8 100644
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
@@ -802,10 +810,22 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value);
-	else if (!strcmp(key, "options.strategy"))
-		git_config_string(&opts->strategy, key, value);
-	else if (!strcmp(key, "options.gpg-sign"))
-		git_config_string(&opts->gpg_sign, key, value);
+	else if (!strcmp(key, "options.strategy")) {
+		if (!value)
+			config_error_nonbool(key);
+		else {
+			free(opts->strategy);
+			opts->strategy = xstrdup(value);
+		}
+	}
+	else if (!strcmp(key, "options.gpg-sign")) {
+		if (!value)
+			config_error_nonbool(key);
+		else {
+			free(opts->gpg_sign);
+			opts->gpg_sign = xstrdup(value);
+		}
+	}
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
2.10.0.windows.1.325.ge6089c1


