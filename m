Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E99D1F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 10:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeCUKfR (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 06:35:17 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42998 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeCUKfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 06:35:15 -0400
Received: by mail-pl0-f65.google.com with SMTP id w15-v6so2859266plq.9
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 03:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ontokWbb+DgwdxfFC+ZS6rqcjJDgA3rUOTo3SsLSeus=;
        b=djUcvfE0+jBROUM8EU+yxLTC6lUKVkpi8Udkz1Yokiuel3/EfrMyzHo2NpF5UM6VDu
         axpz/m2VCcacKcn9BIy6L/07a06vvBgJ6pO6ffghDK99h/fofmqEHtSTNjNzUGFKanJW
         MEQj5KXdewAPSGZ4tuPkwTwjYkWeRRUeS1N0Z0aG47NopniuVGhbkBFbN55QAZNHrXLs
         fbhh6kLR8BF9i2eDNyryXHUBUTQn8CnAllUtH5MKpms88wqOhEacS8NQ5we66HFrsTWh
         0RW2xAbRODzP+3urTsWy6G70K+NPrbUdUSRigk0CWPn6PQWTCzBUmRjHC2lRlFyqyqkz
         VYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ontokWbb+DgwdxfFC+ZS6rqcjJDgA3rUOTo3SsLSeus=;
        b=EU7KySYiuYDyXbttfLA9uoFVn0blKweFmpCv4iFm2gDb8owZx7mdK+VVCheNlGdxV0
         JPIqHrI5nqZl4mYrn8VNXtoSEkNzg8ayWdEAqi0PCgbkSM/u7ZZqGWXHhoSAj+l8umbc
         Eh28ZYdHtTCghuN66twHpj+WcCy7E5XbbnCte5+Tnq8j1evX7FQkkJwlKQ0gLhaKav9S
         XiDhdDf2yiBPSv5HnaYtirpD8JvbeB4jxvicNT4BUhVbJhY5z7ojhxe7/mK+7X3iqvsQ
         UXe0N0u4G2h4lCSpxTGHFaVUJLlc8clIfn4Dr69El/WRoAMKWQn5aQ4ikx6L2o3pPge4
         Ping==
X-Gm-Message-State: AElRT7EMrdkh8OD8yv8W3c28d3jcwt3J2l6iZYzE9IVE6wsW4Unjdvoc
        v9gLt/BkWIAJQhjjNjrrrJ7ZP2SD
X-Google-Smtp-Source: AG47ELthe1hbY80NShCJ3rArTztUmIf3zdxu/zU3w8auRCwLDmgPvNKrvO/RIOAYdLdybuOd5PsjjQ==
X-Received: by 2002:a17:902:b907:: with SMTP id bf7-v6mr18238578plb.325.1521628515304;
        Wed, 21 Mar 2018 03:35:15 -0700 (PDT)
Received: from localhost.localdomain (softbank126094241038.bbtec.net. [126.94.241.38])
        by smtp.gmail.com with ESMTPSA id q2sm7083319pgf.5.2018.03.21.03.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Mar 2018 03:35:14 -0700 (PDT)
From:   Yuki Kokubun <orga.chem.job@gmail.com>
To:     git@vger.kernel.org
Cc:     Yuki Kokubun <orga.chem.job@gmail.com>
Subject: [PATCH] filter-branch: consider refs/replace can refer to an object other than commit
Date:   Wed, 21 Mar 2018 10:35:04 +0000
Message-Id: <20180321103504.9483-1-orga.chem.job@gmail.com>
X-Mailer: git-send-email 2.16.2.18.g09cb46d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git filter-branch -- --all" can be confused when refs that refer to objects
other than commits exists.
Because "git rev-parse --all" that is internally used can return refs that
refer to an object other than commit. But it is not considered in the phase of
updating refs. Such refs can be created by "git replace" with objects other than
commits.

Signed-off-by: Yuki Kokubun <orga.chem.job@gmail.com>
---
 git-filter-branch.sh     |  3 +++
 t/t7003-filter-branch.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 1b7e4b2cd..a9fafe64f 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -479,6 +479,9 @@ do
 	# avoid rewriting a ref twice
 	test -f "$orig_namespace$ref" && continue
 
+	# refs/replace can point to a non commit object
+	test $(git cat-file -t "$ref") = commit || continue
+
 	sha1=$(git rev-parse "$ref"^0)
 	rewritten=$(map $sha1)
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 7cb60799b..efeaf5887 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -470,4 +470,17 @@ test_expect_success 'tree-filter deals with object name vs pathname ambiguity' '
 	git show HEAD:$ambiguous
 '
 
+test_expect_success 'rewrite repository including refs/replace that point to non commit object' '
+	test_when_finished "git reset --hard original" &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	test_when_finished "git replace -d $tree" &&
+	echo A >new &&
+	git add new &&
+	new_tree=$(git write-tree) &&
+	git replace $tree $new_tree &&
+	git reset --hard HEAD &&
+	git filter-branch -f -- --all >filter-output 2>&1 &&
+	! fgrep fatal filter-output
+'
+
 test_done
-- 
2.16.2.18.g09cb46d

