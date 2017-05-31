Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D301FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbdEaVjX (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:39:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:60815 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbdEaVjX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:39:23 -0400
Received: (qmail 17067 invoked by uid 109); 31 May 2017 21:39:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 21:39:20 +0000
Received: (qmail 8898 invoked by uid 111); 31 May 2017 21:39:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 17:39:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 17:39:20 -0400
Date:   Wed, 31 May 2017 17:39:20 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 30/33] tree-diff: convert diff_tree_paths to struct
 object_id
Message-ID: <20170531213920.daqlw3s5ppmq36ww@sigill.intra.peff.net>
References: <20170530173109.54904-1-bmwill@google.com>
 <20170530173109.54904-31-bmwill@google.com>
 <CAGZ79kZjVvk8GoUFMnR7XJMDyvjkKPhw_7kUYPFq_ShcW50pVQ@mail.gmail.com>
 <20170531212920.yy3swp732rjfnzge@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170531212920.yy3swp732rjfnzge@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 05:29:20PM -0400, Jeff King wrote:

> Or did you mean that diff_tree_paths() could now take an actual
> array-of-struct rather than an array-of-pointer-to-struct? That would
> drop the "parents_oid" array entirely. I think that's actually
> orthogonal to this change (the same could have been done with the
> original sha1 array), but would be a nice cleanup on top.

I took a quick look at this, but it doesn't work. This caller
(find_paths_multitree) would be happy to just pass the existing
"parents" array.

But if we change the interface to diff_tree_paths(), we also have to
change ll_diff_tree_paths() to match. And that function is called from
emit_path(), which really does assemble a list of pointers to
non-adjacent bits of memory. So it would still have to allocate, and
would now have to copy whole oids rather than just pointers.

But even worse, it seems to leave some entries as NULL. We'd need some
sentinel value (like the null sha1) to replace that.

So I think the code is already in its simplest form.

-Peff
