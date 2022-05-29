Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01AAC433EF
	for <git@archiver.kernel.org>; Sun, 29 May 2022 22:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiE2Wj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 May 2022 18:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiE2Wj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 May 2022 18:39:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8815A15C
        for <git@vger.kernel.org>; Sun, 29 May 2022 15:39:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2979C1216AE;
        Sun, 29 May 2022 18:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=avh4T1fSbQo4QnvLmNw07A+AnpmrpD8iZTfxZ2
        3Ycx4=; b=sIeL9QFV2eQyinYsls65tpvGfQ01cOVxCooOzGZ0mWebFrV/sBjZMz
        erSuyUxmupXARbivmkwABILA6hfV5HLZtisizvZaFfOjCIRV5KqYg+/J5kdIritx
        5ttY32+j9R2Glf7AO/U1iz8CwCbzSSJb/w+k+hyQedUEhrGIO2VrI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2133B1216AD;
        Sun, 29 May 2022 18:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79A8C1216AC;
        Sun, 29 May 2022 18:39:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Robert Dailey <rcdailey.lists@gmail.com>
Subject: [PATCH] pathspec: correct an empty string used as a pathspec element
References: <CAHd499D81VN=aGsM6kaNLF2ZMg-Zg10U=qU-j7gQ7uXnqqfdqg@mail.gmail.com>
        <xmqqh758yz4u.fsf@gitster.g> <xmqq8rqkyyc2.fsf@gitster.g>
Date:   Sun, 29 May 2022 15:39:51 -0700
In-Reply-To: <xmqq8rqkyyc2.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        29 May 2022 11:42:53 -0700")
Message-ID: <xmqqpmjwx8so.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 414F83DC-DFA0-11EC-A6D6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pathspecs with only negative elements did not work with some
commands that pass the pathspec along to a subprocess.  For
instance,

    $ git add -p -- ':!*.txt'

should add everything except for paths ending in ".txt", but it gets
complaint from underlying "diff-index" and aborts.

We used to error out when a pathspec with only negative elements in
it, like the one in the above example.  Later, 859b7f1d (pathspec:
don't error out on all-exclusionary pathspec patterns, 2017-02-07)
updated the logic to add an empty string as an extra element.  The
intention was to let the extra element to match everything and let
the negative ones given by the user to subtract from it.

At around the same time, we were migrating from "an empty string is
a valid pathspec element that matches everything" to "either a dot
or ":/" is used to match all, and an empty string is rejected",
between d426430e (pathspec: warn on empty strings as pathspec,
2016-06-22) and 9e4e8a64 (pathspec: die on empty strings as
pathspec, 2017-06-06).  I think 9e4e8a64, which happened long after
859b7f1d happened, was not careful enough to turn the empty string
859b7f1d added to either a dot or ":/".

A care should be taken as the definition of "everything" depends on
subcommand.  For the purpose of "add -p", adding a "." to add
everything in the current directory is the right thing to do.  But
for some other commands, ":/" (i.e. really really everything, even
things outside the current subdirectory) is the right choice.

We would break commands in a big way if we get this wrong, so add a
handful of test pieces to make sure the resulting code still
excludes the paths that are expected and includes "everything" else.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pathspec.c                  |   2 +-
 t/t6132-pathspec-exclude.sh | 181 ++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index ddeeba7911..84ad9c73cf 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -629,7 +629,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	 */
 	if (nr_exclude == n) {
 		int plen = (!(flags & PATHSPEC_PREFER_CWD)) ? 0 : prefixlen;
-		init_pathspec_item(item + n, 0, prefix, plen, "");
+		init_pathspec_item(item + n, 0, prefix, plen, ".");
 		pathspec->nr++;
 	}
 
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 8ff1d76f79..9fdafeb1e9 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -195,6 +195,7 @@ test_expect_success 'multiple exclusions' '
 '
 
 test_expect_success 't_e_i() exclude case #8' '
+	test_when_finished "rm -fr case8" &&
 	git init case8 &&
 	(
 		cd case8 &&
@@ -244,4 +245,184 @@ test_expect_success 'grep --untracked PATTERN :(exclude)*FILE' '
 	test_cmp expect-grep actual-grep
 '
 
+# Depending on the command, all negative pathspec needs to subtract
+# either from the full tree, or from the current directory.
+#
+# The sample tree checked out at this point has:
+# file
+# sub/file
+# sub/file2
+# sub/sub/file
+# sub/sub/sub/file
+# sub2/file
+#
+# but there may also be some cruft that interferes with "git clean"
+# and "git add" tests.
+
+test_expect_success 'archive with all negative' '
+	git reset --hard &&
+	git clean -f &&
+	git -C sub archive --format=tar HEAD -- ":!sub/" >archive &&
+	"$TAR" tf archive >actual &&
+	cat >expect <<-\EOF &&
+	file
+	file2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add with all negative' '
+	H=$(git rev-parse HEAD) &&
+	git reset --hard $H &&
+	git clean -f &&
+	test_when_finished "git reset --hard $H" &&
+	for path in file sub/file sub/sub/file sub2/file
+	do
+		echo smudge >>"$path" || return 1
+	done &&
+	git -C sub add -- ":!sub/" &&
+	git diff --name-only --no-renames --cached >actual &&
+	cat >expect <<-\EOF &&
+	file
+	sub/file
+	sub2/file
+	EOF
+	test_cmp expect actual &&
+	git diff --name-only --no-renames >actual &&
+	echo sub/sub/file >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add -p with all negative' '
+	H=$(git rev-parse HEAD) &&
+	git reset --hard $H &&
+	git clean -f &&
+	test_when_finished "git reset --hard $H" &&
+	for path in file sub/file sub/sub/file sub2/file
+	do
+		echo smudge >>"$path" || return 1
+	done &&
+	yes | git -C sub add -p -- ":!sub/" &&
+	git diff --name-only --no-renames --cached >actual &&
+	cat >expect <<-\EOF &&
+	file
+	sub/file
+	sub2/file
+	EOF
+	test_cmp expect actual &&
+	git diff --name-only --no-renames >actual &&
+	echo sub/sub/file >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clean with all negative' '
+	H=$(git rev-parse HEAD) &&
+	git reset --hard $H &&
+	test_when_finished "git reset --hard $H && git clean -f" &&
+	git clean -f &&
+	for path in file9 sub/file9 sub/sub/file9 sub2/file9
+	do
+		echo cruft >"$path" || return 1
+	done &&
+	git -C sub clean -f -- ":!sub" &&
+	test_path_is_file file9 &&
+	test_path_is_missing sub/file9 &&
+	test_path_is_file sub/sub/file9 &&
+	test_path_is_file sub2/file9
+'
+
+test_expect_success 'commit with all negative' '
+	H=$(git rev-parse HEAD) &&
+	git reset --hard $H &&
+	test_when_finished "git reset --hard $H" &&
+	for path in file sub/file sub/sub/file sub2/file
+	do
+		echo smudge >>"$path" || return 1
+	done &&
+	git -C sub commit -m sample -- ":!sub/" &&
+	git diff --name-only --no-renames HEAD^ HEAD >actual &&
+	cat >expect <<-\EOF &&
+	file
+	sub/file
+	sub2/file
+	EOF
+	test_cmp expect actual &&
+	git diff --name-only --no-renames HEAD >actual &&
+	echo sub/sub/file >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reset with all negative' '
+	H=$(git rev-parse HEAD) &&
+	git reset --hard $H &&
+	test_when_finished "git reset --hard $H" &&
+	for path in file sub/file sub/sub/file sub2/file
+	do
+		echo smudge >>"$path" &&
+		git add "$path" || return 1
+	done &&
+	git -C sub reset --quiet -- ":!sub/" &&
+	git diff --name-only --no-renames --cached >actual &&
+	echo sub/sub/file >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep with all negative' '
+	H=$(git rev-parse HEAD) &&
+	git reset --hard $H &&
+	test_when_finished "git reset --hard $H" &&
+	for path in file sub/file sub/sub/file sub2/file
+	do
+		echo "needle $path" >>"$path" || return 1
+	done &&
+	git -C sub grep -h needle -- ":!sub/" >actual &&
+	cat >expect <<-\EOF &&
+	needle sub/file
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files with all negative' '
+	git reset --hard &&
+	git -C sub ls-files -- ":!sub/" >actual &&
+	cat >expect <<-\EOF &&
+	file
+	file2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'rm with all negative' '
+	git reset --hard &&
+	test_when_finished "git reset --hard" &&
+	git -C sub rm -r --cached -- ":!sub/" >actual &&
+	git diff --name-only --no-renames --diff-filter=D --cached >actual &&
+	cat >expect <<-\EOF &&
+	sub/file
+	sub/file2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'stash with all negative' '
+	H=$(git rev-parse HEAD) &&
+	git reset --hard $H &&
+	test_when_finished "git reset --hard $H" &&
+	for path in file sub/file sub/sub/file sub2/file
+	do
+		echo smudge >>"$path" || return 1
+	done &&
+	git -C sub stash push -m sample -- ":!sub/" &&
+	git diff --name-only --no-renames HEAD >actual &&
+	echo sub/sub/file >expect &&
+	test_cmp expect actual &&
+	git stash show --name-only >actual &&
+	cat >expect <<-\EOF &&
+	file
+	sub/file
+	sub2/file
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.36.1-385-g60203f3fdb

