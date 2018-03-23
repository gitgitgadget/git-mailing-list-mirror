Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 260931F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeCWWlW (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:41:22 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47565 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752462AbeCWWlS (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Mar 2018 18:41:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 74C0120C1B;
        Fri, 23 Mar 2018 18:41:17 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 23 Mar 2018 18:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        aaronjgreenberg.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=vIhgleWfQuK9vwaeY9Wr4oszx+hnUbWZkGTViiyQXJI=; b=PHPPkIWU
        2PSuPF3jJtuQERTmtLtBVZWkUTJxofgZKGMGvgH5g42PzeGxzStzvOTJxwm7Cp9O
        wW4hWJOUT/ZRBM2i5+GDbgHsLVjLu2WX6liPf0Kr1ITLYNLpUW/IGGwTPwIpvv8U
        SPWO4Nu5jBOfq+Gcxx8iYjyRXGIMWEbpgAh1zWYR7h+FCZlHT0VYwwQOWTqeUqFt
        DM1zKN/AU/QuxdrNveiGHEnB8Dw7g73HjToKcOkkB9TpuQt4oY8tCbSrNgasBxmO
        i+3R0+niSa7CG3pO+5JWYDgzJYkTDv7pIh995aTSJEv1pV10JbB/elt1GfqwvryU
        D74kHXIDgFtU1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=vIhgleWfQuK9vwaeY9Wr4oszx+hnUbWZkGTViiyQXJI=; b=BCxSIoRX
        X4d8uBqyU+horlrvhWGwARLDdOG/ZyFTKcxj+i2XALGYJJHFkXKN4hpYBnLb6g6q
        9fudQNNoOgOQoSLmUsn7XsuW3JyuHunjFWHdYeKu0nP1EAnasIk6Npq81CjRrE2W
        jmnvNru+LC5qntUufhfmjx57P4zPq8cBOMe+FtD93kpINy1T4GAHMfA6oa8a/aur
        53sFubowDtW8WkBMkVeUKivQSq/QbfB9qqnzFKY7sRUMXgqYGIkE2n7H29VN9jRS
        JTplIymxduFwdGH/hsgwlpwC2FxJ7kOsjeJGfoK0sBKiVxmlj6ClfDTiFgCF4mMQ
        cOjzxRN/JGo45Q==
X-ME-Sender: <xms:jYK1WuMILP7T3hLrLGontWB6_Q6a_D8lr6nDbBAbGkXiwKeNbzBMYg>
Received: from localhost.localdomain (unknown [159.203.64.218])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27AFC240F8;
        Fri, 23 Mar 2018 18:41:17 -0400 (EDT)
From:   Aaron Greenberg <p@aaronjgreenberg.com>
To:     peff@peff.net
Cc:     git@matthieu-moy.fr, git@vger.kernel.org, p@aaronjgreenberg.com,
        gitster@pobox.com
Subject: [PATCH] branch: implement shortcut to delete last branch
Date:   Fri, 23 Mar 2018 22:40:35 +0000
Message-Id: <1521844835-23956-2-git-send-email-p@aaronjgreenberg.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521844835-23956-1-git-send-email-p@aaronjgreenberg.com>
References: <20180323085636.GA24416@sigill.intra.peff.net>
 <1521844835-23956-1-git-send-email-p@aaronjgreenberg.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch gives git-branch the ability to delete the previous
checked-out branch using the "-" shortcut. This shortcut already exists
for git-checkout, git-merge, and git-revert. A common workflow is

1. Do some work on a local topic-branch and push it to a remote.
2. 'remote/topic-branch' gets merged in to 'remote/master'.
3. Switch back to local master and fetch 'remote/master'.
4. Delete previously checked-out local topic-branch.

$ git checkout -b topic-a
$ # Do some work...
$ git commit -am "Implement feature A"
$ git push origin topic-a

$ git checkout master
$ git branch -d topic-a
$ # With this patch, a user could simply type
$ git branch -d -

"-" is a useful shortcut for cleaning up a just-merged branch
(or a just switched-from branch.)

Signed-off-by: Aaron Greenberg <p@aaronjgreenberg.com>
---
 builtin/branch.c  | 3 +++
 t/t3200-branch.sh | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6d0cea9..9e37078 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -221,6 +221,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
+		if (!strcmp(argv[i], "-"))
+			argv[i] = "@{-1}";
+
 		strbuf_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6c0b7ea..78c25aa 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -776,6 +776,14 @@ test_expect_success 'deleting currently checked out branch fails' '
 	test_must_fail git branch -d my7
 '
 
+test_expect_success 'test deleting last branch' '
+	git checkout -b my7.1 &&
+	git checkout  - &&
+	test_path_is_file .git/refs/heads/my7.1 &&
+	git branch -d - &&
+	test_path_is_missing .git/refs/heads/my7.1
+'
+
 test_expect_success 'test --track without .fetch entries' '
 	git branch --track my8 &&
 	test "$(git config branch.my8.remote)" &&
-- 
2.7.4

