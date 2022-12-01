Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D23C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLATyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiLATyv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:54:51 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03494BA605
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:54:49 -0800 (PST)
Received: (qmail 25911 invoked by uid 109); 1 Dec 2022 19:54:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Dec 2022 19:54:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28232 invoked by uid 111); 1 Dec 2022 19:54:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Dec 2022 14:54:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Dec 2022 14:54:48 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] Don't lazy-fetch commits when parsing them
Message-ID: <Y4kGiEXdTOpn5Eyi@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1669922792.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1669922792.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2022 at 11:27:29AM -0800, Jonathan Tan wrote:

> Thanks everyone for your reviews. Here is a reroll with the requested change
> (just one small one).

Thanks, this looks OK to me. However Junio noted in "What's cooking"
that it seems to break CI on windows. The problem is in t5318.93:

  2022-12-01T09:26:44.8887018Z ++ cat test_err
  2022-12-01T09:26:44.8887414Z error: Could not read 0000000000000000000000000000000000000000
  2022-12-01T09:26:44.8887825Z error: Could not read 0000000000000000000000000000000000000000
  2022-12-01T09:26:44.8888240Z error: Could not read 0000000000000000000000000000000000000000
  2022-12-01T09:26:44.8888639Z error: Could not read 0000000000000000000000000000000000000000
  2022-12-01T09:26:44.8889052Z error: Could not read 0000000000000000000000000000000000000000
  2022-12-01T09:26:44.8889512Z error: Could not read 0000000000000000000000000000000000000000
  2022-12-01T09:26:44.8889991Z fatal: failed to read object 0000000000000000000000000000000000000000: Function not implemented
  2022-12-01T09:26:44.8890401Z ++ return 1
  2022-12-01T09:26:44.8890761Z error: last command exited with $?=1
  2022-12-01T09:26:44.8891263Z not ok 93 - corrupt commit-graph write (broken parent)

Looks like the check in die_if_corrupt() is seeing a different errno
value than ENOENT. I wonder if we need to take more care to preserve it
across calls. It does look like we hit the same sequence of functions
that read_object_file_extended() did, but perhaps this was buggy all
along, and you're now exposing it through a new code path.

In particular I wonder if obj_read_unlock() might be the culprit here,
and something like this might help:

diff --git a/object-file.c b/object-file.c
index 8adef99a7c..db2d35519e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1641,9 +1641,12 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 			     struct object_info *oi, unsigned flags)
 {
 	int ret;
+	int save_errno;
 	obj_read_lock();
 	ret = do_oid_object_info_extended(r, oid, oi, flags);
+	save_errno = errno;
 	obj_read_unlock();
+	errno = save_errno;
 	return ret;
 }
 

-Peff
