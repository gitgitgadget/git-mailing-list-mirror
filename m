Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5597F206FB
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbcGELYF (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:65365 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932838AbcGELXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:23:41 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MQhyf-1asiiM0War-00U6Ln; Tue, 05 Jul 2016 13:23:31
 +0200
Date:	Tue, 5 Jul 2016 13:23:28 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 05/17] Prepare the builtins for a libified
 merge_recursive()
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <d57b8b684c45b8ee9c7736f4f273345b1d50a2d4.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:i0+OSb3qcJzkEo7BDoT0bdyMMW8dWYAqgKg1nifIqohH/7EH7CY
 kNjrcxODs1WOpjpoU4O5xytpjp5fZ8pBOSBOXoWOInmFmZeRARtwBK8fwTPwPvflQO+ySNJ
 MU8zuARN+EDhwsOKjoNvpA4Y7QH01tDu1v3PW0jlm08cOf+BrFOjzqY0BXeYGntHtJqme9S
 6THlFx6MfaKicZfkd4vzg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:xGDedXGG4SI=:Q+sdKv1f5CehzQBLWiSo5P
 yy3kegfs2Dnt6Q7LYQMF/pNulh+EVQ2JtP1eO6m6oMP3zhioLKD+gHfwqlbvAdRNdrtcmF6uB
 y0A3/LAJaBvacuB5i/n1666sV4iT3MnmYyO6ODttKxtPsAydUixk6fMh6lDUaODyWbEOkV0eY
 dljXf0YCS7ZpRcYhWCfsEJZBHX+UIHcs2Y4UNlCY8DBRTMXq2TwpCADQoeRvVU4iKqWv3NFPN
 4g6JIqFtYeAZV112sdAZYULzUnhej8x2jIRzFsIoGZB78/OqhCwg7B+yOngI+iyFts2NuYP6b
 rHOF+7Ky9ROB308um552vcWbwitgW/s3z0ouDlhOMSwWj3d1/s2XQwaHopP1vREhnY3xUA0oe
 /lh2JI7FaqqCBR1RqrEGcZ4JxBiIyqKI35xA1t2M8Gp6ahpn3soqlY4tI46X4tMHncMCe0Xjj
 iyZZ2YERwUkq3Rkm7mDQZOYzY/Gxpk2HGpfxChY6rzSvyN79sfM8FM5A6U5cmsmOrSXHBe0QJ
 EApPVEb8eUqp8jQvggPsprQ00seW5fD3Ap0QgcImbFLqRVrM6/1PeHLROqMl9CIp1+zUhZear
 n3Co/ajcyJZilMV1R+0S5b9eybdcAgPtf0J32kP+QKyzqROsXCzFQOAIa/ntPvU3tl7Dy/0DB
 QksWqupI61e/z4aKV+o8EnCXzmS55g5m52aAa4jLWvZk+1THCoDkVu9pbh7Fmtj6wMD06exkE
 e0HSdeyyv/macQnHqDyQPbWpKeWKliojpwcHNh6g1Ins0TzbOo/OmV63H/tTKA6bXjvTgSjNg
 9aXH59h
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Previously, callers of merge_trees() or merge_recursive() expected that
code to die() with an error message. This used to be okay because we
called those commands from scripts, and had a chance to print out a
message in case the command failed fatally (read: with exit code 128).

As scripting incurs its own set of problems (portability, speed,
idiosynchracies of different shells, limited data structures leading to
inefficient code), we are converting more and more of these scripts into
builtins, using library functions directly.

We already tried to use merge_recursive() directly in the builtin
git-am, for example. Unfortunately, we had to roll it back temporarily
because some of the code in merge-recursive.c still deemed it okay to
call die(), when the builtin am code really wanted to print out a useful
advice after the merge failed fatally. In the next commits, we want to
fix that.

The code touched by this commit expected merge_trees() to die() with
some useful message when there is an error condition, but merge_trees()
is going to be improved by converting all die() calls to return error()
instead (i.e. return value -1 after printing out the message as before),
so that the caller can react more flexibly.

This is a step to prepare for the version of merge_trees() that no
longer dies,  even if we just imitate the previous behavior by calling
exit(128): this is what callers of e.g. `git merge` have come to expect.

Note that the callers of the sequencer (revert and cherry-pick) already
fail fast even for the return value -1; The only difference is that they
now get a chance to say "<command> failed".

A caller of merge_trees() might want handle error messages themselves
(or even suppress them). As this patch is already complex enough, we
leave that change for a later patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c | 4 +++-
 builtin/merge.c    | 2 ++
 sequencer.c        | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c3486bd..14312f7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -567,8 +567,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.ancestor = old->name;
 			o.branch1 = new->name;
 			o.branch2 = "local";
-			merge_trees(&o, new->commit->tree, work,
+			ret = merge_trees(&o, new->commit->tree, work,
 				old->commit->tree, &result);
+			if (ret < 0)
+				exit(128);
 			ret = reset_tree(new->commit->tree, opts, 0,
 					 writeout_error);
 			if (ret)
diff --git a/builtin/merge.c b/builtin/merge.c
index b555a1b..7b898db 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -682,6 +682,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		hold_locked_index(&lock, 1);
 		clean = merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
+		if (clean < 0)
+			exit(128);
 		if (active_cache_changed &&
 		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 			die (_("unable to write %s"), get_index_file());
diff --git a/sequencer.c b/sequencer.c
index c6362d6..13b794a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -293,6 +293,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	clean = merge_trees(&o,
 			    head_tree,
 			    next_tree, base_tree, &result);
+	if (clean < 0)
+		return clean;
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
@@ -561,6 +563,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
+		if (res < 0)
+			return res;
 		write_message(&msgbuf, git_path_merge_msg());
 	} else {
 		struct commit_list *common = NULL;
-- 
2.9.0.280.g32e2a70


