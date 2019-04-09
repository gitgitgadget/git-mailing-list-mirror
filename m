Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C939620248
	for <e@80x24.org>; Tue,  9 Apr 2019 23:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDIXIB (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 19:08:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64001 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfDIXIB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 19:08:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3F9F52A08;
        Tue,  9 Apr 2019 19:07:59 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=aI4ZLy0bcLjTR8+ia+GSZi7JI
        R4=; b=v+EsZvMP3LUl+Q9zEPg/KT9MKEdFHqPw5JNsxIPCuH7iVAJwiHRnQnEaG
        Ur7h+vC61QrJ7kbIPLhhja+UDGr4YsmbBh6tpUO+K8W4K5F3A+8x4SL7fCCA+uxt
        1PC42XJx4WgE9ZV9zCuxKpyFxh709otuIKObtXDqvt09DyOJdY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DB0A52A04;
        Tue,  9 Apr 2019 19:07:59 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=1steWBb7d9OVqYfLekljoKJG923KpOPJWIKAzGbEan8=; b=ytxytWtLH28UeBQMLsWnmj6UKcaK4ebmqtNdH74uoYLPIuIDYgw8utonih6JIv010k3ruHe5lMt6xjXI1TNW/KZqIOloYOmZs7Wz7cklURRZLkC4vKPTmVx0gbdDCaxlLusRfeDgt35NCf44hCFEwfW7tZXTOKnUp+L9Xrsj2p0=
Received: from hylob.dartmouth.edu (unknown [129.170.31.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 53EA3529FF;
        Tue,  9 Apr 2019 19:07:54 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, debian@onerussian.com,
        Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH v3 1/3] submodule: refuse to add repository with no commits
Date:   Tue,  9 Apr 2019 19:07:35 -0400
Message-Id: <20190409230737.26809-2-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409230737.26809-1-kyle@kyleam.com>
References: <20190409230737.26809-1-kyle@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4F25EBC4-5B1C-11E9-85C9-EE24A11ADF13-24757444!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the path given to 'git submodule add' is an existing repository
that is not in the index, the repository is passed to 'git add'.  If
this repository doesn't have a commit checked out, we don't get a
useful result: there is no subproject OID to track, and any untracked
files in the sub-repository are added as blobs in the top-level
repository.

To avoid getting into this state, abort if the path is a repository
that doesn't have a commit checked out.  Note that this check must
come before the 'git add --dry-run' check because the next commit will
make 'git add' fail when given a repository that doesn't have a commit
checked out.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 git-submodule.sh           |  7 +++++++
 t/t7400-submodule-basic.sh | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2c0fb6d723..c88a05086e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -231,6 +231,13 @@ cmd_add()
 		die "$(eval_gettext "'\$sm_path' already exists in the index and is no=
t a submodule")"
 	fi
=20
+	if test -d "$sm_path" &&
+		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
+	then
+	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
+	    die "$(eval_gettext "'\$sm_path' does not have a commit checked out=
")"
+	fi
+
 	if test -z "$force" &&
 		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path=
" > /dev/null 2>&1
 	then
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index aba2d4d6ee..a208cb26e1 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -46,6 +46,15 @@ test_expect_success 'submodule update aborts on missin=
g gitmodules url' '
 	test_must_fail git submodule init
 '
=20
+test_expect_success 'add aborts on repository with no commits' '
+	cat >expect <<-\EOF &&
+	'"'repo-no-commits'"' does not have a commit checked out
+	EOF
+	git init repo-no-commits &&
+	test_must_fail git submodule add ../a ./repo-no-commits 2>actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'setup - repository in init subdirectory' '
 	mkdir init &&
 	(
@@ -809,7 +818,7 @@ test_expect_success '../bar/a/b/c works with relative=
 local path - ../foo/bar.gi
 		cp pristine-.git-config .git/config &&
 		cp pristine-.gitmodules .gitmodules &&
 		mkdir -p a/b/c &&
-		(cd a/b/c && git init) &&
+		(cd a/b/c && git init && test_commit msg) &&
 		git config remote.origin.url ../foo/bar.git &&
 		git submodule add ../bar/a/b/c ./a/b/c &&
 		git submodule init &&
--=20
2.21.0

