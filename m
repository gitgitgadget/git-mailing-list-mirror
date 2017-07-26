Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F30208A0
	for <e@80x24.org>; Wed, 26 Jul 2017 20:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbdGZUIh (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 16:08:37 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36660 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdGZUIg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 16:08:36 -0400
Received: by mail-pf0-f170.google.com with SMTP id z129so35369102pfb.3
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9nQ1VyDPZ51oPQTsQdV1e76/QrCBgfbetD4AwPtNbxU=;
        b=H+JDJhtHLsIh8VDfnfgLumhH71omCDnhhPA2dOB9UpsAhyZze0HLVvDSY9esYhDUOR
         grZA7knMQ3o29rBdr4ot6PSsRpiJIJfA3CZ9FHWqkEkcOANFsaGSqErEub2jE3vBbrOl
         6RuU8KbU3ZJ5qKM/eF/dgeD4sptxEsu/+8GJdnQQCVtOwjzXfb2Nka1Ub/TeFVXGWSWX
         NbRRtkuSJnDQqLH60qn2iYYvtlnd0Wxi7oW8OnXeWI3+mi3nrVAF12Hj8E8jhyi4FuSC
         xOtqMpo8vRvoM2LsN0HZ5vVmTnQMu84GCYPIdK/OPStUOdgmcYl1Eql4WVOBHTamKALC
         oV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9nQ1VyDPZ51oPQTsQdV1e76/QrCBgfbetD4AwPtNbxU=;
        b=dtBKu1Vt7dMKPJV8vx7NrEewMwk5uLFVIqNFAVbYxYalIYA+RMDosdq4FgALdazfho
         QoDaRP90XKPv1FFcLWUqn5Ma6czzDODkeG7ovNZF9iv1vZdvVxGK+tbSQTJJ0LcGYlNS
         5Yo3Qw65O2NdZCfKsdLQqcjxUpk1rQhytM00UpP7ZnfWoRVdusb/oy8v70VaMQPb71Mm
         KDabEZeru4u3hiPHWi//MdDxhFwtpxaGMWL2ziAzf0M9zz0vbR1YIB8elvEcCoGR3E61
         NQlHVLr9HcLfsM9RMGGORO0o3ZIt7kBwaJCD2FCPrxqPdsgDIV/QjfhGjl6WOoBv81Tp
         1WXg==
X-Gm-Message-State: AIVw112qhB4CncDPQXz+q6ekzl01ThsxWrhzTS0Eqz5IhyZ+fuBYvQjk
        n5DslVZ+Zfv3DoMD
X-Received: by 10.99.96.193 with SMTP id u184mr1903477pgb.125.1501099716147;
        Wed, 26 Jul 2017 13:08:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b827:7828:2b7f:c1e7])
        by smtp.gmail.com with ESMTPSA id e4sm36976021pga.71.2017.07.26.13.08.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 13:08:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jacob.keller@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: correct error message for missing commits.
Date:   Wed, 26 Jul 2017 13:08:32 -0700
Message-Id: <20170726200832.28522-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule diff should be displayed we currently just add the
submodule objects to the main object store and then e.g. walk the
revision graph and create a summary for that submodule.

It is possible that we are missing the submodule either completely or
partially, which we currently differentiate with different error messages
depending on whether (1) the whole submodule object store is missing or
(2) just the needed for this particular diff. (1) is reported as
"not initialized", and (2) is reported as "commits not present".

If a submodule is deinit'ed its repository data is still around inside
the superproject, such that the diff can still be produced. In that way
the error message (1) is misleading as we can have a diff despite the
submodule being not initialized.

Downgrade the error message (1) to be the same as (2) and just say
the commits are not present, as that is the true reason why the diff
cannot be shown.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I came across this error message in the series for the
object store modularisation[1], when I was trying to replace
'add_submodule_odb' by a custom loaded object store from a
submodule repo object, which got me thinking on the error
message and the true cause for it.  

While this could go in separately, I may carry it in that
series, as there we'd come up with more error messages
("could not create submodule object store" as well as the
"commits not present", maybe even "submodule not lookup failed")

Thanks,
Stefan

[1] https://public-inbox.org/git/20170706202739.6056-1-sbeller@google.com/
  

 submodule.c                               | 2 +-
 t/t4059-diff-submodule-not-initialized.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6531c5d609..280c246477 100644
--- a/submodule.c
+++ b/submodule.c
@@ -567,7 +567,7 @@ static void show_submodule_header(FILE *f, const char *path,
 
 	if (add_submodule_odb(path)) {
 		if (!message)
-			message = "(not initialized)";
+			message = "(commits not present)";
 		goto output_header;
 	}
 
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
index cd70fd5192..49bca7b48d 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -95,7 +95,7 @@ test_expect_success 'submodule not initialized in new clone' '
 	git clone . sm3 &&
 	git -C sm3 diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 $smhead1...$smhead2 (not initialized)
+	Submodule sm1 $smhead1...$smhead2 (commits not present)
 	EOF
 	test_cmp expected actual
 '
-- 
2.14.0.rc0.3.g6c2e499285

