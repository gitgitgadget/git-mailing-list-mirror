Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404C4C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 16:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbiDZQO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 12:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352846AbiDZQO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 12:14:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75319A9B4
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 09:11:50 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE26C183DA6;
        Tue, 26 Apr 2022 12:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nRdt/6xwo1nJ
        j6FqlIGQ1XVFrm1pf5FbWVuHlcfXSY8=; b=cfwqqNn670F5syxa8w2e0hVLUa4L
        gTS3RIleHXVcepXidTcARwlujUHjYuT+l2eozEobYXxHdG69mt2M1O8vBrvsJ+S9
        ppt0ySY9erpETx8O1rf1OLn/mhZ/u3nR0E+iaDPqildpal0n0B8Jx7i7wC0SaZqW
        ap2ZzYySBOu5ye4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C653D183DA5;
        Tue, 26 Apr 2022 12:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2BA7C183DA4;
        Tue, 26 Apr 2022 12:11:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fh?= =?utf-8?Q?auer?= 
        <mha1993@live.de>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] 2.36 gitk/diff-tree --stdin regression fix
References: <xmqqh76j3i3r.fsf@gitster.g> <xmqqbkwpvyyc.fsf@gitster.g>
        <83a76d46-5069-d6c7-b8b3-f3a063637abb@gmail.com>
        <6ac7e164-c4ba-0ffc-a8a4-4cede1d4e7ae@gmail.com>
        <xmqqo80nsw5h.fsf@gitster.g>
Date:   Tue, 26 Apr 2022 09:11:44 -0700
In-Reply-To: <xmqqo80nsw5h.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        26 Apr 2022 08:26:50 -0700")
Message-ID: <xmqq7d7bsu2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91F342AE-C57B-11EC-9A84-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This only surfaced as a regression after 2.36 release, but the
breakage was already there with us for at least a year.

The diff_free() call is to be used after we completely finished with
a diffopt structure.  After "git diff A B" finishes producing
output, calling it before process exit is fine.  But there are
commands that prepares diff_options struct once, compares two sets
of paths, releases resources that were used to do the comparison,
then reuses the same diff_option struct to go on to compare the next
two sets of paths, like "git log -p". =20

After "git log -p" finishes showing a single commit, calling it
before it goes on to the next commit is NOT fine.  There is a
mechanism, the .no_free member in diff_options struct, to help "git
log" to avoid calling diff_free() after showing each commit and
instead call it just one.  When the mechanism was introduced in
e900d494 (diff: add an API for deferred freeing, 2021-02-11),
however, we forgot to do the same to "diff-tree --stdin", which *is*
a moral equivalent to "git log".

During 2.36 release cycle, we started clearing the pathspec in
diff_free(), so programs like gitk that runs

    git diff-tree --stdin -- <pathspec>

downstream of a pipe, processing one commit after another, started
showing irrelevant comparison outside the given <pathspec> from the
second commit.  The same commit, by forgetting to teach the .no_free
mechanism, broke "diff-tree --stdin -I<regexp>" and nobody noticed
it for over a year, presumably because it is so seldom used an
option.

But <pathspec> is a different story.  The breakage was very
prominently visible and was reported immediately after 2.36 was
released.

Fix this breakage by mimicking how "git log" utilizes the .no_free
member so that "diff-tree --stdin" behaves more similarly to "log".

Protect the fix with a few new tests.

Reported-by: Matthias A=C3=9Fhauer <mha1993@live.de>
Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I feel MUCH better with this than the revert, now Phillip helped
   me to get the root cause straight.  Addition of clear_pathspec()
   to diff_tree() was *not* a mistake but is quite reasonable thing
   to do.  Not using the .no_free hack in a code path that needed it
   was.



 builtin/diff-tree.c     |  3 +++
 log-tree.c              |  1 +
 t/t4013-diff-various.sh | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0e0ac1f167..116097a404 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -195,6 +195,7 @@ int cmd_diff_tree(int argc, const char **argv, const =
char *prefix)
 		int saved_dcctc =3D 0;
=20
 		opt->diffopt.rotate_to_strict =3D 0;
+		opt->diffopt.no_free =3D 1;
 		if (opt->diffopt.detect_rename) {
 			if (!the_index.cache)
 				repo_read_index(the_repository);
@@ -217,6 +218,8 @@ int cmd_diff_tree(int argc, const char **argv, const =
char *prefix)
 		}
 		opt->diffopt.degraded_cc_to_c =3D saved_dcctc;
 		opt->diffopt.needed_rename_limit =3D saved_nrl;
+		opt->diffopt.no_free =3D 0;
+		diff_free(&opt->diffopt);
 	}
=20
 	return diff_result_code(&opt->diffopt, 0);
diff --git a/log-tree.c b/log-tree.c
index 25165e2a91..f8c18fd8b9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1098,6 +1098,7 @@ int log_tree_commit(struct rev_info *opt, struct co=
mmit *commit)
 	opt->loginfo =3D &log;
 	opt->diffopt.no_free =3D 1;
=20
+	/* NEEDSWORK: no restoring of no_free?  Why? */
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
=20
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 750aee17ea..628b01f355 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -542,6 +542,20 @@ test_expect_success 'diff-tree --stdin with log form=
atting' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'diff-tree --stdin with pathspec' '
+	cat >expect <<-EOF &&
+	Third
+
+	dir/sub
+	Second
+
+	dir/sub
+	EOF
+	git rev-list master^ |
+	git diff-tree -r --stdin --name-only --format=3D%s dir >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'diff -I<regex>: setup' '
 	git checkout master &&
 	test_seq 50 >file0 &&
--=20
2.36.0-202-g319c44b8f9

