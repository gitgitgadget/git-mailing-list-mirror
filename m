Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62EEF20248
	for <e@80x24.org>; Tue,  9 Apr 2019 23:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDIXIJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 19:08:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59877 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDIXIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 19:08:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E44E52A10;
        Tue,  9 Apr 2019 19:08:01 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=B444AfZYNjWiWWu3SXcFZOvbT
        Wg=; b=sQOFAfckcL8aPW+1+OGxma3HHJnIsob5fbQBhUKZLhOPGp420jTZ7MlvR
        R/cHzXNG+3VRelSY0XYHcUZVW9FgkYKdwdNmfEKTv54HhGnkX6N5l5eEOWdKgy7d
        JsvZ+b975ulMwgJQ+z4mSsH2c5ugNqZLRfp6Q7cLEYOaOCxAnE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7782C52A0F;
        Tue,  9 Apr 2019 19:08:01 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=L2Cl4ihWgtsRKFb0Np7XaJqmCZUBwT7qT3nrHa1Yr1Y=; b=nZ+IGVOqL72lPQretIN/RjMxwM29ta95gnbpFTItMVDu75udHuney7X/l0q6HrNMalodV4608ES874TirMOxWAqnHyGRpHfXG0dsrYpxdXcqsc27Ennlh1ufs9r4b17xnF7XABk6pG3/uYLXsF3uodhxqiMCQZSYLHI2EbaFcVs=
Received: from hylob.dartmouth.edu (unknown [129.170.31.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88A6152A03;
        Tue,  9 Apr 2019 19:07:57 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, debian@onerussian.com,
        Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH v3 2/3] dir: do not traverse repositories with no commits
Date:   Tue,  9 Apr 2019 19:07:36 -0400
Message-Id: <20190409230737.26809-3-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409230737.26809-1-kyle@kyleam.com>
References: <20190409230737.26809-1-kyle@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 51107A26-5B1C-11E9-A248-EE24A11ADF13-24757444!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When treat_directory() encounters a directory that is not in the index
and DIR_NO_GITLINKS is unset, it calls resolve_gitlink_ref() to decide
if a directory looks like a repository, in which case the directory
won't be traversed.  As a result, 'status -uall' and 'ls-files -o'
will show only the directory, even when there are untracked files
within the directory.

For the unusual case where a repository doesn't have a commit checked
out, resolve_gitlink_ref() returns -1 because HEAD cannot be resolved,
and the directory is treated as a normal directory (i.e. traversal
does not stop at the repository boundary).  The status and ls-files
commands above list untracked files within the repository rather than
showing only the top-level directory.  And if 'git add' is called on a
repository with no commit checked out, any untracked files under the
repository are added as blobs in the top-level project, a behavior
that is unlikely to be what the caller intended.

The above case is a corner case in an already unusual situation of the
working tree containing a repository that is not a tracked submodule,
but we might as well treat anything that looks like a repository
consistently.  Loosen the "looks like a repository" criteria in
treat_directory() by replacing resolve_gitlink_ref() with
is_nonbare_repository_dir(), one of the checks that is performed
downstream when resolve_gitlink_ref() is called.

As the required update to t3700-add shows, calling 'git add' on a
repository with no commit checked out will now raise an error.  While
this is the desired behavior, note that the output isn't yet
appropriate.  The next commit will improve this output.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 dir.c                                   |  6 ++-
 t/t3009-ls-files-others-nonsubmodule.sh | 50 +++++++++++++++++++++++++
 t/t3700-add.sh                          |  1 +
 3 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100755 t/t3009-ls-files-others-nonsubmodule.sh

diff --git a/dir.c b/dir.c
index b2cabadf25..a4e59eb351 100644
--- a/dir.c
+++ b/dir.c
@@ -1467,9 +1467,11 @@ static enum path_treatment treat_directory(struct =
dir_struct *dir,
 			return path_none;
 		}
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
-			struct object_id oid;
-			if (resolve_gitlink_ref(dirname, "HEAD", &oid) =3D=3D 0)
+			struct strbuf sb =3D STRBUF_INIT;
+			strbuf_addstr(&sb, dirname);
+			if (is_nonbare_repository_dir(&sb))
 				return exclude ? path_excluded : path_untracked;
+			strbuf_release(&sb);
 		}
 		return path_recurse;
 	}
diff --git a/t/t3009-ls-files-others-nonsubmodule.sh b/t/t3009-ls-files-o=
thers-nonsubmodule.sh
new file mode 100755
index 0000000000..963f3462b7
--- /dev/null
+++ b/t/t3009-ls-files-others-nonsubmodule.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description=3D'test git ls-files --others with non-submodule reposi=
tories
+
+This test runs git ls-files --others with the following working tree:
+
+    nonrepo-no-files/
+      plain directory with no files
+    nonrepo-untracked-file/
+      plain directory with an untracked file
+    repo-no-commit-no-files/
+      git repository without a commit or a file
+    repo-no-commit-untracked-file/
+      git repository without a commit but with an untracked file
+    repo-with-commit-no-files/
+      git repository with a commit and no untracked files
+    repo-with-commit-untracked-file/
+      git repository with a commit and an untracked file
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: directories' '
+	mkdir nonrepo-no-files/ &&
+	mkdir nonrepo-untracked-file &&
+	: >nonrepo-untracked-file/untracked &&
+	git init repo-no-commit-no-files &&
+	git init repo-no-commit-untracked-file &&
+	: >repo-no-commit-untracked-file/untracked &&
+	git init repo-with-commit-no-files &&
+	git -C repo-with-commit-no-files commit --allow-empty -mmsg &&
+	git init repo-with-commit-untracked-file &&
+	test_commit -C repo-with-commit-untracked-file msg &&
+	: >repo-with-commit-untracked-file/untracked
+'
+
+test_expect_success 'ls-files --others handles untracked git repositorie=
s' '
+	git ls-files -o >output &&
+	cat >expect <<-EOF &&
+	nonrepo-untracked-file/untracked
+	output
+	repo-no-commit-no-files/
+	repo-no-commit-untracked-file/
+	repo-with-commit-no-files/
+	repo-with-commit-untracked-file/
+	EOF
+	test_cmp expect output
+'
+
+test_done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index be582a513b..5a8425962b 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -396,6 +396,7 @@ test_expect_success 'no file status change if no path=
spec is given in subdir' '
 '
=20
 test_expect_success 'all statuses changed in folder if . is given' '
+	rm -fr empty &&
 	git add --chmod=3D+x . &&
 	test $(git ls-files --stage | grep ^100644 | wc -l) -eq 0 &&
 	git add --chmod=3D-x . &&
--=20
2.21.0

