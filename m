Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F80C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 05:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiD3FdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 01:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiD3FdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 01:33:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B30BB10
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 22:29:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 827A518E098;
        Sat, 30 Apr 2022 01:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OvahMIK6tZU2KAu8pMrK7KfgK7r9/0WHgNyXr1
        tdf+Y=; b=cR9A9tYBGTfN8rQ6hUk7t23KmDmpsc/z/wLCLMoZxEGHq3yYyRMNnq
        OBXGsO9cO42RhTpaXMs9eC+/EJyKAR75bQf1eSKtHBc4B1HwsXFWTobDInkwQFRs
        F6fAuT/EQ83nW0yfH7ng8SfL9LuREkvXnzvvQc23UMHCBPvBCI1EQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D4A418E097;
        Sat, 30 Apr 2022 01:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA5FA18E089;
        Sat, 30 Apr 2022 01:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Li <dan@danielyli.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: [PATCH] 2.36 show regression fix
References: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
        <xmqqzgk388tt.fsf@gitster.g>
Date:   Fri, 29 Apr 2022 22:29:51 -0700
In-Reply-To: <xmqqzgk388tt.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        29 Apr 2022 21:59:58 -0700")
Message-ID: <xmqqo80j87g0.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FE5D7C4-C846-11EC-98E7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This only surfaced as a regression after 2.36 release, but the
breakage was already there with us for at least a year.

e900d494 (diff: add an API for deferred freeing, 2021-02-11)
introduced a mechanism to delay freeing resources held in
diff_options struct that need to be kept as long as the struct will
be reused to compute diff.  "git log -p" was taught to utilize the
mechanism but it was done with an incorrect assumption that the
underlying helper function, cmd_log_walk(), is called only once,
and it is OK to do the freeing at the end of it.

Alas, for "git show A B", the function is called once for each
commit given, so it is not OK to free the resources until we finish
calling it for all the commits given from the command line.

During 2.36 release cycle, we started clearing the <pathspec> as
part of this freeing, which made the bug a lot more visible.

Fix this breakage by tweaking how cmd_log_walk() frees the resources
at the end and using a variant of it that does not immediately free
the resources to show each commit object from the command line in
"git show".

Protect the fix with a few new tests.

Reported-by: Daniel Li <dan@danielyli.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Junio C Hamano <gitster@pobox.com> writes:

> Daniel Li <dan@danielyli.com> writes:
>
>> git version: 2.36.0
>> OS: macOS Monterey 12.2.1
>> Installed via: homebrew
>
> I think this is the same regression as the recently talked about
> "diff-tree --stdin" aka "gitk" regression.
>
> https://lore.kernel.org/git/xmqq7d7bsu2n.fsf@gitster.g/
>
> e900d494 (diff: add an API for deferred freeing, 2021-02-11), broke
> cmd_log_walk(), and we started to lose some setting that was parsed
> from the command line and stored in the diff_options structure after
> cmd_log_walk() runs just once.  But "git show A B" runs the function
> once for each commit.   A recent change in 2.36.0 made it worse by
> adding <pathspec> to the set of setting that gets lost after
> cmd_log_walk() runs once.
>
> Thanks for a report.

 builtin/log.c           | 23 ++++++++++++++++++-----
 t/t4013-diff-various.sh | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c211d66d1d..6696c4cfd0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -417,7 +417,7 @@ static void finish_early_output(struct rev_info *rev)
 	show_early_header(rev, "done", n);
 }
 
-static int cmd_log_walk(struct rev_info *rev)
+static int cmd_log_walk_no_free(struct rev_info *rev)
 {
 	struct commit *commit;
 	int saved_nrl = 0;
@@ -444,7 +444,6 @@ static int cmd_log_walk(struct rev_info *rev)
 	 * and HAS_CHANGES being accumulated in rev->diffopt, so be careful to
 	 * retain that state information if replacing rev->diffopt in this loop
 	 */
-	rev->diffopt.no_free = 1;
 	while ((commit = get_revision(rev)) != NULL) {
 		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
 			/*
@@ -469,8 +468,6 @@ static int cmd_log_walk(struct rev_info *rev)
 	}
 	rev->diffopt.degraded_cc_to_c = saved_dcctc;
 	rev->diffopt.needed_rename_limit = saved_nrl;
-	rev->diffopt.no_free = 0;
-	diff_free(&rev->diffopt);
 
 	if (rev->remerge_diff) {
 		tmp_objdir_destroy(rev->remerge_objdir);
@@ -484,6 +481,17 @@ static int cmd_log_walk(struct rev_info *rev)
 	return diff_result_code(&rev->diffopt, 0);
 }
 
+static int cmd_log_walk(struct rev_info *rev)
+{
+	int retval;
+
+	rev->diffopt.no_free = 1;
+	retval = cmd_log_walk_no_free(rev);
+	rev->diffopt.no_free = 0;
+	diff_free(&rev->diffopt);
+	return retval;
+}
+
 static int git_log_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
@@ -680,6 +688,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 
 	count = rev.pending.nr;
 	objects = rev.pending.objects;
+	rev.diffopt.no_free = 1;
 	for (i = 0; i < count && !ret; i++) {
 		struct object *o = objects[i].item;
 		const char *name = objects[i].name;
@@ -725,12 +734,16 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			rev.pending.nr = rev.pending.alloc = 0;
 			rev.pending.objects = NULL;
 			add_object_array(o, name, &rev.pending);
-			ret = cmd_log_walk(&rev);
+			ret = cmd_log_walk_no_free(&rev);
 			break;
 		default:
 			ret = error(_("unknown type: %d"), o->type);
 		}
 	}
+
+	rev.diffopt.no_free = 0;
+	diff_free(&rev.diffopt);
+
 	free(objects);
 	return ret;
 }
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 750aee17ea..7a44d5d595 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -542,6 +542,25 @@ test_expect_success 'diff-tree --stdin with log formatting' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show A B ... -- <pathspec>' '
+	# side touches dir/sub, file0, and file3
+	# master^ touches dir/sub, and file1
+	# master^^ touches dir/sub, file0, and file2
+	git show --name-only --format="<%s>" side master^ master^^ -- dir >actual &&
+	cat >expect <<-\EOF &&
+	<Side>
+
+	dir/sub
+	<Third>
+
+	dir/sub
+	<Second>
+
+	dir/sub
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'diff -I<regex>: setup' '
 	git checkout master &&
 	test_seq 50 >file0 &&
-- 
2.36.0-256-g547811d5a1

