Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8881F4DD
	for <e@80x24.org>; Tue,  5 Sep 2017 08:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbdIEIry (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 04:47:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750748AbdIEIry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 04:47:54 -0400
Received: (qmail 17967 invoked by uid 109); 5 Sep 2017 08:47:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:47:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6967 invoked by uid 111); 5 Sep 2017 08:48:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 04:48:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 04:47:52 -0400
Date:   Tue, 5 Sep 2017 04:47:52 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 2/3] refs/files-backend: fix memory leak in
 lock_ref_for_update
Message-ID: <20170905084751.c4rbeuxx5rdqwdgo@sigill.intra.peff.net>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <f136e83168453af7a0d1eba45c8ad47d01dd9a41.1504024261.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f136e83168453af7a0d1eba45c8ad47d01dd9a41.1504024261.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 07:18:23PM +0200, Martin Ågren wrote:

> After the previous patch, none of the functions we call hold on to
> `referent.buf`, so we can safely release the string buffer before
> returning.

I ended up doing this a little differently in my version:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9266f5ab9d..1d16c1b33e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2287,9 +2292,12 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * the transaction, so we have to read it here
 			 * to record and possibly check old_sha1:
 			 */
-			if (refs_read_ref_full(&refs->base,
-					       referent.buf, 0,
-					       lock->old_oid.hash, NULL)) {
+			ret = refs_read_ref_full(&refs->base,
+						 referent.buf, 0,
+						 lock->old_oid.hash, NULL);
+			strbuf_release(&referent);
+
+			if (ret) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
@@ -2310,6 +2318,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			ret = split_symref_update(refs, update,
 						  referent.buf, transaction,
 						  affected_refnames, err);
+			strbuf_release(&referent);
 			if (ret)
 				return ret;
 		}

After we look at referent.buf once in each of the branch arms, we don't
need it at all. Disposing of it there means we don't have to worry about
it in all of the later early-returns.

I'm assuming that referent will always be empty unless REF_ISSYMREF is
set. Which seems reasonable, but I didn't double check.

Food for thought. I'd be OK with either version.

-Peff
