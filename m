Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE75206FB
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbcGELYU (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:52384 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932892AbcGELYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:24:10 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Mdren-1ax4HP16kf-00Pan7; Tue, 05 Jul 2016 13:24:02
 +0200
Date:	Tue, 5 Jul 2016 13:24:01 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 12/17] am -3: use merge_recursive() directly again
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <6f759e9860cc423e6aff57af58ecd7d4c79e6d0f.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+PnyjTIP/jGGSm1VW3wfI4fT4JIKuY/RWxS5Ds0hRYQAPDNsluI
 Hf/fsSQSprnxVeT3KyjX2smrjDTW9xUpIs+/mvxCop4CKg5i65hNDJlFFA/zGD16Gs++ATp
 f7HA1/md7zWn5BeA7lN5uG6cQd/NihwJoERDfh7tTXsFh/kP35CHuwUmmJRm86e0CzAe161
 RINfQToYmjWXSizC4cowA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:PzJMJwSaZok=:lyOkCDlgofrbPbAnJqv6zc
 D/PD5TMRDM1SFzVRRyIDADwcKum4YqzCuKq4PQhz3eTaMN9/APvFfhKx34zYJziOBIbwfsgMR
 MQaH0EfsBP2J+Z4UiP6COoJReHqcGvoaJZNpqKb/1ygpOa/iag9LAzxYOO19J2vLs5DInVK8/
 A965UqATghgrBQ88ahuovfa0xq1fCUbDOxwi3NE2OiQSfaq9oo4KC/nL1KFS9uGQEP5NLaV9n
 zcexBVw5o0mq6jRWXuRZ+CiiXWLeQohUqV409t1S0twK52s6RjmV2Jsopk1CLunoM8aaeY4le
 xq93kNTSo4BoAXB4xSuIWLzGruwesp6D9zGexKH6COCxeItp/WssMmtdKq+FJZWYUuwm1FKNg
 Tt8CludrsOlF6AYEOQm1x6KKelYkWAHAgl6Xxy4hXTfln0azl1Y5byBCxHHlOhaJkgEjOPYYK
 MUy/SI7hiSN9cHOY6SvIxiGPkkXU6J5xLRmY9RIrWYxh01u2CtERJvJ0H9eLIZ5PdDBF1RsAo
 kqlLlo0ZZdkN1DmCvqeydXDxVszaPL5m7UZN8iRgH1h3+0mv+Pv1q4dJuRXMIs+ZG+lo9jjR8
 PQNiY4JQopiLTGbXUJ80GkynhTz0fxI3xSwHyl+vYI58na5l2SQH69Id/ZUKPHilKlxlUlPu9
 dp+hA/kO7ACJnHZxekbS0DAkvL7m45Jn1WYFdCs8KznYioMZb8gk7RXRC9hxAzyOq9BHURr0c
 JT2cwwBPtEcJUOv+BePUm/SyyDDo8+r9jR/S7zStmXW2Vb8DYoNqHDURvCMGDKZLmLDv0aajD
 zkxQNEH
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
completing the error codepath, 2015-10-09).

Note: the code now calls merge_recursive_generic() again. Unlike
merge_trees() and merge_recursive(), this function returns 0 upon success,
as most of Git's functions. Therefore, the error value -1 naturally is
handled correctly, and we do not have to take care of it specifically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 49 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f07f89a..be652f9 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1578,44 +1578,16 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 }
 
 /**
- * Do the three-way merge using fake ancestor, her tree constructed
- * from the fake ancestor and the postimage of the patch, and our
- * state.
- */
-static int run_fallback_merge_recursive(const struct am_state *state,
-					unsigned char *orig_tree,
-					unsigned char *our_tree,
-					unsigned char *her_tree)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-	int status;
-
-	cp.git_cmd = 1;
-
-	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
-			 sha1_to_hex(her_tree), linelen(state->msg), state->msg);
-	if (state->quiet)
-		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
-
-	argv_array_push(&cp.args, "merge-recursive");
-	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
-	argv_array_push(&cp.args, "--");
-	argv_array_push(&cp.args, sha1_to_hex(our_tree));
-	argv_array_push(&cp.args, sha1_to_hex(her_tree));
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
 	unsigned char orig_tree[GIT_SHA1_RAWSZ], her_tree[GIT_SHA1_RAWSZ],
 		      our_tree[GIT_SHA1_RAWSZ];
+	const unsigned char *bases[1] = {orig_tree};
+	struct merge_options o;
+	struct commit *result;
+	char *her_tree_name;
 
 	if (get_sha1("HEAD", our_tree) < 0)
 		hashcpy(our_tree, EMPTY_TREE_SHA1_BIN);
@@ -1667,11 +1639,22 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	 * changes.
 	 */
 
-	if (run_fallback_merge_recursive(state, orig_tree, our_tree, her_tree)) {
+	init_merge_options(&o);
+
+	o.branch1 = "HEAD";
+	her_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
+	o.branch2 = her_tree_name;
+
+	if (state->quiet)
+		o.verbosity = 0;
+
+	if (merge_recursive_generic(&o, our_tree, her_tree, 1, bases, &result)) {
 		rerere(state->allow_rerere_autoupdate);
+		free(her_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
 
+	free(her_tree_name);
 	return 0;
 }
 
-- 
2.9.0.280.g32e2a70


