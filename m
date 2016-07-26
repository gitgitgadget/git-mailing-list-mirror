Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE785203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbcGZQHD (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:07:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:61436 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757064AbcGZQG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:59 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MGSgq-1bWWrT1Ano-00DEqe; Tue, 26 Jul 2016 18:06:43
 +0200
Date:	Tue, 26 Jul 2016 18:06:30 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 11/16] am -3: use merge_recursive() directly again
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <9068aaf45f3956da3f02f265b0a77c03742cd6cd.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EzdOqCZOpNwgocki+TjYiDnDO3DyccUD3i7KwXNWS7d2RfALYqO
 wOw1KuSO3YpsvGn/YwDPRsft0dbYqtoHcHNaDJIyJ9on0t+IlxvLHdLPuBo7hKSPNclRPkZ
 N8G478j8yqLoOLMKnXvS9XD8Syuygcp0JHHoW5d9AnpggareJhc4Rj9pmAoPxw6jLae6LNs
 XaCny/f9aN4lV3LfS/NDQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TeHuOe0EGVA=:oB84boBbU1IGWQzdGzocRW
 gbN1ftqoaemZK5oDtzFnsVfA7Ph0q77bisPBwH3HDdaQY0yLa53uxmMrdf5+Wst2VggGXxu/f
 0W3y8i2DdFEUHCRMmuQiBicgGaPhtNF7bYD5PM5si97qGiUt94u2qEWt1HGW1BFpGKoWoO0JE
 +EFJESrN/J2RxH0eL307Qm8WwTbq3REJWZZ6wT/YRVu0CE11nY2xEGzq3WsmNan18oD7GjoUF
 tmkOj6Po4YGnKHDqgtQo4iTZ6Zg+MGEIUOemtDHhnJ6HWf2B9fjJtevgY91/zZ10A07WKYExE
 gZdcIttlZszFDg/PLaQ2vjREJI6/OOb25aqAKra8t7gjuVJZVZFRbM9JyyRYmrx34C8XAPNAc
 Z9vh290c8lAzwv3fgVg1XBnuOs8mLoBmC0fLHM9TKrXo7yhuZW1Xxtg594aC1ONEKpxW0XBsZ
 x63TKBZ9I7VSt37If4E+LEeLyE/GZ2FL23grxIoWbffxv3CGM6XZNzAqYO2XkuAYmVJTZMwx1
 DNRW715Ggu5oRERWLN9fkCexTi9U7LTXYfHJPwHPcUO9v68u/OpmqborRo4L+dgrDqzPmLz0F
 S627qVfBQapA7ei3KWdjg09J6/NHvWg7p0JX0/x2SFqqGhUNrAKkoXxlIUE56sg5+ADTY3lz0
 CxJgJxGmJV+4pm7QG+9HYs0WqvDdC2V9o0yWKSc3xwhZfydP697QSAOlQogj0kR6++QSYzM1E
 5ibfgaTboiTWTRu1+z7NlWRMTKM+0LLot49+uJtWLaHF68nOZY4ENriski36JduX8hkhj0bJU
 KT+GL5q
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Last October, we had to change this code to run `git merge-recursive`
in a child process: git-am wants to print some helpful advice when the
merge failed, but the code in question was not prepared to return, it
die()d instead.

We are finally at a point when the code *is* prepared to return errors,
and can avoid the child process again.

This reverts commit c63d4b2 (am -3: do not let failed merge from
completing the error codepath, 2015-10-09), with the necessary changes
to adjust for the fact that Git's source code changed in the meantime
(such as: using OIDs instead of hashes in the recursive merge, and a
removed gender bias).

Note: the code now calls merge_recursive_generic() again. Unlike
merge_trees() and merge_recursive(), this function returns 0 upon success,
as most of Git's functions. Therefore, the error value -1 naturally is
handled correctly, and we do not have to take care of it specifically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 62 +++++++++++++++++++++---------------------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index b77bf11..cfb79ea 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1579,47 +1579,18 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 }
 
 /**
- * Do the three-way merge using fake ancestor, their tree constructed
- * from the fake ancestor and the postimage of the patch, and our
- * state.
- */
-static int run_fallback_merge_recursive(const struct am_state *state,
-					unsigned char *orig_tree,
-					unsigned char *our_tree,
-					unsigned char *their_tree)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-	int status;
-
-	cp.git_cmd = 1;
-
-	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
-			 sha1_to_hex(their_tree), linelen(state->msg), state->msg);
-	if (state->quiet)
-		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
-
-	argv_array_push(&cp.args, "merge-recursive");
-	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
-	argv_array_push(&cp.args, "--");
-	argv_array_push(&cp.args, sha1_to_hex(our_tree));
-	argv_array_push(&cp.args, sha1_to_hex(their_tree));
-
-	status = run_command(&cp) ? (-1) : 0;
-	discard_cache();
-	read_cache();
-	return status;
-}
-
-/**
  * Attempt a threeway merge, using index_path as the temporary index.
  */
 static int fall_back_threeway(const struct am_state *state, const char *index_path)
 {
-	unsigned char orig_tree[GIT_SHA1_RAWSZ], their_tree[GIT_SHA1_RAWSZ],
-		      our_tree[GIT_SHA1_RAWSZ];
+	struct object_id orig_tree, their_tree, our_tree;
+	const struct object_id *bases[1] = { &orig_tree };
+	struct merge_options o;
+	struct commit *result;
+	char *their_tree_name;
 
-	if (get_sha1("HEAD", our_tree) < 0)
-		hashcpy(our_tree, EMPTY_TREE_SHA1_BIN);
+	if (get_oid("HEAD", &our_tree) < 0)
+		hashcpy(our_tree.hash, EMPTY_TREE_SHA1_BIN);
 
 	if (build_fake_ancestor(state, index_path))
 		return error("could not build fake ancestor");
@@ -1627,7 +1598,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	discard_cache();
 	read_cache_from(index_path);
 
-	if (write_index_as_tree(orig_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
 
 	say(state, stdout, _("Using index info to reconstruct a base tree..."));
@@ -1643,7 +1614,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		init_revisions(&rev_info, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
 		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
-		add_pending_sha1(&rev_info, "HEAD", our_tree, 0);
+		add_pending_sha1(&rev_info, "HEAD", our_tree.hash, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
 	}
@@ -1652,7 +1623,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error(_("Did you hand edit your patch?\n"
 				"It does not apply to blobs recorded in its index."));
 
-	if (write_index_as_tree(their_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(their_tree.hash, &the_index, index_path, 0, NULL))
 		return error("could not write tree");
 
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
@@ -1668,11 +1639,22 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	 * changes.
 	 */
 
-	if (run_fallback_merge_recursive(state, orig_tree, our_tree, their_tree)) {
+	init_merge_options(&o);
+
+	o.branch1 = "HEAD";
+	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
+	o.branch2 = their_tree_name;
+
+	if (state->quiet)
+		o.verbosity = 0;
+
+	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
 		rerere(state->allow_rerere_autoupdate);
+		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
 
+	free(their_tree_name);
 	return 0;
 }
 
-- 
2.9.0.281.g286a8d9


