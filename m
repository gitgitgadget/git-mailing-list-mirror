Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A561C77B7A
	for <git@archiver.kernel.org>; Sat, 13 May 2023 16:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjEMQ7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 12:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEMQ72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 12:59:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E1F2D68
        for <git@vger.kernel.org>; Sat, 13 May 2023 09:59:26 -0700 (PDT)
Received: (qmail 23528 invoked by uid 109); 13 May 2023 16:59:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 13 May 2023 16:59:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1724 invoked by uid 111); 13 May 2023 16:59:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 13 May 2023 12:59:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 13 May 2023 12:59:25 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 4/9] fetch: print left-hand side when fetching HEAD:foo
Message-ID: <20230513165925.GA113985@coredump.intra.peff.net>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
 <2cc7318697ef6062f6deadf7a22feb26c2c829e8.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cc7318697ef6062f6deadf7a22feb26c2c829e8.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2023 at 02:34:15PM +0200, Patrick Steinhardt wrote:

> @@ -946,7 +948,7 @@ static int update_local_ref(struct ref *ref,
>  	if (oideq(&ref->old_oid, &ref->new_oid)) {
>  		if (verbosity > 0)
>  			display_ref_update(display_state, '=', _("[up to date]"), NULL,
> -					   remote, ref->name, summary_width);
> +					   remote_ref->name, ref->name, summary_width);
>  		return 0;
>  	}

Here (and in other hunks) we now dereference remote_ref unconditionally.
But in existing parts of the code, we guard against remote_ref being
NULL. E.g., later on:

          if (!current || !updated) {
                  const char *msg;
                  const char *what;
                  int r;
                  /*
                   * Nicely describe the new ref we're fetching.
                   * Base this on the remote's ref name, as it's
                   * more likely to follow a standard layout.
                   */
                  const char *name = remote_ref ? remote_ref->name : "";
		  [...]

I'm not sure if the old code was being overly defensive, or if the new
code is ripe for a segfault. But it's probably worth looking into (it
was noticed by Coverity).

Looking at the caller, it is always store_update_refs() which passes its
own "rm", a pointer iterating over ref_map. And it should always be
non-NULL, since that's the loop condition.

So I think your code is fine, but you might want to double-check my
logic. (And it may be worth cleaning up the existing redundant check to
prevent confusion).

-Peff
