Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E641203C1
	for <e@80x24.org>; Thu, 21 Jul 2016 01:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbcGUBj3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 21:39:29 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35122 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbcGUBj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 21:39:27 -0400
Received: by mail-pf0-f182.google.com with SMTP id x72so24528149pfd.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 18:39:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MKQ6F1SzY4mJC78eH33wYB3Ya/PXX4cKghxnBe+2pPs=;
        b=lau5DMX/JECM2mAyrxLl/rawqgAzclOwMFhe24ncszJcts9jv1bvW3nn5tEv3Wmwuc
         RCejDt+ij3AOpaUTS4jheClatBLywQAq1CDoKq2rpIQJa6acw2AfTxJlzDTeyiWkyCcT
         111jUxnzTEvPJ33/zbCpKqGnf6ZkoHIPglwyByfhzFTMHpENd1UEKeuouI01QBK4AA6g
         tO1t+inLPW0UXHvCwfOxtAI/KQhReSbSdvi3hAauwNSS/h+veFOV8K9208ELc2kt5luk
         Qwc/YVQznBE0VHhGv12ckOavVbzU4wPkNcIgI6siBnFBoXXxHrKt44dTJ2WuBvqwlQxP
         dvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MKQ6F1SzY4mJC78eH33wYB3Ya/PXX4cKghxnBe+2pPs=;
        b=MRnUVvbNLvtQnkI9hKUBNx0H+xn3QHPyPc5P4R8bV7v7uFGcN+gkB77Th+XcYzeKc/
         OCMjdvZqGhh+kbF21xvHrLDHlo+HkDazgXNa3TXmTIp0eh8pIcTBWI+1TJVgJyN9yZUx
         o6TqjA+DRAOYOncSeQteZ9dt86+2/NXTZ1kqlArpbaLz2lSu5sh4y5qsyN2cBgR+FuP7
         W0LP4vWQZn5QB4w/ilFhosYvRXkYTL4gQigDTMSyI5Fasrw0QGSqfWZHuWL1PAVbmHbb
         PFaw6as2I+zTy66aFdYtKNj94bi6ptqCX9LUwXvAccwyP45sgmV5xn3XZxaYHe4/XUid
         Ydlg==
X-Gm-Message-State: ALyK8tLQ7239WGft7sTFw9y0DVgOg/XlGAusIz3Np2v9DwZ5N1AbmonxymdPdMI1erUvShGz
X-Received: by 10.98.200.29 with SMTP id z29mr68805231pff.143.1469065166658;
        Wed, 20 Jul 2016 18:39:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:685b:61cf:78cb:f3fd])
        by smtp.gmail.com with ESMTPSA id b68sm7308595pfg.85.2016.07.20.18.39.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 18:39:25 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule--helper: correct index computation
Date:	Wed, 20 Jul 2016 18:39:23 -0700
Message-Id: <20160721013923.17435-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.370.g4a59376.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In 665b35eccd39 (2016-06-09, submodule--helper: initial clone learns
retry logic), the index computation for the second round is wrong; it
should make use of the index that was handed in via the idx_task_cb
pointer. When that commit was introduced, I wrote:

> I wonder how we can test this properly as the git binary we have here
> is too reliable, but I observed the correctness of this patch when
> cloning a repo with lots of submodules and one of them failing.

This was only partially true as I did not observe the second try failing,
only the first retry succeeding. Testing however is really easy, when the
url of one submodule is bogus, so add a test for that.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c |  4 +++-
 t/t7406-submodule-update.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 494e088..5d54885 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -795,7 +795,9 @@ static int update_clone_task_finished(int result,
 		suc->failed_clones[suc->failed_clones_nr++] = ce;
 		return 0;
 	} else {
-		idx = suc->current - suc->list.nr;
+		idx -= suc->list.nr;
+		if (idx >= suc->failed_clones_nr)
+			die("BUG: idx too large???");
 		ce  = suc->failed_clones[idx];
 		strbuf_addf(err, _("Failed to clone '%s' a second time, aborting"),
 			    ce->name);
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 88e9750..ffb329f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -889,4 +889,20 @@ test_expect_success 'git clone passes the parallel jobs config on to submodules'
 	rm -rf super4
 '
 
+cat << EOF >expect
+Submodule 'deeper/submodule' (bogus-url) registered for path 'deeper/submodule'
+fatal: clone of 'bogus-url' into submodule path '$pwd/super4/deeper/submodule' failed
+Failed to clone 'deeper/submodule'. Retry scheduled
+fatal: clone of 'bogus-url' into submodule path '$pwd/super4/deeper/submodule' failed
+Failed to clone 'deeper/submodule' a second time, aborting
+EOF
+
+test_expect_success 'correct message for retries' '
+	test_when_finished "rm -rf super4" &&
+	git -C super config -f .gitmodules submodule."deeper/submodule".url bogus-url &&
+	git -C super commit -a -m "bogus url for one submodule" &&
+	test_must_fail git clone --recurse-submodules -j 1 super super4 2>&1 | grep deeper >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.9.2.370.g4a59376.dirty

