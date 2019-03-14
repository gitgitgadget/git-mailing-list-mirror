Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921F420248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCNPJl (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:09:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57745 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCNPJk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:09:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FDA55C59A;
        Thu, 14 Mar 2019 11:03:02 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=KnH3h7wvobi3CqxWda19vp9Wd
        E0=; b=lCGZb/mMgKI7V5uBCfMJtPvombpm6bo81I6KDLqEbdNfVEWQ831fqdUXM
        x9tHv+1bVJUqMEzyJL7qc51Nt5Ws9krzCWyoCRFxFbqc2EPvR0UU2Ms9eUcpIPzW
        8Rm7bxbGRl7vzeFUeST7FpYZ0YI3GW9QS5EQ2iagSqCgwxNJV8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 587885C599;
        Thu, 14 Mar 2019 11:03:02 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=b3kXPWg5Ygvb2YKPa6xzcdbn3GvwteMOXHo+hgsrac0=; b=LIirAG6jw07L/1fmtexztv1Wrcgb3RNH6pYX3aURVb7zMMaHyBqJfzSJFfps/OpCBuk0FaXY0MwS4kdv3RKBtZDrS+G7Gjsr6e9UfUxp5PCGfpm7wPPsFqjZz/rEb18o8PDgSbSh03PRUgqOUrQmjCHq4AL3l09uzCnmQ12TYYk=
Received: from hylob.dartmouth.edu (unknown [129.170.31.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1FB9E5C591;
        Thu, 14 Mar 2019 11:02:58 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     debian@onerussian.com, Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH 1/4] submodule: refuse to add repository with no commits
Date:   Thu, 14 Mar 2019 11:02:16 -0400
Message-Id: <20190314150219.2040-2-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314150219.2040-1-kyle@kyleam.com>
References: <20190314150219.2040-1-kyle@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 41A8697A-466A-11E9-994F-D01F9763A999-24757444!pb-smtp20.pobox.com
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
getting into this state unless --force is used.  Reacting to --force
isn't very useful, especially because an upcoming commit will make
'git add' fail in this situation, but it allows us to use the same
'git add --dry-run' condition as the ignored path case.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 git-submodule.sh           | 12 ++++++++++--
 t/t7400-submodule-basic.sh | 11 ++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 514ede2596..6c74656027 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -234,10 +234,18 @@ cmd_add()
 	if test -z "$force" &&
 		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path=
" > /dev/null 2>&1
 	then
-		eval_gettextln "The following path is ignored by one of your .gitignor=
e files:
+		if test -d "$sm_path" &&
+			test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null) &&
+			! git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null
+		then
+			die "$(eval_gettext "'\$sm_path' does not have any commits")"
+		else
+			eval_gettextln "\
+The following path is ignored by one of your .gitignore files:
 \$sm_path
 Use -f if you really want to add it." >&2
-		exit 1
+			exit 1
+		fi
 	fi
=20
 	if test -n "$custom_name"
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

