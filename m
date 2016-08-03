Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F581F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbcHCUpf (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:45:35 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35583 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499AbcHCUpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:45:18 -0400
Received: by mail-pa0-f42.google.com with SMTP id iw10so76996856pac.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:44:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LdfbR+V7wH3RI9w5M8uTGWmmfVEcHXSaubUbBDVjFJ8=;
        b=HMkVry6TNt4e2lQOhVDfaCPaMj6p+pbbw5a9NlxQCPIHzem2SkBnMzZ2HJqF7GfE5c
         WQzsq9ANXQwwTqMLthDaFAJXre4oMf1RwTTd2VD2eqrWOBsfrNeZyNQW753b/8Ymo7V9
         XnaTpIY1rs9acwB41YUtjjvQgSXLLJ9FlkoJ9csqUYrCS98TT3W5Bc6tYmhy2IlttCmJ
         QE7xjjB6Vq1K7zwWmVpWB5l8wlz1YHQPSR+VfuLyvjMKVcvmQjrmriHDeUJ3Cbv5a1I4
         3dl3zdFHWmgPs97L0BVkx89mUAOpaCgE4A7M46PiYqG15YR5gGeAdfZhkl1+EtSXOtsf
         tJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LdfbR+V7wH3RI9w5M8uTGWmmfVEcHXSaubUbBDVjFJ8=;
        b=lfWjg59Ah6CyDeQRXdVrD1wxrPH6tJhQepV1a6V/b+9/P2cYOSAvWYt9M/Z/q1wS+L
         2QH5RSOfKbzUPgs/qHlMTMg3mphWjUnIgLNwR+nOXyn3YbhvZ8gHb+dfiWigcyRu5L2U
         FuixZ0BTaXWehhtYcq8llw1YKmzR5xFytkROlNEYn5ryOqtgeOOnEPKChJYae4NL1tNY
         Fzeai6JsEOhPSX44Qpq7FlJQA/ogdypJvW4QyABBC1E9cu6fp4hKjuMgHrWepQVYh5tV
         LerH4I1nLtQPbqoA1JCZunpTGIkD57G5Ubm9mNmjyM8xXDdS3VfLVwmr0Cm9TZ3OIUEq
         7wTQ==
X-Gm-Message-State: AEkoous4VpGWQxZuXcdzsUU/qZfLKeTnkAiG38JX88qjQjkufhko7npg1jMPJK3zyUUxUrBr
X-Received: by 10.66.142.233 with SMTP id rz9mr121268077pab.143.1470257065696;
        Wed, 03 Aug 2016 13:44:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f855:e892:92e2:7149])
        by smtp.gmail.com with ESMTPSA id q1sm14718735pfd.48.2016.08.03.13.44.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 13:44:25 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 6/7] submodule update: allow '.' for branch value
Date:	Wed,  3 Aug 2016 13:44:04 -0700
Message-Id: <20160803204404.3356-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.524.gdbd1860
In-Reply-To: <20160803204404.3356-1-sbeller@google.com>
References: <20160803204404.3356-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Gerrit has a "superproject subscription" feature[1], that triggers a
commit in a superproject that is subscribed to its submodules.
Conceptually this Gerrit feature can be done on the client side with
Git via (except for raciness, error handling etc):

  while [ true ]; do
    git -C <superproject> submodule update --remote --force
    git -C <superproject> commit -a -m "Update submodules"
    git -C <superproject> push
  done

for each branch in the superproject. To ease the configuration in Gerrit
a special value of "." has been introduced for the submodule.<name>.branch
to mean the same branch as the superproject[2], such that you can create a
new branch on both superproject and the submodule and this feature
continues to work on that new branch.

Now we find projects in the wild with such a .gitmodules file.
The .gitmodules used in these Gerrit projects do not conform
to Gits understanding of how .gitmodules should look like.
This teaches Git to deal gracefully with this syntax as well.

The redefinition of "." does no harm to existing projects unaware of
this change, as "." is an invalid branch name in Git, so we do not
expect such projects to exist.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 18 ++++++++++++++++++
 t/t7406-submodule-update.sh | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9be2c75..f1acc4d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -912,6 +912,24 @@ static const char *remote_submodule_branch(const char *path)
 	if (!sub->branch)
 		return "master";
 
+	if (!strcmp(sub->branch, ".")) {
+		unsigned char sha1[20];
+		const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
+
+		if (!refname)
+			die(_("No such ref: %s"), "HEAD");
+
+		/* detached HEAD */
+		if (!strcmp(refname, "HEAD"))
+			die(_("Submodule (%s) branch configured to inherit "
+			      "branch from superproject, but the superproject "
+			      "is not on any branch"), sub->name);
+
+		if (!skip_prefix(refname, "refs/heads/", &refname))
+			die(_("Expecting a full ref name, got %s"), refname);
+		return refname;
+	}
+
 	return sub->branch;
 }
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1bb1f43..d7983cf 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -209,9 +209,42 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
 	)
 '
 
+test_expect_success 'submodule update --remote should fetch upstream changes with .' '
+	(
+		cd super &&
+		git config -f .gitmodules submodule."submodule".branch "." &&
+		git add .gitmodules &&
+		git commit -m "submodules: update from the respective superproject branch"
+	) &&
+	(
+		cd submodule &&
+		echo line4a >> file &&
+		git add file &&
+		test_tick &&
+		git commit -m "upstream line4a" &&
+		git checkout -b test-branch &&
+		test_commit on-test-branch
+	) &&
+	(
+		cd super &&
+		git submodule update --remote --force submodule &&
+		git -C submodule log -1 --oneline >actual
+		git -C ../submodule log -1 --oneline master >expect
+		test_cmp expect actual &&
+		git checkout -b test-branch &&
+		git submodule update --remote --force submodule &&
+		git -C submodule log -1 --oneline >actual
+		git -C ../submodule log -1 --oneline test-branch >expect
+		test_cmp expect actual &&
+		git checkout master &&
+		git branch -d test-branch &&
+		git reset --hard HEAD^
+	)
+'
+
 test_expect_success 'local config should override .gitmodules branch' '
 	(cd submodule &&
-	 git checkout -b test-branch &&
+	 git checkout test-branch &&
 	 echo line5 >> file &&
 	 git add file &&
 	 test_tick &&
-- 
2.9.2.524.gdbd1860

