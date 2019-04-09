Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D17120248
	for <e@80x24.org>; Tue,  9 Apr 2019 23:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDIXIH (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 19:08:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50362 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDIXIH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 19:08:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F39B52A01;
        Tue,  9 Apr 2019 19:07:55 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=CHaPkeTwr30ehKDXedRU7HMOI2s=; b=LcnsyBUlaXaSig81AfIn
        K5ZmtNImYh/GmJkkdOhYbGnvyIgFaDBFBVKH88fcQZgfZU7n5h/0/n8xDVWZju0A
        0aomuv5Csz4gtEb2jOPfR3qepkLDLMQlpnUr5cxuuIEfLWIFAOT9OtqIO65mIJJo
        FLwytFGe6nrtG7mRRhWVYQM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1734552A00;
        Tue,  9 Apr 2019 19:07:55 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=mesmtp; bh=FWMjmk9ppppbrr0wFYCggyJXkx0zwcW50vIABTciqso=;
 b=ObR4x0NNRTIle0Eyr8klfR+xwr/ozFwGdKJU4X/PXGYkheXs2wD0cXY+60V2Y/41q7g2rPuwUb9L2WYAv8yE57TC5v7YCKFm8l/e6KN0ZaSQt77K6pJ8meOVEisYZv9lJcFbv6cKsv3ZHtbeLgAKyNanJ1iXhgCj8BFlw+fUT0k=
Received: from hylob.dartmouth.edu (unknown [129.170.31.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B618529FA;
        Tue,  9 Apr 2019 19:07:52 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, debian@onerussian.com,
        Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH v3 0/3] dir: treat a repository without commits as a repository
Date:   Tue,  9 Apr 2019 19:07:34 -0400
Message-Id: <20190409230737.26809-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Pobox-Relay-ID: 4D392114-5B1C-11E9-8A42-EE24A11ADF13-24757444!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of <20190402183505.31512-1-kyle@kyleam.com>.  Thanks,
Junio, for your comments on v2.

The series improves the handling of sub-repositories that don't have a
commit checked out.  In particular, it addresses the following issues:

  * Calling 'git add repo' is meant to register the repository as a
    submodule, but, for a sub-repository that doesn't have a commit
    checked out, it is at best a no-op.  If the sub-repository has any
    untracked files, they are added as blobs in the top-level
    repository.

    Instead error in this situation.

  * 'git submodule add' calls 'git add' on a sub-repository, so it has
    the same issues as above.  Plus it modifies .gitmodules even
    though there is no sub-project OID to register.

    Instead error in this situation.

  * Commands like 'ls-files -o' and 'status -uall' usually stop
    traversing at sub-repository boundaries, but they don't if the
    sub-repository doesn't have a commit checked out.

    Instead stop traversing at a sub-repository even if it doesn't
    have a commit checked out.

Main changes from v2:

  * Leave be the "non-submodule .git" test from
    t3000-ls-files-others.sh rather than confusingly using it as the
    basis for the new t3009-ls-files-others-nonsubmodule.sh
    (<87d0m2bui0.fsf@kyleam.com>).

  * Drop unneeded setup function in test (<87d0m2bui0.fsf@kyleam.com>).

  * Provide appropriate output for the 'git add repo-no-commits'
    failure (<87bm1mbua4.fsf@kyleam.com>).

Other changes from v2:

  * Commit message tweaks.  These include replacing wording like "no
    commits" with something like "no commit checked out" because,
    technically, this series also concerns repositories that have
    commit objects but are on an unborn branch.

  * Change the "git submodule add" error message to match the wording
    of the new error message added in add_to_index().

  * Consistently use "expect" rather than "expected" as the output
    file name for expected test output.


Kyle Meyer (3):
  submodule: refuse to add repository with no commits
  dir: do not traverse repositories with no commits
  add: error appropriately on repository with no commits

 builtin/add.c                           |  3 +-
 dir.c                                   |  6 ++-
 git-submodule.sh                        |  7 ++++
 read-cache.c                            |  3 ++
 t/t3009-ls-files-others-nonsubmodule.sh | 50 +++++++++++++++++++++++++
 t/t3700-add.sh                          | 12 ++++++
 t/t7400-submodule-basic.sh              | 11 +++++-
 7 files changed, 88 insertions(+), 4 deletions(-)
 create mode 100755 t/t3009-ls-files-others-nonsubmodule.sh

Range-diff against v2:
1:  b080e2c557 ! 1:  ad1b0b44e8 submodule: refuse to add repository with =
no commits
    @@ -4,14 +4,16 @@
    =20
         When the path given to 'git submodule add' is an existing reposi=
tory
         that is not in the index, the repository is passed to 'git add'.=
  If
    -    this repository doesn't have any commits, we don't get a useful
    -    result: there is no subproject OID to track, and any untracked f=
iles
    -    in the sub-repository are added to the current repository.
    +    this repository doesn't have a commit checked out, we don't get =
a
    +    useful result: there is no subproject OID to track, and any untr=
acked
    +    files in the sub-repository are added as blobs in the top-level
    +    repository.
    =20
    -    Detect if the path is a repository with no commits and abort to =
avoid
    -    getting into this state.  Note that this check must come before =
the
    -    'git add --dry-run' check because an upcoming commit will make '=
git
    -    add' fail in this situation.
    +    To avoid getting into this state, abort if the path is a reposit=
ory
    +    that doesn't have a commit checked out.  Note that this check mu=
st
    +    come before the 'git add --dry-run' check because the next commi=
t will
    +    make 'git add' fail when given a repository that doesn't have a =
commit
    +    checked out.
    =20
         Signed-off-by: Kyle Meyer <kyle@kyleam.com>
    =20
    @@ -26,7 +28,7 @@
     +		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
     +	then
     +	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
    -+	    die "$(eval_gettext "'\$sm_path' does not have any commits")"
    ++	    die "$(eval_gettext "'\$sm_path' does not have a commit checke=
d out")"
     +	fi
     +
      	if test -z "$force" &&
    @@ -41,12 +43,12 @@
      '
     =20
     +test_expect_success 'add aborts on repository with no commits' '
    -+	cat >expected <<-\EOF &&
    -+	'"'repo-no-commits'"' does not have any commits
    ++	cat >expect <<-\EOF &&
    ++	'"'repo-no-commits'"' does not have a commit checked out
     +	EOF
     +	git init repo-no-commits &&
     +	test_must_fail git submodule add ../a ./repo-no-commits 2>actual &=
&
    -+	test_i18ncmp expected actual
    ++	test_i18ncmp expect actual
     +'
     +
      test_expect_success 'setup - repository in init subdirectory' '
2:  c027701842 < -:  ---------- t3000: move non-submodule repo test to se=
parate file
3:  97f53e30c0 < -:  ---------- t3009: test that ls-files -o traverses bo=
gus repo
4:  a926b87102 ! 2:  1bf762bbd3 dir: do not traverse repositories with no=
 commits
    @@ -9,12 +9,15 @@
         will show only the directory, even when there are untracked file=
s
         within the directory.
    =20
    -    For the unusual case where a repository doesn't have any commits=
,
    -    resolve_gitlink_ref() returns -1 because HEAD cannot be resolved=
, and
    -    the directory is treated as a normal directory (i.e. traversal d=
oes
    -    not stop at the repository boundary).  The status and ls-files
    +    For the unusual case where a repository doesn't have a commit ch=
ecked
    +    out, resolve_gitlink_ref() returns -1 because HEAD cannot be res=
olved,
    +    and the directory is treated as a normal directory (i.e. travers=
al
    +    does not stop at the repository boundary).  The status and ls-fi=
les
         commands above list untracked files within the repository rather=
 than
    -    showing only the top-level directory.
    +    showing only the top-level directory.  And if 'git add' is calle=
d on a
    +    repository with no commit checked out, any untracked files under=
 the
    +    repository are added as blobs in the top-level project, a behavi=
or
    +    that is unlikely to be what the caller intended.
    =20
         The above case is a corner case in an already unusual situation =
of the
         working tree containing a repository that is not a tracked submo=
dule,
    @@ -22,23 +25,12 @@
         consistently.  Loosen the "looks like a repository" criteria in
         treat_directory() by replacing resolve_gitlink_ref() with
         is_nonbare_repository_dir(), one of the checks that is performed
    -    downstream when resolve_gitlink_ref() is called with an empty
    -    repository.
    +    downstream when resolve_gitlink_ref() is called.
    =20
    -    As the required update to t3700-add shows, being looser with the=
 check
    -    means that we're stricter when adding empty repositories to the =
index:
    -
    -      % git add repo
    -      warning: adding embedded git repository: repo
    -      hint: You've added another git repository inside your current =
repository.
    -      hint: [...]
    -      error: unable to index file 'repo/'
    -      fatal: adding files failed
    -
    -    That error message isn't particularly helpful in this situation,=
 but
    -    it seems preferable to the old behavior of adding the repository=
's
    -    untracked files.  And if the caller really wants the previous
    -    behavior, they can get it by adding a trailing slash.
    +    As the required update to t3700-add shows, calling 'git add' on =
a
    +    repository with no commit checked out will now raise an error.  =
While
    +    this is the desired behavior, note that the output isn't yet
    +    appropriate.  The next commit will improve this output.
    =20
         Signed-off-by: Kyle Meyer <kyle@kyleam.com>
    =20
    @@ -61,12 +53,20 @@
      	}
    =20
      diff --git a/t/t3009-ls-files-others-nonsubmodule.sh b/t/t3009-ls-f=
iles-others-nonsubmodule.sh
    - --- a/t/t3009-ls-files-others-nonsubmodule.sh
    + new file mode 100755
    + --- /dev/null
      +++ b/t/t3009-ls-files-others-nonsubmodule.sh
     @@
    -       directory with no files aside from a bogus .git file
    -     repo-bogus-untracked-file/
    -       directory with a bogus .git file and another untracked file
    ++#!/bin/sh
    ++
    ++test_description=3D'test git ls-files --others with non-submodule r=
epositories
    ++
    ++This test runs git ls-files --others with the following working tre=
e:
    ++
    ++    nonrepo-no-files/
    ++      plain directory with no files
    ++    nonrepo-untracked-file/
    ++      plain directory with an untracked file
     +    repo-no-commit-no-files/
     +      git repository without a commit or a file
     +    repo-no-commit-untracked-file/
    @@ -75,26 +75,14 @@
     +      git repository with a commit and no untracked files
     +    repo-with-commit-untracked-file/
     +      git repository with a commit and an untracked file
    - '
    -=20
    - . ./test-lib.sh
    -@@
    - 	expected
    - 	output
    - 	repo-bogus-untracked-file/untracked
    -+	repo-no-commit-no-files/
    -+	repo-no-commit-untracked-file/
    -+	repo-with-commit-no-files/
    -+	repo-with-commit-untracked-file/
    - 	EOF
    - '
    -=20
    -@@
    - 	echo foo >repo-bogus-no-files/.git &&
    - 	mkdir repo-bogus-untracked-file &&
    - 	echo foo >repo-bogus-untracked-file/.git &&
    --	: >repo-bogus-untracked-file/untracked
    -+	: >repo-bogus-untracked-file/untracked &&
    ++'
    ++
    ++. ./test-lib.sh
    ++
    ++test_expect_success 'setup: directories' '
    ++	mkdir nonrepo-no-files/ &&
    ++	mkdir nonrepo-untracked-file &&
    ++	: >nonrepo-untracked-file/untracked &&
     +	git init repo-no-commit-no-files &&
     +	git init repo-no-commit-untracked-file &&
     +	: >repo-no-commit-untracked-file/untracked &&
    @@ -103,9 +91,22 @@
     +	git init repo-with-commit-untracked-file &&
     +	test_commit -C repo-with-commit-untracked-file msg &&
     +	: >repo-with-commit-untracked-file/untracked
    - '
    -=20
    - test_expect_success 'ls-files --others handles non-submodule .git' =
'
    ++'
    ++
    ++test_expect_success 'ls-files --others handles untracked git reposi=
tories' '
    ++	git ls-files -o >output &&
    ++	cat >expect <<-EOF &&
    ++	nonrepo-untracked-file/untracked
    ++	output
    ++	repo-no-commit-no-files/
    ++	repo-no-commit-untracked-file/
    ++	repo-with-commit-no-files/
    ++	repo-with-commit-untracked-file/
    ++	EOF
    ++	test_cmp expect output
    ++'
    ++
    ++test_done
    =20
      diff --git a/t/t3700-add.sh b/t/t3700-add.sh
      --- a/t/t3700-add.sh
-:  ---------- > 3:  a2f9af5448 add: error appropriately on repository wi=
th no commits
--=20
2.21.0

