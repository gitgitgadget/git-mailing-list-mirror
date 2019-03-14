Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D0E20248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfCNPJh (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:09:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50573 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfCNPJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:09:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA3B35C593;
        Thu, 14 Mar 2019 11:02:58 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=IiqitU/cSz2rA+g36doE+JTave4=; b=T3oooJoolFGyGSE3edoY
        8opGlehQ/teNqjLZdMBMNPfqOZxdUwKb9GWf15VRxeBtcQO8uXbWByy4nJnQqd1y
        Ugmxa3yJNyu6YNLDBI7hJdf/hBfXO7qJS9+3O0GNTL+op/C2lFmmDvXouABrquPN
        PGeIHWk1QMmYeO0nYNUpxBU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C30195C592;
        Thu, 14 Mar 2019 11:02:58 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=mesmtp; bh=gjcLJWQZ+sRlGsye9EcR55Zl8VfXqmmmNikri4KRHCM=;
 b=Lagnbf9zq+kzcAgdG2/RgJvtu5B1BEGPnJntOulsdOztawRAo0mT4tkGBx792EtRzg5Hxruis4MW6V0XZd3az76BjrWxsThXzmu3TH1xEVHy6JgcGL47ygDJcfNTPqt/T5qabB9jA55EJHrrLnuvwsacW77LYAUhwqfWepGdryc=
Received: from hylob.dartmouth.edu (unknown [129.170.31.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 012F85C590;
        Thu, 14 Mar 2019 11:02:55 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     debian@onerussian.com, Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH 0/4] dir: Treat a repository without commits as a repository
Date:   Thu, 14 Mar 2019 11:02:15 -0400
Message-Id: <20190314150219.2040-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Pobox-Relay-ID: 3FCB5C16-466A-11E9-A85A-D01F9763A999-24757444!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the working tree contains a repository with no commits, it's
treated as an empty directory, not a repository:

    $ git init
    $ git init no-commit && touch no-commit/untracked
    $ git init with-commit && touch with-commit/untracked
    $ git -C with-commit commit --allow-empty -mmsg
    $ git ls-files -o
    no-commit/untracked
    with-commit/

That's admittedly a weird case that is unlikely to happen in the wild,
and indeed I didn't observe it in the wild.  In DataLad, we rely on
`ls-files -o` to stop at the boundary of a submodule (like it does
with "with-commit" above), and we noticed the "repository with no
commit" exception on a minimal snippet that was meant for debugging
another issue [*].

This series makes the "is repository?" check in treat_directory() use
is_nonbare_repository_dir() instead of resolve_gitlink_ref() so that a
repository without any commits is treated like a repository rather
than an empty directory.  This makes the reporting from commands like
ls-files consistent for the case shown above, and it also avoids the
case where 'git add no-commit' (no trailing slash) adds the untracked
files of the no-commit/ repository to the index of the current
repository.

[*]: https://github.com/datalad/datalad/issues/3139#issuecomment-46054264=
7

Kyle Meyer (4):
  submodule: refuse to add repository with no commits
  t3000: move non-submodule repo test to separate file
  t3009: test that ls-files -o traverses bogus repo
  dir: do not traverse repositories with no commits

 dir.c                                   |  6 ++-
 git-submodule.sh                        | 12 +++++-
 t/t3000-ls-files-others.sh              |  7 ----
 t/t3009-ls-files-others-nonsubmodule.sh | 56 +++++++++++++++++++++++++
 t/t3700-add.sh                          |  1 +
 t/t7400-submodule-basic.sh              | 11 ++++-
 6 files changed, 81 insertions(+), 12 deletions(-)
 create mode 100755 t/t3009-ls-files-others-nonsubmodule.sh

--=20
2.21.0

