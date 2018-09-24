Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66CE41F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeIYDFf (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:05:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:57818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727057AbeIYDFe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:05:34 -0400
Received: (qmail 11308 invoked by uid 109); 24 Sep 2018 21:01:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Sep 2018 21:01:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30675 invoked by uid 111); 24 Sep 2018 21:01:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 24 Sep 2018 17:01:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2018 17:01:27 -0400
Date:   Mon, 24 Sep 2018 17:01:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180924210127.GA6255@sigill.intra.peff.net>
References: <cover.1537555544.git.me@ttaylorr.com>
 <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
 <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
 <20180921213753.GA11177@sigill.intra.peff.net>
 <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
 <20180921221832.GC11177@sigill.intra.peff.net>
 <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
 <20180924181011.GA24781@sigill.intra.peff.net>
 <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
 <20180924205022.GA26936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180924205022.GA26936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 04:50:22PM -0400, Jeff King wrote:

> On Mon, Sep 24, 2018 at 01:32:26PM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > So I think it's conceptually consistent to always show a subset.
> > 
> > OK.  Then I agree with you that it is a good approach to first adopt
> > core.* knobs that universally apply, and add specialized ones as
> > they are needed later.
> 
> Thanks. There's one other major decision for this series, I think.
> 
> Do you have an opinion on whether for_each_alternate_refs() interface
> should stop passing back refnames? By the "they may not even exist"
> rationale in this sub-thread, I think it's probably foolish for any
> caller to actually depend on the names being meaningful.
> 
> We need to decide now because the idea of which data is relevant is
> getting baked into the documented alternateRefsCmd output format.

Just to sketch it out further, I was thinking that we'd do something
like this at the front of Taylor's series (with the rest rebased as
appropriate on top).

-- >8 --
Subject: [PATCH] transport: drop refnames from for_each_alternate_ref

None of the current callers use the refname parameter we pass to their
callbacks. In theory somebody _could_ do so, but it's actually quite
weird if you think about it: it's a ref in somebody else's repository.
So the name has no meaning locally, and in fact there may be duplicates
if there are multiple alternates.

The users of this interface really only care about seeing some ref tips,
since that promises that the alternate has the full commit graph
reachable from there. So let's keep the information we pass back to the
bare minimum.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 3 +--
 fetch-pack.c           | 3 +--
 transport.c            | 6 +++---
 transport.h            | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a3bb13af10..39993f2bcf 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -281,8 +281,7 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	return 0;
 }
 
-static void show_one_alternate_ref(const char *refname,
-				   const struct object_id *oid,
+static void show_one_alternate_ref(const struct object_id *oid,
 				   void *data)
 {
 	struct oidset *seen = data;
diff --git a/fetch-pack.c b/fetch-pack.c
index 75047a4b2a..b643de143b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -76,8 +76,7 @@ struct alternate_object_cache {
 	size_t nr, alloc;
 };
 
-static void cache_one_alternate(const char *refname,
-				const struct object_id *oid,
+static void cache_one_alternate(const struct object_id *oid,
 				void *vcache)
 {
 	struct alternate_object_cache *cache = vcache;
diff --git a/transport.c b/transport.c
index 1c76d64aba..2e0bc414d0 100644
--- a/transport.c
+++ b/transport.c
@@ -1336,7 +1336,7 @@ static void read_alternate_refs(const char *path,
 	cmd.git_cmd = 1;
 	argv_array_pushf(&cmd.args, "--git-dir=%s", path);
 	argv_array_push(&cmd.args, "for-each-ref");
-	argv_array_push(&cmd.args, "--format=%(objectname) %(refname)");
+	argv_array_push(&cmd.args, "--format=%(objectname)");
 	cmd.env = local_repo_env;
 	cmd.out = -1;
 
@@ -1348,13 +1348,13 @@ static void read_alternate_refs(const char *path,
 		struct object_id oid;
 
 		if (get_oid_hex(line.buf, &oid) ||
-		    line.buf[GIT_SHA1_HEXSZ] != ' ') {
+		    line.buf[GIT_SHA1_HEXSZ]) {
 			warning(_("invalid line while parsing alternate refs: %s"),
 				line.buf);
 			break;
 		}
 
-		cb(line.buf + GIT_SHA1_HEXSZ + 1, &oid, data);
+		cb(&oid, data);
 	}
 
 	fclose(fh);
diff --git a/transport.h b/transport.h
index 01e717c29e..9baeca2d7a 100644
--- a/transport.h
+++ b/transport.h
@@ -261,6 +261,6 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, unsigned int *reject_reasons);
 
-typedef void alternate_ref_fn(const char *refname, const struct object_id *oid, void *);
+typedef void alternate_ref_fn(const struct object_id *oid, void *);
 extern void for_each_alternate_ref(alternate_ref_fn, void *);
 #endif
-- 
2.19.0.764.g0a058409ab

