Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72E11F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbeKNKPD (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:15:03 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:36964 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:15:03 -0500
Received: by mail-ot1-f74.google.com with SMTP id q6so9989832otk.4
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c0Dtnac/GkIoitoSsGrP8UZTLgBS/bMDjrrAtpnCaZw=;
        b=D2cmM5YdAQdTzxIEG8DB+iSQnUNZr3RDRpby4W/x1tdbYGQaL5KuUOAzEtYA71wWaX
         4BfVl3f4+MaF0FMDuEa/+48gKKHCAVHWoCc1dzf8BjsbSpcKKFcXAWHLR4D/864Ojbrd
         HEkAs12xvWScmjCVi2U9XjzHk218UE8KCn3HOTEmcr0/5eWkgoG2qjhIKz7LnBE88K6v
         ykLw8SlkWMQ+niV7fo3zb2cVo0+KXtqFkEtEIljCiULi2sNro+i9qyzLld5YkJkIC40s
         MSMlSbnQ5NxVQJeIAM4fka40I0xuFD+E64DrGaLqRtcequ7Sdzku/1YDRcFG7DoMOAcx
         jl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c0Dtnac/GkIoitoSsGrP8UZTLgBS/bMDjrrAtpnCaZw=;
        b=BNKWREuHOH/T1p4KTljJP7q3AMSnF4qkSneVp65H6Nz1PI3XUXBFizQUHxummjHC8G
         RaTWkSdijYobFcWhDf2B8ycPMng34SyEGTkeKKQLVjRKA6NBYVM8fEWcnINLHdJpXx7Q
         w1AL1KjPhmQklk1JPbr7lhOZmsUsh/tc2puX+7BKVgHM+WI3SMMZX3NZi+6E3Wsxa2CE
         ruhfG7dsktGarVo1O7NAjknZm7B+xIDLWI/7geUHnsHv/LCMc6iyHOJ91cyCjqxDg8hI
         YCYyB8hfYPG7QCa1ZpMpeW397Ko6GRwEF1qJYCp5rD1wZdAx8YIFnKfP4KhYQAumq2/0
         sOcg==
X-Gm-Message-State: AGRZ1gKWIXFLj8CIy5eIkA87ba3Aw5EdVdi2DCaGgJ6W4ncmW/W+t8jV
        jjQl5AEKbCV1zXdaZOIeGzZvu34LxcM6
X-Google-Smtp-Source: AJdET5fZPBcQR3/HSVb7rpAe84g/nfnmv9nRvWc1Si+9wwBhqnGRhLg9zrNneAtgOt1F3r/UWj0YGfuaMfUA
X-Received: by 2002:a9d:1516:: with SMTP id u22mr5327657otf.49.1542154459844;
 Tue, 13 Nov 2018 16:14:19 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:13:02 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-20-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 19/23] submodule: don't add submodule as odb for push
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In push_submodule(), because we do not actually need access to objects
in the submodule, do not invoke add_submodule_odb().
(for_each_remote_ref_submodule() does not require access to those
objects, and the actual push is done by spawning another process,
which handles object access by itself.)

This code of push_submodule() is exercised in t5531 and continues
to work, showing that the submodule odbc is not needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 262f03f118..5818088df2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1021,9 +1021,6 @@ static int push_submodule(const char *path,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
-	if (add_submodule_odb(path))
-		return 1;
-
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		argv_array_push(&cp.args, "push");
-- 
2.19.1.1215.g8438c0b245-goog

