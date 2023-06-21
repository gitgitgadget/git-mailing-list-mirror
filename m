Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A127EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 06:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjFUGrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjFUGqq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 02:46:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F30F271E
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 23:45:12 -0700 (PDT)
Received: (qmail 11576 invoked by uid 109); 21 Jun 2023 06:45:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jun 2023 06:45:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13395 invoked by uid 111); 21 Jun 2023 06:45:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jun 2023 02:45:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jun 2023 02:44:59 -0400
From:   Jeff King <peff@peff.net>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Determining whether you have a commit locally, in a partial
 clone?
Message-ID: <20230621064459.GA607974@coredump.intra.peff.net>
References: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
 <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com>
 <CAPMMpojUpJD21x2i_hshTB96TBFVd-_WRV54KHT2-4R8DUh8=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPMMpojUpJD21x2i_hshTB96TBFVd-_WRV54KHT2-4R8DUh8=Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 09:12:24PM +0200, Tao Klerks wrote:

> I'm back to begging for any hints here: Any idea how I can determine
> whether a given commit object exists locally, *without causing it to
> be fetched by the act of checking for it?*

This is not very efficient, but:

  git cat-file --batch-check='%(objectname)' --batch-all-objects --unordered |
  grep $some_sha1

will tell you whether we have the object locally.

I don't work with partial clones often, but it feels like being able to
say:

  git --no-partial-fetch cat-file ...

would be a useful primitive to have. The implementation might start
something like this:

diff --git a/object-file.c b/object-file.c
index 7c1af5c8db..494cdd7706 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1555,6 +1555,14 @@ void disable_obj_read_lock(void)
 
 int fetch_if_missing = 1;
 
+static int allow_lazy_fetch(void)
+{
+	static int ret = -1;
+	if (ret < 0)
+		ret = git_env_bool("GIT_PARTIAL_FETCH", 1);
+	return ret;
+}
+
 static int do_oid_object_info_extended(struct repository *r,
 				       const struct object_id *oid,
 				       struct object_info *oi, unsigned flags)
@@ -1622,6 +1630,7 @@ static int do_oid_object_info_extended(struct repository *r,
 
 		/* Check if it is a missing object */
 		if (fetch_if_missing && repo_has_promisor_remote(r) &&
+		    allow_lazy_fetch() &&
 		    !already_retried &&
 		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
 			promisor_remote_get_direct(r, real, 1);

and then have git.c populate the environment variable, similar to how we
handle --literal-pathspecs, etc.

That fetch_if_missing kind of does the same thing, but it's mostly
controlled by programs themselves which try to handle missing remote
objects specially. It does seem like you might be able to bend it to
your will here, though. I think without any patches that:

  git rev-list --objects --exclude-promisor-objects $oid

will tell you whether we have the object or not (since it turns off
fetch_if_missing, and thus will either succeed, printing nothing, or
bail if the object can't be found). It feels like --missing=error should
function similarly, but it seems to still lazy-fetch (I guess since it's
the default, the point is to just find truly unavailable objects). Using
--missing=print disables the lazy-fetch, but it seems to bail
immediately if you ask it about a missing object (I didn't dig, but my
guess is that --missing is mostly about objects we traverse, not the
initial tips).

-Peff
