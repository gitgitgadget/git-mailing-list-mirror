Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D0B1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756393AbcLPTDf (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:03:35 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34248 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755396AbcLPTDd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:03:33 -0500
Received: by mail-pf0-f172.google.com with SMTP id c4so15498510pfb.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 11:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qHNZaOXYcMkwxcHYpLPm6rtEgD+Z7B+iiiIn0exEHgg=;
        b=mGeygNN4fbxw6yNeJ92RgW+AiCLRjCck+vtLkQPyWNRdqFtuw16OP70XdhoNEnzKYX
         upNaFkTyn6GCRqji5H8lDDTU++Tq+VKJtB1Ua2e38qms88L1NntrUmkbdcinG96qQAa1
         YbYsetQ9VG1qlvjCZMt4B2EXchpt4YxZaabE5VD/dHtsg3klXCuXKE4P6SQ20en8rSSW
         BvJIyaltT9gYlP3OUKpBlZUjHhq2FZ31+/KKbeYf3UhFFz66v9GJe6BfdioJARbVRP5D
         W/SnN2/5jGPC2dEQZ1C8RH4Lj+cxuV62Vg84z5qZMwiUEQExOxSAdTVHDasvWmawdN73
         Xy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qHNZaOXYcMkwxcHYpLPm6rtEgD+Z7B+iiiIn0exEHgg=;
        b=NZFwxHEGRguYmSV4qqw+RydtwXS+Ybm3/hTHLfAQctwKI4yGCZKqkFHwWmIYEjy29x
         w9Th+q/26E9ilzpHhv9GrUTzs6jfucdIhbSiSPtknYEkpQDSUtBTezB742UZVP9ZMR+9
         4j7UHGKA6j3X98seqCLMG+A0TeJLmxRVrrzAH20Vl3z9EHV1cP+YMsek32IfeNA+MdRg
         Mj89Me+ENz9t32kTEAqTqeoWbU3a2TLsAoDD9f0SE7fCYiYsdf/yBfqzuvzCyqTK8v2A
         wWV3EFrhcQdFZEvnTWdVz2w/QEjp6WxMpePrB7TsR0m63OaeKXPI1ZMxkAbDsMy+9B3D
         89Nw==
X-Gm-Message-State: AKaTC02l8m/PMbu0rhE3afqK0y7+quFgsUfysrubV6Rm0ydW7yg/WYX91mn95MJZdNFB9oJ8
X-Received: by 10.84.210.40 with SMTP id z37mr9952786plh.32.1481915012875;
        Fri, 16 Dec 2016 11:03:32 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm13573389pfk.73.2016.12.16.11.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Dec 2016 11:03:31 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com, jacob.keller@gmail.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v7 0/7] recursively grep across submodules
Date:   Fri, 16 Dec 2016 11:03:15 -0800
Message-Id: <1481915002-162130-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480555714-186183-1-git-send-email-bmwill@google.com>
References: <1480555714-186183-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v7:
* Rebased on 'origin/bw/realpath-wo-chdir' in order to fix the race condition
  that occurs when verifying a submodule's gitdir.
* Reverted is_submodule_populated() to use resolve_gitdir() now that there is
  no race condition.
* Added !MINGW to a test in t7814 so that it won't run on windows.  This is due
  to testing if colons in filenames are still handled correctly, yet windows
  doesn't allow colons in filenames.

Brandon Williams (7):
  submodules: add helper to determine if a submodule is populated
  submodules: add helper to determine if a submodule is initialized
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
 submodule.c                        |  50 +++++
 submodule.h                        |   3 +
 t/t7814-grep-recurse-submodules.sh | 241 +++++++++++++++++++++++
 tree-walk.c                        |  28 +++
 13 files changed, 729 insertions(+), 31 deletions(-)
 create mode 100755 t/t7814-grep-recurse-submodules.sh

-- 
2.8.0.rc3.226.g39d4020

