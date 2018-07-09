Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A221F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 18:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeGISIH (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 14:08:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:52304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933824AbeGISIG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 14:08:06 -0400
Received: (qmail 30651 invoked by uid 109); 9 Jul 2018 18:08:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Jul 2018 18:08:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13673 invoked by uid 111); 9 Jul 2018 18:08:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 14:08:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 14:08:04 -0400
Date:   Mon, 9 Jul 2018 14:08:04 -0400
From:   Jeff King <peff@peff.net>
To:     William Chargin <wchargin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unexpected behavior with :/<text> references
Message-ID: <20180709180804.GA6134@sigill.intra.peff.net>
References: <CAFW+GMBLeLyJjJPaEXkyQ5fJ=L4q4vQ=26wjZ+n07ZvSaTaCUg@mail.gmail.com>
 <CAFW+GMAnkLYReotwRvbVt9iPqmuq_8WMc1sck4Jkj_fyafVm3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFW+GMAnkLYReotwRvbVt9iPqmuq_8WMc1sck4Jkj_fyafVm3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 08, 2018 at 10:13:12PM -0700, William Chargin wrote:

> After further investigation, it appears that ":/foo" indeed resolves to
> the commit with message "foobar" (in the above example) if the commits
> are not all created at the same time: e.g., by adding `sleep 1` between
> the commit commands, or exporting `GIT_AUTHOR_DATE`.

I suspect it's actually GIT_COMMITTER_DATE (but I didn't dig into it, so
I could be wrong). "Youngest" in terms of commits generally refers to
the committer date.

> This leaves only the question of why :/<text> references don't resolve
> to commits reachable only from HEAD, and whether this is the best
> behavior.

I agree that it would make sense to look at HEAD here. The point of ":/"
is to search everything reachable, and HEAD is part of that
reachability. _Usually_ it doesn't matter because HEAD is pointing to
another ref, but the detached case is an exception.

Doing this would bring us in line with the behavior of other parts of
Git. E.g., f0298cf1c6 (revision walker: include a detached HEAD
in --all, 2009-01-16).

The patch is probably this:

diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7e..641ca12f91 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1650,6 +1650,7 @@ static int get_oid_with_context_1(const char *name,
 			struct commit_list *list = NULL;
 
 			for_each_ref(handle_one_ref, &list);
+			head_ref(handle_one_ref, &list);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(name + 2, oid, list);
 		}

but I didn't test it at all. Do you want to try adding a case for this
to our test suite (probably in t4208) and wrapping it up with a commit
message?

-Peff
