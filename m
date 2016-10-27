Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C9E20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943015AbcJ0WjF (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:39:05 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35989 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942817AbcJ0WjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:39:04 -0400
Received: by mail-pf0-f169.google.com with SMTP id e6so25024150pfk.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=T4BBzj45TgLkw0TN8XLTEMdCvv/kUu4/Ud5J/rd7lwo=;
        b=TH/bjQvsFx3F7VoHz61WKB8ZYfYmXrMbTCGQ4h5k/R0QP17i+U6XosvGGeU4+4dcxd
         8/RIXB6kHzsgTJt/n/kID6mhkiArthLMElT46eXmDYhH32W2F4DHWGg8xMHEUaNfsiGh
         KpYtVbOn9r2E09U3/6vPIlbPnvYkj0PajnvQojUqJrk9fWHbG9WswT+x0eROgcJ2Hltg
         JozkploQZC6DLGlCQ3blQB5+1fYC8ZNlOm0bmK9KKvTkwqifK8ZfA2vNo6ntqYA/YaER
         n1YnWl9//V9OJhRJYGSasx4DjUkVqQrR1wBvcVABGnU8qbWnYB5Y4OUFiH1Nd3xKJz9v
         xOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T4BBzj45TgLkw0TN8XLTEMdCvv/kUu4/Ud5J/rd7lwo=;
        b=GYrLjQq5QHQLlkRmrKDR55eqFgeBD2lqEwgEs9OvwF0gp0Ptj+KMuqPAiMLap+e2IT
         YxCRbvBFiQwj2iiS+OqXPmbZTvhEa08qJ+FvDauzygzYqBNaLx1fuNdjkY2Fr5bINKbW
         uzd7v7IHcBZTPmacZG2LG5ql4S8jsAV7njK8bQrTfSvwslpuNo0SdB5646ANh+Q4DLpe
         eUTKkTmGXdVny+qA1uBUPh4FMORETkoznoKo3/ds1pYWBhFm0cjbjY+tRD0Ii+lkhcSe
         h20HCbFM7730W8RuI8VS8nuqmAUyN7qUOeweRsYGahHtycfdBzPcdoF8zNDVMxb97rZZ
         4LFg==
X-Gm-Message-State: ABUngvdglV0lqkt37uYe0ZG/brJFG3Fnvdee7F/oKB6/+fbb9ctc+2dICseeZlYucTFBwqON
X-Received: by 10.98.90.135 with SMTP id o129mr18687593pfb.81.1477607942879;
        Thu, 27 Oct 2016 15:39:02 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.37.191])
        by smtp.gmail.com with ESMTPSA id d2sm8129400pfd.38.2016.10.27.15.39.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 27 Oct 2016 15:39:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [RFC PATCH 0/5] recursively grep across submodules 
Date:   Thu, 27 Oct 2016 15:38:29 -0700
Message-Id: <20161027223834.35312-1-bmwill@google.com>
X-Mailer: git-send-email 2.10.1.613.g6021889
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds some basic api functions to the submodule interface as
well as teaching grep to recursively search in submodules.

The additions to the submodule interface allow grep to verify that a submodule
has been initialized and checked out prior to launching a child process.  One
issue that still needs to be worked out is when greppig history, you could be
in a state where the submodule doesn't have a working tree (or the path you had
in the past doesn't match what currently exists) so instead of changing
directory into the submdoule you need to look for the .git directory for the
submodule in the parents .git/modules directory.  If it exists we would need to
change directory to .git/modules/<submodule> and then run the child process
from there.  This currently doesn't work due to commit <10f5c52656> since the 
GIT_DIR env variable is explicitly set to be '.git'.  I'm going to spend some
more time thinking about this problem and will address it as an additional patch in
the series at a later time.

As for the rest of the series, it should be ready for review or comments.


Brandon Williams (5):
  submodules: add helper functions to determine presence of submodules
  submodules: load gitmodules file from commit sha1
  grep: add submodules as a grep source type
  grep: optionally recurse into submodules
  grep: enable recurse-submodules to work on <tree> objects

 Documentation/git-grep.txt         |  14 ++
 builtin/grep.c                     | 364 ++++++++++++++++++++++++++++++++++---
 cache.h                            |   2 +
 config.c                           |   8 +-
 git.c                              |   2 +-
 grep.c                             |  16 +-
 grep.h                             |   1 +
 submodule-config.c                 |   6 +-
 submodule-config.h                 |   3 +
 submodule.c                        |  51 ++++++
 submodule.h                        |   3 +
 t/t7814-grep-recurse-submodules.sh | 141 ++++++++++++++
 tree-walk.c                        |  17 +-
 13 files changed, 588 insertions(+), 40 deletions(-)
 create mode 100755 t/t7814-grep-recurse-submodules.sh

-- 
2.10.1.613.g6021889

