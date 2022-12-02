Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0A2C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiLBA2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiLBA2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:28:17 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C295FD1588
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:23:11 -0800 (PST)
Received: (qmail 26572 invoked by uid 109); 2 Dec 2022 00:23:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Dec 2022 00:23:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30700 invoked by uid 111); 2 Dec 2022 00:23:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Dec 2022 19:23:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Dec 2022 19:23:09 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] Don't lazy-fetch commits when parsing them
Message-ID: <Y4lFbemK4HHiCsyJ@coredump.intra.peff.net>
References: <Y4kGiEXdTOpn5Eyi@coredump.intra.peff.net>
 <20221201212650.414069-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221201212650.414069-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2022 at 01:26:50PM -0800, Jonathan Tan wrote:

> > 1734 void die_if_corrupt(struct repository *r,
> > 1735                     const struct object_id *oid,
> > 1736                     const struct object_id *real_oid)
> > 1737 {
> > 1738         const struct packed_git *p;
> > 1739         const char *path;
> > 1740         struct stat st;
> > 1741
> > 1742         obj_read_lock();
> > 1743         if (errno && errno != ENOENT)
> > 1744                 die_errno(_("failed to read object %s"), oid_to_hex(oid));
> 
> I wonder if we could just remove this check. Even as it is, I don't think that
> there is any guarantee that obj_read_lock() would not clobber errno. Removing
> it makes all tests pass locally, but I haven't tried it on CI.
> 
> (One argument that could be made is that we shouldn't have any die_if_corrupt()
> refactoring or other refactoring of the sort, because previously its contents
> was part of a function and it could thus rely on the errno of what has happened
> previously. But I think that even without my patches, we couldn't rely on it
> in the first place - looking at obj_read_lock(), it looks like it could init a
> mutex, and depending on the implementation of that, it could clobber errno.)

Yeah, I don't see any difference in the new caller versus what the
original was doing. The errno we care about comes from inside
oid_object_info_extended(). So in any case, we'll see at least
obj_read_unlock() followed by obj_read_lock() between the syscalls of
interest and this check. And I don't even really see any indication that
oid_object_info_extended() tries to set or preserve errno itself. The
likely sequence is:

  - find_pack_entry() fails to find it; errno isn't set at all
  - loose_object_info() tries to open it and probably gets ENOENT
  - we check find_pack_entry() again after reprepare_packed_git()
  - that fails so we return -1, barring submodule or partial clone
    tricks

So it really seems like we're quite likely to get an errno from opening
or mapping packs. Which implies the original suffers from the same
issue, but we simply never triggered it meaningfully in a test.

I'm not entirely sure on just removing the check. It comes from
3ba7a06552 (A loose object is not corrupt if it cannot be read due to
EMFILE, 2010-10-28), so we'd lose what that commit is trying to do.
Though I think even back then, I think it would have suffered from the
same problems (minus the lock/unlock; I'm still unclear which syscall is
the actual culprit here).

If we assume that errno from reading the object isn't reliable, I think
you'd have to actually re-check things. Something like:

  if (find_pack_entry(...) || !stat_loose_object(...))
    /* ok, it's not missing */

but of course we don't have the actual errno that _did_ cause us to
fail, which makes the error message we'd print a lot less useful. Maybe
this check should be ditched and we should complain much closer to the
source of the problem:

diff --git a/object-file.c b/object-file.c
index 26290554bb..743ba8210e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1460,8 +1460,12 @@ static int loose_object_info(struct repository *r,
 	}
 
 	map = map_loose_object(r, oid, &mapsize);
-	if (!map)
+	if (!map) {
+		if (errno != ENOENT)
+			error_errno("unable to open loose object %s",
+				    oid_to_hex(oid));
 		return -1;
+	}
 
 	if (!oi->sizep)
 		oi->sizep = &size_scratch;

That might make things more verbose for other code paths, but that kind
of seems like a good thing. If you have an object file that we can't
open, we probably _should_ be complaining loudly about it.

We may need to be a little more careful about preserving errno in
map_loose_object_1(), though (gee, another place where the existing
check could run into trouble).

-Peff
