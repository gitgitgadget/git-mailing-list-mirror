Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900B71FAE2
	for <e@80x24.org>; Tue, 27 Mar 2018 18:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeC0SrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 14:47:07 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45301 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750878AbeC0SrG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Mar 2018 14:47:06 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 384B421420;
        Tue, 27 Mar 2018 14:47:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Mar 2018 14:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        aaronjgreenberg.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=vIhgleWfQuK9vwaeY9Wr4oszx+hnUbWZkGTViiyQXJI=; b=fzuncGDw
        3K+lW9LujyFxmgpIL0Za92WtQ222izlec6V0AzCqriJvDSVlTnNhrtnZ6CouqQUD
        VTMBpgsAAd4jlJAPKKpPERPMaT1Ao/xWm1JPACnUQ5t4x2BMq2/A19dFAqxp98g5
        W4OGMZFl6wDcs2TyvahwMv2r73mG2jOYED2WAXEOQsIFneLfF0D+wnysmAKSMF1X
        Zhb9JjsVpvijLA4/1DjRIYY5J3uP1ZsBT3oYuoWmicDZECvbAcioB8/mGDH+/Cm/
        0GZI8lgM75M/7wK1CuINGeZC/bKptEJOx0XROLcZ1Uk71fOWTrjfNcoLc2MlyCvB
        /18vpaeiRNRcIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=vIhgleWfQuK9vwaeY9Wr4oszx+hnUbWZkGTViiyQXJI=; b=fAfDbt/x
        Xwngh7uhuG8GUgUCsTR5mcSlZehQxPvW9pXcowwtMYSyPucIITwnOAj9sDYZ8x1W
        IGDFIcei8NxtBsxdKISvt4Ptd7Me1e7fF9Tov7wqVyng712EfRga/KF3M5gf+XSv
        c4EP6A0vuLMdu5QagjWSjO/w8Pm/9SvXlDtbEPi6wxBFdzntmllN85SW/gIg843y
        yJRF/6eBRlLG8qNt+oOSwAdaPJ+IE+YUG6GoBo6hXUVJXPsVf4FuP7UNON/tLNkd
        AqtEZxGoWKHHcViQLfhh3KapNJu78iv2XUqLDWCyec+ZOPqD/CLw9NEH0Yu773Hc
        Ay8vjNpCS//2+Q==
X-ME-Sender: <xms:qpG6Wj3IhsNv2-n1IfIsZR6OS2TuHKS98MP-gsYJ9V-Oh4V-b3lFaw>
Received: from localhost.localdomain (unknown [159.203.64.218])
        by mail.messagingengine.com (Postfix) with ESMTPA id E7480E507D;
        Tue, 27 Mar 2018 14:47:05 -0400 (EDT)
From:   Aaron Greenberg <p@aaronjgreenberg.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Aaron Greenberg <p@aaronjgreenberg.com>
Subject: [PATCH] branch: implement shortcut to delete last branch
Date:   Tue, 27 Mar 2018 18:46:30 +0000
Message-Id: <1522176390-646-2-git-send-email-p@aaronjgreenberg.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522176390-646-1-git-send-email-p@aaronjgreenberg.com>
References: <1522176390-646-1-git-send-email-p@aaronjgreenberg.com>
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

