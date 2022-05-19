Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D1DC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 07:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiESHFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 03:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiESHFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 03:05:18 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 00:05:17 PDT
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66121B8BDE
        for <git@vger.kernel.org>; Thu, 19 May 2022 00:05:17 -0700 (PDT)
Received: (qmail 5826 invoked by uid 109); 19 May 2022 06:58:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 May 2022 06:58:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 19 May 2022 02:58:34 -0400
From:   Jeff King <peff@peff.net>
To:     "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: Bug - remote.c:236: hashmap_put overwrote entry after
 hashmap_get returned NULL
Message-ID: <YoXqmrOTxD5MiDU1@coredump.intra.peff.net>
References: <24f547-6285e280-59-40303580@48243747>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24f547-6285e280-59-40303580@48243747>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 08:23:25AM +0200, Ing. Martin Prantl Ph.D. wrote:

> file:.git/config    branch..remote=origin
> file:.git/config    branch..merge=refs/heads/
> [...]
> 
> git ls-remote
> BUG: remote.c:236: hashmap_put overwrote entry after hashmap_get returned NULL

Those branch entries with an empty subsection are the culprit. I'm not
sure how they got there, but they should be safe to remove, which will
make your immediate problem go away.

It looks like handling of such bogus keys regressed in 4a2dcb1a08
(remote: die if branch is not found in repository, 2021-11-17). In
make_branch(), the call to find_branch() gets confused by the 0-length
"len" parameter, and instead uses strlen() on the partial string
containing the rest of the config key. So it tries to look up branch
".remote" for the first key, and ".merge" for the second. Since neither
exist, in both cases it then tries to add a new entry, but this time
correctly using the 0-length string. Which will confusingly already be
present when handling the second key.

Either find_branch() needs to become more careful about distinguishing
the two cases, or perhaps 0-length names should be rejected earlier (I
don't think they could ever be useful).

Perhaps something like this, though I'll leave it to the original author
(cc'd) to decide what's best.

diff --git a/remote.c b/remote.c
index 42a4e7106e..2f000a6416 100644
--- a/remote.c
+++ b/remote.c
@@ -354,7 +354,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 	struct remote_state *remote_state = cb;
 
 	if (parse_config_key(key, "branch", &name, &namelen, &subkey) >= 0) {
-		if (!name)
+		if (!name || !namelen)
 			return 0;
 		branch = make_branch(remote_state, name, namelen);
 		if (!strcmp(subkey, "remote")) {

-Peff
