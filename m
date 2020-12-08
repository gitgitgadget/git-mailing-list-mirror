Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1A0C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 15:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB69323A9B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 15:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgLHP7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:59:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:56440 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbgLHP7c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 10:59:32 -0500
Received: (qmail 12975 invoked by uid 109); 8 Dec 2020 15:58:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Dec 2020 15:58:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2832 invoked by uid 111); 8 Dec 2020 15:58:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Dec 2020 10:58:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Dec 2020 10:58:51 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Cloning empty repository uses locally configured default branch
 name
Message-ID: <X8+iu/0nPfd0lrSn@coredump.intra.peff.net>
References: <20201208013121.677494-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208013121.677494-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 07, 2020 at 05:31:20PM -0800, Jonathan Tan wrote:

> When cloning an empty repository, a local branch is created. But its
> name is not the name of the branch that the remote HEAD points to - it
> is the locally configured default branch name. This issue arose at
> $DAYJOB and, from my memory, it is also not an uncommon workflow to
> configure things online on a repo host and then use "git clone" so that
> things like remotes are automatically configured.
> 
> Has anyone looked into solutions for this? Both protocol v0 and v2 do
> not send symref information about unborn branches (v0 because, as
> protocol-capabilities.txt says, "servers SHOULD include this capability
> for the HEAD symref if it is one of the refs being sent"; v2 because
> a symref is included only if it refers to one of the refs being sent).
> In protocol v2, this could be done by adding a capability to ls-remote
> (maybe, "unborn"), and in protocol v0, this could be done either by
> updating the existing "symref" capability to be written even when the
> target branch is unborn (which is potentially backwards incompatible) or
> introducing a new capability which is like "symref".

We discussed this a few years ago, and I even wrote a small patch (for
v0 at the time, of course):

  https://lore.kernel.org/git/20170525155924.hk5jskennph6tta3@sigill.intra.peff.net/

A rebased version of that patch is below (it needed updating to handle
some namespacing stuff). Coupled with your patch here for the truly
empty repo case, it makes the server side of v0 do what you'd want.

But the client side needs to handle it, too. See the linked thread for
some discussion.

I wouldn't be too worried about the backwards incompatibility of sending
a symref line in the capabilities that doesn't point to a ref we're
sending. Old clients are quite likely to ignore it. But...

> A small issue is that upload-pack protocol v0 doesn't even write the
> blank ref line ("000...000 capabilities^{}") if HEAD points to an unborn
> branch, but that can be fixed as in the patch below.

I would worry how clients handle this bogus entry in the ref
advertisement. It looks like the actual Git client is OK, but what about
jgit, libgit2, etc? That's not necessarily a deal-breaker, but it would
be nice to know how they react.

It also only helps with v0 (and I agree with the sentiment that it would
be OK to ignore v0 at this point). For v2, we'd have to issue a HEAD
line like:

  0000000000000000000000000000000000000000 HEAD symref=refs/heads/foo

That probably would break clients, but the unborn capability should take
care of that.

Patch below (I think it only helps v0, but it could serve as a model for
doing the same thing in v2).

---
 upload-pack.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 1006bebd50..b0cc337dcb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1218,20 +1218,21 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int find_symref(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
+static void find_symref(const char *refname, struct string_list *out)
 {
 	const char *symref_target;
 	struct string_list_item *item;
+	struct strbuf namespaced = STRBUF_INIT;
+	int flag;
+
+	strbuf_addf(&namespaced, "%s%s", get_git_namespace(), refname);
+	symref_target = resolve_ref_unsafe(namespaced.buf, 0, NULL, &flag);
+	strbuf_release(&namespaced);
 
-	if ((flag & REF_ISSYMREF) == 0)
-		return 0;
-	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
-		die("'%s' is a symref but it is not?", refname);
-	item = string_list_append(cb_data, strip_namespace(refname));
+		return;
+	item = string_list_append(out, refname);
 	item->util = xstrdup(strip_namespace(symref_target));
-	return 0;
 }
 
 static int parse_object_filter_config(const char *var, const char *value,
@@ -1326,7 +1327,7 @@ void upload_pack(struct upload_pack_options *options)
 	data.daemon_mode = options->daemon_mode;
 	data.timeout = options->timeout;
 
-	head_ref_namespaced(find_symref, &data.symref);
+	find_symref("HEAD", &data.symref);
 
 	if (options->advertise_refs || !data.stateless_rpc) {
 		reset_timeout(data.timeout);
-- 
2.29.2.980.g00fe049108

