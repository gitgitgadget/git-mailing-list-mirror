Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF1620193
	for <e@80x24.org>; Mon, 24 Oct 2016 23:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754361AbcJXXKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 19:10:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50129 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753901AbcJXXKP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 19:10:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DE8D493DA;
        Mon, 24 Oct 2016 19:10:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=5
        7WZ4/cTwF3mhhbl3YP4pmzHs/M=; b=nRsoNk2kMtPc9vzzL4ohF1J/XjmN1bzda
        zI7Vsnh5HCMswMBi4fnVIhz9CYl0QnkEYMpJBk86wP187QjaAX8niN8VUuh+YwPS
        jP+M3T12zrcehsxTYjAIMEu7wnFEKTQiQfdiNUPBltP/mU4+SnugOAF2Auo1Uhna
        t04BfY+F6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=bFX
        LzP7odfgzhwpOsXP+gSoRbeehqbLqd2dMUzk6PxePkUuF9F8Dj7nkRNbfL/w/9dA
        SPZkcE989nbXULkOIdWHPkJoLVuaUPsdiFhNd+2bNrHpUEzLWXI8Zax2ZIAwJ7LY
        4TnP1lAZ+Vnmr9ykUF5dO8aXRNm6zfjgw57TBHb0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46B1D493D9;
        Mon, 24 Oct 2016 19:10:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 94B5E493D8;
        Mon, 24 Oct 2016 19:10:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] reset: --unmerge
Date:   Mon, 24 Oct 2016 16:10:11 -0700
Message-ID: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04D7B37C-9A3F-11E6-A5C8-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The procedure to resolve a merge conflict typically goes like this:

 - first open the file in the editor, and with the help of conflict
   markers come up with a resolution.

 - save the file.

 - look at the output from "git diff" to see the combined diff to
   double check if the resolution makes sense.

 - perform other tests, like trying to build the result with "make".

 - finally "git add file" to mark that you are done.

and repeating the above until you are done with all the conflicted
paths.  If you, for whatever reason, accidentally "git add file" by
mistake until you are convinced that you resolved it correctly (e.g.
doing "git add file" immediately after saving, without a chance to
peruse the output from "git diff"), there is no good way to recover.
There is "git checkout -m file" but that overwrites the working tree
file to reproduce the conflicted state, which is not exactly what
you want.  You only want to reproduce the conflicted state in the
index, so that you can inspect the (proposed) merge resolution you
already have in your working tree.

Add "git reset --unmerge <paths>" command that does just that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Not thought through thoroughly yet about details, such as "should
   it always require at least one pathspec?".

 builtin/reset.c           |  8 +++++++-
 t/t7107-reset-unmerged.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 9020ec66c8..3aa9e0b34a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -21,6 +21,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "resolve-undo.h"
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
@@ -272,6 +273,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
+	int unmerge = 0;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_SET_INT(0, "mixed", &reset_type,
@@ -286,6 +288,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
+		OPT_BOOL(0, "unmerge", &unmerge,
+			 N_("recover conflicted stages from an earlier 'git add'")),
 		OPT_END()
 	};
 
@@ -357,7 +361,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		hold_locked_index(lock, 1);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			if (read_from_tree(&pathspec, oid.hash, intent_to_add))
+			if (unmerge)
+				unmerge_cache(&pathspec);
+			else if (read_from_tree(&pathspec, oid.hash, intent_to_add))
 				return 1;
 			if (get_git_work_tree())
 				refresh_index(&the_index, flags, NULL, NULL,
diff --git a/t/t7107-reset-unmerged.sh b/t/t7107-reset-unmerged.sh
new file mode 100755
index 0000000000..57b2e27150
--- /dev/null
+++ b/t/t7107-reset-unmerged.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='git reset with paths'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo one >file &&
+	git add file &&
+	git commit -m "one" &&
+	git tag initial &&
+
+	echo two >file &&
+	git commit -a -m "two" &&
+
+	git checkout -b side initial &&
+	echo three >file &&
+	git commit -a -m "three"
+'
+
+test_expect_success "cause conflict, resolve, and unresolve" '
+	git reset --hard &&
+	git checkout master &&
+	test_must_fail git merge side &&
+
+	git ls-files -u >expect &&
+
+	echo four >file &&
+	git add file &&
+
+	git reset --unmerge -- file &&
+	git ls-files -u >actual &&
+	test_cmp expect actual
+'
+
+test_done
