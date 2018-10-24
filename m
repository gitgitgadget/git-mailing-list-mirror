Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0701F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJXPyp (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 11:54:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:52410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727947AbeJXPyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 11:54:45 -0400
Received: (qmail 6915 invoked by uid 109); 24 Oct 2018 07:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Oct 2018 07:27:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2109 invoked by uid 111); 24 Oct 2018 07:27:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Oct 2018 03:27:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2018 03:27:52 -0400
Date:   Wed, 24 Oct 2018 03:27:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] upload-pack: fix broken if/else chain in config callback
Message-ID: <20181024072752.GA29717@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The upload_pack_config() callback uses an if/else chain
like:

  if (!strcmp(var, "a"))
     ...
  else if (!strcmp(var, "b"))
     ...
  etc

This works as long as the conditions are mutually exclusive,
but one of them is not. 20b20a22f8 (upload-pack: provide a
hook for running pack-objects, 2016-05-18) added:

  else if (current_config_scope() != CONFIG_SCOPE_REPO) {
     ... check some more options ...
  }

That was fine in that commit, because it came at the end of
the chain.  But later, 10ac85c785 (upload-pack: add object
filtering for partial clone, 2017-12-08) did this:

  else if (current_config_scope() != CONFIG_SCOPE_REPO) {
     ... check some more options ...
  } else if (!strcmp("uploadpack.allowfilter", var))
     ...

We'd always check the scope condition first, meaning we'd
_only_ respect allowfilter when it's in the repo config. You
can see this with:

  git -c uploadpack.allowfilter=true upload-pack . | head -1

which will not advertise the filter capability (but will
after this patch). We never noticed because:

  - our tests always set it in the repo config

  - in protocol v2, we use a different code path that
    actually calls repo_config_get_bool() separately, so
    that _does_ work. Real-world people experimenting with
    this may be using v2.

The more recent uploadpack.allowrefinwant option is in the
same boat.

There are a few possible fixes:

  1. Bump the scope conditional back to the bottom of the
     chain. But that just means somebody else is likely to
     make the same mistake later.

  2. Make the conditional more like the others. I.e.:

       else if (!current_config_scope() != CONFIG_SCOPE_REPO &&
                !strcmp(var, "uploadpack.notallowedinrepo"))

     This works, but the idea of the original structure was
     that we may grow multiple sensitive options like this.

  3. Pull it out of the chain entirely. The chain mostly
     serves to avoid extra strcmp() calls after we've found
     a match. But it's not worth caring about those. In the
     worst case, when there isn't a match, we're already
     hitting every strcmp (and this happens regularly for
     stuff like "core.bare", etc).

This patch does (3).

Signed-off-by: Jeff King <peff@peff.net>
---
Phew. That was a lot of explanation for a small patch, but
this was sufficiently subtle I thought it worth it. And
also, I was really surprised the bug managed to exist for
this long without anybody noticing.

 upload-pack.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 540778d1dd..489c18e222 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1028,14 +1028,17 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
 			keepalive = -1;
-	} else if (current_config_scope() != CONFIG_SCOPE_REPO) {
-		if (!strcmp("uploadpack.packobjectshook", var))
-			return git_config_string(&pack_objects_hook, var, value);
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
 		allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
 		allow_ref_in_want = git_config_bool(var, value);
 	}
+
+	if (current_config_scope() != CONFIG_SCOPE_REPO) {
+		if (!strcmp("uploadpack.packobjectshook", var))
+			return git_config_string(&pack_objects_hook, var, value);
+	}
+
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-- 
2.19.1.1094.gd480080bf6
