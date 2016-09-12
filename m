Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D2E207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 15:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbcILP7g (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 11:59:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:41929 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751400AbcILP7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 11:59:35 -0400
Received: (qmail 12251 invoked by uid 109); 12 Sep 2016 15:59:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 15:59:34 +0000
Received: (qmail 14009 invoked by uid 111); 12 Sep 2016 15:59:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 11:59:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 11:59:31 -0400
Date:   Mon, 12 Sep 2016 11:59:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 0/2] patch-id for merges
Message-ID: <20160912155930.2acw4265nfjq3uyj@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
 <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
 <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
 <xmqqfup8aiud.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfup8aiud.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 02:01:14PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And here is v3. Besides commit-message fixups, it drops patch 2, and
> > instead the third patch teaches commit_patch_id() to distinguish between
> > errors and "no patch id".
> >
> > Frankly, I still like v2 better, but I do not feel like arguing with
> > Johannes about it anymore.
> 
> FWIW, I too like the simplicity of v2, as all the error-to-die
> conversion is for cases in which there is no sane recovery path.
> 
> I'll have to take a bit deeper look at [v3 2/2] that had to become
> more involved to decide if the additional flexibility is really
> worth it.

One other option I didn't really look at: commit_patch_id() could
consider feeding it a merge as an error, and it would be come the
caller's responsibility to avoid doing so. That should already be the
case for "format-patch --base".

We'd probably have to change add_commit_patch_id() and
has_commit_patch_id() to return NULL early when fed a merge, but that is
not too bad.

The reason I didn't pursue this is that I didn't want the definition of
"what constitutes something with no patch-id" to cross too many
abstraction layers. But it's not like we expect a multitude of
conditions; it will probably remain just "we don't handle merges" for
the foreseeable future.

That looks like the patch below (as a replacement for patch 2), which is
even less invasive. It also performs a little better on my example case,
because we avoid adding merges to the hashmap entirely.

diff --git a/patch-ids.c b/patch-ids.c
index 77e4663..5d2d96a 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -7,10 +7,12 @@
 int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1, int diff_header_only)
 {
-	if (commit->parents)
+	if (commit->parents) {
+		if (commit->parents->next)
+			return -1;
 		diff_tree_sha1(commit->parents->item->object.oid.hash,
 			       commit->object.oid.hash, "", options);
-	else
+	} else
 		diff_root_tree_sha1(commit->object.oid.hash, "", options);
 	diffcore_std(options);
 	return diff_flush_patch_id(options, sha1, diff_header_only);
@@ -72,11 +74,20 @@ static int init_patch_id_entry(struct patch_id *patch,
 	return 0;
 }
 
+static int patch_id_defined(struct commit *commit)
+{
+	/* must be 0 or 1 parents */
+	return !commit->parents || !commit->parents->next;
+}
+
 struct patch_id *has_commit_patch_id(struct commit *commit,
 				     struct patch_ids *ids)
 {
 	struct patch_id patch;
 
+	if (!patch_id_defined(commit))
+		return NULL;
+
 	memset(&patch, 0, sizeof(patch));
 	if (init_patch_id_entry(&patch, commit, ids))
 		return NULL;
@@ -89,6 +100,9 @@ struct patch_id *add_commit_patch_id(struct commit *commit,
 {
 	struct patch_id *key = xcalloc(1, sizeof(*key));
 
+	if (!patch_id_defined(commit))
+		return NULL;
+
 	if (init_patch_id_entry(key, commit, ids)) {
 		free(key);
 		return NULL;

I'd probably do a preparatory patch to drop the return value from
add_commit_patch_id(). No callers actually look at it.

-Peff
