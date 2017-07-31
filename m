Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01AD1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbdGaU5O (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:57:14 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38841 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbdGaU5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:57:12 -0400
Received: by mail-pg0-f68.google.com with SMTP id 125so18814433pgi.5
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hD1l6DYPaWp0HFtkPQdg2hZpeZWejeiUJAoPbbbL90w=;
        b=QNurUyxjto1jgwXoR5p8hMURQwt/pORACzc8hbPtOkiq5WMEVZX/FW/fkWbBP3MMvH
         +rMQdQFnro4AjzR9RaxwP2Li3N0GmEegzhGzW/NealetGI8+1Gk5qu1qz9WJQlLpC32D
         69RXK/pdDSwii4eqZKpPaAph5fPLwMMXL8/KT/qoZod7DAhQMYD2HzyWHLxJerzqyVKR
         3W1V0jlH9C4axreyacYcETRuYvmZTKV0hiArlD9q1ZsEbsczaqg5mifvQho1+WWa63gr
         rJIobUUDc1xWcfwCD3RprC9esNds/nOUYSzcoK0jhtGQ4OkYwI0jVU6RgSadTy1BntYw
         G9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hD1l6DYPaWp0HFtkPQdg2hZpeZWejeiUJAoPbbbL90w=;
        b=uZRGJtjuCIs9q4RwVkuiyTjaDQbrbHeJ0RIhQkR3KUbHzAB9c2DQdiVvEXy3w+7cyL
         2CT5V1TrnifDzdMiX7Dt7jkXot70NaRVTIyk/a/IK8d8egWdFtYH1e95py9Sw/wyuL/g
         xFJn2sp0Qp3vgy9hiWIG1HCtBstH3uFkmDo84KOf0O4Q066C7Zt1n6SnoTfXu0ZUNUpB
         EXRyrUnerPIIiUglE20LTYzm2LApuKXamnDOtmFXWcSK+98dmh5IXySdhortDe0sWoiA
         +YyY0OB5mn0XLaQWi5FapKvbEIOsfNp2VRaHUpfSDChZ6AGitjeZYW2diOPlEuFpsVkN
         FJpw==
X-Gm-Message-State: AIVw110dccmZi0t0neDtCXt1NtL3PP5l91jIIXhGm++yQBvQ2r6VO9+m
        7XKlTTQ8aXmXrNeGTqahrA==
X-Received: by 10.98.160.146 with SMTP id p18mr17105376pfl.322.1501534631910;
        Mon, 31 Jul 2017 13:57:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:57:11 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 09/13] submodule foreach: correct '$path' in nested submodules from a subdirectory
Date:   Tue,  1 Aug 2017 02:26:17 +0530
Message-Id: <20170731205621.24305-10-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170731205621.24305-1-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git submodule foreach' from a subdirectory of your
repository, nested submodules get a bogus value for $sm_path:
For a submodule 'sub' that contains a nested submodule 'nested',
running 'git -C dir submodule foreach echo $path' would report
path='../nested' for the nested submodule. The first part '../' is
derived from the logic computing the relative path from $pwd to the
root of the superproject. The second part is the submodule path inside
the submodule. This value is of little use and is hard to document.

There are two different possible solutions that have more value:
(a) The path value is documented as the path from the toplevel of the
    superproject to the mount point of the submodule.
    In this case we would want to have path='sub/nested'.

(b) As Ramsay noticed the documented value is wrong. For the non-nested
    case the path is equal to the relative path from $pwd to the
    submodules working directory. When following this model,
    the expected value would be path='../sub/nested'.

The behavior for (b) was introduced in 091a6eb0fe (submodule: drop the
top-level requirement, 2013-06-16) the intent for $path seemed to be
relative to $cwd to the submodule worktree, but that did not work for
nested submodules, as the intermittent submodules were not included in
the path.

If we were to fix the meaning of the $path using (a) such that "path"
is "the path from the toplevel of the superproject to the mount point
of the submodule", we would break any existing submodule user that runs
foreach from non-root of the superproject as the non-nested submodule
'../sub' would change its path to 'sub'.

If we would fix the meaning of the $path using (b), such that "path"
is "the relative path from $pwd to the submodule", then we would break
any user that uses nested submodules (even from the root directory) as
the 'nested' would become 'sub/nested'.

Both groups can be found in the wild.  The author has no data if one group
outweighs the other by large margin, and offending each one seems equally
bad at first.  However in the authors imagination it is better to go with
(a) as running from a sub directory sounds like it is carried out
by a human rather than by some automation task.  With a human on
the keyboard the feedback loop is short and the changed behavior can be
adapted to quickly unlike some automation that can break silently.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh             |  1 -
 t/t7407-submodule-foreach.sh | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a427ddafd..493a64372 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -320,7 +320,6 @@ cmd_foreach()
 				prefix="$prefix$sm_path/"
 				sanitize_submodule_env
 				cd "$sm_path" &&
-				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
 				# we make $path available to scripts ...
 				path=$sm_path &&
 				if test $# -eq 1
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42..0663622a4 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -82,9 +82,9 @@ test_expect_success 'test basic "submodule foreach" usage' '
 
 cat >expect <<EOF
 Entering '../sub1'
-$pwd/clone-foo1-../sub1-$sub1sha1
+$pwd/clone-foo1-sub1-$sub1sha1
 Entering '../sub3'
-$pwd/clone-foo3-../sub3-$sub3sha1
+$pwd/clone-foo3-sub3-$sub3sha1
 EOF
 
 test_expect_success 'test "submodule foreach" from subdirectory' '
@@ -196,6 +196,38 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 	) &&
 	test_i18ncmp expect actual
 '
+sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
+sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
+sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
+nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
+nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
+nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
+submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
+
+cat >expect <<EOF
+Entering '../nested1'
+$pwd/clone2-nested1-nested1-$nested1sha1
+Entering '../nested1/nested2'
+$pwd/clone2/nested1-nested2-nested2-$nested2sha1
+Entering '../nested1/nested2/nested3'
+$pwd/clone2/nested1/nested2-nested3-nested3-$nested3sha1
+Entering '../nested1/nested2/nested3/submodule'
+$pwd/clone2/nested1/nested2/nested3-submodule-submodule-$submodulesha1
+Entering '../sub1'
+$pwd/clone2-foo1-sub1-$sub1sha1
+Entering '../sub2'
+$pwd/clone2-foo2-sub2-$sub2sha1
+Entering '../sub3'
+$pwd/clone2-foo3-sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
+	(
+		cd clone2/untracked &&
+		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
 
 cat > expect <<EOF
 nested1-nested1
-- 
2.13.0

