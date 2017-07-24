Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370E7203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbdGXUf4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:35:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34803 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbdGXUfx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:35:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id v190so12659838pgv.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hD1l6DYPaWp0HFtkPQdg2hZpeZWejeiUJAoPbbbL90w=;
        b=R23uXAQEWVV+7eR/0y3hV+1VQwnuMyR38xyR+pEl0ws0ynmwVOV/eCUaDGvTKrEDDe
         6725EOaHp9bkhCP1VqxZLuRl3gLELbeIatqBQyB+3nZRzdGEQS/gHMOG39Xi/hiYgtRa
         mY6e0p5vRH2x0EgRjRShKjMasv+feQjvDQDYYsk8Q+iVi/wTHsWGYzh/dpMssXdRIYEf
         Uhh1KlXO24r7agcshXSm8nsWZjJnm5NkLkr+tImdcb5ujoWzJqqYkdYpThRgvGnXyrYa
         G8srOSz1GZqy2nzoQRkajDrqwskV7TzNOZecqR+RAcOxzJAWbeQTt82QEZ30nZS8uUjB
         4ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hD1l6DYPaWp0HFtkPQdg2hZpeZWejeiUJAoPbbbL90w=;
        b=d785wNycQYtzuP/gDCxAcTYWP1rS5fL92A/vvFJo+gf04nsLeOly4qwBoC6ZHTMHza
         IeaOU3GEdBEbDOgtWCROZVq6SE074wOjTfAbW8FjEQzzj6iroOrmzOB4EAHJ8PVkbXT1
         W+M4Ya3Qx8ZGiYgciBbSoKCY1PRNy/FVsciDJsYrcOK7LDqH0aT++BDBSIgC11SOELgL
         N0JTEVe+AMUtbYXRQ2jaJwUjApdioduTjdMldiZFV0/mqQVg6DpdMfCXMrUHrW2EurMl
         ObTgAcGzfjTw4F4PCwE49Rc0fplu/WnVeBubeAMIYLmnx/RTO+2USMvveDLubu03MqCn
         FX2Q==
X-Gm-Message-State: AIVw111VPdtnhNRKcH488TStt3L3VcVMidGI6oChrm8ottPL2p49ehiX
        6W1/kPiLjf5jR4Ef8Ok=
X-Received: by 10.101.70.137 with SMTP id h9mr16981336pgr.50.1500928553242;
        Mon, 24 Jul 2017 13:35:53 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:35:52 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 09/13] submodule foreach: correct '$path' in nested submodules from a subdirectory
Date:   Tue, 25 Jul 2017 02:04:50 +0530
Message-Id: <20170724203454.13947-10-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
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

