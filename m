Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F020220248
	for <e@80x24.org>; Tue,  2 Apr 2019 18:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfDBSfo (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 14:35:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54495 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfDBSfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 14:35:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65FC864EC5;
        Tue,  2 Apr 2019 14:35:40 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=lsvJO3KIHXPZ1P2FYbyzi85L0
        30=; b=fZI6UdFDbofwuIukI4eY+Gl27cvsOk8IQa6xlikYOL7hlFNSs5bG/OYUU
        IRKR3zEf0eUXZRw0D7IfhlPYpLTPt12NSAOuaD+I/ApDCi1f69BFovzLy8XH5uyF
        jmH28rfBP8hh8Aq9ytf/wP6v+T5EFLhwACjBTo1N9NN9jqyTLE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E6DE64EC4;
        Tue,  2 Apr 2019 14:35:40 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=zJgdVAjOhgYSSUb3wZjjOLg+g5FRpWul5ne+s250Rhg=; b=bY0m17NAX5SkfMsGQZGUeVCyjE8RYK7R2cBCzUCw7ZwFpvue25tcc4jEUekYR/i/FZ5/Zg2pyEU65VjpVsi33AQl1BidM4cwU2qzNzKQsT6dlIZrgxzHj4YH2/ZuQ08Myx+hK6Dx6DbszC4zEUcSHeM5xscgmbZHuTZUfxMqqmE=
Received: from hylob.dartmouth.edu (unknown [129.170.31.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92C9F64EC1;
        Tue,  2 Apr 2019 14:35:36 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Cc:     debian@onerussian.com
Subject: [PATCH v2 1/4] submodule: refuse to add repository with no commits
Date:   Tue,  2 Apr 2019 14:35:02 -0400
Message-Id: <20190402183505.31512-2-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402183505.31512-1-kyle@kyleam.com>
References: <87lg1eq146.fsf@kyleam.com>
 <20190402183505.31512-1-kyle@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 1C285DFC-5576-11E9-ABEB-EE24A11ADF13-24757444!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the path given to 'git submodule add' is an existing repository
that is not in the index, the repository is passed to 'git add'.  If
this repository doesn't have any commits, we don't get a useful
result: there is no subproject OID to track, and any untracked files
in the sub-repository are added to the current repository.

Detect if the path is a repository with no commits and abort to avoid
getting into this state.  Note that this check must come before the
'git add --dry-run' check because an upcoming commit will make 'git
add' fail in this situation.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 git-submodule.sh           |  7 +++++++
 t/t7400-submodule-basic.sh | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 514ede2596..5a9dc9bf7e 100755
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
+	    die "$(eval_gettext "'\$sm_path' does not have any commits")"
+	fi
+
 	if test -z "$force" &&
 		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path=
" > /dev/null 2>&1
 	then
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index aba2d4d6ee..6adf640143 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -46,6 +46,15 @@ test_expect_success 'submodule update aborts on missin=
g gitmodules url' '
 	test_must_fail git submodule init
 '
=20
+test_expect_success 'add aborts on repository with no commits' '
+	cat >expected <<-\EOF &&
+	'"'repo-no-commits'"' does not have any commits
+	EOF
+	git init repo-no-commits &&
+	test_must_fail git submodule add ../a ./repo-no-commits 2>actual &&
+	test_i18ncmp expected actual
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

