Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB7EC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3D920732
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJTnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:43:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:40060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726177AbgDJTnm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 15:43:42 -0400
Received: (qmail 7614 invoked by uid 109); 10 Apr 2020 19:43:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 19:43:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2186 invoked by uid 111); 10 Apr 2020 19:54:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 15:54:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 15:43:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] remote: drop auto-strlen behavior of make_branch() and
 make_rewrite()
Message-ID: <20200410194341.GA1363756@coredump.intra.peff.net>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410194211.GA1363484@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The make_branch() and make_rewrite() functions can take a NUL-terminated
string or a ptr/len pair. They use a sentinel value of "0" for the len
to tell the difference between the two. However, when parsing config
like:

  [branch ""]
  merge = whatever

whose key flattens to:

  branch..merge

we might actually have a zero-length branch name. This is obviously
nonsense, but the current code would consider it as a NUL-terminated
string and use the branch name ".merge".

We could use a better sentinel value here (like "-1"), but that gets in
the way of moving to size_t, which is a more appropriate type for a
ptr/len combo.

Let's instead just drop this feature and have the callers (of which
there are only two total) use strlen() themselves. This simplifies the
code, and lets us move to using size_t.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/remote.c b/remote.c
index c43196ec06..35bc3f9f2d 100644
--- a/remote.c
+++ b/remote.c
@@ -174,54 +174,43 @@ static void add_merge(struct branch *branch, const char *name)
 	branch->merge_name[branch->merge_nr++] = name;
 }
 
-static struct branch *make_branch(const char *name, int len)
+static struct branch *make_branch(const char *name, size_t len)
 {
 	struct branch *ret;
 	int i;
 
 	for (i = 0; i < branches_nr; i++) {
-		if (len ? (!strncmp(name, branches[i]->name, len) &&
-			   !branches[i]->name[len]) :
-		    !strcmp(name, branches[i]->name))
+		if (!strncmp(name, branches[i]->name, len) &&
+		    !branches[i]->name[len])
 			return branches[i];
 	}
 
 	ALLOC_GROW(branches, branches_nr + 1, branches_alloc);
 	ret = xcalloc(1, sizeof(struct branch));
 	branches[branches_nr++] = ret;
-	if (len)
-		ret->name = xstrndup(name, len);
-	else
-		ret->name = xstrdup(name);
+	ret->name = xstrndup(name, len);
 	ret->refname = xstrfmt("refs/heads/%s", ret->name);
 
 	return ret;
 }
 
-static struct rewrite *make_rewrite(struct rewrites *r, const char *base, int len)
+static struct rewrite *make_rewrite(struct rewrites *r,
+				    const char *base, size_t len)
 {
 	struct rewrite *ret;
 	int i;
 
 	for (i = 0; i < r->rewrite_nr; i++) {
-		if (len
-		    ? (len == r->rewrite[i]->baselen &&
-		       !strncmp(base, r->rewrite[i]->base, len))
-		    : !strcmp(base, r->rewrite[i]->base))
+		if (len == r->rewrite[i]->baselen &&
+		    !strncmp(base, r->rewrite[i]->base, len))
 			return r->rewrite[i];
 	}
 
 	ALLOC_GROW(r->rewrite, r->rewrite_nr + 1, r->rewrite_alloc);
 	ret = xcalloc(1, sizeof(struct rewrite));
 	r->rewrite[r->rewrite_nr++] = ret;
-	if (len) {
-		ret->base = xstrndup(base, len);
-		ret->baselen = len;
-	}
-	else {
-		ret->base = xstrdup(base);
-		ret->baselen = strlen(base);
-	}
+	ret->base = xstrndup(base, len);
+	ret->baselen = len;
 	return ret;
 }
 
@@ -470,7 +459,7 @@ static void read_config(void)
 		const char *head_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
-			current_branch = make_branch(head_ref, 0);
+			current_branch = make_branch(head_ref, strlen(head_ref));
 		}
 	}
 	git_config(handle_config, NULL);
@@ -1584,7 +1573,7 @@ struct branch *branch_get(const char *name)
 	if (!name || !*name || !strcmp(name, "HEAD"))
 		ret = current_branch;
 	else
-		ret = make_branch(name, 0);
+		ret = make_branch(name, strlen(name));
 	set_merge(ret);
 	return ret;
 }
-- 
2.26.0.414.ge3a6455e3d

