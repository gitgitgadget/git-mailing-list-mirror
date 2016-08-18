Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FDD41F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753624AbcHSC33 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:29:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:59871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752936AbcHSC31 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 22:29:27 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0ML6XF-1ba7Xi3n9d-000KUv; Thu, 18 Aug 2016 16:51:04
 +0200
Date:   Thu, 18 Aug 2016 16:51:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/2] Do not lock temporary files via child processes on
 Windows
In-Reply-To: <cover.1471437637.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1471531799.git.johannes.schindelin@gmx.de>
References: <cover.1471437637.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7LTkTUbifHIwIeohce7vDdx4MEO9cdkXiTbYG44tJzdDxeUMdWe
 jd62D/0neWczLTejeYVpFRfh+DOlPp8+L2bZa8ggSGiztYasnoyAepmaC9GLxTPvqFrIjJV
 pIiGohmPJrKn9biN5TqVVEig4+tiyRPviQ3VUREYvTtoo4W+WxigO5XtEJYy8NdUSllXDI5
 mvBZoYoSfFYFfpt1GgMZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8dmMP4VQNtQ=:VqftjQqvCLEUR9m7VK07Ls
 OBuNxOLK4TrDK40p0FAVUVDZEWSTQgMJG9VCHIi5LJniXL27uHkj7CMvhPvZRA4hgjRRTFZJp
 DQh6T4LLScH9iPPlbVWIsIvi7kh82e7NKzeZ/6nvTzWmfaSFL9p6EnQo31bBxVChZwBTKSpUS
 faSI3mC3Wqfr4uE3v9AeluOmjB1tps2b3ZWdgX3BeApkpYWAsbHi24JTXwBXlQPNVWZnKwc0t
 yfIjnnwMGB5UiQlLfEjlVLgF+PE1SoTMTLXz1je6hDVbnAtwA+QUluBDO2doCptlTX1zdF4Hf
 mtR79Nyw467hpUp5dDJ8Y9ublUfxYMVW+XxjTniMqK74eK4jxsC4P5Ehxiq+BOoJsUZp2tA0E
 ETyO6/VC2u/BYUtdhI5d9iA2iL5q8iSnEdwPbWDC0KY9CptFuSJrDa5sazlZLYGQzC5yoUVwW
 qowTrAN7bFOkMbLehWbndJrss1Lu3ZP+3F7cm4qW+5yBPq9vC2EOrnClDlBfrCXDcvJIZVOS4
 sJWLJdhuRd0/bnGnfXv+t5dM11JeDJDj6bNAg6b1y9gBUNiRiDdFBKhQC7iP0CEX9eLd11i2P
 Xt81G1QfmZYQiWknioBWMPMaACza+jOgQ6ttAUgHmTX0qms7N4oeCay7ZZwaS8f+i8KAfTk9G
 knhRvvo9MdpE141spuo7vcqzmz8UTcY4Bx8Ysw4o8msgB4loQGiaKIWhoZ7qtHA42WryjLoM8
 i3MY31fGfJIP0lmWW27CSyH2apmJ32X4NQA2mD19H/H9WzrhhxKdilPocw1v95TgAFh7NDG1k
 UVZwrII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This issue was originally reported and fixed in
https://github.com/git-for-windows/git/pull/755

The problem is that file handles to temporary files (such as
index.lock) were inherited by spawned processes. If those spawned
processes do not exit before the parent process wants to delete or
rename them, we are in big trouble.

The original use case triggering the bug is a merge driver that does
not quit, but listen to subsequent merge requests.

However, the same issue turned up in Lars Schneider's work on making
clean/smudge filters batchable (i.e. more efficient by avoiding
possibly thousands of child processes, one per file).

Changes since v1:

- the two commit messages have been corrected, as per Junio's and Eric's
  suggestion,
- lockfile.h and tempfile.h now sport explicit documentation that the
  current process needs to write to the files, no spawned processes.


Ben Wijen (2):
  t6026-merge-attr: child processes must not inherit index.lock handles
  mingw: ensure temporary file handles are not inherited by child
    processes

 compat/mingw.h        |  4 ++++
 lockfile.h            |  4 ++++
 t/t6026-merge-attr.sh | 13 +++++++++++++
 tempfile.c            |  2 +-
 tempfile.h            |  4 ++++
 5 files changed, 26 insertions(+), 1 deletion(-)

Published-As: https://github.com/dscho/git/releases/tag/mingw-index-lock-v2
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-index-lock-v2

Interdiff vs v1:

 diff --git a/lockfile.h b/lockfile.h
 index 3d30193..d26ad27 100644
 --- a/lockfile.h
 +++ b/lockfile.h
 @@ -55,6 +55,10 @@
   *   * calling `fdopen_lock_file()` to get a `FILE` pointer for the
   *     open file and writing to the file using stdio.
   *
 + *   Note that the file descriptor returned by hold_lock_file_for_update()
 + *   is marked O_CLOEXEC, so the new contents must be written by the
 + *   current process, not a spawned one.
 + *
   * When finished writing, the caller can:
   *
   * * Close the file descriptor and rename the lockfile to its final
 diff --git a/tempfile.h b/tempfile.h
 index 4219fe4..2f0038d 100644
 --- a/tempfile.h
 +++ b/tempfile.h
 @@ -33,6 +33,10 @@
   *   * calling `fdopen_tempfile()` to get a `FILE` pointer for the
   *     open file and writing to the file using stdio.
   *
 + *   Note that the file descriptor returned by create_tempfile()
 + *   is marked O_CLOEXEC, so the new contents must be written by
 + *   the current process, not any spawned one.
 + *
   * When finished writing, the caller can:
   *
   * * Close the file descriptor and remove the temporary file by

-- 
2.9.2.691.g78954f3

base-commit: d63263a4dee8fc7da9b97bbdedf9c0d1f33024d4
