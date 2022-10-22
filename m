Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FED5C38A2D
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJVAWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJVAVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:21:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B42AD9D0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:21:52 -0700 (PDT)
Received: (qmail 15222 invoked by uid 109); 22 Oct 2022 00:21:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 00:21:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18981 invoked by uid 111); 22 Oct 2022 00:21:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 20:21:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 20:21:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] repack: expand error message for missing pack files
Message-ID: <Y1M3nhOqdYP7QoEv@coredump.intra.peff.net>
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If pack-objects tells us it generated pack $hash, we expect to find
.tmp-$$-pack-$hash.pack, .idx, .rev, and so on. Some of these files are
optional, but others are not. For the required ones, we'll bail with an
error if any of them is missing.

The error message is just "missing required file", which is a bit vague.
We should be more clear that it is not the user's fault, but rather that
the sub-pgoram we called is not operating as expected. In practice,
nobody should ever see this message, as it would generally only be
caused by a bug in Git.

It probably doesn't make sense to convert this to a BUG(), though, as
there are other (unlikely) possibilities, such as somebody else racily
deleting the files, filesystem errors causing stat() to fail, and so on.

A nice side effect here is that we stop relying on fname_old in this
code path, which will let us deal with it only in the first part of the
conditional.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index b5bd9e5fed..d1929bb3db 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1030,7 +1030,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				if (rename(fname_old, fname))
 					die_errno(_("renaming '%s' failed"), fname_old);
 			} else if (!exts[ext].optional)
-				die(_("missing required file: %s"), fname_old);
+				die(_("pack-objects did not write a '%s' file for pack %s-%s"),
+				    exts[ext].name, packtmp, item->string);
 			else if (unlink(fname) < 0 && errno != ENOENT)
 				die_errno(_("could not unlink: %s"), fname);
 
-- 
2.38.1.496.ga614b0e9bd

