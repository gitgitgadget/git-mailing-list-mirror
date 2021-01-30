Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EE6C433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 05:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E89E64E0F
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 05:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhA3FtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 00:49:06 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39134 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbhA3Fsl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 00:48:41 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l5j6f-006bDu-Vs; Fri, 29 Jan 2021 22:47:38 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l5j6e-003C3n-2O; Fri, 29 Jan 2021 22:47:37 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id B08991280D2A;
        Fri, 29 Jan 2021 22:47:35 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2J0gQDG9iGzU; Fri, 29 Jan 2021 22:47:35 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id E3633128059F;
        Fri, 29 Jan 2021 22:47:34 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 29 Jan 2021 22:46:52 -0700
Message-Id: <20210130054655.48237-1-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.84.g93c9af8b0b
In-Reply-To: <20201228192919.1195211-1-seth@eseth.com>
References: <20201228192919.1195211-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1l5j6e-003C3n-2O;;;mid=<20210130054655.48237-1-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v10 0/3]  mergetool: add hideResolved configuration (was automerge)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v9:

- Rename automerge to hideResolved.

  Several mergetools have a feature that they call "automerge", "auto
  merge", or "auto solve" and Git has a `mergetool.meld.useAutoMerge`
  flag so I think it's better to avoid potential confusion. Plus Git
  already performed the merge and this doesn't do any additional
  merging, instead it just "hides" conflicts that Git already resolved.

- Reworked and consolidated commits and commit messages.

- Add preference hierarchy.

  Followed Junio's suggestions:
  https://lore.kernel.org/git/xmqqpn2ivcc1.fsf@gitster.c.googlers.com/

- Switch from sed to two merge-file calls.

  Thanks to everyone who helped with all the suggestions and fixup!s to
  get sed working cross-platform. Unfortunately there's not a great,
  portable method to preserve carriage returns when using both autocrlf
  and MSYS2: https://lore.kernel.org/git/20210120232447.GA35105@ellen/

  Although calling merge-file twice is (much) less efficient than sed
  it's still fairly quick for small files. For large files it's likely
  opening those files in a mergetool will have a higher overhead than
  the merge-file invocations:
  https://lore.kernel.org/git/20210122010902.GA48178@ellen/

  A potential future optimisation could be to augment the
  C implementation (xmerge.c ?) with a flag to write two files as the
  merge is being performed instead of writing conflict markers.

- Kept `initialize_merge_tool` wrapper.

  I updated the commit message where `initialize_merge_tool` is
  introduced to try and better explain my thinking for not simply
  exposing `setup_tool` instead. I'm happy to switch that if anyone
  still feels it should be switched.

Seth House (3):
  mergetool: add hideResolved configuration
  mergetool: break setup_tool out into separate initialization function
  mergetool: add per-tool support and overrides for the hideResolved
    flag

 Documentation/config/mergetool.txt   | 15 +++++++++++++++
 Documentation/git-mergetool--lib.txt |  4 ++++
 git-difftool--helper.sh              |  6 ++++++
 git-mergetool--lib.sh                | 11 ++++++++---
 git-mergetool.sh                     | 26 ++++++++++++++++++++++++++
 t/t7610-mergetool.sh                 | 18 ++++++++++++++++++
 6 files changed, 77 insertions(+), 3 deletions(-)

-- 
2.29.2


