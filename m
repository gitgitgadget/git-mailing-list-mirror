Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1362A20248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCNPJh (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:09:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54271 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCNPJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:09:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 426E25C5A8;
        Thu, 14 Mar 2019 11:03:11 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=74xv6UM0j2BZnrv2w9q/wnYO5
        bw=; b=HdYKahxd8s4/63MjWU7/Og8bc/aobEsOrtHZjlpe+rFJH0ysKuoQwPsc+
        8j1afMsAZWxsFNxrvYPfeCC8ql7VUrY4JRH+UrekYxMI1JgXAItTS4qOpyHMjiUi
        v1HsYV++bT8+WJfy+neajk/Czx96XvKJzR6jp8YdIVgVe1Veg8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B2C65C5A7;
        Thu, 14 Mar 2019 11:03:11 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=9N75kEzyWaWhMWYHfD6WhxOj/85mJoxLTWMSyfxupD0=; b=GbsWU+lctdGwHcmI4fYeq2PMwsmKgoGT2WimfX+CKIUUMDy4IvNwW7O3z8UfAxR8laOwKOHjoYZAb/quL4jhizuIlayRpNP7J4HVHTWuGKagAx0uch051eT3zeyVzTgWn+xNd/Qh5UxizUpelKyCCs2MEp9yw8MGdqOBU0egfoE=
Received: from hylob.dartmouth.edu (unknown [129.170.31.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 730E55C5A2;
        Thu, 14 Mar 2019 11:03:07 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     debian@onerussian.com, Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH 4/4] dir: do not traverse repositories with no commits
Date:   Thu, 14 Mar 2019 11:02:19 -0400
Message-Id: <20190314150219.2040-5-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314150219.2040-1-kyle@kyleam.com>
References: <20190314150219.2040-1-kyle@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4739A156-466A-11E9-9209-D01F9763A999-24757444!pb-smtp20.pobox.com
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

For the unusual case where a repository doesn't have any commits,
resolve_gitlink_ref() returns -1 because HEAD cannot be resolved, and
the directory is treated as a normal directory (i.e. traversal does
not stop at the repository boundary).  The status and ls-files
commands above list untracked files within the repository rather than
showing only the top-level directory.

The above case is a corner case in an already unusual situation of the
working tree containing a repository that is not a tracked submodule,
but we might as well treat anything that looks like a repository
consistently.  Loosen the "looks like a repository" criteria in
treat_directory() by replacing resolve_gitlink_ref() with
is_nonbare_repository_dir(), one of the checks that is performed
downstream when resolve_gitlink_ref() is called with an empty
repository.

As the required update to t3700-add shows, being looser with the check
means that we're stricter when adding empty repositories to the index:

  % git add repo
  warning: adding embedded git repository: repo
  hint: You've added another git repository inside your current repositor=
y.
  hint: [...]
  error: unable to index file 'repo/'
  fatal: adding files failed

That error message isn't particularly helpful in this situation, but
it seems preferable to the old behavior of adding the repository's
untracked files.  And if the caller really wants the previous
behavior, they can get it by adding a trailing slash.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 dir.c                                   |  6 ++++--
 t/t3009-ls-files-others-nonsubmodule.sh | 22 +++++++++++++++++++++-
 t/t3700-add.sh                          |  1 +
 3 files changed, 26 insertions(+), 3 deletions(-)

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
index 9ed75928aa..be4e7e26bc 100755
--- a/t/t3009-ls-files-others-nonsubmodule.sh
+++ b/t/t3009-ls-files-others-nonsubmodule.sh
@@ -8,6 +8,14 @@ This test runs git ls-files --others with the following =
working tree:
       directory with no files aside from a bogus .git file
     repo-bogus-untracked-file/
       directory with a bogus .git file and another untracked file
+    repo-no-commit-no-files/
+      git repository without a commit or a file
+    repo-no-commit-untracked-file/
+      git repository without a commit but with an untracked file
+    repo-with-commit-no-files/
+      git repository with a commit and no untracked files
+    repo-with-commit-untracked-file/
+      git repository with a commit and an untracked file
 '
=20
 . ./test-lib.sh
@@ -17,6 +25,10 @@ test_expect_success 'setup: expected output' '
 	expected
 	output
 	repo-bogus-untracked-file/untracked
+	repo-no-commit-no-files/
+	repo-no-commit-untracked-file/
+	repo-with-commit-no-files/
+	repo-with-commit-untracked-file/
 	EOF
 '
=20
@@ -25,7 +37,15 @@ test_expect_success 'setup: directories' '
 	echo foo >repo-bogus-no-files/.git &&
 	mkdir repo-bogus-untracked-file &&
 	echo foo >repo-bogus-untracked-file/.git &&
-	: >repo-bogus-untracked-file/untracked
+	: >repo-bogus-untracked-file/untracked &&
+	git init repo-no-commit-no-files &&
+	git init repo-no-commit-untracked-file &&
+	: >repo-no-commit-untracked-file/untracked &&
+	git init repo-with-commit-no-files &&
+	git -C repo-with-commit-no-files commit --allow-empty -mmsg &&
+	git init repo-with-commit-untracked-file &&
+	test_commit -C repo-with-commit-untracked-file msg &&
+	: >repo-with-commit-untracked-file/untracked
 '
=20
 test_expect_success 'ls-files --others handles non-submodule .git' '
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

