Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF7AECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 19:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiH3TqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiH3TqG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 15:46:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B471C6610E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 12:46:03 -0700 (PDT)
Received: (qmail 7562 invoked by uid 109); 30 Aug 2022 19:46:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Aug 2022 19:46:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28429 invoked by uid 111); 30 Aug 2022 19:46:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Aug 2022 15:46:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Aug 2022 15:46:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH 2/2] tempfile: update comment describing state transitions
Message-ID: <Yw5o+Wowr6LkMV0R@coredump.intra.peff.net>
References: <Yw5nmNJSm9uzLOKL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yw5nmNJSm9uzLOKL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back when 1a9d15db25 (tempfile: a new module for handling temporary
files, 2015-08-10) added this comment, tempfile structs were held in
memory for the life of a process, and there were various guarantees
about which fields were valid in which states.

Since 422a21c6a0 (tempfile: remove deactivated list entries, 2017-09-05)
and 076aa2cbda (tempfile: auto-allocate tempfiles on heap, 2017-09-05),
the flow is quite different: objects come and go from the list, and
inactive ones are deallocated. And the previous commit removed the
"active" flag from the struct entirely.

Let's bring the comment up to date with the current code.

Signed-off-by: Jeff King <peff@peff.net>
---
This could arguably come first in the series, minus the bit about the
"active" flag, since it is really putting the finishing touches on those
old commits from 2017. But it felt easier to reason about the end state
after dropping the flag entirely.

 tempfile.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 29e61077a8..e27048f970 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -14,16 +14,14 @@
  *
  * The possible states of a `tempfile` object are as follows:
  *
- * - Uninitialized. In this state the object's `on_list` field must be
- *   zero but the rest of its contents need not be initialized. As
- *   soon as the object is used in any way, it is irrevocably
- *   registered in `tempfile_list`, and `on_list` is set.
+ * - Inactive/unallocated. The only way to get a tempfile is via a creation
+ *   function like create_tempfile(). Once allocated, the tempfile is on the
+ *   global tempfile_list and considered active.
  *
  * - Active, file open (after `create_tempfile()` or
  *   `reopen_tempfile()`). In this state:
  *
  *   - the temporary file exists
- *   - `active` is set
  *   - `filename` holds the filename of the temporary file
  *   - `fd` holds a file descriptor open for writing to it
  *   - `fp` holds a pointer to an open `FILE` object if and only if
@@ -35,14 +33,8 @@
  *   `fd` is -1, and `fp` is `NULL`.
  *
  * - Inactive (after `delete_tempfile()`, `rename_tempfile()`, or a
- *   failed attempt to create a temporary file). In this state:
- *
- *   - `active` is unset
- *   - `filename` is empty (usually, though there are transitory
- *     states in which this condition doesn't hold). Client code should
- *     *not* rely on the filename being empty in this state.
- *   - `fd` is -1 and `fp` is `NULL`
- *   - the object is removed from `tempfile_list` (but could be used again)
+ *   failed attempt to create a temporary file). The struct is removed from
+ *   the global tempfile_list and deallocated.
  *
  * A temporary file is owned by the process that created it. The
  * `tempfile` has an `owner` field that records the owner's PID. This
-- 
2.37.3.1051.g85dc4064ac
