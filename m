Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D99B207B3
	for <e@80x24.org>; Wed,  3 May 2017 03:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdECD3r (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 23:29:47 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36668 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdECD3n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 23:29:43 -0400
Received: by mail-yw0-f176.google.com with SMTP id l18so79311246ywh.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 20:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wR8113/KTbbkHqLhdk+XI0/6S7aWGML0sV1/lBan5h8=;
        b=ZvMaTsANwk848FOb8Zp8N9r5Z41vCpGrvz+psCm2jrzUXScKJQ14BVl88au8JQt9vT
         ltpdBP0iOX37LSr41YRLIMXz+41V5aHldoSWEN3ZsS9zCUgw2lrQRYYiHqY4ygZl5x+l
         7617cF3bTe41KhaSiX6wSBDJgqBDt3KbigTumcvWr4WYaE7+R6zwFp2KVUF7HX8IlBPT
         RNarMk5ATGBrqvprfhvjqmbXL/qFJFNLlBoLcpQyeYe/riorfdppERpKRRCFwdj5WAAA
         lpC39i9yMhXHj7kbOe02do6UGD/kQCZ6R1FpVjRSXSyk+dGu/RqJ5Zu0zMlSy3JQBhUb
         FagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wR8113/KTbbkHqLhdk+XI0/6S7aWGML0sV1/lBan5h8=;
        b=Q0dd/dU4OP7FveJ0itWxlQUgdc7F/wzPRqM0h/LABgz9iUul2tMFk7QK5eQuPK527G
         KfJP0FMM2uCxTeupF6nGcLNB5kYNEuDz+Kbv/wZ7pHEGGPWxxvlJobTT3s78i/FrLsir
         oXnPWvvmzWkH2+I20fNgmpZ1EI03IgwcoJWg30EOH+CY+tG0GX71b/sMBxGyeGy6Kjda
         Ltke8Kbo0rodiebvWQz/jW7Z7ylsZsFaT0HOMmMvq3hBF5XI8jVX36+HE/ql+13hvcTn
         MvSMopELBDbJP/MsStqNQwd88eKMOhTO7/zRXSbKHeX7LvNx/L5mINrQc1wzH70e/nFm
         ijMg==
X-Gm-Message-State: AN3rC/7TFPn6c+mkb7s8IZ1DItRyNsD8n1YKIwM6VAs8pGBNgpZwmao5
        sNcL61xRKeImEA==
X-Received: by 10.129.77.7 with SMTP id a7mr3892084ywb.104.1493782182585;
        Tue, 02 May 2017 20:29:42 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.23])
        by smtp.gmail.com with ESMTPSA id v3sm11329586ywi.79.2017.05.02.20.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 20:29:41 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 0/7] Keep git clean -d from inadvertently removing ignored files 
Date:   Tue,  2 May 2017 22:29:25 -0500
Message-Id: <20170503032932.16043-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes the bug where git clean -d culls directories containing
only untracked and ignored files, by first teaching read_directory() and
read_directory_recursive() to search "untracked" directories (read: directories
*treated* as untracked because they only contain untracked and ignored files)
for ignored contents, and then teaching cmd_clean() to skip untracked
directories containing ignored files.

This does, however, introduce a breaking change in the behavior of git status:
when invoked with --ignored, git status will now return ignored files in an
untracked directory, whereas previously it would not.

First patches to the actual C code that I'm sending out! :D Looking forward to
feedback - the changes I made in read_directory_recursive() and read_directory()
feel a bit hacky, but I'm not sure how to get around that.

Samuel Lijin (7):
  t7300: skip untracked dirs containing ignored files
  dir: recurse into untracked dirs for ignored files
  dir: add method to check if a dir_entry lexically contains another
  dir: hide untracked contents of untracked dirs
  dir: change linkage of cmp_name() and check_contains()
  builtin/clean: teach clean -d to skip dirs containing ignored files
  t7061: check for ignored file in untracked dir

 builtin/clean.c            | 24 ++++++++++++++++--
 dir.c                      | 61 ++++++++++++++++++++++++++++++++++++++++++++--
 dir.h                      |  3 +++
 t/t7061-wtstatus-ignore.sh |  1 +
 t/t7300-clean.sh           | 10 ++++++++
 5 files changed, 95 insertions(+), 4 deletions(-)

-- 
2.12.2

