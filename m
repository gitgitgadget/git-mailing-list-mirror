Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB035C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 01:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiLIB6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLIB5h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 20:57:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8F7D062
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 17:56:36 -0800 (PST)
Received: (qmail 30920 invoked by uid 109); 9 Dec 2022 01:56:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Dec 2022 01:56:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19408 invoked by uid 111); 9 Dec 2022 01:56:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 20:56:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 20:56:34 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 3/4] object-file: emit corruption errors when detected
Message-ID: <Y5KV0vIkxyA95/xf@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670532905.git.jonathantanmy@google.com>
 <7c9ed861e7431352df864c8d2c3bec7dee6e3905.1670532905.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c9ed861e7431352df864c8d2c3bec7dee6e3905.1670532905.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 12:57:07PM -0800, Jonathan Tan wrote:

> Note that in the RHS of this patch's diff, a check for ENOENT that was
> introduced in 3ba7a06552 (A loose object is not corrupt if it cannot
> be read due to EMFILE, 2010-10-28) is also removed. The purpose of this
> check is to avoid a false report of corruption if the errno contains
> something like EMFILE (or anything that is not ENOENT), in which case
> a more generic report is presented. Because, as of this patch, we no
> longer rely on such a heuristic to determine corruption, but surface
> the error message at the point when we read something that we did not
> expect, this check is no longer necessary.

I think this version still has the small issue that we'll _only_ surface
a generic error return in such a case, and never report EMFILE
specifically. I.e., I think we'd still want something like this on top:

diff --git a/object-file.c b/object-file.c
index dc7665d6fa..36082bc991 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1422,6 +1422,7 @@ static int loose_object_info(struct repository *r,
 			     struct object_info *oi, int flags)
 {
 	int status = 0;
+	int fd;
 	unsigned long mapsize;
 	const char *path = NULL;
 	void *map;
@@ -1455,7 +1456,13 @@ static int loose_object_info(struct repository *r,
 		return 0;
 	}
 
-	map = map_loose_object_1(r, oid, &mapsize, &path);
+	fd = open_loose_object(r, oid, &path);
+	if (fd < 0) {
+		if (errno != ENOENT)
+			error_errno(_("unable to open loose object %s"), path);
+		return -1;
+	}
+	map = map_fd(fd, path, &mapsize);
 	if (!map)
 		return -1;
 

Otherwise ENOENT and EMFILE are indistinguishable from the user's
perspective. And one is normal and routine, but the other points to
something the user probably needs to fix.

-Peff
