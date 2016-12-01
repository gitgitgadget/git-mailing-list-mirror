Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC5C81FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 01:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754485AbcLAB2r (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 20:28:47 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33004 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbcLAB2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 20:28:46 -0500
Received: by mail-pg0-f50.google.com with SMTP id 3so88306143pgd.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 17:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v4Km5IgKGXh85ITMyuG6qOmtRFGOyghvRam6tKyKuoI=;
        b=cEIUAEkiPjmF3LiQAB6I5sG03uq/u3LNscm/gtDi2jKTH+6whcpfNwqjoiZVUyP/Pd
         vOEymuvTXdScCdXWo5O4oqRVcPXUAYiG7SGTdC/R+hZglGW/8aTggcIpBPvooqlkWL0e
         KdqrBSaV+XG9tOd/a5nj82hDac0B9rhwzljbf8gFtrfa+8Sx29fZsGHH0IqJeL2tXNd9
         i1/YySq6SKFdq9XnNbb9a1dXh8lzBiEsCY3I3sPgQCKNxvH/xZQ4+O9haWZWCIbLh6Ds
         G/ytKLhFvlwpwdc0p+PtB5z1XpZRWcVBltKUWa8SHLsXOEX0OO71CuDr+Ai0b87T0/UW
         jBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v4Km5IgKGXh85ITMyuG6qOmtRFGOyghvRam6tKyKuoI=;
        b=d30FxZEKzFMQ1ZBg+xdfFIbqGXttkaKt5BbAQyb//wE+g0Uu+mSdQRqekGFwWPwpYC
         lFjMnFPpE4obpp/OnqQrtzgdt0CIbTsvsQLUmEsP1WIYZJU6wU100RePJW3QjegdxI2J
         XUGe69QPUhCOTCvY7VOc0jLoRRsyUrvFcorZJFlMWU38D4f2hot2eEuoQcOgUaS+qWQR
         P2WmGcK34+cZR3gCme9pve9Q51PorBbp5Yk/xyUP3cW3ZWBwXsyGckwGC5RuEFG1ViBk
         85e3v0+b/Jw0oFOT1rKFDsE6uRmZkH8LvSgM4asMNR8AwWNIe6w018cLBUWW4dPo/ld4
         670Q==
X-Gm-Message-State: AKaTC02xJ0eZh4Og3GisMGiKeHIgFxHRVMILYnQWwx1+KzifbID3BLSeLu6MqaIgwvBRh2EX
X-Received: by 10.84.210.130 with SMTP id a2mr79354759pli.106.1480555725233;
        Wed, 30 Nov 2016 17:28:45 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id i194sm87872386pgc.46.2016.11.30.17.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 17:28:43 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v6 0/6] recursively grep across submodules
Date:   Wed, 30 Nov 2016 17:28:28 -0800
Message-Id: <1480555714-186183-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479840397-68264-1-git-send-email-bmwill@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6 fixes a race condition which existed in the 'is_submodule_populated'
function.  Instead of calling 'resolve_gitdir' to check for the existance of a
.git file/directory, use 'stat'.  'resolve_gitdir' calls 'chdir' which can
affect other running threads trying to load thier files into a buffer in
memory.

Thanks to Stefan and Jeff for help debugging this problem.

Brandon Williams (6):
  submodules: add helper functions to determine presence of submodules
  submodules: load gitmodules file from commit sha1
  grep: add submodules as a grep source type
  grep: optionally recurse into submodules
  grep: enable recurse-submodules to work on <tree> objects
  grep: search history of moved submodules

 Documentation/git-grep.txt         |  14 ++
 builtin/grep.c                     | 386 ++++++++++++++++++++++++++++++++++---
 cache.h                            |   2 +
 config.c                           |   8 +-
 git.c                              |   2 +-
 grep.c                             |  16 +-
 grep.h                             |   1 +
 submodule-config.c                 |   6 +-
 submodule-config.h                 |   3 +
 submodule.c                        |  51 +++++
 submodule.h                        |   3 +
 t/t7814-grep-recurse-submodules.sh | 241 +++++++++++++++++++++++
 tree-walk.c                        |  28 +++
 13 files changed, 730 insertions(+), 31 deletions(-)
 create mode 100755 t/t7814-grep-recurse-submodules.sh

--- interdiff based on 'bw/grep-recurse-submodules'

diff --git a/submodule.c b/submodule.c
index 062e58b..8516ab0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -239,9 +239,10 @@ int is_submodule_initialized(const char *path)
 int is_submodule_populated(const char *path)
 {
 	int ret = 0;
+	struct stat st;
 	char *gitdir = xstrfmt("%s/.git", path);
 
-	if (resolve_gitdir(gitdir))
+	if (!stat(gitdir, &st))
 		ret = 1;
 
 	free(gitdir);

-- 
2.8.0.rc3.226.g39d4020

