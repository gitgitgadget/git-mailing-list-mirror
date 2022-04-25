Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE561C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbiDYRs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiDYRsz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:48:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2462E0
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:45:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DA4A11AB22;
        Mon, 25 Apr 2022 13:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:cc:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=TBerMGVoo6S6W8+Rys7XvEVem
        PuwCP00i/lSxJb1XaI=; b=LbDBY31k0GEmrvmoDuqxQZe59wLB2WJeCmH+N/AB0
        OzSmOTt6+ukbQzKIZP8uoLtZUBtAQZ/seZAbav8Q34uYOo2hfK4cvuhXSnI7pK1T
        QrJ9/j3HliP8YdnAhW61rJrk8xNSgPYt2Lb/9LSdUI0jn8lfBXmsWWG/KYic/qik
        Z0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72FDF11AB1F;
        Mon, 25 Apr 2022 13:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D08B111AB12;
        Mon, 25 Apr 2022 13:45:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] 2.36 gitk/diff-tree --stdin regression fix
References: <xmqqh76j3i3r.fsf@gitster.g>
cc:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Date:   Mon, 25 Apr 2022 10:45:47 -0700
Message-ID: <xmqqbkwpvyyc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8AD6C368-C4BF-11EC-B743-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 244c2724 (diff.[ch]: have diff_free() call
clear_pathspec(opts.pathspec), 2022-02-16).

The diff_free() call is to be used after a diffopt structure is used
to compare two sets of paths to release resources that were needed
only for that comparison, and keep the data such as pathspec that
are reused by the diffopt structure to make the next and subsequent
comparison (imagine "git log -p -<options> -- <pathspec>" where the
options and pathspec are kept in the diffopt structure, used to
compare HEAD and HEAD~, then used again when HEAD~ and HEAD~2 are
compared).

We by mistake started clearing the pathspec in diff_free(), so
programs like gitk that runs

    git diff-tree --stdin -- <pathspec>

downstream of a pipe, processing one commit after another, started
showing irrelevant comparison outside the given <pathspec> from the
second commit.

The buggy commit may have been hiding the places where diff
machinery is used only once and called diff_free() to release that
per-comparison resources, but forgetting to call clear_pathspec() to
release the resource held for the (potentially) repeated comparison,
and we eventually would want to add clear_pathspec() to clear
resources to be released after a (potentially repeated) diff session
is done (if there are similar resources other than pathspec that
need to be cleared at the end, we should then know where to clear
them), but that is "per program invocation" leak that will be
cleaned up by calling exit(3) and of lower priority than fixing this
behavior-breaking regression.

Reported-by: Matthias A=C3=9Fhauer <mha1993@live.de>
Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 add-interactive.c | 6 +++---
 blame.c           | 3 +++

 builtin/reset.c   | 1 +
 diff.c            | 1 -
 notes-merge.c     | 2 ++
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index e1ab39cce3..6498ae196f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -797,14 +797,14 @@ static int run_revert(struct add_i_state *s, const =
struct pathspec *ps,
 	diffopt.flags.override_submodule_config =3D 1;
 	diffopt.repo =3D s->r;
=20
-	if (do_diff_cache(&oid, &diffopt)) {
-		diff_free(&diffopt);
+	if (do_diff_cache(&oid, &diffopt))
 		res =3D -1;
-	} else {
+	else {
 		diffcore_std(&diffopt);
 		diff_flush(&diffopt);
 	}
 	free(paths);
+	clear_pathspec(&diffopt.pathspec);
=20
 	if (!res && write_locked_index(s->r->index, &index_lock,
 				       COMMIT_LOCK) < 0)
diff --git a/blame.c b/blame.c
index 401990726e..206c295660 100644
--- a/blame.c
+++ b/blame.c
@@ -1403,6 +1403,7 @@ static struct blame_origin *find_origin(struct repo=
sitory *r,
 		}
 	}
 	diff_flush(&diff_opts);
+	clear_pathspec(&diff_opts.pathspec);
 	return porigin;
 }
=20
@@ -1446,6 +1447,7 @@ static struct blame_origin *find_rename(struct repo=
sitory *r,
 		}
 	}
 	diff_flush(&diff_opts);
+	clear_pathspec(&diff_opts.pathspec);
 	return porigin;
 }
=20
@@ -2326,6 +2328,7 @@ static void find_copy_in_parent(struct blame_scoreb=
oard *sb,
 	} while (unblamed);
 	target->suspects =3D reverse_blame(leftover, NULL);
 	diff_flush(&diff_opts);
+	clear_pathspec(&diff_opts.pathspec);
 }
=20
 /*
diff --git a/builtin/reset.c b/builtin/reset.c
index 24968dd628..b97745ee94 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -274,6 +274,7 @@ static int read_from_tree(const struct pathspec *path=
spec,
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
+	clear_pathspec(&opt.pathspec);
=20
 	return 0;
 }
diff --git a/diff.c b/diff.c
index 0aef3db6e1..c862771a58 100644
--- a/diff.c
+++ b/diff.c
@@ -6345,7 +6345,6 @@ void diff_free(struct diff_options *options)
=20
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
-	clear_pathspec(&options->pathspec);
 }
=20
 void diff_flush(struct diff_options *options)
diff --git a/notes-merge.c b/notes-merge.c
index 7ba40cfb08..b4a3a903e8 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -175,6 +175,7 @@ static struct notes_merge_pair *diff_tree_remote(stru=
ct notes_merge_options *o,
 		       oid_to_hex(&mp->remote));
 	}
 	diff_flush(&opt);
+	clear_pathspec(&opt.pathspec);
=20
 	*num_changes =3D len;
 	return changes;
@@ -260,6 +261,7 @@ static void diff_tree_local(struct notes_merge_option=
s *o,
 		       oid_to_hex(&mp->local));
 	}
 	diff_flush(&opt);
+	clear_pathspec(&opt.pathspec);
 }
=20
 static void check_notes_merge_worktree(struct notes_merge_options *o)
--=20
2.36.0-194-g075c326b54


