Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEE7CE7B00
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 04:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjI1EbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 00:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjI1EbG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 00:31:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E7E121
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 21:31:02 -0700 (PDT)
Received: (qmail 3581 invoked by uid 109); 28 Sep 2023 04:31:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Sep 2023 04:31:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9595 invoked by uid 111); 28 Sep 2023 04:31:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Sep 2023 00:31:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Sep 2023 00:30:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 6/6] commit-graph: report incomplete chains during
 verification
Message-ID: <20230928043058.GA57926@coredump.intra.peff.net>
References: <20230926055452.GA1341109@coredump.intra.peff.net>
 <20230926060430.GF1341418@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926060430.GF1341418@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 02:04:30AM -0400, Jeff King wrote:

> @@ -608,6 +611,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
>  
>  		if (!valid) {
>  			warning(_("unable to find all commit-graph files"));
> +			*incomplete_chain = 1;
>  			break;
>  		}
>  	}

Reviewing my own patch since I noticed it misses a case. ;)

The whole function here looks like (abbreviated):

  int valid = 1;

  for (i = 0; i < count; i++) {
          if (get_oid_hex(line.buf, &oids[i])) {
                  warning(_("invalid commit-graph chain: line '%s' not a hash"),
                          line.buf);
                  valid = 0;
                  break;
          }
  
          valid = 0;
          for (odb = r->objects->odb; odb; odb = odb->next) {
                  struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
                  if (g) {
                          if (add_graph_to_chain(g, graph_chain, oids, i)) {
                                  graph_chain = g;
                                  valid = 1;
                          }
  
                          break;
                  }
          }
  
          if (!valid) {
                  warning(_("unable to find all commit-graph files"));
                  break;
          }
  }

My patch updates the final "if (!valid)" check, which covers anything
that happened in the loop over the odb (i.e., finding and opening the
file itself). But if we see a line which does not parse as an oid, we
break out of the outer loop earlier. We set "valid", but nobody looks at
it! So the caller would not be correctly notified that we had an error
in that case.

The fix is simple: we can just check "valid" after leaving the outer
loop, which covers both cases. And we'll want an extra test to check it.
This is actually covered by the test modified earlier in patch 3, where
sha1 and sha256 produced different results. I fixed it there by
consistently corrupting the first line of the file, but we really want
to check both cases.

I'll send a re-roll in a moment.

-Peff
