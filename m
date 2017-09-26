Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D94920281
	for <e@80x24.org>; Tue, 26 Sep 2017 18:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030675AbdIZS2A (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 14:28:00 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:51834 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967715AbdIZS17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 14:27:59 -0400
Received: by mail-pg0-f50.google.com with SMTP id k193so6366234pgc.8
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NFIB/ekQy6v1XE8IAOBJsYJ98bK2kBeKbcx6W0EaR2I=;
        b=IgnO8+ryp4uDlxfJLdmok6AeFMVMwCEI3n1EsBKc8WjODG//ROVmQLwYTinO/ptrnt
         dcCpGxEYcSvldolX3YIo1SoS82PUzm9Ts3DNdxvvuSrZ6S9z8YWF8fI+XSBe2I1TkyFC
         z6A4/8kkzSMD2EgXnWQMDDXyD3onk2a+IS2vAKX5+r6M8gPeoQaj9nvtHIrnnqqmqWj1
         BN9SNP+xDlI+9WtbKRLTqQ+GNYRmgcT4zkKRy/7Jb63KrUyVandVPjgGBgKpO50aR2H2
         y9PcznhIJ6L3+k+Ch63PMoKUzn4OhXiNxZYWRy1uH86WPiMtRm3EtgNxcDKZ8Ai7icJ+
         AZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NFIB/ekQy6v1XE8IAOBJsYJ98bK2kBeKbcx6W0EaR2I=;
        b=dOMuy9+hQOmXp3Yu0ZGZpciAgLLwpcbKw0Xj7jB8Ec6RN2ZScqB6gVKNk4UukSs+Kr
         9h2KQKJrr2U2cnRT3B6Zvqk+fpxlm28slHD6rGXxUyByEqVe2MW0fM4vrW4jIJvBdXt7
         OkrLZtiJmmPHKHP/axobRVe1lL927cBXVXyB7gXfLMN4bpUnnU5j3OiYhbytPp/lkuNB
         TUJOn40buF+/mdn4zPM5DOel+eeHzvP9QSi2GJsmWkBAknvVDM//eWPpBA9haKUYVoK5
         fLWsIqy3VrCd1tgv45Q3Q5Sw/JX7oO5ETknge+hZVZU6AIg1qahepZcx1i0qFbCtPZxE
         FZug==
X-Gm-Message-State: AHPjjUhJLKvxYrIV5HsU/zRyyMpUI9AKE65mQ9dQ+33Syw/bc/paz/Mm
        P/Wz3QAazdPDn93H6rMDDxLAHhItmEw=
X-Google-Smtp-Source: AOwi7QBhwPVEuppeT6x+Ncvnvxzvyhk/ZrIb8ZT+UZR0Dx+/gT0acVvWso7n8PoYoR4+oYcjElywOg==
X-Received: by 10.99.186.91 with SMTP id l27mr11658236pgu.279.1506450478767;
        Tue, 26 Sep 2017 11:27:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7981:413b:8357:cbf7])
        by smtp.gmail.com with ESMTPSA id u186sm15271348pgb.35.2017.09.26.11.27.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 11:27:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: correct error message for missing commits.
Date:   Tue, 26 Sep 2017 11:27:56 -0700
Message-Id: <20170926182756.13319-1-sbeller@google.com>
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

