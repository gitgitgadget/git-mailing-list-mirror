Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A4EC433E6
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B3222DBF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAWTyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:54:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54198 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbhAWTya (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:54:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A76D117948;
        Sat, 23 Jan 2021 14:53:43 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=y5mZYQwZLoeAPHuTuvBcS8n+9
        wE=; b=vRGR+Zt02M2zHKKAoMljiBZQ3HmUxmrGMekJBgPajpEPbqTOylXOIUP6t
        6aF6J0ux2Bb6ugd473/5vYeulYvzXO2HWC+zY3CxzCE0Z+N03zStVrY0GEqQIJtV
        WbGXzf9b1vkHDv/41ODLLUBpCc8C9Vnre7IEIlInCc4H99mZ3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=xEcZoxj6WGhDyZyrtKw
        +q3s7V9BOBK/woyKo0ZWxP2kSl4jxdjmjd++4gcf4AQSRHYBDewtFM/5P5O7GNO6
        94tolwXTPC+j305dg3yeyQcdkbG00BfMQnmOw7Ck4a+XyrHhHlVtZvrdLbENV1z3
        y/EKw2kwPoSdbeTdanqipCUw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 024C2117947;
        Sat, 23 Jan 2021 14:53:43 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 425D9117943;
        Sat, 23 Jan 2021 14:53:40 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     gitgitgadget@gmail.com, ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH v7 3/3] ls-files.c: add --deduplicate option
Date:   Sat, 23 Jan 2021 11:53:34 -0800
Message-Id: <20210123195334.2970374-3-gitster@pobox.com>
X-Mailer: git-send-email 2.30.0-491-g302c625a7b
In-Reply-To: <20210123195334.2970374-1-gitster@pobox.com>
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
 <20210123195334.2970374-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: B0932C7C-5DB4-11EB-A638-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

During a merge conflict, the name of a file may appear multiple
times in "git ls-files" output, once for each stage.  If you use
both `--delete` and `--modify` at the same time, the output may
mention a deleted file twice.

When none of the '-t', '-u', or '-s' options is in use, these
duplicate entries do not add much value to the output.

Introduce a new '--deduplicate' option to suppress them.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
[jc: extended doc and rewritten commit log]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-files.txt |  8 +++++
 builtin/ls-files.c             | 31 ++++++++++++++--
 t/t3012-ls-files-dedup.sh      | 66 ++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 3 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.=
txt
index 0a3b5265b3..6d11ab506b 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
 		(-[c|d|o|i|s|u|k|m])*
 		[--eol]
+		[--deduplicate]
 		[-x <pattern>|--exclude=3D<pattern>]
 		[-X <file>|--exclude-from=3D<file>]
 		[--exclude-per-directory=3D<file>]
@@ -80,6 +81,13 @@ OPTIONS
 	\0 line termination on output and do not quote filenames.
 	See OUTPUT below for more information.
=20
+--deduplicate::
+	When only filenames are shown, suppress duplicates that may
+	come from having multiple stages during a merge, or giving
+	`--deleted` and `--modified` option at the same time.
+	When any of the `-t`, `--unmerged`, or `--stage` option is
+	in use, this option has no effect.
+
 -x <pattern>::
 --exclude=3D<pattern>::
 	Skip untracked files matching pattern.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e94d724aff..f6f9e483b2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int line_terminator =3D '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
+static int skipping_duplicates;
=20
 static const char *prefix;
 static int max_prefix_len;
@@ -328,11 +329,14 @@ static void show_files(struct repository *repo, str=
uct dir_struct *dir)
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
 		if ((show_cached || show_stage) &&
-		    (!show_unmerged || ce_stage(ce)))
+		    (!show_unmerged || ce_stage(ce))) {
 			show_ce(repo, dir, ce, fullname.buf,
 				ce_stage(ce) ? tag_unmerged :
 				(ce_skip_worktree(ce) ? tag_skip_worktree :
 				 tag_cached));
+			if (skipping_duplicates)
+				goto skip_to_next_name;
+		}
=20
 		if (!(show_deleted || show_modified))
 			continue;
@@ -341,11 +345,28 @@ static void show_files(struct repository *repo, str=
uct dir_struct *dir)
 		stat_err =3D lstat(fullname.buf, &st);
 		if (stat_err && (errno !=3D ENOENT && errno !=3D ENOTDIR))
 			error_errno("cannot lstat '%s'", fullname.buf);
-		if (stat_err && show_deleted)
+		if (stat_err && show_deleted) {
 			show_ce(repo, dir, ce, fullname.buf, tag_removed);
+			if (skipping_duplicates)
+				goto skip_to_next_name;
+		}
 		if (show_modified &&
-		    (stat_err || ie_modified(repo->index, ce, &st, 0)))
+		    (stat_err || ie_modified(repo->index, ce, &st, 0))) {
 			show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			if (skipping_duplicates)
+				goto skip_to_next_name;
+		}
+		continue;
+
+skip_to_next_name:
+		{
+			int j;
+			struct cache_entry **cache =3D repo->index->cache;
+			for (j =3D i + 1; j < repo->index->cache_nr; j++)
+				if (strcmp(ce->name, cache[j]->name))
+					break;
+			i =3D j - 1; /* compensate for the for loop */
+		}
 	}
=20
 	strbuf_release(&fullname);
@@ -572,6 +593,8 @@ int cmd_ls_files(int argc, const char **argv, const c=
har *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_BOOL(0, "deduplicate", &skipping_duplicates,
+			 N_("suppress duplicate entries")),
 		OPT_END()
 	};
=20
@@ -611,6 +634,8 @@ int cmd_ls_files(int argc, const char **argv, const c=
har *cmd_prefix)
 		 * you also show the stage information.
 		 */
 		show_stage =3D 1;
+	if (show_tag || show_stage)
+		skipping_duplicates =3D 0;
 	if (dir.exclude_per_dir)
 		exc_given =3D 1;
=20
diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
new file mode 100755
index 0000000000..2682b1f43a
--- /dev/null
+++ b/t/t3012-ls-files-dedup.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description=3D'git ls-files --deduplicate test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	>a.txt &&
+	>b.txt &&
+	>delete.txt &&
+	git add a.txt b.txt delete.txt &&
+	git commit -m base &&
+	echo a >a.txt &&
+	echo b >b.txt &&
+	echo delete >delete.txt &&
+	git add a.txt b.txt delete.txt &&
+	git commit -m tip &&
+	git tag tip &&
+	git reset --hard HEAD^ &&
+	echo change >a.txt &&
+	git commit -a -m side &&
+	git tag side
+'
+
+test_expect_success 'git ls-files --deduplicate to show unique unmerged =
path' '
+	test_must_fail git merge tip &&
+	git ls-files --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	a.txt
+	b.txt
+	delete.txt
+	EOF
+	test_cmp expect actual &&
+	git merge --abort
+'
+
+test_expect_success 'git ls-files -d -m --deduplicate with different dis=
play options' '
+	git reset --hard side &&
+	test_must_fail git merge tip &&
+	rm delete.txt &&
+	git ls-files -d -m --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	a.txt
+	delete.txt
+	EOF
+	test_cmp expect actual &&
+	git ls-files -d -m -t --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	C a.txt
+	C a.txt
+	C a.txt
+	R delete.txt
+	C delete.txt
+	EOF
+	test_cmp expect actual &&
+	git ls-files -d -m -c --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	a.txt
+	b.txt
+	delete.txt
+	EOF
+	test_cmp expect actual &&
+	git merge --abort
+'
+
+test_done
--=20
2.30.0-491-g302c625a7b

